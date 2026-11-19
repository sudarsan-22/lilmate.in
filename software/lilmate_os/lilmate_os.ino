/*
  ============================================================================
   LILMATE OS 0.1  -  Troko-style desk companion for tiny hardware
   Board  : DFRobot Beetle ESP32-C3 (4 MB, no PSRAM)
   Display: 0.96" SSD1306 128x64 I2C  (SDA 8, SCL 9)
   Input  : TTP223 touch on GPIO 2 (only input!)

   Touch (everywhere):  2 taps = next screen   3 taps = back to face
   Face  : tap = pat   hold = cuddle   3 taps = play (fly / ball)
   Clock : tap = refresh weather
   Focus : tap = start / pause   hold = stop / start break
   Tasks : tap = next            hold = done / undo
   Habits: tap = next            hold = +1
   Game  : tap = turn around     hold = exit
   Info  : hold = dashboard QR   hold 4 s = Wi-Fi setup hotspot
   Alerts: tap = dismiss         hold = snooze 10 min

   Phone : http://lilmate.local   (or the IP on the INFO screen)
   Chat  : your own Telegram bot  (token in dashboard settings)
   USB   : 115200 baud, same commands as Telegram (/help)
  ============================================================================
*/
#include <Wire.h>
#include <Update.h>
#include "config.h"
#include "store.h"
#include "diag.h"
#include "face.h"
#include "touch.h"
#include "net.h"
#include "apps.h"
#include "agent.h"
#include "work.h"
#include "link.h"
#include "power.h"
#include "commands.h"
#include "web.h"

void handleTelegram(const InMsg &m) {
  String text = m.text, low = text; low.toLowerCase();
  if (!S.tgChat[0]) {   // first /start pairs this bot with your chat
    if (low.startsWith("/start")) {
      copyStr(S.tgChat, m.chat, sizeof(S.tgChat)); markDirty(D_SET);
      tgReply(m.chat, String("🎉 Paired! I'm ") + S.owner + "'s Lilmate.\n\n" + HELP_TEXT, true);
      wakeUp(false); faceSetMood(M_LOVE, 3000); faceSay("Paired with your phone!");
    } else tgReply(m.chat, "👋 Send /start to pair with this Lilmate.");
    return;
  }
  if (strcmp(m.chat, S.tgChat) != 0) { tgReply(m.chat, "Sorry, I already belong to someone 🙂"); return; }
  String r = runCommand(text, SRC_TG, m.from);
  if (r.length()) tgReply(m.chat, r, low.startsWith("/start") || low.startsWith("/help"));
}

// ------------------------------------------------------------ firmware update over the USB cable (from lil.mate Desk)
// "@ota <size> <md5>"  ->  "@ota {ok}"  then raw bytes in 1 KB chunks, each answered "@ok <bytes so far>",
// then "@ota {ok,done}" and a restart. The old firmware keeps running if anything goes wrong.
static void otaScreen(const char *top, const char *bottom, int pct) {
  oled.clearBuffer();
  centerStr(22, u8g2_font_7x14B_tr, top);
  if (pct >= 0) { oled.drawFrame(14, 32, 100, 8); oled.drawBox(16, 34, pct * 96 / 100, 4); }
  centerStr(54, u8g2_font_5x7_tr, bottom);
  oled.sendBuffer();
}
static void otaFail(const char *why) {
  Update.abort();
  Serial.printf("@ota {\"ok\":false,\"e\":\"%s\"}\n", why);
  otaScreen("UPDATE FAILED", why, -1); delay(1500);
}
void serialOta(String args) {
  args.trim(); int sp = args.indexOf(' ');
  uint32_t size = (sp < 0 ? args : args.substring(0, sp)).toInt();
  String md5 = sp < 0 ? "" : args.substring(sp + 1); md5.trim();
  if (size < 64 * 1024 || size > 0x1E0000) { Serial.println("@ota {\"ok\":false,\"e\":\"bad size\"}"); return; }
  if (!Update.begin(size)) { otaFail(Update.errorString()); return; }
  if (md5.length() == 32) Update.setMD5(md5.c_str());
  Serial.printf("[ota] usb %u bytes\n", (unsigned)size);
  otaScreen("UPDATING", "keep me plugged in", 0);
  Serial.println("@ota {\"ok\":true}");
  static uint8_t buf[1024];
  uint32_t got = 0, last = millis(); int shown = 0;
  while (got < size) {
    size_t want = min((uint32_t)sizeof(buf), size - got), n = 0;
    while (n < want) {
      int a = Serial.available();
      if (a > 0) { n += Serial.read(buf + n, min((size_t)a, want - n)); last = millis(); }
      else if (millis() - last > 8000) { otaFail("timeout"); return; }
      else delay(1);
    }
    if (Update.write(buf, n) != n) { otaFail(Update.errorString()); return; }
    got += n;
    Serial.printf("@ok %u\n", (unsigned)got);
    int pct = (uint64_t)got * 100 / size;
    if (pct - shown >= 4 || got == size) { shown = pct; char b[24]; snprintf(b, sizeof(b), "%d%%  keep me plugged in", pct); otaScreen("UPDATING", b, pct); }
  }
  if (!Update.end(true)) { otaFail(Update.errorString()); return; }
  Serial.println("@ota {\"ok\":true,\"done\":true}");
  otaScreen("UPDATED!", "restarting...", 100);
  Serial.flush(); storeFlush(); diagRestart(SW_OTA); delay(400); ESP.restart();
}

// USB serial console: same commands, plus Wi-Fi setup and touch simulation for testing
String serialBuf;
void serialLoop() {
  while (Serial.available()) {
    char c = Serial.read();
    if (c == '\r') continue;
    if (c != '\n') { if (serialBuf.length() < 700) serialBuf += c; continue; }
    String line = serialBuf; serialBuf = ""; line.trim();
    if (!line.length()) continue;
    // machine protocol from pc_agent/lilmate_agent.py (USB link, no Wi-Fi needed)
    if (line.startsWith("@ev ")) {
      JsonDocument d;
      if (!deserializeJson(d, line.substring(4))) { agentEvent(d.as<JsonObjectConst>(), true); Serial.println("@ok"); }
      else Serial.println("@err json");
      continue;
    }
    if (line.startsWith("@pc ")) {
      JsonDocument d;
      if (!deserializeJson(d, line.substring(4))) Serial.printf("@pcr {\"focus\":%s}\n", pcUpdate(d.as<JsonObjectConst>()) ? "true" : "false");
      continue;
    }
    if (line.startsWith("@cal ")) {
      JsonDocument d;
      if (!deserializeJson(d, line.substring(5))) { calSet(d["ev"].as<JsonArrayConst>()); Serial.println("@ok"); }
      continue;
    }
    if (line == "@state") { JsonDocument d; buildState(d); Serial.print("@st "); serializeJson(d, Serial); Serial.println(); continue; }
    if (line.startsWith("@cmd ")) { JsonDocument d; d["r"] = runCommand(line.substring(5), SRC_AGENT, ""); Serial.print("@re "); serializeJson(d, Serial); Serial.println(); continue; }
    if (line.startsWith("@ota ")) { serialOta(line.substring(5)); continue; }
    if (line.startsWith("@hello")) { Serial.printf("@hi {\"fw\":\"%s\",\"name\":\"%s\"}\n", FW_VERSION, S.owner); continue; }
    String low = line; low.toLowerCase();
    if (low.startsWith("/wifi ")) {          // /wifi My Network|password
      String a = line.substring(6); int bar = a.indexOf('|');
      String ssid = bar < 0 ? a : a.substring(0, bar), pass = bar < 0 ? "" : a.substring(bar + 1);
      copyStr(S.ssid, ssid.c_str(), sizeof(S.ssid)); copyStr(S.pass, pass.c_str(), sizeof(S.pass));
      markDirty(D_SET); storeFlush();
      Serial.printf("> Wi-Fi saved (%s). Restarting...\n", S.ssid);
      diagRestart(SW_WIFI_SAVE); delay(300); ESP.restart();
    }
    if (low.startsWith("/sim bat ")) { simBatV = low.substring(9).toFloat(); simBatUntil = millis() + 120000; nextBatRead = 0; Serial.printf("> simulating battery %.2f V for 2 min\n", simBatV); continue; }
    if (low.startsWith("/sim ")) {           // /sim tap|double|triple|long|vlong|press
      String g = low.substring(5);
      for (int i = 1; i < 8; i++) if (g == TOUCH_NAMES[i]) { tPush((TouchEv)i); Serial.printf("> sim %s\n", TOUCH_NAMES[i]); }
      continue;
    }
    if (low == "/state") { Serial.printf("> screen=%s mood=%s asleep=%d off=%d alert=%d heap=%u wifi=%d ap=%d\n", SCREEN_NAMES[screen], MOOD_NAMES[mood], asleep, displayOff, al.active, (unsigned)ESP.getFreeHeap(), wifiUp, apMode); continue; }
    String r = runCommand(line, SRC_SERIAL, "");
    Serial.print("> "); Serial.println(r);
  }
}

// the lilmate.in logo: an arch head with two happy ^ ^ eyes and an orange (here: white) spark
void drawLogo(int cx, int cy, bool happy, int spark) {
  for (int r = 17; r <= 19; r++) oled.drawCircle(cx, cy, r, U8G2_DRAW_UPPER_LEFT | U8G2_DRAW_UPPER_RIGHT);
  oled.drawBox(cx - 19, cy, 3, 6); oled.drawBox(cx + 17, cy, 3, 6);                   // the arch's legs
  for (int s = -1; s <= 1; s += 2) {
    int ex = cx + s * 7;
    if (happy) for (int t = 0; t < 2; t++) { oled.drawLine(ex - 4, cy + 3 - t, ex, cy - 1 - t); oled.drawLine(ex, cy - 1 - t, ex + 4, cy + 3 - t); }
    else oled.drawRBox(ex - 1, cy - 3, 3, 7, 1);
  }
  if (spark) {   // three little strokes at the top right
    int sx = cx + 16, sy = cy - 22;
    oled.drawLine(sx, sy, sx - 2, sy + 6);           oled.drawLine(sx + 1, sy, sx - 1, sy + 6);            // up
    oled.drawLine(sx + 9, sy + 3, sx + 4, sy + 8);   oled.drawLine(sx + 9, sy + 4, sx + 5, sy + 8);        // diagonal
    oled.drawLine(sx + 12, sy + 12, sx + 6, sy + 14); oled.drawLine(sx + 12, sy + 13, sx + 6, sy + 15);   // right
  }
}

void bootSplash() {
  for (int f = 0; f < 70; f++) {
    oled.clearBuffer();
    int y = 64 - f * 3; if (y < 30) y = 30;                       // the logo rises in
    drawLogo(64, y, f > 34, f > 40 && (f / 4) % 3 != 0);           // eyes open, then go happy; spark twinkles
    if (f > 30) centerStr(y + 22, u8g2_font_7x14B_tr, "lil.mate");
    if (f > 46) centerStr(63, u8g2_font_5x7_tr, "OS " FW_VERSION);
    oled.sendBuffer();
    delay(16);
  }
  delay(300);
  // eyes open
  faceBegin();
  uint32_t t0 = millis();
  while (millis() - t0 < 900) { faceUpdate(millis()); oled.clearBuffer(); faceDraw(millis()); oled.sendBuffer(); delay(FRAME_MS); }
}

void setup() {
  Serial.setRxBufferSize(4096);   // room for firmware chunks over USB
  Serial.begin(115200);
  delay(50);
  Serial.println("\n== " FW_NAME " " FW_VERSION " ==");
  storeBegin();
  diagBoot();
  workBegin();
  powerBegin();
  touchBegin();
  randomSeed(esp_random());

  oled.setBusClock(800000);
  oled.begin();
  oled.setContrast(S.contrast);
  bootSplash();

  netBegin();
  linkBegin();
  webBegin();

  lastActivity = millis();
  faceSetMood(M_HAPPY, 2000);
  faceSay(String("Hi ") + S.owner + "!");
  Serial.printf("[boot] heap %lu, tasks %u, reminders %u, habits %u\n", (unsigned long)ESP.getFreeHeap(), nTasks, nRems, nHabits);
}

void loop() {
  uint32_t now = millis();
  diagStage(ST_TOUCH); touchPoll(); handleTouch(now);
  diagStage(ST_WIFI);  wifiLoop();
  diagStage(ST_WEB);   server.handleClient();

  InMsg m;
  diagStage(ST_TG);
  while (xQueueReceive(inQ, &m, 0) == pdTRUE) handleTelegram(m);
  diagStage(ST_SERIAL); serialLoop();

  if (netSettingsChanged) { netSettingsChanged = false; markDirty(D_SET); }
  if (tgOffsetChanged) { tgOffsetChanged = false; markDirty(D_TG); }

  static uint32_t lastBrain = 0, lastFrame = 0;
  diagStage(ST_WIFI); linkLoop();
  now = millis();   // handlers above may have stamped events with a newer millis(); never subtract into the past
  if (now - lastBrain >= 1000) { lastBrain = now; diagTick(); diagStage(ST_BRAIN); brainTick(now); agentTick(now); workTick(now); powerTick(now); }
  if (now - lastFrame >= frameMs) {
    lastFrame = now;
    diagStage(ST_RENDER);
    if (screen == S_GAME && !linkBusy()) gameStep(now);
    faceUpdate(now);
    if (!displayOff) render(now);
  }

  diagStage(ST_STORE); storeLoop();
  diagStage(ST_IDLE);
  if (restartAt && now > restartAt) { storeFlush(); ESP.restart(); }
  delay(1);
}
