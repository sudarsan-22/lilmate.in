// TTP223 gesture engine: press / release / tap x1-3 / long / very long
#pragma once
#include "config.h"

enum TouchEv : uint8_t { T_NONE, T_PRESS, T_RELEASE, T_TAP1, T_TAP2, T_TAP3, T_LONG, T_VLONG };
static const char *TOUCH_NAMES[] = { "none", "press", "release", "tap", "double", "triple", "long", "vlong" };

#define TAP_GAP_MS   320   // wait this long after a release before deciding tap count
#define LONG_MS      650
#define VLONG_MS     4000
#define DEBOUNCE_MS  15

struct {
  bool raw = false, stable = false, longFired = false, vlongFired = false;
  uint32_t rawAt = 0, downAt = 0, upAt = 0;
  uint8_t taps = 0;
} tc;

TouchEv tq[8]; uint8_t tqHead = 0, tqTail = 0;
void tPush(TouchEv e) { uint8_t n = (tqHead + 1) & 7; if (n != tqTail) { tq[tqHead] = e; tqHead = n; } }
TouchEv touchNext() { if (tqHead == tqTail) return T_NONE; TouchEv e = tq[tqTail]; tqTail = (tqTail + 1) & 7; return e; }
bool touchHeld() { return tc.stable; }
uint32_t touchHeldMs() { return tc.stable ? millis() - tc.downAt : 0; }

void touchBegin() { pinMode(TOUCH_PIN, INPUT_PULLDOWN); }

void touchPoll() {
  uint32_t now = millis();
  bool r = digitalRead(TOUCH_PIN) == HIGH;
  if (r != tc.raw) { tc.raw = r; tc.rawAt = now; }
  if (r != tc.stable && now - tc.rawAt >= DEBOUNCE_MS) {
    tc.stable = r;
    if (r) { tc.downAt = now; tc.longFired = tc.vlongFired = false; tPush(T_PRESS); }
    else {
      tPush(T_RELEASE);
      if (tc.longFired) tc.taps = 0;
      else { if (tc.taps < 3) tc.taps++; tc.upAt = now; }
    }
  }
  if (tc.stable) {
    if (!tc.longFired && now - tc.downAt >= LONG_MS) { tc.longFired = true; tc.taps = 0; tPush(T_LONG); }
    if (!tc.vlongFired && now - tc.downAt >= VLONG_MS) { tc.vlongFired = true; tPush(T_VLONG); }
  } else if (tc.taps && now - tc.upAt >= TAP_GAP_MS) {
    tPush(tc.taps == 1 ? T_TAP1 : tc.taps == 2 ? T_TAP2 : T_TAP3);
    tc.taps = 0;
  }
}
