// Habit scenes: every habit gets a little animated picture that fills up as you go
// (a glass of water, a book, a dumbbell, a breathing sun, a moon, a growing plant),
// and reaching a goal sets off a short celebration.
#pragma once
#include "config.h"

enum SceneKind : uint8_t { SC_PLANT, SC_WATER, SC_BOOK, SC_LIFT, SC_SUN, SC_MOON, SC_WALK };
SceneKind sceneFor(const char *name) {
  String n = name; n.toLowerCase();
  auto has = [&](const char *k) { return n.indexOf(k) >= 0; };
  if (has("water") || has("drink") || has("glass") || has("hydrat")) return SC_WATER;
  if (has("read") || has("book") || has("study") || has("learn") || has("page")) return SC_BOOK;
  if (has("gym") || has("lift") || has("push") || has("workout") || has("exercise") || has("squat") || has("plank")) return SC_LIFT;
  if (has("medit") || has("breath") || has("yoga") || has("calm") || has("stretch")) return SC_SUN;
  if (has("sleep") || has("bed") || has("nap")) return SC_MOON;
  if (has("walk") || has("step") || has("run") || has("jog") || has("cycl")) return SC_WALK;
  return SC_PLANT;
}

// draws in a 52x40 box at (x, y); f = progress 0..1
void drawScene(SceneKind k, int x, int y, float f, uint32_t now) {
  f = constrain(f, 0.f, 1.f);
  const float t = now / 1000.0f;
  switch (k) {
    case SC_WATER: {   // a glass that fills up, with a little wave and bubbles
      int gx = x + 12, gw = 28, top = y + 2, bot = y + 38;
      oled.drawLine(gx, top, gx + 3, bot); oled.drawLine(gx + gw, top, gx + gw - 3, bot); oled.drawLine(gx + 3, bot, gx + gw - 3, bot);
      int lvl = bot - 1 - (int)(f * 33);
      for (int yy = lvl; yy < bot; yy++) {
        int inset = 1 + (yy - top) * 3 / (bot - top);
        int wave = yy == lvl ? (int)(sinf(t * 4) * 1.5f) : 0;
        oled.drawHLine(gx + inset + 1, yy + wave, gw - 2 * inset - 1);
      }
      if (f > 0.05f) { oled.setDrawColor(0); for (int b = 0; b < 3; b++) { int by = bot - 3 - (int)fmodf(t * 9 + b * 11, max(4.f, (float)(bot - lvl - 4))); if (by > lvl + 1) oled.drawPixel(gx + 8 + b * 6, by); } oled.setDrawColor(1); }
      break;
    }
    case SC_BOOK: {    // an open book, a page turning now and then
      int cx = x + 26, by = y + 30;
      oled.drawLine(x + 4, by - 16, cx, by - 12); oled.drawLine(cx, by - 12, x + 48, by - 16);
      oled.drawLine(x + 4, by, cx, by + 4); oled.drawLine(cx, by + 4, x + 48, by);
      oled.drawLine(x + 4, by - 16, x + 4, by); oled.drawLine(x + 48, by - 16, x + 48, by); oled.drawLine(cx, by - 12, cx, by + 4);
      for (int l = 0; l < 3; l++) { oled.drawLine(x + 8, by - 11 + l * 4, cx - 4, by - 8 + l * 4); oled.drawLine(cx + 4, by - 8 + l * 4, x + 44, by - 11 + l * 4); }
      float p = fmodf(t, 3.f);                       // turning page
      if (p < 0.8f) { int px = cx + (int)((x + 46 - cx) * cosf(p / 0.8f * PI)); oled.drawLine(cx, by - 12, px, by - 18); oled.drawLine(px, by - 18, px, by - 2); oled.drawLine(px, by - 2, cx, by + 4); }
      int read = (int)(f * 10); for (int i = 0; i < read; i++) oled.drawPixel(x + 6 + i * 4, y + 2);   // pages read
      break;
    }
    case SC_LIFT: {    // a dumbbell going up and down, a sweat drop at the end
      int up = (int)(fabsf(sinf(t * 2.5f)) * 12), bx = x + 6, by = y + 26 - up;
      oled.drawBox(bx, by - 6, 6, 12); oled.drawBox(bx + 34, by - 6, 6, 12); oled.drawBox(bx + 6, by - 1, 28, 3);
      oled.drawBox(bx - 3, by - 4, 3, 8); oled.drawBox(bx + 40, by - 4, 3, 8);
      oled.drawHLine(x + 2, y + 39, 48);
      if (f > 0.6f) { int dy = y + 6 + (int)fmodf(t * 12, 14); oled.drawPixel(x + 48, dy); oled.drawPixel(x + 47, dy + 1); oled.drawPixel(x + 49, dy + 1); oled.drawPixel(x + 48, dy + 2); }
      break;
    }
    case SC_SUN: {     // a sun that breathes in (4 s) and out (6 s), rays grow with progress
      float c = fmodf(t, 10.f), s = c < 4 ? c / 4 : 1 - (c - 4) / 6;
      int r = 6 + (int)(s * 6), cx = x + 26, cy = y + 20;
      oled.drawDisc(cx, cy, r);
      int rays = 4 + (int)(f * 8);
      for (int i = 0; i < rays; i++) { float a = i * 2 * PI / rays + t * 0.2f; oled.drawLine(cx + cosf(a) * (r + 3), cy + sinf(a) * (r + 3), cx + cosf(a) * (r + 7), cy + sinf(a) * (r + 7)); }
      break;
    }
    case SC_MOON: {    // a crescent moon, stars come out as you go, z z z
      int cx = x + 22, cy = y + 20;
      oled.drawDisc(cx, cy, 13); oled.setDrawColor(0); oled.drawDisc(cx + 7, cy - 5, 12); oled.setDrawColor(1);
      int stars = (int)(f * 6); static const int8_t sp[6][2] = { {38, 4}, {46, 14}, {40, 30}, {8, 34}, {30, 36}, {48, 26} };
      for (int i = 0; i < stars; i++) { int sx = x + sp[i][0], sy = y + sp[i][1]; if ((int)(t * 2 + i) % 3) { oled.drawPixel(sx, sy); oled.drawPixel(sx - 1, sy); oled.drawPixel(sx + 1, sy); oled.drawPixel(sx, sy - 1); oled.drawPixel(sx, sy + 1); } }
      oled.setFont(u8g2_font_5x7_tr); int zy = y + 10 - (int)fmodf(t * 4, 8); oled.drawStr(x + 36, zy, "z");
      break;
    }
    case SC_WALK: {    // a little road that scrolls, a flag at the goal
      int gy = y + 34;
      oled.drawHLine(x, gy, 52);
      for (int i = 0; i < 4; i++) { int dx = x + ((int)(t * 20) + i * 14) % 52; oled.drawHLine(dx, gy + 3, 6); }
      int px = x + 4 + (int)(f * 38), step = ((int)(t * 6)) % 2;
      oled.drawCircle(px, gy - 16, 3); oled.drawLine(px, gy - 13, px, gy - 6);
      oled.drawLine(px, gy - 6, px - 3 + step * 6, gy - 1); oled.drawLine(px, gy - 6, px + 3 - step * 6, gy - 1);
      oled.drawLine(px, gy - 11, px - 3 + step * 6, gy - 8); oled.drawLine(px, gy - 11, px + 3 - step * 6, gy - 8);
      oled.drawVLine(x + 48, gy - 18, 18); oled.drawTriangle(x + 48, gy - 18, x + 48, gy - 12, x + 53, gy - 15);
      break;
    }
    default: {         // a plant that grows a leaf for every step
      int px = x + 26, py = y + 38;
      oled.drawLine(px - 9, py - 8, px - 7, py); oled.drawLine(px + 9, py - 8, px + 7, py); oled.drawHLine(px - 7, py, 15); oled.drawHLine(px - 10, py - 8, 21);
      int h = 4 + (int)(f * 22), sway = (int)(sinf(t * 1.5f) * 1.5f);
      oled.drawLine(px, py - 8, px + sway, py - 8 - h);
      int leaves = 1 + (int)(f * 5);
      for (int i = 0; i < leaves; i++) { int ly = py - 12 - i * 4; if (ly < py - 8 - h) break; int s = i % 2 ? 1 : -1; oled.drawEllipse(px + s * 4 + sway / 2, ly, 3, 1); }
      if (f >= 1) oled.drawDisc(px + sway, py - 9 - h, 3);   // it flowers
      break;
    }
  }
}

// ------------------------------------------------------------ goal celebration (3.5 s, any tap closes it)
struct { uint32_t until = 0; char name[24] = ""; uint16_t streak = 0; SceneKind kind = SC_PLANT; } cel;
void celebrateStart(const char *name, uint16_t streak) {
  copyStr(cel.name, name, sizeof(cel.name)); cel.streak = streak; cel.kind = sceneFor(name); cel.until = millis() + 3500;
}
bool celebrateDraw(uint32_t now) {
  now = millis();
  if (!cel.until || now > cel.until) { cel.until = 0; return false; }
  uint32_t el = 3500 - (cel.until - now);
  for (int i = 0; i < 26; i++) {                   // confetti falling from the top
    uint32_t h = i * 2654435761u;
    int cx = h % 128, cy = (int)((el / 12 + (h >> 8) % 64) % 70) - 6, w = 1 + (h >> 16) % 3;
    if ((h >> 20) % 2) oled.drawBox(cx, cy, w, 2); else oled.drawPixel(cx, cy);
  }
  drawScene(cel.kind, 2, 14, 1.f, now);
  oled.setFont(u8g2_font_7x14B_tr); oled.drawStr(60, 30, "GOAL!");
  oled.setFont(u8g2_font_5x7_tr); oled.drawStr(60, 42, cel.name);
  char b[20]; snprintf(b, sizeof(b), "streak %ud", cel.streak); oled.drawStr(60, 52, b);
  return true;
}
bool celebrateTouch(TouchEv e) { if (!cel.until) return false; if (e == T_TAP1 || e == T_TAP2 || e == T_LONG) cel.until = 0; return e != T_PRESS && e != T_RELEASE; }
