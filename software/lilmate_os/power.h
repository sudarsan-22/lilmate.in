// Power: USB vs battery, battery level (optional 2-resistor divider), battery saver, low-battery protection
//
// Battery sense (optional hardware): Li-ion B+ --[100k]-- GPIO3 --[100k]-- GND   (4.2 V full -> 2.1 V on the pin)
// Without the divider the battery level is "unknown"; the saver still switches on when no computer USB is present.
#pragma once
#include <esp_sleep.h>
#include "config.h"

#define BAT_PIN   3
#define BAT_DIV   2.0f

uint8_t  powerMode = 0;          // 0 auto, 1 always full power, 2 always battery saver
bool     batPresent = false, charging = false, saver = false, lowWarned = false;
float    batV = 0;               // smoothed battery volts
int      batPct = -1;            // -1 unknown
uint32_t nextBatRead = 0, simBatUntil = 0, lowSince = 0;
float    simBatV = 0;
uint16_t frameMs = FRAME_MS;
uint32_t screenOffMs = SCREEN_OFF_MS;

bool usbHost() { return HWCDC::isPlugged(); }   // plugged into a computer (USB frames seen)

int pctFromVolts(float v) {      // resting Li-ion curve
  static const float V[] = { 4.20f, 4.10f, 4.00f, 3.90f, 3.80f, 3.75f, 3.70f, 3.65f, 3.60f, 3.50f, 3.30f };
  static const int   P[] = { 100,   90,    80,    65,    50,    40,    30,    20,    12,    5,     0 };
  if (v >= V[0]) return 100;
  for (int i = 1; i < 11; i++) if (v >= V[i]) return P[i] + (int)((v - V[i]) / (V[i - 1] - V[i]) * (P[i - 1] - P[i]));
  return 0;
}

float readBatVolts() {
  if (simBatUntil && millis() < simBatUntil) return simBatV;
  uint32_t mv = 0;
  for (int i = 0; i < 8; i++) mv += analogReadMilliVolts(BAT_PIN);
  return mv / 8.0f / 1000.0f * BAT_DIV;
}

void applySaver(bool on) {
  if (on == saver) return;
  saver = on;
  frameMs = on ? 60 : FRAME_MS;                       // 16 fps is plenty for the face on battery
  screenOffMs = on ? 240000 : SCREEN_OFF_MS;          // screen off 4 min after falling asleep
  Serial.printf("[power] %s\n", on ? "battery saver ON" : "full power");
}

void powerBegin() {
  powerMode = prefs.getUChar("pwr", 0);
  analogSetPinAttenuation(BAT_PIN, ADC_11db);
  float v = readBatVolts();
  batPresent = v > 2.8f && v < 4.6f;                  // a floating / grounded pin reads ~0
  if (batPresent) { batV = v; batPct = pctFromVolts(v); }
  Serial.printf("[power] battery %s%s\n", batPresent ? "sensed " : "not sensed (no divider on GPIO3)", batPresent ? String(v, 2).c_str() : "");
}

void deepSleepEmpty() {
  oled.clearBuffer();
  centerStr(26, u8g2_font_7x14B_tr, "battery empty");
  centerStr(44, u8g2_font_6x10_tr, "please charge me");
  centerStr(60, u8g2_font_5x7_tr, "touch to wake");
  oled.sendBuffer();
  delay(3000);
  storeFlush();
  oled.setPowerSave(1);
  esp_deep_sleep_enable_gpio_wakeup(1ULL << TOUCH_PIN, ESP_GPIO_WAKEUP_GPIO_HIGH);
  esp_deep_sleep_start();
}

void powerTick(uint32_t now) {
  now = millis();
  bool host = usbHost();
  if (now > nextBatRead) {
    nextBatRead = now + 5000;
    float v = readBatVolts();
    bool sim = simBatUntil && now < simBatUntil;
    if (sim) batPresent = true;
    if (batPresent) {
      batV = (batV < 1 || sim) ? v : batV * 0.8f + v * 0.2f;
      batPct = pctFromVolts(batV);
      charging = host || batV >= 4.17f;
      if (!charging && batPct <= 15 && !lowWarned) {
        lowWarned = true;
        raiseAlert(AK_REMIND, "Battery low! Feed me a charger");
        tgNotify("🔋 lil.mate battery is low (" + String(batPct) + "%). Please plug it in.");
      }
      if (batPct >= 25 || charging) lowWarned = false;
      if (!charging && batV < 3.35f) { if (!lowSince) lowSince = now; if (now - lowSince > 15000) deepSleepEmpty(); }
      else lowSince = 0;
    }
  }
  bool onBattery = !host && !(batPresent && charging);
  applySaver(powerMode == 2 || (powerMode == 0 && onBattery));
  // Wi-Fi modem sleep saves ~50 mA but makes the web page and team games laggy: only on battery, never mid-game
  static int8_t sleepState = -1;
  int8_t want = (saver && !linkBusy()) ? 1 : 0;
  if (want != sleepState) { sleepState = want; WiFi.setSleep(want == 1); }
}

void drawBatteryIcon(int x, int y) {   // 13x7, only when it matters (on battery or charging)
  if (!batPresent || (usbHost() && batPct >= 99)) return;
  oled.drawFrame(x, y, 11, 7); oled.drawBox(x + 11, y + 2, 2, 3);
  int f = (batPct * 9 + 50) / 100; if (f > 0) oled.drawBox(x + 1, y + 1, f, 5);
  if (charging) {   // small bolt to the left of the battery
    oled.drawTriangle(x - 3, y, x - 6, y + 4, x - 3, y + 4);
    oled.drawTriangle(x - 4, y + 3, x - 4, y + 7, x - 1, y + 3);
  }
  if (!charging && batPct <= 15 && (millis() / 500) % 2) oled.drawBox(x + 1, y + 1, 9, 5);
}

String powerText() {
  String s = String("🔌 Power: ") + (usbHost() ? "computer USB" : "battery / charger") + (saver ? " · battery saver ON" : " · full power") + " (mode " + (powerMode == 0 ? "auto" : powerMode == 1 ? "full" : "saver") + ")";
  if (batPresent) s += "\n🔋 Battery " + String(batPct) + "% (" + String(batV, 2) + " V)" + (charging ? " charging" : "");
  else s += "\n🔋 Battery level unknown: add a 100k/100k divider from battery + to GPIO3 to measure it";
  return s;
}
void powerJson(JsonObject o) {
  o["usb"] = usbHost(); o["saver"] = saver; o["mode"] = powerMode == 0 ? "auto" : powerMode == 1 ? "full" : "saver";
  o["bat"] = batPresent; if (batPresent) { o["pct"] = batPct; o["v"] = batV; o["chg"] = charging; }
}
