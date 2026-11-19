// Crash recorder: why did Lilmate restart, after how long, and where was it?
// RTC_NOINIT memory survives crashes / watchdog / software resets (not power loss),
// so after a crash we still know the previous uptime, lowest heap and code stage.
#pragma once
#include <esp_system.h>
#include <esp_attr.h>
#include "config.h"

#define DIAG_MAGIC 0xD1A6C0DE
RTC_NOINIT_ATTR uint32_t rtcMagic, rtcUp, rtcHeapMin, rtcStage, rtcNetStage, rtcSwWhy;

// main-loop stages (what the CPU was doing when it died)
enum { ST_BOOT = 1, ST_TOUCH, ST_WIFI, ST_WEB, ST_TG, ST_SERIAL, ST_BRAIN, ST_RENDER, ST_STORE, ST_IDLE };
// net-task stages
enum { NS_IDLE = 1, NS_WEATHER, NS_TG_SEND, NS_TG_POLL };
// why we restarted ourselves
enum { SW_NONE = 0, SW_OTA, SW_WIFI_SAVE, SW_CMD, SW_AP_RETRY };

static const char *stageName(uint32_t s) {
  static const char *n[] = { "?", "boot", "touch", "wifi", "web", "telegram", "serial", "brain", "render", "store", "idle" };
  return s < sizeof(n) / sizeof(n[0]) ? n[s] : "?";
}
static const char *netStageName(uint32_t s) {
  static const char *n[] = { "?", "idle", "weather", "tg-send", "tg-poll" };
  return s < sizeof(n) / sizeof(n[0]) ? n[s] : "?";
}
static const char *swName(uint32_t s) {
  static const char *n[] = { "restart", "firmware update", "wifi saved", "command", "hotspot retry" };
  return s < sizeof(n) / sizeof(n[0]) ? n[s] : "restart";
}
const char *resetName(uint8_t r) {
  switch (r) {
    case ESP_RST_POWERON:  return "power on (unplugged / power cut)";
    case ESP_RST_EXT:      return "reset pin";
    case ESP_RST_SW:       return "software restart";
    case ESP_RST_PANIC:    return "CRASH (panic)";
    case ESP_RST_INT_WDT:  return "CRASH (interrupt watchdog)";
    case ESP_RST_TASK_WDT: return "CRASH (task watchdog)";
    case ESP_RST_WDT:      return "CRASH (watchdog)";
    case ESP_RST_BROWNOUT: return "LOW VOLTAGE (brownout)";
    case ESP_RST_DEEPSLEEP:return "deep sleep wake";
    case ESP_RST_USB:      return "USB reset (flashing / port)";
    default:               return "other";
  }
}

struct ResetRec { uint8_t reason, stage, netStage, swWhy; uint32_t prevUp, heapMin, boot; };
#define NRESET 6
ResetRec resetLog[NRESET]; uint8_t nReset = 0;
uint32_t bootCount = 0;
ResetRec lastReset = {};

void diagBoot() {
  bootCount = prefs.getUInt("boots", 0) + 1;
  prefs.putUInt("boots", bootCount);
  ResetRec r = {};
  r.reason = (uint8_t)esp_reset_reason();
  r.boot = bootCount;
  if (rtcMagic == DIAG_MAGIC) { r.prevUp = rtcUp; r.heapMin = rtcHeapMin; r.stage = rtcStage; r.netStage = rtcNetStage; r.swWhy = rtcSwWhy; }
  lastReset = r;
  size_t len = prefs.getBytesLength("rlog");
  if (len && len % sizeof(ResetRec) == 0 && len / sizeof(ResetRec) <= NRESET) { prefs.getBytes("rlog", resetLog, len); nReset = len / sizeof(ResetRec); }
  if (nReset == NRESET) { memmove(resetLog, resetLog + 1, sizeof(ResetRec) * (NRESET - 1)); nReset--; }
  resetLog[nReset++] = r;
  prefs.putBytes("rlog", resetLog, nReset * sizeof(ResetRec));
  rtcMagic = DIAG_MAGIC; rtcUp = 0; rtcHeapMin = ESP.getFreeHeap(); rtcStage = ST_BOOT; rtcNetStage = NS_IDLE; rtcSwWhy = SW_NONE;
  Serial.printf("[diag] boot #%lu, reset: %s (prev uptime %lus, stage %s/%s, min heap %lu)\n",
                (unsigned long)bootCount, resetName(r.reason), (unsigned long)r.prevUp, stageName(r.stage), netStageName(r.netStage), (unsigned long)r.heapMin);
}
inline void diagStage(uint32_t s) { rtcStage = s; }
inline void diagNet(uint32_t s) { rtcNetStage = s; }
void diagTick() { rtcUp = millis() / 1000; uint32_t h = ESP.getMinFreeHeap(); rtcHeapMin = h; }
void diagRestart(uint32_t why) { rtcSwWhy = why; }

String resetLine(const ResetRec &r) {
  String s = "#" + String(r.boot) + " " + (r.reason == ESP_RST_SW ? String(swName(r.swWhy)) : String(resetName(r.reason)));
  if (r.prevUp) s += ", after " + String(r.prevUp / 60) + "m" + String(r.prevUp % 60) + "s";
  if (r.reason == ESP_RST_PANIC || r.reason == ESP_RST_INT_WDT || r.reason == ESP_RST_TASK_WDT || r.reason == ESP_RST_WDT)
    s += String(", in ") + stageName(r.stage) + " / net " + netStageName(r.netStage) + ", min heap " + String(r.heapMin / 1024) + "k";
  return s;
}
String resetReport() {
  String s = "🩺 Restarts (newest last), boot #" + String(bootCount) + ", min heap now " + String(ESP.getMinFreeHeap() / 1024) + "k\n";
  for (int i = 0; i < nReset; i++) s += resetLine(resetLog[i]) + "\n";
  return s;
}
