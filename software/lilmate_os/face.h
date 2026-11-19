// Face engine: tweened robot eyes, moods, particles, toys, speech bubble
#pragma once
#include <U8g2lib.h>
#include "config.h"

U8G2_SSD1306_128X64_NONAME_F_HW_I2C oled(U8G2_R0, U8X8_PIN_NONE, I2C_SCL, I2C_SDA);

struct EyeP { float w, h, r, lidIn, lidOut, bottom; };
struct FaceAnim { EyeP L, R; float gx, gy, cy; };
FaceAnim fc, ft;                 // current + target

Mood     mood = M_NEUTRAL;       // what is shown
Mood     restMood = M_NEUTRAL;   // what it returns to after a timed mood
uint32_t moodUntil = 0;

uint32_t blinkAt = 0, nextBlink = 1500;
uint32_t nextGaze = 0;
bool     gazeHold = false;       // toy/think owns the gaze

String   bubble;                 // speech text
uint32_t bubbleAt = 0, bubbleDur = 0;
bool     bubbleSticky = false;   // stays until cleared (alerts)

struct Particle { float x, y, vx, vy; uint8_t kind; int16_t life; };
#define NPART 8
Particle parts[NPART];
uint32_t nextParticle = 0;

enum Toy : uint8_t { TOY_NONE, TOY_FLY, TOY_BALL };
Toy toy = TOY_NONE;
float toyX, toyY, toyVX, toyVY;
uint32_t toyUntil = 0;

String topLine;                  // small status text over the eyes (focus timer etc.)

// ------------------------------------------------------------ mood shapes
void moodShape(Mood m, EyeP &L, EyeP &R) {
  L = R = EyeP{28, 32, 8, 0, 0, 0};
  switch (m) {
    case M_HAPPY:     L = R = EyeP{30, 30, 12, 0, 0, 0.5f}; break;
    case M_LAUGH:     L = R = EyeP{30, 22, 8, 0, 0, 0.5f}; break;
    case M_LOVE:      L = R = EyeP{30, 30, 10, 0, 0, 0}; break;
    case M_SURPRISED: L = R = EyeP{32, 38, 15, 0, 0, 0}; break;
    case M_ANGRY:     L = R = EyeP{30, 28, 6, 0.55f, 0.05f, 0}; break;
    case M_SAD:       L = R = EyeP{28, 28, 8, 0.05f, 0.5f, 0}; break;
    case M_SLEEPY:    L = R = EyeP{30, 12, 5, 0, 0.25f, 0}; break;
    case M_SLEEP:     L = R = EyeP{30, 3, 1, 0, 0, 0}; break;
    case M_THINK:     L = EyeP{26, 24, 7, 0.15f, 0, 0}; R = EyeP{28, 32, 8, 0, 0, 0}; break;
    case M_COOL:      L = R = EyeP{32, 16, 4, 0, 0, 0}; break;
    case M_WINK:      L = EyeP{30, 30, 12, 0, 0, 0.5f}; R = EyeP{30, 3, 1, 0, 0, 0}; break;
    case M_FOCUS:     L = R = EyeP{30, 18, 5, 0.35f, 0, 0}; break;
    case M_ALERT:     L = R = EyeP{30, 38, 9, 0, 0, 0}; break;
    case M_DIZZY:     L = R = EyeP{28, 28, 13, 0, 0, 0}; break;
    case M_CURIOUS:   L = EyeP{30, 36, 10, 0, 0, 0}; R = EyeP{26, 24, 8, 0.15f, 0, 0}; break;
    default: break;
  }
}

void faceApplyMood() {
  moodShape(mood, ft.L, ft.R);
  if (mood == M_THINK) { ft.gx = 0.6f; ft.gy = -0.7f; gazeHold = true; }
  else if (toy == TOY_NONE) gazeHold = false;
}

void faceSetMood(Mood m, uint32_t durMs = 0) {
  if (m >= M_COUNT) m = M_NEUTRAL;
  mood = m;
  moodUntil = durMs ? millis() + durMs : 0;
  if (!durMs) restMood = m;
  faceApplyMood();
}
void faceSetRest(Mood m) {      // change the resting mood without interrupting a timed one
  restMood = m;
  if (!moodUntil && mood != m) { mood = m; faceApplyMood(); }
}

void faceSay(const String &text, uint32_t durMs = 0, bool sticky = false) {
  bubble = asciiOnly(text);
  bubbleAt = millis();
  bubbleDur = durMs ? durMs : constrain(2200 + (int)bubble.length() * 90, 2500, 12000);
  bubbleSticky = sticky;
}
void faceClearBubble() { bubble = ""; bubbleSticky = false; }
bool faceBubbleOn(uint32_t now) { return bubble.length() && (bubbleSticky || now - bubbleAt < bubbleDur); }

void spawnParticle(uint8_t kind, float x, float y) {
  for (auto &p : parts) if (p.life <= 0) {
    p.x = x; p.y = y; p.kind = kind; p.life = 60;
    p.vx = (kind == 0) ? 0.35f : (random(-10, 11) / 40.0f);
    p.vy = (kind == 0) ? -0.35f : -0.6f;
    return;
  }
}

void startToy(Toy t, uint32_t durMs = 9000) {
  toy = t; toyUntil = millis() + durMs; gazeHold = (t != TOY_NONE);
  toyX = random(10, 118); toyY = random(6, 20);
  toyVX = random(0, 2) ? 1.6f : -1.6f; toyVY = 0;
}

// ------------------------------------------------------------ primitives
void drawHeart(int cx, int cy, int s) {
  int r = s / 4;
  oled.drawDisc(cx - r, cy - r / 2, r);
  oled.drawDisc(cx + r, cy - r / 2, r);
  oled.drawTriangle(cx - 2 * r - 1, cy - r / 2 + 1, cx + 2 * r + 1, cy - r / 2 + 1, cx, cy + s / 2);
}

void drawChevron(int cx, int cy, int dir) {  // dir +1 = '>'
  for (int t = -2; t <= 2; t++) {
    oled.drawLine(cx - 8 * dir, cy - 9 + t, cx + 7 * dir, cy + t);
    oled.drawLine(cx + 7 * dir, cy + t, cx - 8 * dir, cy + 9 + t);
  }
}

void drawEyeShape(int cx, int cy, const EyeP &e, bool left, float hScale) {
  int w = (int)(e.w + 0.5f), h = (int)(e.h * hScale + 0.5f);
  if (h < 2) h = 2;
  int x = cx - w / 2, y = cy - h / 2;
  int r = min((int)(e.r + 0.5f), (min(w, h) - 1) / 2);
  if (r < 0) r = 0;
  oled.setDrawColor(1);
  if (r > 0) oled.drawRBox(x, y, w, h, r); else oled.drawBox(x, y, w, h);
  oled.setDrawColor(0);
  int hin = (int)(e.lidIn * h), hout = (int)(e.lidOut * h);
  if (hin > 0 || hout > 0) {               // slanted eyelid
    int inX = left ? x + w : x - 1, outX = left ? x - 1 : x + w;
    oled.drawTriangle(inX, y - 1, outX, y - 1, outX, y + hout);
    oled.drawTriangle(inX, y - 1, outX, y + hout, inX, y + hin);
  }
  if (e.bottom > 0.02f && h > 6) {         // happy crescent
    int cut = (int)(e.bottom * h);
    oled.drawFilledEllipse(cx, y + h - cut + h / 2 + 1, w / 2 + 3, h / 2 + 1);
  }
  oled.setDrawColor(1);
}

void drawBlush(int cx, int cy) {
  for (int i = 0; i < 3; i++) oled.drawLine(cx - 6 + i * 5, cy + 3, cx - 3 + i * 5, cy - 1);
}

static inline float lerpf(float a, float b, float t) { return a + (b - a) * t; }
void lerpEye(EyeP &c, const EyeP &t, float k) {
  c.w = lerpf(c.w, t.w, k); c.h = lerpf(c.h, t.h, k); c.r = lerpf(c.r, t.r, k);
  c.lidIn = lerpf(c.lidIn, t.lidIn, k); c.lidOut = lerpf(c.lidOut, t.lidOut, k); c.bottom = lerpf(c.bottom, t.bottom, k);
}

// ------------------------------------------------------------ update
void faceUpdate(uint32_t now) {
  if (moodUntil && now > moodUntil) { moodUntil = 0; mood = restMood; faceApplyMood(); }

  // blink
  if (now > nextBlink && mood != M_SLEEP && mood != M_LAUGH && mood != M_LOVE) {
    blinkAt = now;
    nextBlink = now + random(2200, 6000);
    if (random(0, 6) == 0) nextBlink = now + 260;  // double blink
  }

  // gaze
  if (toy != TOY_NONE) {
    if (now > toyUntil) { toy = TOY_NONE; gazeHold = (mood == M_THINK); ft.gx = ft.gy = 0; }
    else if (toy == TOY_FLY) {
      toyVX += random(-10, 11) / 18.0f; toyVY += random(-10, 11) / 18.0f;
      toyVX = constrain(toyVX, -2.5f, 2.5f); toyVY = constrain(toyVY, -1.8f, 1.8f);
      toyX += toyVX; toyY += toyVY;
      if (toyX < 4 || toyX > 123) { toyVX = -toyVX; toyX = constrain(toyX, 4.0f, 123.0f); }
      if (toyY < 3 || toyY > 60) { toyVY = -toyVY; toyY = constrain(toyY, 3.0f, 60.0f); }
    } else if (toy == TOY_BALL) {
      toyVY += 0.35f; toyX += toyVX; toyY += toyVY;
      if (toyY > 58) { toyY = 58; toyVY = -toyVY * 0.82f; if (fabsf(toyVY) < 1.2f) toyVY = -5.5f; }
      if (toyX < 4 || toyX > 123) { toyVX = -toyVX; toyX = constrain(toyX, 4.0f, 123.0f); }
    }
    if (toy != TOY_NONE) { ft.gx = constrain((toyX - 64) / 50.0f, -1.0f, 1.0f); ft.gy = constrain((toyY - 32) / 26.0f, -1.0f, 1.0f); }
  } else if (!gazeHold && now > nextGaze) {
    nextGaze = now + random(1200, 4200);
    if (random(0, 2) == 0) { ft.gx = 0; ft.gy = 0; }
    else { ft.gx = random(-10, 11) / 10.0f; ft.gy = random(-6, 7) / 10.0f; }
    if (mood == M_SLEEP || mood == M_SLEEPY) ft.gy = 0.3f;
  }

  ft.cy = faceBubbleOn(now) ? 22 : (topLine.length() ? 35 : 32);

  float k = 0.28f;
  lerpEye(fc.L, ft.L, k); lerpEye(fc.R, ft.R, k);
  fc.gx = lerpf(fc.gx, ft.gx, 0.22f); fc.gy = lerpf(fc.gy, ft.gy, 0.22f); fc.cy = lerpf(fc.cy, ft.cy, 0.25f);

  // particles
  if (now > nextParticle) {
    if (mood == M_SLEEP) { spawnParticle(0, 96, 18); nextParticle = now + 1400; }
    else if (mood == M_LOVE) { spawnParticle(1, random(20, 108), 50); nextParticle = now + 450; }
    else nextParticle = now + 300;
  }
  for (auto &p : parts) if (p.life > 0) { p.x += p.vx; p.y += p.vy; p.life--; if (p.y < 6 || p.x < 6 || p.x > 122) p.life = 0; }
}

// ------------------------------------------------------------ render
void faceDraw(uint32_t now) {
  bool bub = faceBubbleOn(now);
  float hs = bub ? 0.72f : 1.0f;
  if (now - blinkAt < 150) { float t = (now - blinkAt) / 150.0f; hs *= max(0.08f, t < 0.5f ? 1 - 2 * t : 2 * t - 1); }

  int ox = (int)(fc.gx * 12), oy = (int)(fc.gy * (bub ? 4 : 8));
  int cy = (int)fc.cy + oy;
  int lx = 40 + ox, rx = 88 + ox;

  EyeP L = fc.L, R = fc.R;   // perspective: eye on the gaze side grows
  if (fc.gx > 0.3f) { R.h += 3; R.w += 2; L.h -= 2; }
  else if (fc.gx < -0.3f) { L.h += 3; L.w += 2; R.h -= 2; }

  switch (mood) {
    case M_LOVE: {
      int s = 26 + (int)(fabsf(sinf(now * 0.008f)) * 6);
      drawHeart(lx, cy, s); drawHeart(rx, cy, s);
    } break;
    case M_LAUGH: {
      int j = (int)(sinf(now * 0.04f) * 2);
      drawChevron(lx, cy + j, 1); drawChevron(rx, cy + j, -1);
    } break;
    case M_COOL: {
      oled.drawRBox(lx - 17, cy - 8, 34, 16, 5); oled.drawRBox(rx - 17, cy - 8, 34, 16, 5);
      oled.drawBox(lx + 17, cy - 6, rx - lx - 34, 3);
      oled.setDrawColor(0);
      oled.drawLine(lx - 11, cy - 4, lx - 5, cy - 4); oled.drawLine(rx - 11, cy - 4, rx - 5, cy - 4);
      oled.setDrawColor(1);
    } break;
    case M_DIZZY: {
      float a = now * 0.01f;
      for (int e = 0; e < 2; e++) {
        int cx = e ? rx : lx;
        for (int i = 0; i < 26; i++) {
          float ang = a + i * 0.5f, rr = 1 + i * 0.5f;
          oled.drawDisc(cx + (int)(cosf(ang) * rr), cy + (int)(sinf(ang) * rr), 1);
        }
      }
    } break;
    default:
      drawEyeShape(lx, cy, L, true, hs);
      drawEyeShape(rx, cy, R, false, hs);
  }

  // decorations
  if ((mood == M_HAPPY || mood == M_LOVE || mood == M_LAUGH) && !bub) { drawBlush(lx - 4, cy + 20); drawBlush(rx + 4, cy + 20); }
  if (mood == M_ALERT) { int b = (now / 250) % 2; oled.drawBox(116, 6 + b, 4, 13); oled.drawBox(116, 22 + b, 4, 4); }
  if (mood == M_CURIOUS) { oled.setFont(u8g2_font_9x15B_tr); oled.drawStr(112, 16, "?"); }
  if (mood == M_THINK) { int n = (now / 400) % 4; for (int i = 0; i < n; i++) oled.drawDisc(100 + i * 7, 8, 2); }
  if (mood == M_SAD) { int ty = cy + 10 + (int)((now / 60) % 20); if (ty < 62) { oled.drawDisc(rx + 12, ty, 2); oled.drawTriangle(rx + 10, ty - 1, rx + 14, ty - 1, rx + 12, ty - 5); } }
  if (mood == M_ANGRY) { int s = (now / 120) % 2; oled.drawLine(108 + s, 4, 116 + s, 10); oled.drawLine(116 + s, 4, 108 + s, 10); }

  for (auto &p : parts) if (p.life > 0) {
    if (p.kind == 0) { oled.setFont(p.life > 30 ? u8g2_font_6x10_tr : u8g2_font_5x7_tr); oled.drawStr((int)p.x, (int)p.y, "z"); }
    else drawHeart((int)p.x, (int)p.y, 8);
  }

  if (toy == TOY_FLY) {
    int x = (int)toyX, y = (int)toyY;
    oled.drawBox(x, y, 3, 3);
    if ((now / 50) % 2) { oled.drawLine(x - 2, y - 2, x - 1, y - 1); oled.drawLine(x + 4, y - 2, x + 3, y - 1); }
    else { oled.drawLine(x - 2, y + 1, x - 1, y + 1); oled.drawLine(x + 3, y + 1, x + 4, y + 1); }
  } else if (toy == TOY_BALL) {
    oled.setDrawColor(0); oled.drawDisc((int)toyX, (int)toyY, 4); oled.setDrawColor(1);
    oled.drawCircle((int)toyX, (int)toyY, 3); oled.drawPixel((int)toyX - 1, (int)toyY - 1);
  }

  if (topLine.length() && !bub) {
    oled.setFont(u8g2_font_5x8_tr);
    int w = oled.getStrWidth(topLine.c_str());
    oled.drawStr(max(0, (128 - w) / 2), 7, topLine.c_str());
  }

  if (bub) {
    oled.setDrawColor(0); oled.drawBox(0, 45, 128, 19); oled.setDrawColor(1);
    oled.drawRFrame(1, 46, 126, 18, 4);
    oled.drawTriangle(56, 46, 64, 46, 60, 42);
    oled.setFont(u8g2_font_6x10_tr);
    int w = oled.getStrWidth(bubble.c_str());
    if (w <= 118) oled.drawStr((128 - w) / 2, 59, bubble.c_str());
    else {  // marquee (u8g2 coords are unsigned: scroll by substring, 6px font)
      String loop = bubble + "      " + bubble;
      int cycle = (bubble.length() + 6) * 6;
      int t = (int)(now - bubbleAt) - 900;
      int off = t > 0 ? (t / 28) % cycle : 0;
      int c0 = off / 6;
      oled.setClipWindow(4, 47, 124, 63);
      oled.drawStr(5 - (off % 6), 59, loop.substring(c0, c0 + 21).c_str());
      oled.setMaxClipWindow();
    }
  }
}

void faceBegin() {
  moodShape(M_SLEEP, fc.L, fc.R);
  fc.gx = fc.gy = 0; fc.cy = 32;
  ft = fc;
  for (auto &p : parts) p.life = 0;
  faceSetMood(M_NEUTRAL);
}
