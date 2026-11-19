// Buddy link: lil.mate <-> lil.mate over ESP-NOW (no router needed), invites + 2-player games
// Works when both buddies are offline (radio channel 1) or on the same Wi-Fi network.
// Games (best of 3): Quick Draw (tap first after GO, too early = foul) and Tug of War (tap fast for 7 s).
// "lil.bot" is a built-in virtual opponent so you can play alone (and so the flow can be tested with one board).
#pragma once
#include <esp_now.h>
#include <esp_wifi.h>
#include "config.h"

#define LINK_CH    1
#define MAX_PEERS  6
#define BOT_IDX    (MAX_PEERS - 1)
static const uint8_t BCAST[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };

enum LType : uint8_t { L_BEACON = 1, L_INVITE, L_ACCEPT, L_DECLINE, L_CANCEL, L_START, L_RESULT, L_TUG, L_PING };
enum PKind : uint8_t { P_WAVE = 1, P_TEA, P_LUNCH, P_JOIN };
enum LKind : uint8_t { K_QUICK = 1, K_TUG = 2 };
struct __attribute__((packed)) LPkt {
  uint8_t m0, m1, ver, type;
  uint16_t team, match;
  uint8_t to[6];
  char name[12];
  uint8_t status, round, kind, flags;
  int32_t a, b;
};
struct LRx { uint8_t mac[6]; int8_t rssi; LPkt p; };
struct Peer { bool used, bot; uint8_t mac[6]; char name[12]; uint8_t status; uint32_t seen; int8_t rssi; };
static const char *PEER_ST[] = { "free", "agent busy", "busy", "asleep", "playing" };

Peer peers[MAX_PEERS];
uint8_t myMac[6]; uint16_t teamId = 0; char teamName[16] = "lilmate";
QueueHandle_t linkQ = nullptr;
bool linkOk = false;
uint32_t linkNextBeacon = 0, linkNextChan = 0;
uint8_t playCur = 0;

enum LMode : uint8_t { LM_IDLE, LM_INVITING, LM_INVITED, LM_COUNTDOWN, LM_ROUND, LM_ROUND_END, LM_MATCH_END };
struct {
  LMode mode; int peer; bool host; uint16_t match;
  uint32_t t0, lastRx, lastTx, roundStart, goAt, botAt;
  uint8_t round, kind; uint16_t qdWait, tugDur;
  int32_t myVal, oppVal; bool myDone, oppDone;
  int32_t tugMine, tugOpp;
  uint8_t myWins, oppWins; int8_t lastWin;   // 1 me, -1 them, 0 draw
} lm = {};

bool linkBusy() { return lm.mode != LM_IDLE; }
uint8_t myStatus() { return lm.mode != LM_IDLE ? 4 : asleep ? 3 : isBusy() ? 2 : agCount(AG_WORKING) ? 1 : 0; }
bool isBot() { return lm.peer == BOT_IDX; }
const char *oppName() { return lm.peer >= 0 ? peers[lm.peer].name : "?"; }

uint16_t hash16(const char *s) { uint16_t h = 0x9E37; while (*s) h = (h * 31) ^ (uint8_t)tolower(*s++); return h; }

// ------------------------------------------------------------ radio
void onLinkRecv(const esp_now_recv_info_t *info, const uint8_t *data, int len) {
  if (len != sizeof(LPkt) || !linkQ) return;
  LRx r; memcpy(r.mac, info->src_addr, 6); r.rssi = info->rx_ctrl ? info->rx_ctrl->rssi : 0; memcpy(&r.p, data, sizeof(LPkt));
  xQueueSend(linkQ, &r, 0);
}

void lsendTo(uint8_t type, const uint8_t *to, int32_t a, int32_t b, uint16_t match) {
  if (!linkOk) return;
  LPkt p = {};
  p.m0 = 'L'; p.m1 = 'M'; p.ver = 1; p.type = type; p.team = teamId; p.match = match;
  memcpy(p.to, to, 6);
  copyStr(p.name, S.owner, sizeof(p.name));
  p.status = myStatus(); p.round = lm.round; p.kind = lm.kind; p.a = a; p.b = b;
  esp_now_send(BCAST, (const uint8_t *)&p, sizeof(p));
}
void lsend(uint8_t type, int32_t a = 0, int32_t b = 0) {
  if (type != L_BEACON && isBot()) return;          // the bot lives on this board
  lsendTo(type, (type == L_BEACON || lm.peer < 0) ? BCAST : peers[lm.peer].mac, a, b, lm.match);
  lm.lastTx = millis();
}

// ------------------------------------------------------------ team social: wave, tea / lunch calls
struct { bool on; int from; uint8_t kind; uint32_t t0; } call = {};
int lastWaveFrom = -1; uint32_t lastWaveAt = 0;
uint32_t botPingAt = 0; uint8_t botPingKind = 0;
uint8_t menuOpen = 0, menuSel = 0; int menuPeer = -1; uint32_t menuAt = 0;
void sendPing(uint8_t kind, int idx) {                 // idx -1 = whole team
  if (idx >= 0 && peers[idx].bot) { botPingKind = kind; botPingAt = millis() + (kind == P_WAVE ? 1200 : 2500); return; }
  lsendTo(L_PING, idx < 0 ? BCAST : peers[idx].mac, kind, 0, 0);
  if (idx < 0 && peers[BOT_IDX].used) { botPingKind = kind; botPingAt = millis() + 2500; }   // the bot answers team calls
}
void wave(int idx) { if (idx < 0 || !peers[idx].used) return; sendPing(P_WAVE, idx); faceSetMood(M_HAPPY, 2000); faceSay(String("Waved at ") + peers[idx].name + "!"); }
void teamCall(uint8_t kind) { sendPing(kind, -1); screen = S_FACE; faceSetMood(M_HAPPY, 2500); faceSay(kind == P_TEA ? "Tea break call sent!" : "Lunch call sent!"); }
void onPing(int from, uint8_t kind) {
  Peer &pe = peers[from];
  bool quiet = isBusy();
  if (kind == P_WAVE) {
    lastWaveFrom = from; lastWaveAt = millis();
    if (!quiet) wakeUp(false);
    faceSetMood(M_HAPPY, 3500); faceSay(String(pe.name) + " waved! tap = wave back");
  } else if (kind == P_TEA || kind == P_LUNCH) {
    call.on = true; call.from = from; call.kind = kind; call.t0 = millis();
    if (!quiet) wakeUp(false);
  } else if (kind == P_JOIN) {
    wakeUp(false); faceSetMood(M_LAUGH, 3000); faceSay(String(pe.name) + " is in! :)");
  }
  Serial.printf("[link] ping %u from %s\n", kind, pe.name);
}

void linkSetTeam(const String &t) {
  copyStr(teamName, t.length() ? t.c_str() : "lilmate", sizeof(teamName));
  teamId = hash16(teamName);
  prefs.putString("team", teamName);
}

void linkBegin() {
  WiFi.macAddress(myMac);
  String t = prefs.getString("team", "lilmate"); copyStr(teamName, t.c_str(), sizeof(teamName)); teamId = hash16(teamName);
  Peer &b = peers[BOT_IDX]; b.used = true; b.bot = true; copyStr(b.name, "lil.bot", sizeof(b.name));
  uint8_t bm[6] = { 0x02, 0, 0, 0, 0, 0xB0 }; memcpy(b.mac, bm, 6);
  linkQ = xQueueCreate(12, sizeof(LRx));
  if (esp_now_init() != ESP_OK) { Serial.println("[link] esp_now_init failed"); return; }
  esp_now_register_recv_cb(onLinkRecv);
  esp_now_peer_info_t pi = {};
  memcpy(pi.peer_addr, BCAST, 6); pi.channel = 0; pi.ifidx = WIFI_IF_STA; pi.encrypt = false;
  linkOk = esp_now_add_peer(&pi) == ESP_OK;
  Serial.printf("[link] ESP-NOW %s, team '%s'\n", linkOk ? "ready" : "peer add failed", teamName);
}

int peerIndex(const uint8_t *mac, bool create) {
  for (int i = 0; i < BOT_IDX; i++) if (peers[i].used && !memcmp(peers[i].mac, mac, 6)) return i;
  if (!create) return -1;
  int pick = -1;
  for (int i = 0; i < BOT_IDX; i++) if (!peers[i].used) { pick = i; break; }
  if (pick < 0) { pick = 0; for (int i = 1; i < BOT_IDX; i++) if (peers[i].seen < peers[pick].seen) pick = i; }
  memset(&peers[pick], 0, sizeof(Peer)); peers[pick].used = true; memcpy(peers[pick].mac, mac, 6);
  return pick;
}
bool peerVisible(int i) { return peers[i].used && (peers[i].bot || millis() - peers[i].seen < 15000); }
int visibleCount() { int n = 0; for (int i = 0; i < MAX_PEERS; i++) if (peerVisible(i)) n++; return n; }
int visibleAt(int k) { for (int i = 0; i < MAX_PEERS; i++) if (peerVisible(i) && k-- == 0) return i; return -1; }

// ------------------------------------------------------------ match flow
void linkReset() { lm.mode = LM_IDLE; lm.peer = -1; setInvert(false); }

void linkInvite(int idx) {
  if (idx < 0 || !peerVisible(idx) || lm.mode != LM_IDLE) return;
  memset(&lm, 0, sizeof(lm));
  lm.mode = LM_INVITING; lm.peer = idx; lm.host = true; lm.match = (uint16_t)esp_random(); lm.t0 = millis(); lm.lastRx = millis();
  if (isBot()) lm.botAt = millis() + 900;
  lsend(L_INVITE);
  Serial.printf("[link] invite -> %s\n", oppName());
}

void beginRound(uint8_t round, uint8_t kind, uint32_t delay, uint16_t param) {
  uint32_t now = millis();
  lm.round = round; lm.kind = kind; lm.mode = LM_COUNTDOWN; lm.roundStart = now + delay;
  lm.myVal = lm.oppVal = 0; lm.myDone = lm.oppDone = false; lm.tugMine = lm.tugOpp = 0;
  if (kind == K_QUICK) { lm.qdWait = param; lm.goAt = lm.roundStart + param; }
  else lm.tugDur = param;
  if (isBot()) {   // pre-roll the bot's behaviour for this round
    lm.botAt = kind == K_QUICK ? (random(0, 100) < 8 ? lm.roundStart + random(300, param) : lm.goAt + random(230, 520))
                               : lm.roundStart + random(120, 190);
  }
  screen = S_PLAY;
}

void hostStartRound(uint8_t round) {
  uint8_t kind = round % 2 ? K_QUICK : K_TUG;
  uint16_t param = kind == K_QUICK ? random(1500, 4000) : 7000;
  beginRound(round, kind, 2600, param);
  lsend(L_START, 2600, param);
}

void acceptInvite() {
  if (lm.mode != LM_INVITED) return;
  lsend(L_ACCEPT);
  lm.mode = LM_COUNTDOWN; lm.round = 0; lm.t0 = millis(); lm.roundStart = millis() + 600000;   // wait for host's START
  setInvert(false); faceClearBubble();
}
void declineInvite() { if (lm.mode == LM_INVITED) { lsend(L_DECLINE); linkReset(); faceSay("Maybe later!"); } }
void linkCancel(const char *why) {
  if (lm.mode == LM_IDLE) return;
  lsend(L_CANCEL);
  String w = why; linkReset();
  faceSetMood(M_SAD, 2000); faceSay(w);
  screen = S_FACE;
}

void finishRound() {
  int8_t w = 0;
  if (lm.kind == K_QUICK) {
    bool mf = lm.myVal < 0, of = lm.oppVal < 0;
    if (mf && of) w = 0; else if (mf) w = -1; else if (of) w = 1;
    else w = lm.myVal < lm.oppVal ? 1 : lm.myVal > lm.oppVal ? -1 : 0;
  } else w = lm.myVal > lm.oppVal ? 1 : lm.myVal < lm.oppVal ? -1 : 0;
  lm.lastWin = w;
  if (w > 0) lm.myWins++; else if (w < 0) lm.oppWins++;
  lm.mode = LM_ROUND_END; lm.t0 = millis();
}

void gameInput() {   // one tap from touch, keyboard or the web
  uint32_t now = millis();
  if (lm.kind == K_QUICK && (lm.mode == LM_COUNTDOWN || lm.mode == LM_ROUND) && !lm.myDone && lm.round) {
    lm.myVal = now < lm.goAt ? -1 : (int32_t)(now - lm.goAt);
    lm.myDone = true; lsend(L_RESULT, lm.myVal);
  } else if (lm.kind == K_TUG && lm.mode == LM_ROUND && now < lm.roundStart + lm.tugDur) {
    lm.tugMine++;
  }
}

void handlePacket(const LRx &r) {
  const LPkt &p = r.p;
  if (p.m0 != 'L' || p.m1 != 'M' || p.ver != 1 || p.team != teamId) return;
  if (!memcmp(r.mac, myMac, 6)) return;
  int i = peerIndex(r.mac, true);
  Peer &pe = peers[i];
  copyStr(pe.name, p.name, sizeof(pe.name)); if (!pe.name[0]) copyStr(pe.name, "buddy", sizeof(pe.name));
  pe.status = p.status; pe.seen = millis(); pe.rssi = r.rssi;
  if (p.type == L_BEACON) return;
  if (memcmp(p.to, myMac, 6) && !(p.type == L_PING && !memcmp(p.to, BCAST, 6))) return;   // not for me (team calls are broadcast)
  uint32_t now = millis();
  bool mine = lm.mode != LM_IDLE && lm.peer == i && p.match == lm.match;
  if (mine) lm.lastRx = now;

  switch (p.type) {
    case L_PING:
      onPing(i, (uint8_t)p.a);
      break;
    case L_INVITE:
      if (lm.mode == LM_IDLE && isBusy()) { lsendTo(L_DECLINE, r.mac, 1, 0, p.match); Serial.printf("[link] busy: declined %s\n", pe.name); }
      else if (lm.mode == LM_IDLE) {
        memset(&lm, 0, sizeof(lm));
        lm.mode = LM_INVITED; lm.peer = i; lm.host = false; lm.match = p.match; lm.t0 = now; lm.lastRx = now;
        wakeUp(false); screen = S_PLAY;
        Serial.printf("[link] invite from %s\n", pe.name);
      } else if (!mine) { uint16_t keep = lm.match; int kp = lm.peer; lm.match = p.match; lm.peer = i; lsend(L_DECLINE, 1); lm.match = keep; lm.peer = kp; }
      break;
    case L_ACCEPT:
      if (mine && lm.mode == LM_INVITING) hostStartRound(1);
      break;
    case L_DECLINE:
      if (mine && lm.mode == LM_INVITING) { linkReset(); faceSetMood(M_SAD, 2000); faceSay(String(pe.name) + (p.a ? " is busy" : " said not now")); screen = S_FACE; }
      break;
    case L_CANCEL:
      if (mine) { linkReset(); faceSetMood(M_SAD, 2000); faceSay(String(pe.name) + " left the game"); screen = S_FACE; }
      break;
    case L_START:
      if (mine && !lm.host && p.round > lm.round) beginRound(p.round, p.kind, (uint32_t)max(0, (int)p.a - 10), (uint16_t)p.b);
      break;
    case L_RESULT:
      if (mine && p.round == lm.round && !lm.oppDone) { lm.oppVal = p.a; lm.oppDone = true; if (lm.kind == K_TUG) lm.tugOpp = p.a; }
      break;
    case L_TUG:
      if (mine && p.round == lm.round && p.a > lm.tugOpp) lm.tugOpp = p.a;
      break;
  }
}

void linkLoop() {
  if (!linkOk) return;
  LRx r;
  while (xQueueReceive(linkQ, &r, 0) == pdTRUE) handlePacket(r);
  uint32_t now = millis();

  // keep the radio on the link channel while offline (on Wi-Fi, ESP-NOW follows the router's channel)
  if (now > linkNextChan) { linkNextChan = now + 2000; if (!apMode && WiFi.status() != WL_CONNECTED) esp_wifi_set_channel(LINK_CH, WIFI_SECOND_CHAN_NONE); }
  if (now > linkNextBeacon) { linkNextBeacon = now + random(2500, 3500); lsend(L_BEACON); }

  if (botPingAt && now > botPingAt) { botPingAt = 0; onPing(BOT_IDX, botPingKind == P_WAVE ? P_WAVE : P_JOIN); }
  if (call.on) { setInvert(!isBusy() && now - call.t0 < 4000 ? (now / 300) % 2 : false); if (now - call.t0 > 60000) { call.on = false; setInvert(false); } }
  if (menuOpen && now - menuAt > 10000) menuOpen = 0;
  if (lm.mode == LM_IDLE) return;
  bool bot = isBot();
  if (!bot && lm.mode != LM_INVITING && lm.mode != LM_INVITED && now - lm.lastRx > 8000) { linkCancel("Lost connection :("); return; }

  switch (lm.mode) {
    case LM_INVITING:
      if (bot && now > lm.botAt) { hostStartRound(1); break; }
      if (now - lm.lastTx > 500) lsend(L_INVITE);
      if (now - lm.t0 > 30000) { linkReset(); faceSay(String(oppName()) + " didn't answer"); screen = S_FACE; }
      break;
    case LM_INVITED:
      setInvert(now - lm.t0 < 5000 ? (now / 300) % 2 : false);
      if (now - lm.t0 > 30000) declineInvite();
      break;
    case LM_COUNTDOWN:
      if (!lm.round) { if (now - lm.t0 > 8000) linkCancel("Game didn't start"); break; }
      if (lm.host && now - lm.lastTx > 250) lsend(L_START, (int32_t)(lm.roundStart > now ? lm.roundStart - now : 0), lm.kind == K_QUICK ? lm.qdWait : lm.tugDur);
      if (now >= lm.roundStart) lm.mode = LM_ROUND;
      // fall through so a foul tap during the countdown is still resolved
      [[fallthrough]];
    case LM_ROUND:
      if (lm.kind == K_QUICK) {
        if (!lm.myDone && lm.mode == LM_ROUND && now > lm.goAt + 3000) { lm.myVal = 9999; lm.myDone = true; }
        if (bot && !lm.oppDone && now >= lm.botAt) { lm.oppVal = lm.botAt < lm.goAt ? -1 : (int32_t)(lm.botAt - lm.goAt); lm.oppDone = true; }
      } else if (lm.mode == LM_ROUND) {
        uint32_t end = lm.roundStart + lm.tugDur;
        if (bot && now >= lm.botAt && now < end) { lm.tugOpp++; lm.botAt = now + random(110, 200); }
        if (!lm.myDone && now >= end) { lm.myDone = true; lm.myVal = lm.tugMine; }
        if (bot && !lm.oppDone && now >= end) { lm.oppDone = true; lm.oppVal = lm.tugOpp; }
        if (!lm.myDone && now - lm.lastTx > 120) lsend(L_TUG, lm.tugMine);
      }
      if (lm.myDone && now - lm.lastTx > 150) lsend(L_RESULT, lm.myVal);
      if (lm.myDone && lm.oppDone) finishRound();
      break;
    case LM_ROUND_END:
      if (now - lm.lastTx > 200) lsend(L_RESULT, lm.myVal);   // make sure the other side got our result
      if (now - lm.t0 > 2800) {
        if (lm.myWins >= 2 || lm.oppWins >= 2 || lm.round >= 5) {
          lm.mode = LM_MATCH_END; lm.t0 = now;
          bool won = lm.myWins > lm.oppWins;
          if (won) petHappy(8);
          faceSetMood(won ? M_LAUGH : lm.myWins == lm.oppWins ? M_SURPRISED : M_SAD, 6000);
        } else if (lm.host) hostStartRound(lm.round + 1);
        else if (now - lm.t0 > 9000) linkCancel("Game didn't continue");
      }
      break;
    case LM_MATCH_END:
      if (now - lm.t0 > 6000) {
        String res = lm.myWins > lm.oppWins ? String("I beat ") + oppName() + " " + lm.myWins + "-" + lm.oppWins + "!"
                   : lm.myWins < lm.oppWins ? String(oppName()) + " won " + lm.oppWins + "-" + lm.myWins + ". Rematch?"
                   : String("Draw with ") + oppName() + "!";
        linkReset(); screen = S_FACE; faceSay(res);
      }
      break;
    default: break;
  }
}

// ------------------------------------------------------------ touch
bool linkTouch(TouchEv e) {
  switch (lm.mode) {
    case LM_INVITED:
      if (e == T_LONG) acceptInvite();
      else if (e == T_TAP2) declineInvite();
      return e != T_PRESS && e != T_RELEASE;
    case LM_INVITING:
      if (e == T_TAP1) { lsend(L_CANCEL); linkReset(); faceSay("Invite cancelled"); screen = S_PLAY; }
      return e != T_PRESS && e != T_RELEASE;
    case LM_COUNTDOWN: case LM_ROUND:
      if (e == T_PRESS) gameInput();
      else if (e == T_VLONG) linkCancel("Game cancelled");
      return true;
    case LM_ROUND_END: return true;
    case LM_MATCH_END: if (e == T_TAP1) lm.t0 = 0; return true;
    default: break;
  }
  if (call.on) {
    if (e == T_LONG) { if (!peers[call.from].bot) sendPing(P_JOIN, call.from); call.on = false; setInvert(false); faceSetMood(M_HAPPY, 2500); faceSay("See you there!"); }
    else if (e == T_TAP1 || e == T_TAP2) { call.on = false; setInvert(false); faceSay("Maybe next time"); }
    return e != T_PRESS && e != T_RELEASE;
  }
  if (menuOpen) {
    if (e == T_TAP1) { menuSel = (menuSel + 1) % 3; menuAt = millis(); }
    else if (e == T_LONG) { menuOpen = 0; if (menuSel == 0) linkInvite(menuPeer); else if (menuSel == 1) wave(menuPeer); }
    return e != T_PRESS && e != T_RELEASE;
  }
  if (e == T_TAP1 && screen == S_FACE && lastWaveFrom >= 0 && millis() - lastWaveAt < 20000) { wave(lastWaveFrom); lastWaveFrom = -1; return true; }
  if (screen == S_PLAY) {
    int n = visibleCount() + 2;                        // rows: tea call, lunch call, then buddies
    if (e == T_TAP1) { playCur = (playCur + 1) % n; return true; }
    if (e == T_LONG) {
      int k = playCur % n;
      if (k == 0) teamCall(P_TEA); else if (k == 1) teamCall(P_LUNCH);
      else { menuPeer = visibleAt(k - 2); menuSel = 0; menuOpen = menuPeer >= 0; menuAt = millis(); }
      return true;
    }
  }
  return false;
}

// ------------------------------------------------------------ drawing
void drawMiniFace(int cx, int cy, bool happy) {
  oled.drawRBox(cx - 9, cy - 7, 18, 14, 4);
  oled.setDrawColor(0);
  if (happy) { oled.drawLine(cx - 6, cy, cx - 4, cy - 2); oled.drawLine(cx - 4, cy - 2, cx - 2, cy); oled.drawLine(cx + 2, cy, cx + 4, cy - 2); oled.drawLine(cx + 4, cy - 2, cx + 6, cy); }
  else { oled.drawBox(cx - 6, cy - 3, 3, 5); oled.drawBox(cx + 3, cy - 3, 3, 5); }
  oled.setDrawColor(1);
}

void drawScoreLine(int y) {
  if (y > 63) y = 63;
  char b[32]; snprintf(b, sizeof(b), "me %u - %u %s", lm.myWins, lm.oppWins, oppName());
  centerStr(y, u8g2_font_5x7_tr, b);
}

void drawMatch(uint32_t now) {
  char b[40];
  switch (lm.mode) {
    case LM_INVITING:
      header("PLAY", "inviting");
      centerStr(30, u8g2_font_6x10_tr, (String("Calling ") + oppName()).c_str());
      for (int i = 0; i < 3; i++) if ((now / 300) % 4 > (uint32_t)i) oled.drawDisc(56 + i * 8, 40, 2);
      centerStr(60, u8g2_font_5x7_tr, "tap = cancel");
      break;
    case LM_INVITED:
      header("GAME TIME!");
      centerStr(29, u8g2_font_7x14B_tr, oppName());
      centerStr(41, u8g2_font_6x10_tr, "wants to play!");
      centerStr(54, u8g2_font_5x7_tr, "Quick Draw + Tug of War");
      centerStr(63, u8g2_font_5x7_tr, (now / 600) % 2 ? "HOLD = YES  2 TAPS = NO" : "hold = yes  2 taps = no");
      break;
    case LM_COUNTDOWN: {
      if (!lm.round) { header("PLAY"); centerStr(36, u8g2_font_6x10_tr, "Get ready..."); drawScoreLine(60); break; }
      header(lm.kind == K_QUICK ? "QUICK DRAW" : "TUG OF WAR", (String("round ") + lm.round).c_str());
      int s = lm.roundStart > now ? (lm.roundStart - now) / 1000 + 1 : 0;
      snprintf(b, sizeof(b), "%d", s);
      oled.setFont(u8g2_font_logisoso24_tr); oled.drawStr((128 - oled.getStrWidth(b)) / 2, 44, b);
      centerStr(53, u8g2_font_5x7_tr, lm.kind == K_QUICK ? "tap when you see GO!" : "tap as fast as you can!");
      if (lm.myDone && lm.myVal < 0) centerStr(26, u8g2_font_6x10_tr, "TOO EARLY!");
      drawScoreLine(64);
    } break;
    case LM_ROUND:
      if (lm.kind == K_QUICK) {
        if (lm.myDone) {
          header("QUICK DRAW");
          if (lm.myVal < 0) centerStr(36, u8g2_font_7x14B_tr, "TOO EARLY!");
          else { snprintf(b, sizeof(b), "%ld ms", (long)lm.myVal); centerStr(38, u8g2_font_logisoso20_tr, b); }
          centerStr(56, u8g2_font_5x7_tr, (String("waiting for ") + oppName()).c_str());
        } else if (now < lm.goAt) {
          header("QUICK DRAW"); drawMiniFace(64, 34, false); centerStr(56, u8g2_font_6x10_tr, "wait for it...");
        } else {
          oled.drawBox(0, 0, 128, 64); oled.setDrawColor(0);
          oled.setFont(u8g2_font_logisoso24_tr); oled.drawStr((128 - oled.getStrWidth("GO!")) / 2, 44, "GO!");
          oled.setDrawColor(1);
        }
      } else {
        uint32_t end = lm.roundStart + lm.tugDur;
        header("TUG OF WAR", (String((end > now ? end - now : 0) / 1000 + 1) + "s").c_str());
        int diff = lm.tugMine - lm.tugOpp;
        int knot = 64 - constrain(diff * 3, -50, 50);
        knot = constrain(knot, 26, 102);
        oled.drawHLine(20, 40, 88); oled.drawHLine(20, 41, 88);
        oled.drawLine(64, 34, 64, 47);                       // centre mark
        oled.drawBox(knot - 3, 36, 7, 9);
        drawMiniFace(10, 40, diff >= 0); drawMiniFace(117, 40, diff <= 0);
        oled.setFont(u8g2_font_5x7_tr);
        snprintf(b, sizeof(b), "me %ld", (long)lm.tugMine); oled.drawStr(0, 63, b);
        snprintf(b, sizeof(b), "%s %ld", oppName(), (long)lm.tugOpp); oled.drawStr(128 - oled.getStrWidth(b), 63, b);
        centerStr(26, u8g2_font_6x10_tr, (now / 200) % 2 ? "TAP! TAP! TAP!" : "tap! tap! tap!");
      }
      break;
    case LM_ROUND_END:
      header(lm.kind == K_QUICK ? "QUICK DRAW" : "TUG OF WAR", (String("round ") + lm.round).c_str());
      centerStr(32, u8g2_font_7x14B_tr, lm.lastWin > 0 ? "You win!" : lm.lastWin < 0 ? (String(oppName()) + " wins").c_str() : "Draw!");
      if (lm.kind == K_QUICK) {
        auto f = [](int32_t v) { return v < 0 ? String("early") : v >= 9999 ? String("--") : String(v) + "ms"; };
        snprintf(b, sizeof(b), "%s vs %s", f(lm.myVal).c_str(), f(lm.oppVal).c_str());
      } else snprintf(b, sizeof(b), "%ld vs %ld taps", (long)lm.myVal, (long)lm.oppVal);
      centerStr(46, u8g2_font_6x10_tr, b);
      drawScoreLine(62);
      break;
    case LM_MATCH_END: {
      bool won = lm.myWins > lm.oppWins, draw = lm.myWins == lm.oppWins;
      if (won && (now / 250) % 2) oled.drawFrame(0, 0, 128, 64);
      centerStr(24, u8g2_font_7x14B_tr, won ? "YOU WIN!" : draw ? "DRAW!" : (String(oppName()) + " wins").c_str());
      snprintf(b, sizeof(b), "%u - %u", lm.myWins, lm.oppWins);
      oled.setFont(u8g2_font_logisoso20_tr); oled.drawStr((128 - oled.getStrWidth(b)) / 2, 50, b);
      centerStr(62, u8g2_font_5x7_tr, won ? "gg! :)" : "rematch soon?");
    } break;
    default: break;
  }
}

bool linkDraw(uint32_t now) {   // the match / a team call / the buddy menu takes over the screen
  if (lm.mode == LM_IDLE) {
    if (call.on) {
      header(call.kind == P_TEA ? "TEA BREAK?" : "LUNCH?", "team");
      centerStr(30, u8g2_font_7x14B_tr, peers[call.from].name);
      centerStr(43, u8g2_font_6x10_tr, call.kind == P_TEA ? "is going for tea" : "is going for lunch");
      centerStr(63, u8g2_font_5x7_tr, (now / 600) % 2 ? "HOLD = I'M IN  TAP = NO" : "hold = i'm in  tap = no");
      return true;
    }
    if (menuOpen && menuPeer >= 0) {
      header(peers[menuPeer].name, "");
      static const char *items[] = { "Play a game", "Wave hello", "Back" };
      oled.setFont(u8g2_font_6x10_tr);
      for (int k = 0; k < 3; k++) {
        int y = 25 + k * 12;
        if (k == menuSel) { oled.drawRBox(0, y - 9, 128, 12, 2); oled.setDrawColor(0); }
        oled.drawStr(6, y, items[k]); oled.setDrawColor(1);
      }
      centerStr(64, u8g2_font_5x7_tr, "tap: next   hold: pick");
      return true;
    }
    return false;
  }
  drawMatch(now);
  return true;
}

void drawPlay(uint32_t now) {
  int nb = visibleCount(), n = nb + 2;
  char r[24]; snprintf(r, sizeof(r), "%d nearby", nb - 1);
  header("TEAM", r);
  if (playCur >= n) playCur = 0;
  int first = playCur > 1 ? playCur - 1 : 0;
  if (first > n - 3) first = max(0, n - 3);
  oled.setFont(u8g2_font_6x10_tr);
  for (int k = first, row = 0; k < n && row < 3; k++, row++) {
    int y = 23 + row * 11;
    const char *name, *st;
    if (k < 2) { name = k == 0 ? "Tea break? (all)" : "Lunch? (all)"; st = "call"; }
    else { int i = visibleAt(k - 2); name = peers[i].name; st = peers[i].bot ? "bot" : PEER_ST[min((int)peers[i].status, 4)]; }
    if (k == playCur) { oled.drawRBox(0, y - 9, 128, 11, 2); oled.setDrawColor(0); }
    oled.drawStr(3, y, name);
    oled.setFont(u8g2_font_5x7_tr);
    oled.drawStr(124 - oled.getStrWidth(st), y - 1, st);
    oled.setFont(u8g2_font_6x10_tr);
    oled.setDrawColor(1);
  }
  centerStr(64, u8g2_font_5x7_tr, "tap: next   hold: choose");
}

String linkStatus() {
  String s = "🎮 Team '" + String(teamName) + "' · " + (linkOk ? "radio on" : "radio off") + "\n";
  for (int i = 0; i < MAX_PEERS; i++) if (peerVisible(i)) s += String(i) + ". " + peers[i].name + (peers[i].bot ? " (bot)" : String(" · ") + PEER_ST[min((int)peers[i].status, 4)] + " · " + peers[i].rssi + "dBm") + "\n";
  if (lm.mode != LM_IDLE) s += String("Match vs ") + oppName() + ": " + lm.myWins + "-" + lm.oppWins;
  return s;
}

void linkJson(JsonObject o) {
  static const char *MODES[] = { "idle", "inviting", "invited", "countdown", "round", "roundend", "matchend" };
  o["team"] = teamName; o["mode"] = MODES[lm.mode]; o["radio"] = linkOk;
  if (lm.mode != LM_IDLE) { o["opp"] = oppName(); o["me"] = lm.myWins; o["them"] = lm.oppWins; o["round"] = lm.round; o["kind"] = lm.kind == K_QUICK ? "quick" : "tug"; }
  if (call.on) { o["call"] = peers[call.from].name; o["callKind"] = call.kind == P_TEA ? "tea" : "lunch"; }
  JsonArray a = o["peers"].to<JsonArray>();
  for (int i = 0; i < MAX_PEERS; i++) if (peerVisible(i)) { JsonObject p = a.add<JsonObject>(); p["i"] = i; p["name"] = peers[i].name; p["bot"] = peers[i].bot; p["st"] = peers[i].bot ? "bot" : PEER_ST[min((int)peers[i].status, 4)]; }
}

// web / keyboard / Telegram entry point
String linkAction(const String &act, int idx) {
  if (act == "invite") { if (idx < 0 || idx >= MAX_PEERS || !peerVisible(idx)) return "No such buddy"; linkInvite(idx); screen = S_PLAY; return String("🎮 Inviting ") + peers[idx].name; }
  if (act == "accept") { acceptInvite(); return "Accepted"; }
  if (act == "decline") { declineInvite(); return "Declined"; }
  if (act == "tap") { gameInput(); return "tap"; }
  if (act == "wave") { if (idx < 0 || idx >= MAX_PEERS || !peerVisible(idx)) return "No such buddy"; wave(idx); return String("👋 Waved at ") + peers[idx].name; }
  if (act == "tea") { teamCall(P_TEA); return "☕ Tea break call sent to the team"; }
  if (act == "lunch") { teamCall(P_LUNCH); return "🍱 Lunch call sent to the team"; }
  if (act == "join") { if (!call.on) return "No call right now"; if (!peers[call.from].bot) sendPing(P_JOIN, call.from); call.on = false; setInvert(false); faceSay("See you there!"); return "You're in!"; }
  if (act == "nocall") { call.on = false; setInvert(false); return "ok"; }
  if (act == "cancel" || act == "quit") { if (lm.mode == LM_INVITING) { lsend(L_CANCEL); linkReset(); return "cancelled"; } linkCancel("Game cancelled"); return "cancelled"; }
  return "?";
}
