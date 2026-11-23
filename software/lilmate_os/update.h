// Firmware updates that need no computer:
//   * Wi-Fi: the buddy checks GitHub itself (daily, or on request), asks "hold to install", downloads over
//     verified HTTPS (pinned roots in roots.h) and checks the md5 before switching to the new firmware.
//   * Bluetooth: a phone or computer (Chrome / Edge, the lil.mate web updater) sends the firmware over BLE.
//     The buddy shows "Bluetooth update? hold = allow" first, so nobody nearby can flash it without a touch.
// USB cable and Wi-Fi uploads from lil.mate Desk / the web updater use serialOta() and /update instead.
// Whatever the path, a failed update leaves the old firmware running.
#pragma once
#include <Update.h>
#include <NetworkClientSecure.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include "config.h"
#include "roots.h"

#define UPDATE_FEED   "https://raw.githubusercontent.com/sudarsan-22/lilmate.in/updates/"
#define BLE_SVC       "6c696c6d-6174-6501-8000-00805f9b34fb"
#define BLE_CTRL      "6c696c6d-6174-6502-8000-00805f9b34fb"   // write: "begin <size> <md5>" / "abort"; notify: wait|ready|ok <n>|done|err <why>
#define BLE_DATA      "6c696c6d-6174-6503-8000-00805f9b34fb"   // write without response: firmware bytes
#define BLE_INFO      "6c696c6d-6174-6504-8000-00805f9b34fb"   // read: {"fw":"0.2.1","name":"…","id":"8b64"}
// lil.mate Desk over Bluetooth (office, no Wi-Fi): the same text lines as the USB cable ("@state", "@cmd …", "@ev {…}").
// The first line must be "@auth <link key>" (Desk learns the key over USB once); until then only "@hello" is answered.
#define BLE_LRX       "6c696c6d-6174-6505-8000-00805f9b34fb"   // write: lines from Desk (any chunking, '\n' ends a line)
#define BLE_LTX       "6c696c6d-6174-6506-8000-00805f9b34fb"   // notify: reply lines, chunked to the link's MTU
#define UPD_CHECK_EVERY (24UL * 3600000UL)
#define BLE_IDLE_OFF_MS (5UL * 60000UL)   // on Wi-Fi, Bluetooth switches itself off after 5 min unused (it holds ~76 KB of RAM)

uint8_t otaBuf[1024];   // one chunk buffer for every update path (only one update can run at a time)

extern uint32_t restartAt;
bool isBusy();

enum UpdSt : uint8_t { U_IDLE, U_CHECKING, U_LATEST, U_READY, U_GETTING, U_DONE, U_FAIL };
static const char *UPD_ST_NAMES[] = { "idle", "checking", "latest", "ready", "installing", "done", "failed" };
struct {
  volatile UpdSt st = U_IDLE;
  volatile uint8_t pct = 0;
  volatile bool wantCheck = false, wantInstall = false;
  char ver[16] = "", file[48] = "", md5[33] = "", notes[100] = "", err[48] = "";
  uint32_t size = 0, checkedAt = 0, promptUntil = 0;
  bool autoInstall = false, nightDone = false;
} up;

// ble state (callbacks run on the NimBLE task)
enum BleSt : uint8_t { B_OFF, B_ON, B_WAIT, B_RECV, B_DONE };
struct {
  volatile BleSt st = B_OFF;
  volatile uint32_t size = 0, got = 0, acked = 0, waitSince = 0, startedAt = 0, lastUse = 0;
  volatile bool connected = false, allowed = false, failed = false;
  char md5[33] = "", err[32] = "";
  BLECharacteristic *ctrl = nullptr, *ltx = nullptr;
  BLEServer *srv = nullptr;
  volatile bool authed = false;
} bl;

bool otaBusy() { return up.st == U_GETTING || bl.st == B_RECV || bl.st == B_WAIT; }

// "0.10.1" > "0.9.9"
bool verNewer(const char *a, const char *b) {
  int x[3] = {0}, y[3] = {0};
  sscanf(a, "%d.%d.%d", &x[0], &x[1], &x[2]); sscanf(b, "%d.%d.%d", &y[0], &y[1], &y[2]);
  for (int i = 0; i < 3; i++) if (x[i] != y[i]) return x[i] > y[i];
  return false;
}

static void updFail(const char *why) { copyStr(up.err, why, sizeof(up.err)); up.st = U_FAIL; Serial.printf("[upd] failed: %s\n", why); }

// ------------------------------------------------------------ Wi-Fi: check + install from GitHub (net task)
extern WiFiClientSecure tls;
static bool roomForTls() { return ESP.getFreeHeap() > 70000 && ESP.getMaxAllocHeap() > 36000; }   // a verified TLS session needs ~45 KB
static bool updCheck() {
  if (!roomForTls()) { up.checkedAt = millis() - UPD_CHECK_EVERY + 600000; Serial.println("[upd] low memory, retry in 10 min"); return false; }
  up.st = U_CHECKING; up.err[0] = 0;
  tls.stop();                                       // one TLS session at a time: the C3 has little RAM
  NetworkClientSecure c; c.setCACert(UPDATE_ROOTS);
  HTTPClient h; h.setConnectTimeout(10000); h.setTimeout(15000);
  h.useHTTP10(true);                                // plain (not chunked) body, so it can be parsed straight off the connection
  if (!h.begin(c, UPDATE_FEED "lilmate.json")) { updFail("no connection"); return false; }
  int code = h.GET();
  if (code != 200) { h.end(); char b[40]; snprintf(b, sizeof(b), code < 0 ? "can't reach GitHub" : "server said %d", code); updFail(b); return false; }
  JsonDocument filter; filter["firmware"] = true; filter["notes"] = true;
  JsonDocument d;
  DeserializationError e = deserializeJson(d, h.getStream(), DeserializationOption::Filter(filter));
  h.end();
  if (e || !d["firmware"]["version"]) { updFail("update info unreadable"); return false; }
  JsonObject f = d["firmware"];
  copyStr(up.ver, f["version"] | "", sizeof(up.ver)); copyStr(up.file, f["file"] | "", sizeof(up.file));
  copyStr(up.md5, f["md5"] | "", sizeof(up.md5)); copyStr(up.notes, d["notes"] | "", sizeof(up.notes));
  up.size = f["size"] | 0;
  up.checkedAt = millis();
  bool newer = verNewer(up.ver, FW_VERSION) && up.size > 65536 && strlen(up.md5) == 32;
  Serial.printf("[upd] GitHub has %s (running %s)%s\n", up.ver, FW_VERSION, newer ? " -> update ready" : "");
  if (newer && up.st != U_READY) { up.promptUntil = millis() + 45000; }
  up.st = newer ? U_READY : U_LATEST;
  return newer;
}

static void updInstall() {
  if (up.st != U_READY && !updCheck()) { if (up.st == U_LATEST) updFail("already up to date"); return; }
  if (batPresent && !charging && !usbHost() && batPct < 40) { updFail("charge me first (battery low)"); return; }
  tls.stop();
  if (!roomForTls()) { updFail("busy, try again in a minute"); return; }
  up.st = U_GETTING; up.pct = 0; up.promptUntil = 0;
  NetworkClientSecure c; c.setCACert(UPDATE_ROOTS);
  HTTPClient h; h.setConnectTimeout(10000); h.setTimeout(20000);
  if (!h.begin(c, String(UPDATE_FEED) + up.file)) { updFail("no connection"); return; }
  int code = h.GET();
  if (code != 200) { h.end(); updFail("download failed"); return; }
  if (h.getSize() > 0 && (uint32_t)h.getSize() != up.size) { h.end(); updFail("wrong file size"); return; }
  if (!Update.begin(up.size)) { h.end(); updFail(Update.errorString()); return; }
  Update.setMD5(up.md5);
  NetworkClient *s = h.getStreamPtr();
  uint8_t *buf = otaBuf; const size_t bufLen = sizeof(otaBuf);
  uint32_t got = 0, last = millis();
  while (got < up.size) {
    int a = s->available();
    if (a > 0) {
      int n = s->readBytes(buf, min((uint32_t)min(a, (int)bufLen), up.size - got));
      if (n > 0 && Update.write(buf, n) != (size_t)n) { Update.abort(); h.end(); updFail(Update.errorString()); return; }
      got += n; last = millis(); up.pct = (uint64_t)got * 100 / up.size;
    } else if (!s->connected() || millis() - last > 20000) { Update.abort(); h.end(); updFail("download stopped"); return; }
    else vTaskDelay(pdMS_TO_TICKS(2));
  }
  h.end();
  if (!Update.end(true)) { updFail(Update.errorString()); return; }   // md5 + image check happen here
  Serial.printf("[upd] installed %s from GitHub, restarting\n", up.ver);
  up.st = U_DONE; up.pct = 100;
  diagRestart(SW_OTA); restartAt = millis() + 2500;
}

void updService() {   // called from the net task (it owns the network)
  if (otaBusy() || bl.st == B_DONE) return;
  if ((up.wantInstall || up.wantCheck) && bl.st == B_ON && !bl.connected) return;   // updTick switches Bluetooth off first
  if (up.wantInstall) { up.wantInstall = false; updInstall(); }
  else if (up.wantCheck) { up.wantCheck = false; updCheck(); }
}

// ------------------------------------------------------------ Bluetooth (BLE) update
static void bleSay(const char *s) { if (bl.ctrl && bl.connected) { bl.ctrl->setValue((uint8_t *)s, strlen(s)); bl.ctrl->notify(); } }
static void bleFail(const char *why) {
  if (bl.st == B_RECV) Update.abort();
  copyStr(bl.err, why, sizeof(bl.err)); char b[48]; snprintf(b, sizeof(b), "err %s", why); bleSay(b);
  bl.st = B_ON; bl.failed = true; Serial.printf("[ble] update failed: %s\n", why);
}

class BleSrv : public BLEServerCallbacks {
  void onConnect(BLEServer *) override { bl.connected = true; bl.authed = false; bl.lastUse = millis(); Serial.println("[ble] connected"); }
  void onDisconnect(BLEServer *s) override {
    bl.connected = false; bl.authed = false; bl.lastUse = millis(); Serial.println("[ble] disconnected");
    if (bl.st == B_RECV || bl.st == B_WAIT) bleFail("disconnected");
    s->getAdvertising()->start();
  }
};
class BleCtrl : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *c) override {
    bl.lastUse = millis();
    String v = c->getValue(); v.trim();
    if (v.startsWith("begin ")) {
      if (up.st == U_GETTING || bl.st == B_RECV) { bleSay("err busy"); return; }
      int sp = v.indexOf(' ', 6);
      bl.size = v.substring(6, sp < 0 ? v.length() : sp).toInt();
      copyStr(bl.md5, sp < 0 ? "" : v.substring(sp + 1).c_str(), sizeof(bl.md5));
      if (bl.size < 65536 || bl.size > 0x1E0000) { bleSay("err bad size"); return; }
      bl.got = bl.acked = 0; bl.allowed = false; bl.failed = false; bl.err[0] = 0;
      bl.waitSince = millis(); bl.st = B_WAIT;   // the person must hold the buddy (see updTouch)
      bleSay("wait");
    } else if (v == "abort") { if (bl.st == B_RECV || bl.st == B_WAIT) bleFail("cancelled"); }
  }
};
class BleData : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *c) override {
    if (bl.st != B_RECV) return;
    size_t n = c->getLength(); uint8_t *p = c->getData();
    if (!n || !p) return;
    if (bl.got + n > bl.size) { bleFail("too much data"); return; }
    if (Update.write(p, n) != n) { bleFail(Update.errorString()); return; }
    bl.got += n;
    if (bl.got - bl.acked >= 4096 || bl.got == bl.size) {
      bl.acked = bl.got; char b[24]; snprintf(b, sizeof(b), "ok %lu", (unsigned long)bl.got); bleSay(b);
    }
    if (bl.got == bl.size) {
      if (!Update.end(true)) { bleFail(Update.errorString()); return; }
      bl.st = B_DONE; bleSay("done"); Serial.println("[ble] update installed, restarting");
      diagRestart(SW_OTA); restartAt = millis() + 2000;
    }
  }
};

// ------------------------------------------------------------ Bluetooth line link for lil.mate Desk
// Bytes written to LRX land in a stream buffer (NimBLE task); the main loop reads whole lines out of it (bleLineLoop in
// the .ino) and runs them like USB lines. Replies go out on LTX through BleOut, a Print that notifies line by line.
static StreamBufferHandle_t bleRx = nullptr;
class BleLRx : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *c) override {
    bl.lastUse = millis();
    size_t n = c->getLength(); uint8_t *p = c->getData();
    if (n && p && bleRx) xStreamBufferSend(bleRx, p, n, 0);   // a full buffer drops bytes: Desk resends on timeout
  }
};
// notify one reply, split to what this connection's MTU carries (20 bytes on the oldest links, ~500 on most)
void bleNotify(const char *s, size_t n) {
  if (!bl.ltx || !bl.connected) return;
  uint16_t mtu = bl.srv ? bl.srv->getPeerMTU(bl.srv->getConnId()) : 23;
  size_t ch = mtu > 23 ? min((size_t)mtu - 3, (size_t)240) : 20;
  for (size_t o = 0; o < n && bl.connected; o += ch) {
    bl.ltx->setValue((uint8_t *)s + o, min(ch, n - o)); bl.ltx->notify();
    delay(3);   // let the stack send it before the next one (no congestion drops)
  }
}
class BleOut : public Print {
 public:
  String line;
  size_t write(uint8_t c) override { line += (char)c; if (c == '\n' || line.length() >= 1024) flush(); return 1; }
  size_t write(const uint8_t *b, size_t n) override { for (size_t i = 0; i < n; i++) write(b[i]); return n; }
  void flush() override { if (line.length()) { bleNotify(line.c_str(), line.length()); line = ""; } }
} bleOut;

// started when there is no Wi-Fi (office), or on request (/bluetooth, phone page).
// On Wi-Fi it switches itself off again after 5 min unused, because it holds ~76 KB of RAM
// (and a GitHub update check needs ~73 KB). Without Wi-Fi it stays on: nothing else needs the memory then.
static BleSrv bleSrvCb; static BleCtrl bleCtrlCb; static BleData bleDataCb; static BleLRx bleLRxCb;   // static: no leak when Bluetooth is turned on again
void bleStart() {
  if (bl.st != B_OFF) return;
  // "lil.mate Sudarsan 8b64": a friendly name for the web updater's list, the id so lil.mate Desk finds *its* buddy
  char name[30]; snprintf(name, sizeof(name), "lil.mate %.14s %s", S.owner, buddyId());
  if (!bleRx) bleRx = xStreamBufferCreate(2048, 1);
  BLEDevice::init(name);
  BLEDevice::setMTU(517);
  BLEServer *srv = BLEDevice::createServer(); srv->setCallbacks(&bleSrvCb); bl.srv = srv;
  BLEService *svc = srv->createService(BLEUUID(BLE_SVC), 20);   // 20 handles: update (8) + Desk line link (5) + room
  bl.ctrl = svc->createCharacteristic(BLE_CTRL, BLECharacteristic::PROPERTY_WRITE | BLECharacteristic::PROPERTY_NOTIFY);
  bl.ctrl->setCallbacks(&bleCtrlCb);
  BLECharacteristic *data = svc->createCharacteristic(BLE_DATA, BLECharacteristic::PROPERTY_WRITE_NR | BLECharacteristic::PROPERTY_WRITE);
  data->setCallbacks(&bleDataCb);
  BLECharacteristic *info = svc->createCharacteristic(BLE_INFO, BLECharacteristic::PROPERTY_READ);
  BLECharacteristic *lrx = svc->createCharacteristic(BLE_LRX, BLECharacteristic::PROPERTY_WRITE | BLECharacteristic::PROPERTY_WRITE_NR);
  lrx->setCallbacks(&bleLRxCb);
  bl.ltx = svc->createCharacteristic(BLE_LTX, BLECharacteristic::PROPERTY_NOTIFY);
  String inf = String("{\"fw\":\"") + FW_VERSION + "\",\"name\":\"" + S.owner + "\",\"id\":\"" + buddyId() + "\"}";
  info->setValue(inf);
  svc->start();
  BLEAdvertising *adv = BLEDevice::getAdvertising();
  adv->addServiceUUID(BLE_SVC); adv->setScanResponse(true);
  adv->start();
  bl.st = B_ON; bl.startedAt = bl.lastUse = millis();
  Serial.printf("[ble] advertising as \"%s\" (heap %u)\n", name, (unsigned)ESP.getFreeHeap());
}
// How long Bluetooth may sit unused while the buddy is on Wi-Fi (Wi-Fi + Bluetooth together leave little memory):
// 30 s when it came on because Wi-Fi dropped, 3 min when lil.mate Desk went quiet, 5 min when someone asked for it.
uint32_t bleIdleMs = BLE_IDLE_OFF_MS;
uint32_t deskSeenAt = 0;   // last status request from lil.mate Desk over Wi-Fi ("/api/state?desk=1")

// which way lil.mate Desk talks to us right now (USB cable, Wi-Fi or Bluetooth); a short banner on the screen when it changes
enum : uint8_t { DV_NONE, DV_USB, DV_WIFI, DV_BLE };
static const char *DV_TEXT[] = { "Desk disconnected", "Desk on USB", "Desk on Wi-Fi", "Desk on Bluetooth" };
uint32_t deskAt[4] = {};             // last line / status request heard from Desk on each way
uint8_t  deskVia = DV_NONE;
uint32_t deskBannerAt = 0;
void deskHeard(uint8_t v) { deskAt[v] = millis() | 1; }
void deskViaTick() {
  uint32_t now = millis();
  // keep the current way while Desk still uses it (it asks every 2 s): a one-off Wi-Fi check while on Bluetooth must not flicker
  if (deskVia != DV_NONE && now - deskAt[deskVia] < 5000) return;
  uint8_t best = DV_NONE; uint32_t bestAge = 15000;   // nothing for 15 s on any way = disconnected
  for (uint8_t v = DV_USB; v <= DV_BLE; v++) if (deskAt[v] && now - deskAt[v] < bestAge) { bestAge = now - deskAt[v]; best = v; }
  if (best == deskVia) return;
  deskVia = best; deskBannerAt = now | 1;
  Serial.printf("[desk] %s\n", DV_TEXT[best]);
  if (!asleep) wakeUp(false);   // show it if the screen had gone dark (not at night)
}
void deskBannerDraw(uint32_t now) {
  if (!deskBannerAt || now - deskBannerAt > 3500) return;
  oled.setDrawColor(0); oled.drawBox(0, 0, 128, 15); oled.setDrawColor(1);
  oled.drawRFrame(4, 0, 120, 15, 4);
  centerStr(11, u8g2_font_6x10_tr, DV_TEXT[deskVia]);
}
uint8_t bleCycles = 0;   // times Bluetooth was switched off since boot (each one leaves ~2.4 KB the library never frees)
void bleStop() {
  if (bl.st != B_ON || bl.connected) return;
  bleCycles++;
  bl.ctrl = bl.ltx = nullptr; bl.srv = nullptr; bl.st = B_OFF; bl.authed = false;
  BLEDevice::deinit(false);   // false: keep the controller's memory so Bluetooth can be turned on again
  Serial.printf("[ble] off (heap %u)\n", (unsigned)ESP.getFreeHeap());
}

// ------------------------------------------------------------ memory safety net
// Restart quietly at night while the buddy sleeps (no splash, screen stays dark, everything saved first) when
//   * Bluetooth was switched off since boot: its leftovers chop the free memory into smaller pieces, or
//   * no big free block has been left for 10 minutes (an HTTPS check needs ~36 KB in one piece).
// The restart log (/diag) shows it as "memory tidy-up (night)".
static void memGuard(uint32_t now) {
  static uint32_t lowSince = 0;
  if (otaBusy() || bl.st != B_OFF) { lowSince = 0; return; }
  bool low = ESP.getMaxAllocHeap() < 24 * 1024;
  if (!low) lowSince = 0;
  else if (!lowSince) { lowSince = now; Serial.printf("[mem] low: biggest block %u\n", (unsigned)ESP.getMaxAllocHeap()); }
  bool want = bleCycles > 0 || (lowSince && now - lowSince > 600000);
  struct tm tm; bool night = !localNow(tm) || (tm.tm_hour >= 1 && tm.tm_hour < 5);
  if (want && now > 3600000 && asleep && night && !isBusy() && !restartAt) {
    Serial.println("[mem] night tidy-up restart"); diagRestart(SW_LOWMEM); restartAt = now + 500;
  }
}

// ------------------------------------------------------------ schedule (main loop, once a second)
// time since t, signed: a stamp taken a moment after "now" (Bluetooth start, a request from another task) counts as 0,
// not as 49 days (unsigned "now - later" wraps around: Bluetooth went off the instant it came on)
static inline int32_t since(uint32_t t) { int32_t d = (int32_t)(millis() - t); return d < 0 ? 0 : d; }

void updTick(uint32_t now) {
  now = millis();
  deskViaTick();
  static uint32_t bootAt = now;
  // daily check once online and the clock is right (needed to verify certificates)
  if (wifiUp && timeOk() && !otaBusy() && up.st != U_CHECKING &&
      (up.checkedAt == 0 ? now - bootAt > 120000 : now - up.checkedAt > UPD_CHECK_EVERY)) { up.checkedAt = now; up.wantCheck = true; }
  // optional: install by itself at 03:00 when nobody is using the buddy
  struct tm tm;
  if (up.autoInstall && up.st == U_READY && localNow(tm) && tm.tm_hour == 3 && !up.nightDone && !isBusy()) { up.nightDone = true; up.wantInstall = true; }
  if (localNow(tm) && tm.tm_hour == 4) up.nightDone = false;
  // Wi-Fi gone for 10 s (office, router off) or not found since boot, or never given Wi-Fi at all: Bluetooth on, so
  // lil.mate Desk switches to it within seconds and a phone can still update the buddy
  bool wifiGone = S.ssid[0] && !apMode && !wifiUp && (offlineMode || (wifiLostAt && now - wifiLostAt > 10000));
  if (bl.st == B_OFF && (wifiGone || (apMode && !S.ssid[0] && now - bootAt > 60000))) { bleStart(); bleIdleMs = 30000; }
  // lil.mate Desk was checking in over Wi-Fi and went quiet for 12 s (its laptop lost Wi-Fi, or left): Bluetooth on for
  // 3 min so it can carry on over Bluetooth. Once per silence; if the laptop just went to sleep, it goes off again.
  if (bl.st == B_OFF && wifiUp && deskSeenAt && since(deskSeenAt) > 12000) { deskSeenAt = 0; bleStart(); bleIdleMs = 180000; Serial.println("[ble] Desk went quiet on Wi-Fi: Bluetooth on for 3 min"); }
  // back on Wi-Fi and nobody is using Bluetooth: give its memory back (right away if an update wants it)
  // Wi-Fi + Bluetooth together leave little memory: an automatic Bluetooth goes after 30 s unused, an asked-for one after 5 min
  if (bl.st == B_ON && !bl.connected && wifiUp && (since(bl.lastUse) > (int32_t)bleIdleMs || up.wantCheck || up.wantInstall)) bleStop();
  memGuard(now);
  // nobody held the buddy within 40 s: refuse the Bluetooth update
  if (bl.st == B_WAIT && since(bl.waitSince) > 40000) bleFail("not allowed on the buddy");
}

// ------------------------------------------------------------ screen + touch (take priority over everything)
static void updScreen(const char *top, const char *bottom, int pct) {
  centerStr(18, u8g2_font_7x14B_tr, top);
  if (pct >= 0) { oled.drawFrame(14, 28, 100, 8); oled.drawBox(16, 30, pct * 96 / 100, 4); }
  centerStr(50, u8g2_font_5x7_tr, bottom);
}
bool updDraw(uint32_t now) {
  char b[32];
  if (up.st == U_GETTING) { snprintf(b, sizeof(b), "%d%%  from the internet", up.pct); updScreen("UPDATING", b, up.pct); centerStr(61, u8g2_font_5x7_tr, "keep me powered"); return true; }
  if (up.st == U_DONE || bl.st == B_DONE) { snprintf(b, sizeof(b), "now on %s", up.st == U_DONE ? up.ver : "the new version"); updScreen("UPDATED!", b, 100); centerStr(61, u8g2_font_5x7_tr, "restarting..."); return true; }
  if (bl.st == B_WAIT) {
    updScreen("BLUETOOTH UPDATE?", "hold me = allow", -1);
    centerStr(36, u8g2_font_5x7_tr, "a phone wants to update me");
    centerStr(61, u8g2_font_5x7_tr, "2 taps = no");
    return true;
  }
  if (bl.st == B_RECV) {
    int pct = bl.size ? (uint64_t)bl.got * 100 / bl.size : 0;
    snprintf(b, sizeof(b), "%d%%  over Bluetooth", pct); updScreen("UPDATING", b, pct); centerStr(61, u8g2_font_5x7_tr, "keep the phone close"); return true;
  }
  if (up.st == U_READY && now < up.promptUntil) {
    header("NEW UPDATE", up.ver);
    oled.setFont(u8g2_font_6x10_tr);
    drawWrapped(0, 26, 10, 2, 21, up.notes[0] ? up.notes : "A new lil.mate version is ready.");
    oled.setFont(u8g2_font_5x7_tr);
    oled.drawStr(0, 63, "hold = install  tap = later");
    return true;
  }
  return false;
}
bool updTouch(TouchEv e) {
  if (up.st == U_GETTING || up.st == U_DONE || bl.st == B_RECV || bl.st == B_DONE) return true;   // hands off while flashing
  if (bl.st == B_WAIT) {
    if (e == T_LONG) {
      if (!Update.begin(bl.size)) { bleFail(Update.errorString()); return true; }
      if (strlen(bl.md5) == 32) Update.setMD5(bl.md5);
      bl.st = B_RECV; bleSay("ready"); faceSay("Updating...");
    } else if (e == T_TAP2) bleFail("not allowed on the buddy");
    bl.lastUse = millis();
    return e != T_PRESS && e != T_RELEASE;
  }
  if (up.st == U_READY && millis() < up.promptUntil) {
    if (e == T_LONG) { up.wantInstall = true; }
    else if (e == T_TAP1 || e == T_TAP2) { up.promptUntil = 0; faceSay("Later! It's on the Info screen"); }
    return e != T_PRESS && e != T_RELEASE;
  }
  return false;
}

// ------------------------------------------------------------ commands, state, INFO line
String updStatusText() {
  String s = String("📦 lil.mate ") + FW_VERSION;
  switch (up.st) {
    case U_READY:   s += "\n✨ " + String(up.ver) + " is ready: send /update now (or hold me on the Info screen)"; if (up.notes[0]) s += String("\n") + up.notes; break;
    case U_LATEST:  s += " · up to date"; break;
    case U_CHECKING: s += " · checking..."; break;
    case U_GETTING: s += " · installing " + String(up.ver) + " (" + up.pct + "%)"; break;
    case U_FAIL:    s += String(" · last try: ") + up.err; break;
    default: break;
  }
  s += String("\nInstall at night by itself: ") + (up.autoInstall ? "on" : "off") + " (/update auto on|off)";
  s += String("\nBluetooth update: ") + (bl.st == B_OFF ? "off (/bluetooth to turn on)" : wifiUp ? "on (switches off after 5 min unused)" : "on");
  return s;
}
String updCommand(const String &argl) {
  if (argl == "" || argl == "check") {
    if (!wifiUp) return "📡 I'm not on Wi-Fi. Update me from the lil.mate app (USB), or over Bluetooth: /bluetooth";
    up.wantCheck = true; return "🔎 Checking GitHub for a new version... ask /update status in a few seconds.";
  }
  if (argl == "now" || argl == "install" || argl == "yes") {
    if (!wifiUp) return "📡 I'm not on Wi-Fi, so I can't download it myself.";
    up.wantInstall = true; return "⬇️ Downloading and installing. I'll restart in about a minute. Keep me powered!";
  }
  if (argl == "status") return updStatusText();
  if (argl.startsWith("auto")) {
    up.autoInstall = argl.endsWith("on"); prefs.putBool("autoupd", up.autoInstall);
    return up.autoInstall ? "🌙 OK, I'll install new versions by myself at 3 am." : "👍 OK, I'll ask before installing.";
  }
  return updStatusText();
}
String bleCommand() {
  if (bl.st == B_OFF) bleStart(); else bl.lastUse = millis();
  bleIdleMs = BLE_IDLE_OFF_MS;   // asked for: keep it the full 5 minutes
  return String("🔵 Bluetooth update is on") + (wifiUp ? " for the next 5 minutes" : "") + ". Open the lil.mate updater in Chrome and pick \"lil.mate " + S.owner + "\".";
}
void updJson(JsonObject o) {
  o["st"] = UPD_ST_NAMES[up.st]; o["ver"] = up.ver; o["pct"] = up.st == U_GETTING ? up.pct : (bl.st == B_RECV && bl.size ? (int)((uint64_t)bl.got * 100 / bl.size) : 0);
  o["notes"] = up.notes; o["err"] = up.err; o["auto"] = up.autoInstall; o["ble"] = bl.st != B_OFF;
}
const char *updInfoLine() {
  static char b[28];
  if (up.st == U_READY) snprintf(b, sizeof(b), "hold: install %s", up.ver);
  else return nullptr;
  return b;
}
bool updHoldInstall() { if (up.st != U_READY) return false; up.wantInstall = true; return true; }
void updBegin() { up.autoInstall = prefs.getBool("autoupd", false); }
