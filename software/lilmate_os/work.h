// Everyday desk life: busy / do-not-disturb, meeting heads-up, breathe-with-me, end-of-day wrap-up
#pragma once
#include "config.h"

// ============================================================ busy / do-not-disturb
// auto = busy while you type steadily (PC agent activity), during a focus session or a meeting.
uint8_t dndMode = 0;            // 0 auto, 1 always on, 2 off
bool    busyAuto = false;
uint32_t busyHoldUntil = 0;
struct Meet { uint32_t t, e; char s[32]; uint8_t warned; };
#define MAX_MEETS 6
Meet meets[MAX_MEETS]; uint8_t nMeets = 0;

Meet *meetingNow() { uint32_t n = nowEpoch(); for (int i = 0; i < nMeets; i++) if (meets[i].t <= n && n < meets[i].e) return &meets[i]; return nullptr; }
Meet *nextMeeting() { uint32_t n = nowEpoch(); Meet *b = nullptr; for (int i = 0; i < nMeets; i++) if (meets[i].t > n && (!b || meets[i].t < b->t)) b = &meets[i]; return b; }

bool isBusy() {
  if (dndMode == 1) return true;
  if (dndMode == 2) return false;
  return busyAuto || (fx.running && !fx.isBreak) || (timeOk() && meetingNow());
}
const char *busyReason() {
  if (dndMode == 1) return "do not disturb";
  if (timeOk() && meetingNow()) return "in a meeting";
  if (fx.running && !fx.isBreak) return "focusing";
  return "in the zone";
}
void setDnd(uint8_t m) { dndMode = m > 2 ? 0 : m; prefs.putUChar("dnd", dndMode); }

void drawDndIcon(int x, int y) {   // "no entry" sign
  oled.drawDisc(x + 4, y + 4, 4); oled.setDrawColor(0); oled.drawBox(x + 1, y + 3, 7, 3); oled.setDrawColor(1);
}

// ============================================================ breathe with me (6 breaths/min: 4 s in, 6 s out)
struct { bool on; uint32_t t0; } br = {};
#define BR_TOTAL 60000
void breatheStart() { br.on = true; br.t0 = millis(); wakeUp(false); screen = S_FACE; faceClearBubble(); }
void breatheStop(bool done) {
  br.on = false;
  if (done) { petHappy(6); faceSetMood(M_HAPPY, 4000); faceSay("Nice. Feel lighter?"); }
}
bool drawBreathe(uint32_t now) {
  if (!br.on) return false;
  now = millis();
  uint32_t el = now - br.t0;
  if (el >= BR_TOTAL) { breatheStop(true); return false; }
  uint32_t c = el % 10000;
  bool in = c < 4000;
  float k = in ? c / 4000.0f : 1.0f - (c - 4000) / 6000.0f;     // 0..1 lung fullness
  k = k * k * (3 - 2 * k);                                        // smooth
  int r = 6 + (int)(k * 20);
  oled.drawCircle(64, 30, r + 3);
  oled.drawDisc(64, 30, r);
  oled.setDrawColor(0);                                           // two calm closed eyes on the "belly"
  if (r > 10) { oled.drawHLine(64 - r / 2 - 3, 28, 6); oled.drawHLine(64 + r / 2 - 3, 28, 6); }
  oled.setDrawColor(1);
  oled.setFont(u8g2_font_6x10_tr);
  const char *t = in ? "breathe in" : "breathe out";
  oled.drawStr(max(0, (128 - (int)oled.getStrWidth(t)) / 2), 63, t);
  oled.setFont(u8g2_font_5x7_tr);
  char b[12]; snprintf(b, sizeof(b), "%lus", (unsigned long)((BR_TOTAL - el) / 1000 + 1));
  oled.drawStr(127 - oled.getStrWidth(b), 7, b);
  return true;
}

// ============================================================ end-of-day wrap-up
int16_t workEndMin = 18 * 60 + 30;  // minutes after midnight, -1 = off
bool    wrapAsk = false, offDuty = false;
int32_t wrapDay = -1, offDutyDay = -1;
uint32_t wrapAskAt = 0, wrapSnoozeUntil = 0, lateNudgeAt = 0, wrapShowUntil = 0;
uint8_t wrapDoneTasks = 0;

void wrapUp() {
  wrapAsk = false; offDuty = true; offDutyDay = todayIdx(); prefs.putInt("offday", offDutyDay);
  wrapShowUntil = millis() + 7000;
  setInvert(false); faceClearBubble();
  String s = "🌙 Day wrapped!\n🎯 Focus: " + String(focusToday()) + " min\n📋 " + String(tasksLeft()) + " task(s) carried to tomorrow";
  for (int i = 0, n = 0; i < nTasks && n < 4; i++) if (!tasks[i].done) { s += String(n ? ", " : ": ") + tasks[i].text; n++; }
  tgNotify(s + "\nSwitch off and rest well 💛");
  petHappy(5);
}
bool drawWrap(uint32_t now) {
  if (wrapShowUntil && now < wrapShowUntil) {
    header("DAY WRAPPED", "bye!");
    char b[32];
    snprintf(b, sizeof(b), "focus today: %u min", focusToday()); centerStr(28, u8g2_font_6x10_tr, b);
    snprintf(b, sizeof(b), "%u tasks -> tomorrow", tasksLeft()); centerStr(41, u8g2_font_6x10_tr, b);
    centerStr(58, u8g2_font_5x7_tr, "switch off & rest well");
    return true;
  }
  if (!wrapAsk) return false;
  header("WORK'S DONE?", "");
  char b[32]; snprintf(b, sizeof(b), "%u tasks left, %um focus", tasksLeft(), focusToday());
  centerStr(29, u8g2_font_5x7_tr, b);
  centerStr(43, u8g2_font_7x14B_tr, "wrap up the day?");
  centerStr(63, u8g2_font_5x7_tr, (now / 600) % 2 ? "HOLD = WRAP  TAP = LATER" : "hold = wrap  tap = later");
  return true;
}

// ============================================================ shared hooks used by apps.h
bool workDraw(uint32_t now) { return drawBreathe(now) || drawWrap(now); }
bool workOverlay() { return br.on || wrapAsk || (wrapShowUntil && millis() < wrapShowUntil); }

bool workTouch(TouchEv e) {
  if (br.on) { if (e == T_TAP1 || e == T_TAP2 || e == T_LONG) breatheStop(false); return e != T_PRESS && e != T_RELEASE; }
  if (wrapAsk) {
    if (e == T_LONG) wrapUp();
    else if (e == T_TAP1 || e == T_TAP2) { wrapAsk = false; wrapSnoozeUntil = millis() + 1800000; setInvert(false); faceSay("Okay, 30 more min"); }
    return e != T_PRESS && e != T_RELEASE;
  }
  if (wrapShowUntil && millis() < wrapShowUntil) { if (e == T_TAP1) wrapShowUntil = 0; return true; }
  return false;
}

void workTick(uint32_t now) {
  now = millis();
  // --- busy from PC activity (hysteresis: on >= 60% active over 3 min, off below 35% after a 2 min hold)
  if (pcOnline() && pc.act >= 0.6f) { if (!busyAuto) Serial.println("[busy] in the zone"); busyAuto = true; busyHoldUntil = now + 120000; }
  else if (busyAuto && (!pcOnline() || (pc.act < 0.35f && now > busyHoldUntil))) busyAuto = false;

  // --- meetings
  if (timeOk()) {
    uint32_t n = nowEpoch();
    for (int i = 0; i < nMeets; i++) {
      Meet &m = meets[i];
      if (!(m.warned & 1) && m.t > n + 20 && m.t - n <= 300) {
        m.warned |= 1;
        raiseAlert(AK_REMIND, String("Meeting in ") + ((m.t - n + 59) / 60) + " min: " + m.s);
        tgNotify(String("📅 In ") + ((m.t - n + 59) / 60) + " min: " + m.s);
      }
      if (!(m.warned & 2) && n >= m.t && n < m.t + 120) { m.warned |= 3; raiseAlert(AK_REMIND, String("Meeting now: ") + m.s); }
    }
    for (int i = 0; i < nMeets; i++) if (n > meets[i].e + 60) { for (int k = i; k < nMeets - 1; k++) meets[k] = meets[k + 1]; nMeets--; i--; }
  }

  // --- top line on the face (focus timer and agent timer keep priority)
  if (!fx.running && timeOk()) {   // a meeting soon beats the agent timer; only the focus timer beats a meeting
    uint32_t n = nowEpoch();
    Meet *cur = meetingNow(), *nx = nextMeeting();
    if (cur) { char b[16]; time_t e = cur->e; struct tm tm; localtime_r(&e, &tm); strftime(b, sizeof(b), "%H:%M", &tm); topLine = String("in meeting - till ") + b; }
    else if (nx && nx->t - n <= 900) { char s[14]; copyStr(s, nx->s, sizeof(s)); topLine = String(s) + " in " + ((nx->t - n + 59) / 60) + "m"; }
  }
  if (!topLine.length() && isBusy()) topLine = String("busy - ") + busyReason();
  if (isBusy() && !asleep && !fx.running && restMood == M_NEUTRAL) faceSetRest(M_FOCUS);
  else if (!isBusy() && restMood == M_FOCUS && !fx.running) faceSetRest(M_NEUTRAL);

  // --- end of day
  if (timeOk() && workEndMin >= 0) {
    struct tm tm; localNow(tm);
    int mins = tm.tm_hour * 60 + tm.tm_min;
    int32_t today = todayIdx();
    bool weekday = tm.tm_wday >= 1 && tm.tm_wday <= 5;
    if (!offDuty && offDutyDay == today) offDuty = true;                              // wrapped before a reboot
    if (offDuty && today != offDutyDay && tm.tm_hour >= 5) offDuty = false;          // new day
    if (weekday && !offDuty && !wrapAsk && wrapDay != today && mins >= workEndMin && now > wrapSnoozeUntil && mins < workEndMin + 240) {
      wrapAsk = true; wrapAskAt = now; wrapDay = today; prefs.putInt("wrapday", today); wakeUp(false);
    }
    if (wrapAsk && now - wrapAskAt > 1800000) { wrapAsk = false; wrapSnoozeUntil = now + 1800000; wrapDay = -1; }   // ignored: ask again later
    bool late = offDuty || (weekday && mins >= workEndMin + 60);
    if (late && pcOnline() && pc.act > 0.3f && now > lateNudgeAt && !asleep) {
      lateNudgeAt = now + 3600000;
      faceSetMood(M_SLEEPY, 4000); faceSay("Working late? Wrap up soon :)");
    }
  }
}

void workBegin() {
  dndMode = prefs.getUChar("dnd", 0);
  workEndMin = prefs.getShort("wend", 18 * 60 + 30);
  wrapDay = prefs.getInt("wrapday", -1);          // asked already today: a reboot does not ask again
  offDutyDay = prefs.getInt("offday", -1); offDuty = false;
}

String workEndText() { if (workEndMin < 0) return "off"; char b[8]; snprintf(b, sizeof(b), "%02d:%02d", workEndMin / 60, workEndMin % 60); return b; }

void calSet(JsonArrayConst arr) {
  Meet old[MAX_MEETS]; uint8_t nOld = nMeets; memcpy(old, meets, sizeof(meets));
  nMeets = 0;
  for (JsonObjectConst o : arr) {
    if (nMeets >= MAX_MEETS) break;
    Meet &m = meets[nMeets];
    m.t = o["t"] | 0; m.e = o["e"] | 0; copyStr(m.s, o["s"] | "meeting", sizeof(m.s));
    if (!m.t) continue;
    if (m.e <= m.t) m.e = m.t + 1800;
    m.warned = 0;
    for (int i = 0; i < nOld; i++) if (old[i].t == m.t && !strcmp(old[i].s, m.s)) m.warned = old[i].warned;   // don't re-alert
    nMeets++;
  }
}
String meetingsText() {
  if (!nMeets) return "📅 No meetings synced. On the PC: lilmate_agent.py set-calendar <ICS link>";
  String s = "📅 Next meetings\n";
  for (int i = 0; i < nMeets; i++) { char b[20]; time_t t = meets[i].t; struct tm tm; localtime_r(&t, &tm); strftime(b, sizeof(b), "%a %H:%M", &tm); s += String(b) + "  " + meets[i].s + "\n"; }
  return s;
}
void workJson(JsonObject o) {
  o["busy"] = isBusy(); o["reason"] = busyReason(); o["dnd"] = dndMode == 0 ? "auto" : dndMode == 1 ? "on" : "off";
  o["act"] = pc.act; o["workEnd"] = workEndText(); o["offDuty"] = offDuty; o["breathing"] = br.on;
  JsonArray a = o["meets"].to<JsonArray>();
  for (int i = 0; i < nMeets; i++) { JsonObject m = a.add<JsonObject>(); m["t"] = meets[i].t; m["e"] = meets[i].e; m["s"] = meets[i].s; }
}
