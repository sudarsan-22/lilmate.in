// Persistent state (NVS via Preferences) + time helpers
#pragma once
#include <Preferences.h>
#include <time.h>
#include "config.h"

struct Task     { char text[TEXT_LEN]; uint8_t done; };
struct Reminder { char text[TEXT_LEN]; uint32_t due; uint8_t daily; };
struct Habit    { char name[16]; uint8_t goal, count; uint16_t streak; int32_t day; };

struct Settings {
  uint16_t magic;
  char ssid[33], pass[65];
  char owner[16];
  char city[32];
  float lat, lon;
  char tz[48];          // POSIX TZ string, empty = auto from weather
  char tgToken[64];
  char tgChat[24];      // paired Telegram chat id
  uint8_t focusMin, breakMin;
  uint8_t sleepFrom, sleepTo;   // night hours (face stays asleep)
  uint8_t contrast;
  uint8_t summaryHour;          // daily summary hour, 255 = off
};

struct PetStats {
  uint16_t magic;
  int16_t  happy;          // 0..100
  uint32_t pats;
  uint16_t gameBest;
  int32_t  focusDay;
  uint16_t focusToday;     // minutes
  uint32_t focusTotal;     // minutes
  uint32_t tasksDone;
  int32_t  summaryDay;     // last day the morning summary ran
};

#define SET_MAGIC 0x4C32
#define PET_MAGIC 0x5031

Settings S;
PetStats pet;
Task     tasks[MAX_TASKS];  uint8_t nTasks = 0;
Reminder rems[MAX_REMINDERS]; uint8_t nRems = 0;
Habit    habits[MAX_HABITS]; uint8_t nHabits = 0;
int32_t  tgOffset = 0;

Preferences prefs;
enum { D_SET = 1, D_TASK = 2, D_REM = 4, D_HAB = 8, D_PET = 16, D_TG = 32 };
uint32_t dirtyMask = 0, dirtyAt = 0;
void markDirty(uint32_t m) { dirtyMask |= m; dirtyAt = millis(); }

// ---------------------------------------------------------------- time
bool timeOk() { return time(nullptr) > 1700000000; }
uint32_t nowEpoch() { return (uint32_t)time(nullptr); }

int32_t daysFromCivil(int y, unsigned m, unsigned d) {
  y -= m <= 2;
  const int era = (y >= 0 ? y : y - 399) / 400;
  const unsigned yoe = (unsigned)(y - era * 400);
  const unsigned doy = (153 * (m > 2 ? m - 3 : m + 9) + 2) / 5 + d - 1;
  const unsigned doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
  return era * 146097 + (int)doe - 719468;
}
bool localNow(struct tm &tm) { time_t t = time(nullptr); localtime_r(&t, &tm); return timeOk(); }
int32_t todayIdx() { struct tm tm; localNow(tm); return daysFromCivil(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday); }
int localHour() { struct tm tm; localNow(tm); return tm.tm_hour; }

// ---------------------------------------------------------------- utils
void copyStr(char *dst, const char *src, size_t n) { strncpy(dst, src ? src : "", n - 1); dst[n - 1] = 0; }

// Strip UTF-8 (emoji etc.) so the ASCII OLED fonts can show it
String asciiOnly(const String &in) {
  String o; o.reserve(in.length());
  for (size_t i = 0; i < in.length(); i++) {
    uint8_t c = in[i];
    if (c >= 0x20 && c < 0x7F) o += (char)c;
    else if (c == '\n') o += ' ';
    else if (c >= 0xC0) {  // start of a multibyte sequence: map a few, drop the rest
      if (c == 0xE2 && i + 2 < in.length() && (uint8_t)in[i + 1] == 0x80 && ((uint8_t)in[i + 2] == 0x99 || (uint8_t)in[i + 2] == 0x98)) o += '\'';
    }
  }
  o.trim();
  return o;
}

// ---------------------------------------------------------------- defaults
void settingsDefaults() {
  memset(&S, 0, sizeof(S));
  S.magic = SET_MAGIC;
  copyStr(S.owner, "Sudarsan", sizeof(S.owner));
  copyStr(S.tz, "IST-5:30", sizeof(S.tz));
  S.focusMin = 25; S.breakMin = 5;
  S.sleepFrom = 23; S.sleepTo = 7;
  S.contrast = 200;
  S.summaryHour = 8;
}
void petDefaults() { memset(&pet, 0, sizeof(pet)); pet.magic = PET_MAGIC; pet.happy = 70; }

template <typename T>
uint8_t loadArr(const char *k, T *arr, uint8_t maxN) {
  size_t len = prefs.getBytesLength(k);
  if (len == 0 || len % sizeof(T) != 0 || len / sizeof(T) > maxN) return 0;
  prefs.getBytes(k, arr, len);
  return len / sizeof(T);
}

void storeBegin() {
  prefs.begin("lilmate", false);
  if (prefs.getBytesLength("set") != sizeof(S) || (prefs.getBytes("set", &S, sizeof(S)), S.magic != SET_MAGIC)) settingsDefaults();
  if (prefs.getBytesLength("pet") != sizeof(pet) || (prefs.getBytes("pet", &pet, sizeof(pet)), pet.magic != PET_MAGIC)) petDefaults();
  nTasks  = loadArr("tasks", tasks, MAX_TASKS);
  nRems   = loadArr("rems", rems, MAX_REMINDERS);
  nHabits = loadArr("habits", habits, MAX_HABITS);
  tgOffset = prefs.getInt("tgo", 0);
}

void storeFlush() {
  if (!dirtyMask) return;
  if (dirtyMask & D_SET)  prefs.putBytes("set", &S, sizeof(S));
  if (dirtyMask & D_PET)  prefs.putBytes("pet", &pet, sizeof(pet));
  if (dirtyMask & D_TASK) { if (nTasks) prefs.putBytes("tasks", tasks, nTasks * sizeof(Task)); else prefs.remove("tasks"); }
  if (dirtyMask & D_REM)  { if (nRems) prefs.putBytes("rems", rems, nRems * sizeof(Reminder)); else prefs.remove("rems"); }
  if (dirtyMask & D_HAB)  { if (nHabits) prefs.putBytes("habits", habits, nHabits * sizeof(Habit)); else prefs.remove("habits"); }
  if (dirtyMask & D_TG)   prefs.putInt("tgo", tgOffset);
  dirtyMask = 0;
}
void storeLoop() { if (dirtyMask && millis() - dirtyAt > 2000) storeFlush(); }

// ---------------------------------------------------------------- list ops
bool addTask(const String &t) {
  if (nTasks >= MAX_TASKS || !t.length()) return false;
  copyStr(tasks[nTasks].text, t.c_str(), TEXT_LEN); tasks[nTasks].done = 0; nTasks++;
  markDirty(D_TASK); return true;
}
bool delTask(int i) {
  if (i < 0 || i >= nTasks) return false;
  for (int k = i; k < nTasks - 1; k++) tasks[k] = tasks[k + 1];
  nTasks--; markDirty(D_TASK); return true;
}
uint8_t tasksLeft() { uint8_t n = 0; for (int i = 0; i < nTasks; i++) if (!tasks[i].done) n++; return n; }

bool addReminder(const String &t, uint32_t due, bool daily) {
  if (nRems >= MAX_REMINDERS) return false;
  copyStr(rems[nRems].text, t.c_str(), TEXT_LEN); rems[nRems].due = due; rems[nRems].daily = daily; nRems++;
  markDirty(D_REM); return true;
}
bool delReminder(int i) {
  if (i < 0 || i >= nRems) return false;
  for (int k = i; k < nRems - 1; k++) rems[k] = rems[k + 1];
  nRems--; markDirty(D_REM); return true;
}
int nextReminder() {  // index of soonest reminder, -1 if none
  int best = -1;
  for (int i = 0; i < nRems; i++) if (best < 0 || rems[i].due < rems[best].due) best = i;
  return best;
}

// Habit day rollover: keeps the streak only if yesterday's goal was met
void habitRoll(Habit &h) {
  if (!timeOk()) return;
  int32_t t = todayIdx();
  if (h.day == t) return;
  if (!(h.day == t - 1 && h.count >= h.goal)) h.streak = 0;
  h.count = 0; h.day = t;
  markDirty(D_HAB);
}
bool addHabit(const String &name, int goal) {
  if (nHabits >= MAX_HABITS || !name.length()) return false;
  Habit &h = habits[nHabits++];
  memset(&h, 0, sizeof(h));
  copyStr(h.name, name.c_str(), sizeof(h.name));
  h.goal = constrain(goal, 1, 20); h.day = timeOk() ? todayIdx() : 0;
  markDirty(D_HAB); return true;
}
bool delHabit(int i) {
  if (i < 0 || i >= nHabits) return false;
  for (int k = i; k < nHabits - 1; k++) habits[k] = habits[k + 1];
  nHabits--; markDirty(D_HAB); return true;
}
// returns 1 = logged, 2 = goal just reached
int logHabit(int i) {
  if (i < 0 || i >= nHabits) return 0;
  Habit &h = habits[i]; habitRoll(h);
  if (h.count < 99) h.count++;
  markDirty(D_HAB);
  if (h.count == h.goal) { h.streak++; return 2; }
  return 1;
}
int findHabit(const String &q) {
  String ql = q; ql.toLowerCase(); ql.trim();
  if (!ql.length()) return -1;
  int n = ql.toInt();
  if (n >= 1 && n <= nHabits && String(n) == ql) return n - 1;
  for (int i = 0; i < nHabits; i++) { String nm = habits[i].name; nm.toLowerCase(); if (nm.startsWith(ql) || ql.startsWith(nm)) return i; }
  return -1;
}

void petHappy(int d) { pet.happy = constrain(pet.happy + d, 0, 100); markDirty(D_PET); }
void focusMinutesAdd(int m) {
  int32_t t = timeOk() ? todayIdx() : 0;
  if (pet.focusDay != t) { pet.focusDay = t; pet.focusToday = 0; }
  pet.focusToday += m; pet.focusTotal += m; markDirty(D_PET);
}
uint16_t focusToday() { int32_t t = timeOk() ? todayIdx() : 0; return pet.focusDay == t ? pet.focusToday : 0; }
