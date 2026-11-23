// TTP223 gesture engine: press / release / tap x1-3 / long / very long
#pragma once
#include "config.h"

enum TouchEv : uint8_t { T_NONE, T_PRESS, T_RELEASE, T_TAP1, T_TAP2, T_TAP3, T_LONG, T_VLONG };
static const char *TOUCH_NAMES[] = { "none", "press", "release", "tap", "double", "triple", "long", "vlong" };

#define TAP_GAP_MS   320   // wait this long after a release before deciding tap count
#define LONG_MS      650
#define VLONG_MS     4000
#define DEBOUNCE_MS  15

#define ARM_MS       300   // the pad must read "not touched" this long before it counts at all
#define STUCK_MS     30000 // held longer than this = the pad is stuck (or recalibrating), not a finger

struct {
  bool raw = false, stable = false, longFired = false, vlongFired = false;
  bool armed = false;   // false at power-on: the TTP223 can read "pressed" while it calibrates, or a hand is on the case
  uint32_t rawAt = 0, downAt = 0, upAt = 0, lowSince = 0;
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
  // not armed yet (power-on, or a stuck pad): wait until the pad has really been let go, so a pad that reads
  // "pressed" from the start can't fire long / very long holds (that started "breathe with me" on every power-on)
  if (!tc.armed) {
    static bool told = false;
    if (r) { tc.lowSince = 0; if (!told && now > 2000) { told = true; Serial.println("[touch] pad reads pressed at start: ignored until it is let go"); } return; }
    if (!tc.lowSince) tc.lowSince = now ? now : 1;
    if (now - tc.lowSince < ARM_MS) return;
    tc.armed = true; tc.raw = tc.stable = false; tc.rawAt = now; tc.taps = 0; told = false;
  }
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
  if (tc.stable && now - tc.downAt >= STUCK_MS) {   // nobody holds a pad for 30 s: stop treating it as a touch
    Serial.println("[touch] pad stuck on: ignored until it is let go");
    tc.armed = false; tc.lowSince = 0; tc.stable = false; tc.taps = 0; tPush(T_RELEASE);
    return;
  }
  if (tc.stable) {
    if (!tc.longFired && now - tc.downAt >= LONG_MS) { tc.longFired = true; tc.taps = 0; tPush(T_LONG); }
    if (!tc.vlongFired && now - tc.downAt >= VLONG_MS) { tc.vlongFired = true; tPush(T_VLONG); }
  } else if (tc.taps && now - tc.upAt >= TAP_GAP_MS) {
    tPush(tc.taps == 1 ? T_TAP1 : tc.taps == 2 ? T_TAP2 : T_TAP3);
    tc.taps = 0;
  }
}
