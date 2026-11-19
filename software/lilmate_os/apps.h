// Apps: screens, focus timer, alerts, game, QR, idle brain
#pragma once
#include <qrcode.h>
#include "config.h"

Screen   screen = S_FACE;
uint32_t lastActivity = 0;
bool     asleep = false, displayOff = false;
bool     swallowGesture = false;   // a wake-up press should not also count as a tap
uint8_t  taskCur = 0, habitCur = 0;
uint32_t qrUntil = 0;              // info screen shows dashboard QR until
String   lastSerialReply;

void markActivity() { lastActivity = millis(); }
void wakeUp(bool greet = false);
// implemented in agent.h / link.h (included after this file)
bool agentTouch(TouchEv e); bool agentDraw(uint32_t now); void drawAgents(uint32_t now);
bool linkTouch(TouchEv e); bool linkDraw(uint32_t now); void drawPlay(uint32_t now); bool linkBusy();
bool workTouch(TouchEv e); bool workDraw(uint32_t now); bool workOverlay(); bool isBusy(); void breatheStart(); void drawDndIcon(int x, int y);
extern uint32_t screenOffMs; extern bool batPresent; extern int batPct; void drawBatteryIcon(int x, int y);   // power.h

// ============================================================ focus (pomodoro)
struct { bool running, paused, isBreak; uint32_t endMs, remainMs, totalMs; uint8_t round; uint8_t plannedMin; } fx = {};

uint32_t focusRemain() {
  if (!fx.running) return (uint32_t)S.focusMin * 60000UL;
  if (fx.paused) return fx.remainMs;
  uint32_t n = millis();
  return fx.endMs > n ? fx.endMs - n : 0;
}
String mmss(uint32_t ms) { uint32_t s = (ms + 999) / 1000; char b[16]; snprintf(b, sizeof(b), "%02lu:%02lu", (unsigned long)(s / 60), (unsigned long)(s % 60)); return b; }

void focusStart(int min) {
  if (min <= 0) min = S.focusMin;
  min = constrain(min, 1, 180);
  fx.running = true; fx.paused = false; fx.isBreak = false;
  fx.plannedMin = min; fx.totalMs = min * 60000UL; fx.endMs = millis() + fx.totalMs;
  fx.round = fx.round >= 4 ? 1 : fx.round + 1;
  faceSetMood(M_FOCUS);
  faceSay("Focus time! " + String(min) + " min");
}
void focusBreak(int min) {
  if (min <= 0) min = S.breakMin;
  min = constrain(min, 1, 60);
  fx.running = true; fx.paused = false; fx.isBreak = true;
  fx.plannedMin = min; fx.totalMs = min * 60000UL; fx.endMs = millis() + fx.totalMs;
  faceSetMood(M_COOL);
  faceSay("Break! Stretch a bit");
}
void focusTogglePause() {
  if (!fx.running) return;
  if (!fx.paused) { fx.remainMs = focusRemain(); fx.paused = true; }
  else { fx.endMs = millis() + fx.remainMs; fx.paused = false; }
}
void focusStop() {
  if (fx.running && !fx.isBreak) {  // count the minutes actually focused
    int done = (fx.totalMs - focusRemain()) / 60000;
    if (done > 0) focusMinutesAdd(done);
  }
  fx.running = fx.paused = fx.isBreak = false;
  topLine = "";
  faceSetMood(M_NEUTRAL);
}

// ============================================================ alerts
enum { AK_REMIND = 1, AK_FOCUS, AK_MSG, AK_NUDGE };
struct { bool active; uint8_t kind; char text[TEXT_LEN + 40]; uint32_t at; } al = {};
bool inverted = false;
void setInvert(bool on) { if (on != inverted) { inverted = on; oled.sendF("c", on ? 0xA7 : 0xA6); } }

void raiseAlert(uint8_t kind, const String &text) {
  wakeUp();
  al.active = true; al.kind = kind; al.at = millis();
  copyStr(al.text, text.c_str(), sizeof(al.text));
  screen = S_FACE;
  Mood m = kind == AK_NUDGE ? M_ANGRY : kind == AK_MSG ? M_SURPRISED : M_ALERT;
  faceSetMood(m, 300000);
  faceSay(text, 0, true);
  Serial.printf("[alert] %s\n", al.text);
}
void dismissAlert(bool snooze = false) {
  if (!al.active) return;
  if (snooze && al.kind == AK_REMIND && timeOk()) {
    String t = al.text; if (t.startsWith("Reminder: ")) t = t.substring(10);
    addReminder(t, nowEpoch() + 600, false);
    faceSay("Snoozed 10 min");
  } else faceClearBubble();
  al.active = false; setInvert(false);
  faceSetMood(M_HAPPY, 1500);
}

// ============================================================ PC agent data
struct { float cpu, ram, act; int bat; bool charging; char host[24]; char title[48]; uint32_t at; } pc = {};   // act = keyboard/mouse activity 0..1 (last 3 min)
bool pcOnline() { return pc.at && millis() - pc.at < 30000; }

// ============================================================ QR (ESP-IDF qrcode component)
uint8_t qrSize = 0; uint8_t qrBits[33 * 33 / 8 + 1]; String qrText;
static void qrCapture(esp_qrcode_handle_t q) {
  int n = esp_qrcode_get_size(q); if (n > 33) n = 33;
  qrSize = n; memset(qrBits, 0, sizeof(qrBits));
  for (int y = 0; y < n; y++) for (int x = 0; x < n; x++) if (esp_qrcode_get_module(q, x, y)) { int i = y * n + x; qrBits[i >> 3] |= 1 << (i & 7); }
}
void qrBuild(const String &text) {
  if (text == qrText && qrSize) return;
  qrText = text; qrSize = 0;
  esp_qrcode_config_t cfg = ESP_QRCODE_CONFIG_DEFAULT();
  cfg.display_func = qrCapture; cfg.max_qrcode_version = 4; cfg.qrcode_ecc_level = ESP_QRCODE_ECC_LOW;
  esp_qrcode_generate(&cfg, text.c_str());
}
void qrDraw(int x0, int y0) {   // white quiet zone + black modules, scale 2 if it fits
  if (!qrSize) return;
  int sc = qrSize * 2 + 4 <= 64 ? 2 : 1;
  int px = qrSize * sc;
  oled.drawBox(x0, y0, px + 4, px + 4);
  oled.setDrawColor(0);
  for (int y = 0; y < qrSize; y++) for (int x = 0; x < qrSize; x++) {
    int i = y * qrSize + x;
    if (qrBits[i >> 3] & (1 << (i & 7))) oled.drawBox(x0 + 2 + x * sc, y0 + 2 + y * sc, sc, sc);
  }
  oled.setDrawColor(1);
}

// ============================================================ drawing helpers
void centerStr(int y, const uint8_t *font, const char *s) { oled.setFont(font); oled.drawStr(max(0, (128 - (int)oled.getStrWidth(s)) / 2), y, s); }   // never negative: u8g2 coords wrap
void header(const char *title, const char *right = nullptr) {
  oled.setFont(u8g2_font_6x10_tr); oled.drawStr(0, 8, title);
  if (right) oled.drawStr(128 - oled.getStrWidth(right), 8, right);
  oled.drawHLine(0, 11, 128);
}
void bar(int x, int y, int w, int h, float frac) {
  oled.drawRFrame(x, y, w, h, 2);
  int f = (int)((w - 4) * constrain(frac, 0.0f, 1.0f));
  if (f > 0) oled.drawBox(x + 2, y + 2, f, h - 4);
}
void drawCloud(int x, int y) { oled.drawDisc(x + 5, y + 7, 4); oled.drawDisc(x + 10, y + 5, 5); oled.drawDisc(x + 15, y + 8, 3); oled.drawBox(x + 5, y + 8, 11, 4); }
void drawWxIcon(int x, int y, int code) {   // ~20x16
  if (code <= 1) {
    oled.drawDisc(x + 10, y + 8, 4);
    for (int i = 0; i < 8; i++) { float a = i * 0.785f; oled.drawLine(x + 10 + cosf(a) * 6, y + 8 + sinf(a) * 6, x + 10 + cosf(a) * 8, y + 8 + sinf(a) * 8); }
  } else if (code == 2) { oled.drawDisc(x + 14, y + 4, 3); drawCloud(x, y + 2); }
  else if (code == 3) drawCloud(x, y + 2);
  else if (code == 45 || code == 48) { for (int i = 0; i < 4; i++) oled.drawHLine(x + 2 + (i % 2) * 2, y + 3 + i * 4, 16); }
  else if ((code >= 71 && code <= 77) || code == 85 || code == 86) { drawCloud(x, y); for (int i = 0; i < 3; i++) oled.drawDisc(x + 5 + i * 5, y + 15, 1); }
  else if (code >= 95) { drawCloud(x, y); oled.drawLine(x + 11, y + 11, x + 8, y + 15); oled.drawLine(x + 8, y + 15, x + 12, y + 15); oled.drawLine(x + 12, y + 15, x + 9, y + 19); }
  else { drawCloud(x, y); for (int i = 0; i < 3; i++) oled.drawLine(x + 6 + i * 4, y + 13, x + 4 + i * 4, y + 17); }
}

// ============================================================ screens
void drawClock() {
  struct tm tm; bool ok = localNow(tm);
  char b[24];
  if (ok) strftime(b, sizeof(b), "%a %d %b", &tm); else strcpy(b, apMode ? "Setup mode" : (wifiUp ? "Syncing time" : "No Wi-Fi"));
  centerStr(9, u8g2_font_6x10_tr, b);
  if (ok) strftime(b, sizeof(b), "%H:%M", &tm); else strcpy(b, "--:--");
  oled.setFont(u8g2_font_logisoso26_tn);
  int w = oled.getStrWidth(b);
  oled.drawStr((128 - w) / 2, 40, b);
  if (ok) { int sx = (128 + w) / 2 + 3; oled.setFont(u8g2_font_5x7_tr); snprintf(b, sizeof(b), "%02d", tm.tm_sec); oled.drawStr(sx, 40, b); }
  if (wx.ok) {
    drawWxIcon(2, 45, wx.code);
    oled.setFont(u8g2_font_6x10_tf);
    snprintf(b, sizeof(b), "%.0f\xb0" "C %s", wx.temp, wxText(wx.code));
    oled.drawStr(26, 54, b);
    oled.setFont(u8g2_font_5x7_tr);
    snprintf(b, sizeof(b), "H%.0f L%.0f %d%%", wx.tmax, wx.tmin, wx.hum);
    oled.drawStr(26, 63, b);
  } else {
    centerStr(58, u8g2_font_5x7_tr, S.city[0] ? "weather loading..." : "set a city for weather");
  }
}

void drawFocus() {
  char r[24];
  snprintf(r, sizeof(r), "today %um", focusToday());
  header(!fx.running ? "FOCUS" : fx.isBreak ? "BREAK" : (String("FOCUS #") + fx.round).c_str(), r);
  String t = mmss(focusRemain());
  oled.setFont(u8g2_font_logisoso24_tn);
  oled.drawStr((128 - oled.getStrWidth(t.c_str())) / 2, 42, t.c_str());
  float frac = fx.running ? 1.0f - (float)focusRemain() / fx.totalMs : 0;
  bar(4, 46, 120, 7, frac);
  centerStr(63, u8g2_font_5x7_tr, fx.paused ? ((millis() / 500) % 2 ? "PAUSED - tap resume" : "") : fx.running ? "tap pause - hold stop" : "tap start - hold break");
}

void drawTasks() {
  char r[16]; snprintf(r, sizeof(r), "%u left", tasksLeft());
  header("TASKS", r);
  if (!nTasks) {
    centerStr(30, u8g2_font_6x10_tr, "No tasks yet");
    centerStr(44, u8g2_font_5x7_tr, "add from phone:");
    centerStr(54, u8g2_font_5x7_tr, "lilmate.local or /task");
    return;
  }
  if (taskCur >= nTasks) taskCur = 0;
  int first = taskCur > 2 ? taskCur - 2 : 0;
  if (first + 4 > nTasks) first = max(0, nTasks - 4);
  oled.setFont(u8g2_font_6x10_tr);
  for (int i = first, row = 0; i < nTasks && row < 4; i++, row++) {
    int y = 23 + row * 12;
    if (i == taskCur) { oled.drawRBox(0, y - 9, 128, 12, 2); oled.setDrawColor(0); }
    oled.drawFrame(3, y - 7, 7, 7);
    if (tasks[i].done) { oled.drawLine(4, y - 4, 6, y - 2); oled.drawLine(6, y - 2, 9, y - 7); }
    char t[20]; copyStr(t, tasks[i].text, sizeof(t));
    oled.drawStr(14, y, t);
    if (tasks[i].done) oled.drawHLine(14, y - 3, oled.getStrWidth(t));
    oled.setDrawColor(1);
  }
}

void drawHabits() {
  char r[12]; snprintf(r, sizeof(r), "%u/%u", nHabits ? habitCur + 1 : 0, nHabits);
  header("HABITS", r);
  if (!nHabits) {
    centerStr(30, u8g2_font_6x10_tr, "No habits yet");
    centerStr(46, u8g2_font_5x7_tr, "e.g. /habit water 8");
    return;
  }
  if (habitCur >= nHabits) habitCur = 0;
  Habit &h = habits[habitCur]; habitRoll(h);
  centerStr(28, u8g2_font_7x14B_tr, h.name);
  if (h.goal <= 10) {
    int sp = 12, x0 = 64 - (h.goal * sp) / 2 + sp / 2;
    for (int i = 0; i < h.goal; i++) { if (i < h.count) oled.drawDisc(x0 + i * sp, 39, 4); else oled.drawCircle(x0 + i * sp, 39, 4); }
  } else bar(8, 35, 112, 8, (float)h.count / h.goal);
  char b[32]; snprintf(b, sizeof(b), "%u/%u today  streak %ud", h.count, h.goal, h.streak);
  centerStr(54, u8g2_font_5x7_tr, b);
  centerStr(63, u8g2_font_5x7_tr, h.count >= h.goal ? "done for today!" : "tap next - hold +1");
}

void drawPc() {
  if (!pcOnline()) {
    header("PC");
    centerStr(30, u8g2_font_6x10_tr, "agent offline");
    centerStr(44, u8g2_font_5x7_tr, "run lilmate_agent.py");
    centerStr(54, u8g2_font_5x7_tr, "on your computer");
    return;
  }
  header("PC", pc.host);
  char b[24];
  oled.setFont(u8g2_font_5x7_tr);
  snprintf(b, sizeof(b), "CPU %3.0f%%", pc.cpu); oled.drawStr(0, 22, b); bar(48, 15, 80, 8, pc.cpu / 100);
  snprintf(b, sizeof(b), "RAM %3.0f%%", pc.ram); oled.drawStr(0, 34, b); bar(48, 27, 80, 8, pc.ram / 100);
  if (pc.bat >= 0) { snprintf(b, sizeof(b), "BAT %3d%%%s", pc.bat, pc.charging ? "+" : ""); oled.drawStr(0, 46, b); bar(48, 39, 80, 8, pc.bat / 100.0f); }
  char t[26]; copyStr(t, asciiOnly(pc.title).c_str(), sizeof(t));
  oled.drawStr(0, 60, t);
}

// ------------------------------------------------------------ Star Catch game
struct GObj { float x, y, v; uint8_t kind; bool on; };
struct { bool playing, over; float px, pv; int score, lives; uint32_t nextSpawn, overAt, hitAt; GObj o[6]; } gm = {};

void gameStart() {
  gm.playing = true; gm.over = false; gm.px = 64; gm.pv = 1.3f; gm.score = 0; gm.lives = 3; gm.hitAt = 0;
  for (auto &o : gm.o) o.on = false;
  gm.nextSpawn = millis() + 700;
}
void gamePress() { if (gm.playing) gm.pv = -gm.pv; }
void gameTap() { if (!gm.playing && (!gm.over || millis() - gm.overAt > 700)) gameStart(); }
// Remote game input from the web dashboard / keyboard: L = left, R = right, T = start/turn, X = quit
void gameKey(char k) {
  markActivity();
  if (asleep || displayOff) wakeUp(false);
  if (al.active) { dismissAlert(false); return; }
  if (k == 'X') { gm.playing = false; gm.over = false; screen = S_FACE; return; }
  if (screen != S_GAME) { screen = S_GAME; gm.playing = false; gm.over = false; }
  if (!gm.playing) { gameTap(); return; }      // any key starts / restarts
  if (k == 'L') gm.pv = -fabsf(gm.pv);
  else if (k == 'R') gm.pv = fabsf(gm.pv);
  else gamePress();                            // T = turn around, same as a tap
}
void gameStep(uint32_t now) {
  if (!gm.playing) return;
  float speed = 1.0f + gm.score * 0.04f;
  gm.px += gm.pv * speed;
  if (gm.px < 9 || gm.px > 119) { gm.pv = -gm.pv; gm.px = constrain(gm.px, 9.0f, 119.0f); }
  if (now > gm.nextSpawn) {
    for (auto &o : gm.o) if (!o.on) {
      o.on = true; o.x = random(8, 120); o.y = 12; o.kind = random(0, 100) < 72 ? 0 : 1;
      o.v = 0.55f + random(0, 40) / 100.0f + gm.score * 0.025f;
      break;
    }
    gm.nextSpawn = now + max(380, 1100 - gm.score * 25);
  }
  for (auto &o : gm.o) if (o.on) {
    o.y += o.v;
    if (o.y > 50 && o.y < 60 && fabsf(o.x - gm.px) < 10) {
      o.on = false;
      if (o.kind == 0) gm.score++;
      else { gm.lives--; gm.hitAt = now; }
    } else if (o.y > 66) o.on = false;
  }
  if (gm.lives <= 0) {
    gm.playing = false; gm.over = true; gm.overAt = now;
    if (gm.score > pet.gameBest) { pet.gameBest = gm.score; markDirty(D_PET); }
    petHappy(5);
  }
}
void drawGame(uint32_t now) {
  char b[24];
  if (!gm.playing && !gm.over) {
    centerStr(16, u8g2_font_7x14B_tr, "STAR CATCH");
    centerStr(30, u8g2_font_5x7_tr, "catch stars, dodge rocks");
    centerStr(40, u8g2_font_5x7_tr, "tap = turn around");
    snprintf(b, sizeof(b), "best %u", pet.gameBest); centerStr(52, u8g2_font_5x7_tr, b);
    centerStr(62, u8g2_font_5x7_tr, "tap to play - hold exit");
    return;
  }
  oled.setFont(u8g2_font_5x7_tr);
  snprintf(b, sizeof(b), "%d", gm.score); oled.drawStr(1, 7, b);
  for (int i = 0; i < gm.lives; i++) drawHeart(122 - i * 9, 4, 7);
  oled.drawHLine(0, 9, 128);
  for (auto &o : gm.o) if (o.on) {
    int x = o.x, y = o.y;
    if (o.kind == 0) { oled.drawLine(x - 3, y, x + 3, y); oled.drawLine(x, y - 3, x, y + 3); oled.drawPixel(x - 2, y - 2); oled.drawPixel(x + 2, y + 2); oled.drawPixel(x + 2, y - 2); oled.drawPixel(x - 2, y + 2); }
    else { oled.drawDisc(x, y, 3); }
  }
  int px = gm.px;
  bool hit = gm.hitAt && now - gm.hitAt < 400;
  oled.drawRBox(px - 9, 54, 18, 10, 3);
  oled.setDrawColor(0);
  if (hit) { oled.drawLine(px - 6, 56, px - 3, 59); oled.drawLine(px - 3, 56, px - 6, 59); oled.drawLine(px + 3, 56, px + 6, 59); oled.drawLine(px + 6, 56, px + 3, 59); }
  else { int d = gm.pv > 0 ? 1 : -1; oled.drawBox(px - 5 + d, 56, 3, 4); oled.drawBox(px + 2 + d, 56, 3, 4); }
  oled.setDrawColor(1);
  if (gm.over) {
    oled.setDrawColor(0); oled.drawBox(14, 18, 100, 30); oled.setDrawColor(1); oled.drawRFrame(14, 18, 100, 30, 4);
    snprintf(b, sizeof(b), "score %d  best %u", gm.score, pet.gameBest);
    centerStr(30, u8g2_font_6x10_tr, "GAME OVER"); centerStr(42, u8g2_font_5x7_tr, b);
  }
}

String dashUrl() { return "http://" + WiFi.localIP().toString(); }

void drawInfo(uint32_t now) {
  if (now < qrUntil && wifiUp) {
    qrBuild(dashUrl());
    qrDraw(0, 0);
    oled.setFont(u8g2_font_5x7_tr);
    oled.drawStr(64, 12, "scan to open");
    oled.drawStr(64, 21, "dashboard");
    oled.drawStr(64, 36, "or visit");
    oled.drawStr(64, 45, "lilmate.local");
    return;
  }
  header("INFO", FW_VERSION);
  char b[32];
  oled.setFont(u8g2_font_5x7_tr);
  if (wifiUp) snprintf(b, sizeof(b), "IP %s", WiFi.localIP().toString().c_str()); else strcpy(b, "Wi-Fi: not connected");
  oled.drawStr(0, 21, b);
  snprintf(b, sizeof(b), "%s  %ddBm", wifiUp ? HOSTNAME ".local" : "-", wifiUp ? WiFi.RSSI() : 0); oled.drawStr(0, 30, b);
  snprintf(b, sizeof(b), "Telegram: %s", !S.tgToken[0] ? "off" : !S.tgChat[0] ? "send /start" : tgLastCode == 200 ? "ok" : "connecting");
  oled.drawStr(0, 39, b);
  if (batPresent) snprintf(b, sizeof(b), "up %luh%02lum  battery %d%%", (unsigned long)(now / 3600000), (unsigned long)(now / 60000 % 60), batPct);
  else snprintf(b, sizeof(b), "up %luh%02lum  heap %uk", (unsigned long)(now / 3600000), (unsigned long)(now / 60000 % 60), (unsigned)(ESP.getFreeHeap() / 1024));
  oled.drawStr(0, 48, b);
  snprintf(b, sizeof(b), "pats %lu  joy %d%%", (unsigned long)pet.pats, pet.happy); oled.drawStr(0, 57, b);
  oled.drawStr(0, 64, "hold: QR  hold 4s: setup");
}

void drawSetup(uint32_t now) {
  bool showUrl = (now / 8000) % 2;
  qrBuild(showUrl ? String("http://192.168.4.1") : "WIFI:T:nopass;S:" + apName + ";;");
  qrDraw(0, 0);
  oled.setFont(u8g2_font_5x7_tr);
  oled.drawStr(62, 8, "WI-FI SETUP");
  oled.drawStr(62, 20, showUrl ? "2. open page" : "1. join Wi-Fi");
  oled.drawStr(62, 30, showUrl ? "192.168.4.1" : apName.c_str());
  oled.drawStr(62, 44, "scan the QR");
  oled.drawStr(62, 53, "with your");
  oled.drawStr(62, 62, "phone camera");
}

// ============================================================ wake / sleep
void wakeUp(bool greet) {
  markActivity();
  if (displayOff) { oled.setPowerSave(0); displayOff = false; }
  if (asleep) {
    asleep = false;
    oled.setContrast(S.contrast);
    faceSetMood(M_SURPRISED, 600);
    restMood = M_NEUTRAL;
    if (greet) {
      int h = localHour();
      String g = !timeOk() ? "Hi " : h < 12 ? "Good morning " : h < 17 ? "Hi " : "Good evening ";
      faceSay(g + S.owner + "!");
    }
  }
}
void goSleep() {
  if (asleep) return;
  asleep = true; screen = S_FACE;
  faceSetMood(M_SLEEP);
  oled.setContrast(8);
}
bool nightNow() {
  if (!timeOk() || S.sleepFrom == S.sleepTo) return false;
  int h = localHour();
  return S.sleepFrom > S.sleepTo ? (h >= S.sleepFrom || h < S.sleepTo) : (h >= S.sleepFrom && h < S.sleepTo);
}

// ============================================================ summaries
String statusText(bool morning) {
  String s;
  if (morning) s = "Good morning " + String(S.owner) + "! ☀️\n";
  else s = "🤖 Lilmate status\n";
  if (wx.ok) { char b[64]; snprintf(b, sizeof(b), "🌤 %s %.0f°C, %s (H%.0f L%.0f)\n", wx.place, wx.temp, wxText(wx.code), wx.tmax, wx.tmin); s += b; if (wxRainy()) s += "☔ Take an umbrella!\n"; }
  s += "📋 Tasks left: " + String(tasksLeft());
  int shown = 0;
  for (int i = 0; i < nTasks && shown < 5; i++) if (!tasks[i].done) { s += (shown ? ", " : " - ") + String(tasks[i].text); shown++; }
  s += "\n";
  int nr = nextReminder();
  if (nr >= 0 && timeOk()) {
    time_t t = rems[nr].due; struct tm tm; localtime_r(&t, &tm); char b[12]; strftime(b, sizeof(b), "%H:%M", &tm);
    s += "⏰ Next: " + String(b) + " " + rems[nr].text + "\n";
  }
  if (nHabits) {
    s += "🔁 Habits:";
    for (int i = 0; i < nHabits; i++) { habitRoll(habits[i]); s += " " + String(habits[i].name) + " " + habits[i].count + "/" + habits[i].goal + (i < nHabits - 1 ? "," : ""); }
    s += "\n";
  }
  if (!morning) {
    s += "🎯 Focus today: " + String(focusToday()) + " min";
    if (fx.running) s += String(fx.isBreak ? " (break " : " (focusing ") + mmss(focusRemain()) + " left)";
    s += "\n💛 Happiness " + String(pet.happy) + "%, pats " + String(pet.pats);
  }
  return s;
}

String chatterLine() {
  int left = tasksLeft();
  int nr = nextReminder();
  switch (random(0, 8)) {
    case 0: if (left) return String(left) + (left == 1 ? " task left!" : " tasks left. You got this!"); break;
    case 1:
      if (nr >= 0 && timeOk() && rems[nr].due > nowEpoch() && rems[nr].due - nowEpoch() < 3600)
        return String("Soon: ") + rems[nr].text + " in " + String((rems[nr].due - nowEpoch()) / 60 + 1) + "m";
      break;
    case 2:
      for (int i = 0; i < nHabits; i++) { habitRoll(habits[i]); if (habits[i].count < habits[i].goal) return String("Don't forget: ") + habits[i].name + " " + habits[i].count + "/" + habits[i].goal; }
      break;
    case 3: if (wxRainy()) return "Rainy out. Umbrella!"; if (wx.ok && wx.temp > 33) return "So hot! Drink water"; break;
    case 4: if (!fx.running && focusToday() == 0 && localHour() >= 9 && localHour() < 19) return "Focus session? 2-tap x2"; break;
    case 5: if (pet.happy < 40) return "Pat my head? :("; break;
  }
  static const char *lines[] = { "Hi %s!", "I like it here.", "*hums a tune*", "Pat my head!", "You're doing great", "Stay hydrated!", "Stretch time?", "Beep boop :)" };
  char b[40]; snprintf(b, sizeof(b), lines[random(0, 8)], S.owner);
  return b;
}

// ============================================================ input
void nextScreen() {
  screen = (Screen)((screen + 1) % S_COUNT);
  if (screen == S_GAME) { gm.playing = false; gm.over = false; }
  if (screen == S_INFO) qrUntil = 0;
}

void onFaceGesture(TouchEv e, uint32_t now) {
  switch (e) {
    case T_PRESS: blinkAt = now; break;
    case T_TAP1:
      if (toy == TOY_FLY) { toy = TOY_NONE; gazeHold = false; faceSetMood(M_LAUGH, 2000); faceSay("Got it! hehe"); petHappy(4); break; }
      pet.pats++; petHappy(6);
      { Mood r[] = { M_HAPPY, M_HAPPY, M_LAUGH, M_WINK, M_LOVE }; faceSetMood(r[random(0, pet.happy > 60 ? 5 : 3)], 2500); }
      if (random(0, 10) < 4) { static const char *p[] = { "Pat pat! ^_^", "Hehe that tickles", "Yay!", "More pats pls", "<3 <3", "I'm happy!" }; faceSay(p[random(0, 6)]); }
      break;
    case T_TAP3:
      if (random(0, 2)) { startToy(TOY_FLY, 10000); faceSetMood(M_CURIOUS, 1500); faceSay("A fly! tap to catch"); }
      else { startToy(TOY_BALL, 8000); faceSetMood(M_HAPPY, 1500); }
      break;
    case T_LONG: faceSetMood(M_LOVE, 600000); pet.pats++; petHappy(10); break;
    case T_VLONG: breatheStart(); break;   // hold 4 s: breathe with me
    case T_RELEASE: if (mood == M_LOVE && moodUntil) { faceSetMood(M_HAPPY, 2500); faceSay("Purr... <3"); } break;
    default: break;
  }
}

void onScreenGesture(TouchEv e, uint32_t now) {
  switch (screen) {
    case S_CLOCK:
      if (e == T_TAP1) { wxRequest = true; }
      break;
    case S_FOCUS:
      if (e == T_TAP1) { if (!fx.running) focusStart(S.focusMin); else focusTogglePause(); }
      else if (e == T_LONG) { if (fx.running) focusStop(); else focusBreak(S.breakMin); }
      break;
    case S_TASKS:
      if (e == T_TAP1 && nTasks) taskCur = (taskCur + 1) % nTasks;
      else if (e == T_LONG && taskCur < nTasks) {
        tasks[taskCur].done ^= 1; markDirty(D_TASK);
        if (tasks[taskCur].done) { pet.tasksDone++; petHappy(8); tgNotify(String("✅ Done: ") + tasks[taskCur].text); }
      }
      break;
    case S_HABITS:
      if (e == T_TAP1 && nHabits) habitCur = (habitCur + 1) % nHabits;
      else if (e == T_LONG && habitCur < nHabits) {
        int r = logHabit(habitCur);
        if (r == 2) { petHappy(10); screen = S_FACE; faceSetMood(M_LOVE, 2500); faceSay(String(habits[habitCur].name) + " done! streak " + habits[habitCur].streak); }
      }
      break;
    case S_GAME:
      if (e == T_PRESS) gamePress();
      else if (e == T_TAP1) gameTap();
      else if (e == T_LONG) { gm.playing = false; gm.over = false; screen = S_FACE; }
      break;
    case S_INFO:
      if (e == T_LONG) qrUntil = now + 20000;
      else if (e == T_VLONG) { faceSay("Setup mode..."); startAP(); }
      break;
    default: break;
  }
}

void handleTouch(uint32_t now) {
  TouchEv e;
  while ((e = touchNext()) != T_NONE) {
    if (e == T_PRESS && (asleep || displayOff)) { wakeUp(true); swallowGesture = true; continue; }
    if (swallowGesture) { if (e == T_TAP1 || e == T_TAP2 || e == T_TAP3 || e == T_LONG) swallowGesture = false; continue; }
    markActivity();
    if (apMode) continue;
    if (al.active) {
      if (e == T_TAP1 || e == T_TAP2 || e == T_TAP3) dismissAlert(false);
      else if (e == T_LONG) dismissAlert(true);
      continue;
    }
    if (linkBusy() ? linkTouch(e) : (agentTouch(e) || workTouch(e) || linkTouch(e))) continue;   // matches, agent prompts, breathe / wrap-up, invites
    if (screen == S_GAME && gm.playing) { onScreenGesture(e, now); continue; }  // raw presses, no tap counting
    if (e == T_TAP2) { nextScreen(); continue; }
    if (e == T_TAP3 && screen != S_FACE) { screen = S_FACE; continue; }
    if (screen == S_FACE) onFaceGesture(e, now); else onScreenGesture(e, now);
  }
}

// ============================================================ brain (1 Hz)
uint32_t nextIdleMood = 20000, nextChatter = 90000, lastDecay = 0;
int32_t  lastMinuteChecked = -1;

void checkReminders() {
  if (!nRems) return;
  uint32_t n = nowEpoch();
  for (int i = 0; i < nRems; i++) {
    if (rems[i].due > n) continue;
    String t = rems[i].text;
    if (rems[i].daily) { while (rems[i].due <= n) rems[i].due += 86400; markDirty(D_REM); }
    else { delReminder(i); i--; }
    raiseAlert(AK_REMIND, "Reminder: " + t);
    tgNotify("⏰ Reminder: " + t);
  }
}

void focusTick() {
  if (!fx.running || fx.paused || focusRemain() > 0) return;
  if (!fx.isBreak) {
    focusMinutesAdd(fx.plannedMin); petHappy(15);
    fx.running = false;
    raiseAlert(AK_FOCUS, "Focus done! Take a " + String(S.breakMin) + "m break");
    tgNotify("🎯 Focus session done (" + String(fx.plannedMin) + " min). Today: " + focusToday() + " min. Break time!");
    focusBreak(S.breakMin);
    faceSay(al.text, 0, true);
  } else {
    fx.running = false; fx.isBreak = false;
    raiseAlert(AK_FOCUS, "Break over! Ready?");
    tgNotify("⏱ Break over. Send /focus for the next round.");
  }
}

void brainTick(uint32_t now) {
  uint32_t idle = now - lastActivity;

  // timed screens fall back to the face
  if (screen != S_FACE && idle > IDLE_TO_FACE_MS && !(screen == S_GAME && gm.playing) && !(screen == S_FOCUS && fx.running) && !linkBusy()) screen = S_FACE;

  if (timeOk()) checkReminders();
  focusTick();

  // alerts: flash for 8 s, auto-clear after 5 min (messages 2 min)
  if (al.active) {
    uint32_t age = now - al.at;
    if (al.kind != AK_MSG && age < 8000) setInvert(!inverted); else setInvert(false);
    if (age > (al.kind == AK_MSG ? 120000UL : 300000UL)) dismissAlert(false);
  }

  // focus overlay
  if (fx.running) topLine = String(fx.isBreak ? "BREAK " : "FOCUS ") + mmss(focusRemain()) + (fx.paused ? " ||" : "");
  else topLine = "";

  // resting mood + sleep
  if (!al.active) {
    bool night = nightNow();
    if (fx.running) { if (!asleep) faceSetRest(fx.isBreak ? M_HAPPY : M_FOCUS); }
    else if (!asleep && (idle > SLEEP_AFTER_MS || (night && idle > 60000))) goSleep();
    else if (!asleep) faceSetRest(idle > SLEEPY_AFTER_MS || (night && idle > 30000) ? M_SLEEPY : pet.happy < 30 ? M_SAD : M_NEUTRAL);
    if (asleep && !displayOff && idle > SLEEP_AFTER_MS + screenOffMs) { oled.setPowerSave(1); displayOff = true; }
  }

  // happiness slowly decays while awake
  if (!asleep && now - lastDecay > 240000) { lastDecay = now; petHappy(-1); }

  // idle personality on the face
  if (screen == S_FACE && !asleep && !al.active && !moodUntil && toy == TOY_NONE && !fx.running && !isBusy()) {   // quiet while busy
    if (now > nextIdleMood) {
      nextIdleMood = now + random(15000, 40000);
      int r = random(0, 10);
      if (r < 2) startToy(random(0, 2) ? TOY_FLY : TOY_BALL, random(5000, 9000));
      else { Mood m[] = { M_CURIOUS, M_HAPPY, M_THINK, M_WINK, M_COOL, M_SURPRISED, M_HAPPY, M_CURIOUS }; faceSetMood(m[random(0, 8)], random(1800, 3200)); }
    }
    if (now > nextChatter && !faceBubbleOn(now)) { nextChatter = now + random(120000, 240000); faceSay(chatterLine()); }
  }

  // once a minute: habit day rollover + morning summary
  if (timeOk()) {
    struct tm tm; localNow(tm);
    int32_t minuteKey = tm.tm_hour * 60 + tm.tm_min;
    if (minuteKey != lastMinuteChecked) {
      lastMinuteChecked = minuteKey;
      for (int i = 0; i < nHabits; i++) habitRoll(habits[i]);
      int32_t t = todayIdx();
      if (S.summaryHour < 24 && tm.tm_hour == S.summaryHour && pet.summaryDay != t) {
        pet.summaryDay = t; markDirty(D_PET);
        tgNotify(statusText(true), true);
        wakeUp(false);
        faceSetMood(M_HAPPY, 4000);
        String g = String("Good morning ") + S.owner + "! " + tasksLeft() + " tasks today";
        if (wx.ok) g += ", " + String(wx.temp, 0) + "C";
        faceSay(g);
      }
    }
  }
}

// ============================================================ render
void render(uint32_t now) {
  oled.clearBuffer();
  if (apMode) drawSetup(now);
  else if (linkBusy() ? linkDraw(now) : (agentDraw(now) || workDraw(now) || linkDraw(now))) {}   // same priority as touch
  else switch (screen) {
    case S_FACE:   faceDraw(now); if (isBusy()) drawDndIcon(1, 0); drawBatteryIcon(114, 0); break;
    case S_AGENTS: drawAgents(now); break;
    case S_PLAY:   drawPlay(now); break;
    case S_CLOCK:  drawClock(); break;
    case S_FOCUS:  drawFocus(); break;
    case S_TASKS:  drawTasks(); break;
    case S_HABITS: drawHabits(); break;
    case S_PC:     drawPc(); break;
    case S_GAME:   drawGame(now); break;
    case S_INFO:   drawInfo(now); break;
    default: break;
  }
  oled.sendBuffer();
}
