// Lilmate OS - hardware + limits
// Target: DFRobot Beetle ESP32-C3 (4 MB flash, no PSRAM)
//         0.96" SSD1306 128x64 I2C OLED, TTP223 touch sensor
#pragma once
#include <Arduino.h>

#define FW_NAME     "Lilmate OS"
#define FW_VERSION  "0.2.0"
#define HOSTNAME    "lilmate"

// ---- Pins (same wiring as minimo_bear / elephant / pengu_chubby) ----
#define TOUCH_PIN   2     // TTP223 OUT, active HIGH
#define I2C_SDA     8
#define I2C_SCL     9

// ---- Limits (kept small: everything lives in NVS) ----
#define MAX_TASKS      10
#define MAX_REMINDERS  10
#define MAX_HABITS     6
#define TEXT_LEN       40

// ---- Timing ----
#define FRAME_MS          30      // ~33 fps
#define IDLE_TO_FACE_MS   45000   // other screens fall back to the face
#define SLEEPY_AFTER_MS   180000  // 3 min no touch -> sleepy
#define SLEEP_AFTER_MS    300000  // 5 min -> asleep (dim)
#define SCREEN_OFF_MS     900000  // 15 min asleep -> OLED off (burn-in guard)
#define WEATHER_EVERY_MS  1800000 // 30 min

enum Mood : uint8_t {
  M_NEUTRAL, M_HAPPY, M_LOVE, M_SURPRISED, M_ANGRY, M_SAD, M_SLEEPY, M_SLEEP,
  M_THINK, M_COOL, M_LAUGH, M_WINK, M_FOCUS, M_ALERT, M_DIZZY, M_CURIOUS, M_COUNT
};
static const char *MOOD_NAMES[M_COUNT] = {
  "neutral", "happy", "love", "surprised", "angry", "sad", "sleepy", "sleep",
  "think", "cool", "laugh", "wink", "focus", "alert", "dizzy", "curious"
};

enum Screen : uint8_t { S_FACE, S_AGENTS, S_CLOCK, S_FOCUS, S_TASKS, S_HABITS, S_PC, S_GAME, S_PLAY, S_INFO, S_COUNT };
static const char *SCREEN_NAMES[S_COUNT] = { "face", "agents", "clock", "focus", "tasks", "habits", "pc", "game", "play", "info" };

enum Source : uint8_t { SRC_SERIAL, SRC_WEB, SRC_TG, SRC_AGENT };
