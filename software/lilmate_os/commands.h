// One command language for Telegram, the web dashboard, the PC agent and USB serial
#pragma once
#include "config.h"

static const char HELP_TEXT[] =
  "🤖 Lilmate commands\n"
  "/status - how everything is\n"
  "/task buy milk - add a task\n"
  "/tasks · /done 2 · /del 2 · /clear\n"
  "/remind 10m stretch\n"
  "/remind 18:30 call mom\n"
  "/remind daily 08:00 meds\n"
  "/reminders · /unremind 1\n"
  "  or just: remind me in 20 min to drink water\n"
  "/habit water 8 - new habit (goal 8/day)\n"
  "/habits · /log water · /unhabit 1\n"
  "/focus [25] · /break [5] · /pause · /stop\n"
  "/say hello - show text on the screen\n"
  "/face happy|love|cool|sad|angry|laugh|sleep|...\n"
  "/pat · /play fly|ball · /screen clock\n"
  "/weather · /city Chennai · /name Sudarsan\n"
  "/brightness 0-255 · /sleep · /wake\n"
  "Any other message pops up on Lilmate's screen.";

// ------------------------------------------------------------ time parsing
static int unitSec(const String &u) {
  static const char *S1[] = { "s", "sec", "secs", "second", "seconds" };
  static const char *M1[] = { "m", "min", "mins", "minute", "minutes" };
  static const char *H1[] = { "h", "hr", "hrs", "hour", "hours" };
  static const char *D1[] = { "d", "day", "days" };
  for (auto w : S1) if (u == w) return 1;
  for (auto w : M1) if (u == w) return 60;
  for (auto w : H1) if (u == w) return 3600;
  for (auto w : D1) if (u == w) return 86400;
  return 0;
}
// "1h30m" -> 5400 ; "10" -> plain=true,10 ; not a duration -> -1
static long parseDurTok(const String &t, bool &plain) {
  plain = false;
  int n = t.length(), i = 0; long total = 0;
  if (!n || !isdigit((uint8_t)t[0])) return -1;
  while (i < n) {
    if (!isdigit((uint8_t)t[i])) return -1;
    long v = 0; while (i < n && isdigit((uint8_t)t[i])) v = v * 10 + (t[i++] - '0');
    int j = i; while (j < n && isalpha((uint8_t)t[j])) j++;
    String u = t.substring(i, j); i = j;
    if (!u.length()) { if (i >= n) { plain = true; return v; } return -1; }
    int us = unitSec(u); if (!us) return -1;
    total += v * us;
  }
  return total;
}
static bool parseClockTok(String t, const String &next, int &h, int &m, bool &usedNext) {
  t.toLowerCase(); usedNext = false;
  bool pm = false, am = false;
  if (t.endsWith("pm")) { pm = true; t.remove(t.length() - 2); }
  else if (t.endsWith("am")) { am = true; t.remove(t.length() - 2); }
  else { String nl = next; nl.toLowerCase(); if (nl == "pm" || nl == "am") { pm = nl == "pm"; am = !pm; usedNext = true; } }
  int c = t.indexOf(':');
  if (c < 0 && !am && !pm) return false;
  for (size_t i = 0; i < t.length(); i++) if (!isdigit((uint8_t)t[i]) && (int)i != c) return false;
  if (!t.length() || c == 0) return false;
  h = c < 0 ? t.toInt() : t.substring(0, c).toInt();
  m = c < 0 ? 0 : t.substring(c + 1).toInt();
  if ((am || pm) && (h < 1 || h > 12)) return false;
  if (pm && h < 12) h += 12;
  if (am && h == 12) h = 0;
  return h < 24 && m < 60;
}
static String nextTok(const String &s, int &pos) {
  while (pos < (int)s.length() && s[pos] == ' ') pos++;
  int e = s.indexOf(' ', pos); if (e < 0) e = s.length();
  String t = s.substring(pos, e); pos = e; return t;
}
// Parses a time spec at the start of s. Returns due epoch (0 = fail); 'used' = chars consumed.
static uint32_t parseWhen(const String &s, int &used) {
  String low = s; low.toLowerCase();
  int pos = 0;
  int save = pos; String t = nextTok(low, pos);
  if (t == "in" || t == "at" || t == "after") save = pos; else pos = save;
  // clock
  int p2 = pos; String a = nextTok(low, p2); int p3 = p2; String b = nextTok(low, p3);
  int h, m; bool usedNext;
  if (a.length() && parseClockTok(a, b, h, m, usedNext)) {
    if (!timeOk()) return 0;
    struct tm tm; localNow(tm); tm.tm_hour = h; tm.tm_min = m; tm.tm_sec = 0;
    time_t due = mktime(&tm);
    if (due <= (time_t)nowEpoch()) due += 86400;
    used = usedNext ? p3 : p2;
    return (uint32_t)due;
  }
  // duration: 10m | 10 min | 1h30m | 1 hour 30 min
  long total = 0; bool any = false;
  for (;;) {
    int q = pos; String tk = nextTok(low, q);
    if (any && tk == "and") { pos = q; continue; }
    bool plain; long v = parseDurTok(tk, plain);
    if (v < 0) break;
    if (plain) {
      int q2 = q; String u = nextTok(low, q2);
      int us = unitSec(u);
      if (!us) { if (!any) { total += v * 60; any = true; pos = q; } break; }  // bare number = minutes
      total += v * us; pos = q2; any = true;
    } else { total += v; pos = q; any = true; }
  }
  if (!any || total <= 0) return 0;
  used = pos;
  return nowEpoch() + total;
}

String fmtDue(uint32_t due) {
  if (!timeOk()) return "in " + String((due - nowEpoch()) / 60) + "m";
  time_t t = due; struct tm tm; localtime_r(&t, &tm); char b[16]; strftime(b, sizeof(b), "%H:%M", &tm);
  long mins = ((long)due - (long)nowEpoch()) / 60;
  String s = b;
  struct tm nt; localNow(nt);
  if (mins >= 0 && mins < 600) s += " (in " + (mins >= 60 ? String(mins / 60) + "h" + String(mins % 60) + "m" : String(mins) + "m") + ")";
  if (mins >= 0 && tm.tm_yday != nt.tm_yday) s += mins < 2880 ? String(" tomorrow") : String(" +" + String(mins / 1440) + "d");
  return s;
}

String cmdRemind(String arg) {
  arg.trim();
  bool daily = false;
  String low = arg; low.toLowerCase();
  if (low.startsWith("daily ")) { daily = true; arg = arg.substring(6); }
  else if (low.startsWith("every day ")) { daily = true; arg = arg.substring(10); }
  else if (low.startsWith("everyday ")) { daily = true; arg = arg.substring(9); }
  arg.trim();
  if (!timeOk()) return "⏳ My clock isn't synced yet (needs Wi-Fi). Try again in a moment.";
  int used = 0; uint32_t due = parseWhen(arg, used);
  String text;
  if (due) text = arg.substring(used);
  else {  // "to drink water in 10 min" / "call mom at 6pm"
    String l2 = arg; l2.toLowerCase();
    int k = max(l2.lastIndexOf(" in "), l2.lastIndexOf(" at "));
    if (k > 0) { String tail = arg.substring(k + 1); int u2 = 0; due = parseWhen(tail, u2); if (due && u2 >= (int)tail.length() - 1) text = arg.substring(0, k); else due = 0; }
  }
  if (!due) return "🤔 I couldn't read the time. Try: /remind 10m stretch, /remind 18:30 call mom";
  text.trim();
  String tl = text; tl.toLowerCase();
  if (tl.startsWith("to ")) text = text.substring(3);
  text.trim();
  if (!text.length()) text = "Reminder";
  if (!addReminder(text, due, daily)) return "Reminder list is full (" + String(MAX_REMINDERS) + ").";
  faceSetMood(M_HAPPY, 1500); faceSay("Okay! " + fmtDue(due));
  return "⏰ Got it: \"" + text + "\" at " + fmtDue(due) + (daily ? " every day" : "");
}

String listTasks() {
  if (!nTasks) return "📋 No tasks. Add one: /task buy milk";
  String s = "📋 Tasks (" + String(tasksLeft()) + " left)\n";
  for (int i = 0; i < nTasks; i++) s += String(i + 1) + ". " + (tasks[i].done ? "✅ " : "⬜ ") + tasks[i].text + "\n";
  return s;
}
String listReminders() {
  if (!nRems) return "⏰ No reminders. Try: remind me in 20 min to drink water";
  String s = "⏰ Reminders\n";
  for (int i = 0; i < nRems; i++) s += String(i + 1) + ". " + fmtDue(rems[i].due) + (rems[i].daily ? " daily " : " ") + rems[i].text + "\n";
  return s;
}
String listHabits() {
  if (!nHabits) return "🔁 No habits. Try: /habit water 8";
  String s = "🔁 Habits today\n";
  for (int i = 0; i < nHabits; i++) {
    habitRoll(habits[i]);
    s += String(i + 1) + ". " + habits[i].name + " " + habits[i].count + "/" + habits[i].goal + (habits[i].count >= habits[i].goal ? " ✅" : "") + "  🔥" + habits[i].streak + "d\n";
  }
  return s;
}
String weatherText() {
  if (!wx.ok) return S.city[0] || S.lat != 0 ? "🌤 Weather not loaded yet." : "🌤 Set a city: /city Chennai";
  char b[120];
  snprintf(b, sizeof(b), "🌤 %s: %.1f°C, %s\nHigh %.0f / Low %.0f, humidity %d%%, wind %.0f km/h", wx.place, wx.temp, wxText(wx.code), wx.tmax, wx.tmin, wx.hum, wx.wind);
  return String(b) + (wxRainy() ? "\n☔ Take an umbrella!" : "");
}

// ------------------------------------------------------------ dispatcher
String runCommand(String line, Source src, const char *from = "") {
  line.trim();
  if (!line.length()) return "";
  markActivity();
  if (asleep || displayOff) wakeUp(false);
  String low = line; low.toLowerCase();

  // natural phrases
  if (low.startsWith("remind me")) return cmdRemind(line.substring(9));
  if (low.startsWith("add task ")) { line = "/task " + line.substring(9); low = line; low.toLowerCase(); }
  if (low == "hi" || low == "hello" || low == "hey") { faceSetMood(M_HAPPY, 2500); faceSay(String("Hi ") + (from && from[0] ? from : S.owner) + "!"); return "👋 Hi! I waved on the screen. Send /help for commands."; }

  if (line[0] != '/') {   // plain message -> pop it on the screen
    String who = (from && from[0]) ? String(String(from) + ": ") : String("");
    raiseAlert(AK_MSG, who + line);
    return "👀 Shown on Lilmate's screen.";
  }

  int sp = line.indexOf(' ');
  String cmd = low.substring(1, sp < 0 ? low.length() : sp);
  int at = cmd.indexOf('@'); if (at >= 0) cmd = cmd.substring(0, at);   // /help@MyBot
  String arg = sp < 0 ? "" : line.substring(sp + 1); arg.trim();
  String argl = arg; argl.toLowerCase();

  if (cmd == "start" || cmd == "help") return HELP_TEXT;
  if (cmd == "status") return statusText(false);

  // tasks
  if (cmd == "task" || cmd == "add" || cmd == "todo") {
    if (!arg.length()) return listTasks();
    if (!addTask(arg)) return "Task list is full (" + String(MAX_TASKS) + "). /clear done ones first.";
    faceSetMood(M_HAPPY, 1500); faceSay("New task!");
    return "📝 Added: " + arg + " (" + String(tasksLeft()) + " left)";
  }
  if (cmd == "tasks" || cmd == "list") return listTasks();
  if (cmd == "done" || cmd == "undone") {
    int i = arg.toInt() - 1;
    if (i < 0 || i >= nTasks) {   // match by text
      for (int k = 0; k < nTasks; k++) { String t = tasks[k].text; t.toLowerCase(); if (argl.length() && t.indexOf(argl) >= 0) { i = k; break; } }
    }
    if (i < 0 || i >= nTasks) return "Which one? " + listTasks();
    tasks[i].done = cmd == "done"; markDirty(D_TASK);
    if (tasks[i].done) { pet.tasksDone++; petHappy(8); faceSetMood(M_LOVE, 2000); faceSay("Nice work!"); }
    return String(tasks[i].done ? "✅ Done: " : "⬜ Reopened: ") + tasks[i].text + " (" + tasksLeft() + " left)";
  }
  if (cmd == "del" || cmd == "delete" || cmd == "rm") {
    int i = arg.toInt() - 1;
    if (i < 0 || i >= nTasks) return "Which one? " + listTasks();
    String t = tasks[i].text; delTask(i);
    return "🗑 Deleted: " + t;
  }
  if (cmd == "clear") {
    int n = 0; for (int i = nTasks - 1; i >= 0; i--) if (tasks[i].done) { delTask(i); n++; }
    return "🧹 Cleared " + String(n) + " done task(s).";
  }

  // reminders
  if (cmd == "remind" || cmd == "reminder" || cmd == "r") { if (!arg.length()) return listReminders(); return cmdRemind(arg); }
  if (cmd == "reminders") return listReminders();
  if (cmd == "unremind" || cmd == "delremind") {
    int i = arg.toInt() - 1;
    if (i < 0 || i >= nRems) return "Which one? " + listReminders();
    String t = rems[i].text; delReminder(i);
    return "🗑 Reminder removed: " + t;
  }

  // habits
  if (cmd == "habit") {
    if (!arg.length()) return listHabits();
    int sp2 = arg.lastIndexOf(' ');
    int goal = sp2 > 0 ? arg.substring(sp2 + 1).toInt() : 0;
    String name = goal > 0 ? arg.substring(0, sp2) : arg;
    if (goal <= 0) goal = 1;
    name.trim();
    if (!addHabit(name, goal)) return "Habit list is full (" + String(MAX_HABITS) + ").";
    return "🔁 New habit: " + name + " (goal " + goal + "/day). Log it with /log " + name;
  }
  if (cmd == "habits") return listHabits();
  if (cmd == "log" || cmd == "did") {
    int i = findHabit(arg);
    if (i < 0) return nHabits ? "Which habit? " + listHabits() : "No habits yet. /habit water 8";
    int r = logHabit(i);
    Habit &h = habits[i];
    if (r == 2) { petHappy(10); faceSetMood(M_LOVE, 2500); faceSay(String(h.name) + " goal done!"); }
    else { faceSetMood(M_HAPPY, 1500); faceSay(String(h.name) + " " + h.count + "/" + h.goal); }
    return String(r == 2 ? "🎉 Goal reached! " : "👍 ") + h.name + " " + h.count + "/" + h.goal + "  🔥" + h.streak + "d";
  }
  if (cmd == "unhabit") {
    int i = arg.toInt() - 1;
    if (i < 0 || i >= nHabits) return "Which one? " + listHabits();
    String n = habits[i].name; delHabit(i);
    return "🗑 Habit removed: " + n;
  }

  // focus
  if (cmd == "focus" || cmd == "pomodoro") {
    int m = arg.toInt(); focusStart(m > 0 ? m : S.focusMin);
    screen = S_FACE;
    return "🎯 Focus started: " + String(fx.plannedMin) + " min. I'll ping you when it's done.";
  }
  if (cmd == "break") { int m = arg.toInt(); focusBreak(m > 0 ? m : S.breakMin); return "☕ Break: " + String(fx.plannedMin) + " min."; }
  if (cmd == "pause" || cmd == "resume") { if (!fx.running) return "No focus running."; focusTogglePause(); return fx.paused ? String("⏸ Paused (" + mmss(focusRemain()) + " left)") : String("▶️ Resumed"); }
  if (cmd == "stop") { if (!fx.running) return "Nothing running."; focusStop(); return "⏹ Stopped. Focus today: " + String(focusToday()) + " min."; }
  if (cmd == "nudge") {   // from the PC agent's focus guard
    if (!fx.running || fx.isBreak) return "ignored (not focusing)";
    raiseAlert(AK_NUDGE, "Back to focus! " + arg);
    return "nudged";
  }

  // expression / screen
  if (cmd == "say" || cmd == "show") {
    if (!arg.length()) return "Usage: /say hello";
    raiseAlert(AK_MSG, (from && from[0] ? String(String(from) + ": ") : String("")) + arg);
    return "👀 Shown on the screen.";
  }
  if (cmd == "face" || cmd == "mood") {
    for (int i = 0; i < M_COUNT; i++) if (argl == MOOD_NAMES[i]) {
      screen = S_FACE;
      if (i == M_SLEEP) goSleep(); else faceSetMood((Mood)i, 8000);
      return String("😊 Face: ") + MOOD_NAMES[i];
    }
    String s = "Faces:"; for (int i = 0; i < M_COUNT; i++) s += String(" ") + MOOD_NAMES[i];
    return s;
  }
  if (cmd == "pat" || cmd == "pet") {
    pet.pats++; petHappy(6); screen = S_FACE;
    faceSetMood(M_LOVE, 2500); faceSay("Remote pat! <3");
    return "💛 Purr... happiness " + String(pet.happy) + "%";
  }
  if (cmd == "play") {
    screen = S_FACE;
    if (argl == "ball") startToy(TOY_BALL, 8000); else startToy(TOY_FLY, 10000);
    return "🪰 Playing!";
  }
  if (cmd == "screen") {
    for (int i = 0; i < S_COUNT; i++) if (argl == SCREEN_NAMES[i]) { screen = (Screen)i; if (screen == S_INFO) qrUntil = 0; return String("🖥 Screen: ") + SCREEN_NAMES[i]; }
    String s = "Screens:"; for (int i = 0; i < S_COUNT; i++) s += String(" ") + SCREEN_NAMES[i];
    return s;
  }
  if (cmd == "sleep") { goSleep(); return "😴 Good night."; }
  if (cmd == "wake") { wakeUp(true); return "☀️ Awake!"; }

  // settings
  if (cmd == "weather") { wxRequest = true; return weatherText(); }
  if (cmd == "city") {
    if (!arg.length()) return String("City: ") + (S.city[0] ? S.city : "(auto from IP)");
    if (argl == "auto") S.city[0] = 0; else copyStr(S.city, arg.c_str(), sizeof(S.city));
    S.lat = S.lon = 0; wx.ok = false; wx.place[0] = 0; wxRequest = true; markDirty(D_SET);
    return "📍 City set to " + String(S.city[0] ? S.city : "auto") + ". Fetching weather...";
  }
  if (cmd == "name") { if (!arg.length()) return String("I call you ") + S.owner; copyStr(S.owner, arg.c_str(), sizeof(S.owner)); markDirty(D_SET); faceSay("Hi " + arg + "!"); return "👋 Nice to meet you, " + arg; }
  if (cmd == "tz") {
    if (argl == "auto") S.tz[0] = 0; else if (arg.length()) copyStr(S.tz, arg.c_str(), sizeof(S.tz));
    markDirty(D_SET); applyTz();
    return String("🕒 Timezone: ") + currentTz();
  }
  if (cmd == "brightness" || cmd == "contrast") { S.contrast = constrain(arg.toInt(), 1, 255); oled.setContrast(S.contrast); markDirty(D_SET); return "🔆 Brightness " + String(S.contrast); }
  if (cmd == "unpair") { S.tgChat[0] = 0; markDirty(D_SET); return "Telegram unpaired. The next /start will pair."; }
  if (cmd == "reboot") { diagRestart(SW_CMD); storeFlush(); delay(200); ESP.restart(); return ""; }
  if (cmd == "wifireset") { S.ssid[0] = 0; S.pass[0] = 0; markDirty(D_SET); storeFlush(); diagRestart(SW_CMD); delay(200); ESP.restart(); return ""; }
  if (cmd == "resets" || cmd == "crash" || cmd == "diag") return resetReport();
  // everyday: busy / breathe / wrap-up / meetings / team
  if (cmd == "dnd" || cmd == "busy") {
    if (argl == "on") setDnd(1); else if (argl == "off") setDnd(2); else if (argl == "auto") setDnd(0);
    return String("🚫 Do-not-disturb: ") + (dndMode == 0 ? "auto (typing, focus, meetings)" : dndMode == 1 ? "ON" : "off") + (isBusy() ? String(" · busy now: ") + busyReason() : String(" · not busy now"));
  }
  if (cmd == "power" || cmd == "battery") {
    if (argl == "auto" || argl == "full" || argl == "saver") { powerMode = argl == "auto" ? 0 : argl == "full" ? 1 : 2; prefs.putUChar("pwr", powerMode); }
    powerTick(millis());
    return powerText();
  }
  if (cmd == "later") { if (wrapAsk) { wrapAsk = false; wrapSnoozeUntil = millis() + 1800000; setInvert(false); return "⏰ Wrap-up asked again in 30 min"; } return "Nothing to postpone"; }
  if (cmd == "ok" || cmd == "dismiss") {
    if (al.active) dismissAlert(false);
    if (wrapAsk) { wrapAsk = false; wrapSnoozeUntil = millis() + 1800000; }
    if (call.on) call.on = false;
    agAckAll(); setInvert(false);
    return "👍 Dismissed";
  }
  if (cmd == "breathe" || cmd == "breath") { breatheStart(); return "🫁 1-minute breathing on lil.mate: in 4 s, out 6 s."; }
  if (cmd == "wrap" || cmd == "wrapup") { wrapUp(); return "🌙 Day wrapped. Rest well!"; }
  if (cmd == "workend") {
    if (argl == "off") workEndMin = -1;
    else if (arg.length()) { int c = arg.indexOf(':'); int h = arg.toInt(), m = c > 0 ? arg.substring(c + 1).toInt() : 0; if (h >= 0 && h < 24 && m >= 0 && m < 60) workEndMin = h * 60 + m; }
    prefs.putShort("wend", workEndMin);
    return "🌙 Work ends at " + workEndText() + " (weekdays: wrap-up prompt, working-late nudge)";
  }
  if (cmd == "meetings" || cmd == "cal") return meetingsText();
  if (cmd == "wave") return linkAction("wave", arg.toInt());
  if (cmd == "tea") return linkAction("tea", -1);
  if (cmd == "lunch") return linkAction("lunch", -1);
  // AI agents
  if (cmd == "agents") return agentList();
  if (cmd == "allow" || cmd == "deny") {
    uint32_t rid = strtoul(arg.c_str(), nullptr, 10);
    if (!rid) { for (auto &s : ag) if (s.used && s.st == AG_PERM) { rid = s.rid; break; } }
    return agDecideRid(rid, cmd == "allow", src == SRC_TG ? "telegram" : "web") ? String(cmd == "allow" ? "✅ Allowed" : "⛔ Denied") : String("No approval waiting with that id.");
  }
  // buddy link / team play
  if (cmd == "buddies" || cmd == "team-play") { if (arg.length()) { int i = arg.toInt(); return linkAction("invite", i); } screen = S_PLAY; return linkStatus(); }
  if (cmd == "invite") return linkAction("invite", arg.toInt());
  if (cmd == "team") { if (arg.length()) linkSetTeam(arg); return "🎮 Team: " + String(teamName) + " (only buddies with the same team see each other)"; }
  if (cmd == "time") {   // /time <unix epoch>  (sent by the PC agent so the clock works offline)
    long ep = atol(arg.c_str());
    if (ep < 1700000000) return "usage: /time <unix epoch>";
    struct timeval tv = { (time_t)ep, 0 }; settimeofday(&tv, nullptr); applyTz();
    return "🕒 Clock set";
  }
  if (cmd == "info") {
    return String(FW_NAME " " FW_VERSION) + "\nIP " + WiFi.localIP().toString() + "  RSSI " + WiFi.RSSI() + "\nheap " + ESP.getFreeHeap() + "  up " + millis() / 60000 + "m\ntz " + currentTz() + "\nlast restart: " + resetLine(lastReset);
  }
  return "🤔 Unknown command. Send /help";
}
