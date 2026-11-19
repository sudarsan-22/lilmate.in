// Networking: Wi-Fi + setup hotspot, NTP, mDNS, weather (Open-Meteo), Telegram bot task
#pragma once
#include <WiFi.h>
#include <WiFiClientSecure.h>
#include <HTTPClient.h>
#include <ESPmDNS.h>
#include <DNSServer.h>
#include <ArduinoJson.h>
#include "config.h"

bool     apMode = false;
bool     offlineMode = false;      // saved Wi-Fi not around (office): stay a normal buddy, retry quietly
uint32_t wifiRetryAt = 0, wifiTryAt = 0, wifiLostAt = 0;
bool linkBusy();
bool     wifiUp = false, wifiEver = false;
uint32_t wifiStartAt = 0, apStartAt = 0;
String   apName;
DNSServer dns;

struct Weather {
  bool ok; float temp, tmax, tmin, wind; int code, hum; int32_t utcOffset; uint32_t at; char place[32];
} wx = {};
volatile bool wxRequest = true;
volatile bool netSettingsChanged = false;   // net task changed S (lat/lon) -> main saves
volatile bool tgOffsetChanged = false;
volatile int  tgLastCode = 0;               // last Telegram HTTP status (for /info)
char autoTz[24] = "";

struct InMsg  { char text[200]; char chat[24]; char from[24]; };
struct OutMsg { char text[480]; char chat[24]; uint8_t kb; };
QueueHandle_t inQ, outQ;

const char *wxText(int c) {
  if (c == 0) return "Clear";
  if (c == 1) return "Mostly clear";
  if (c == 2) return "Partly cloudy";
  if (c == 3) return "Cloudy";
  if (c == 45 || c == 48) return "Fog";
  if (c >= 51 && c <= 57) return "Drizzle";
  if (c >= 61 && c <= 67) return "Rain";
  if (c >= 71 && c <= 77) return "Snow";
  if (c >= 80 && c <= 82) return "Showers";
  if (c == 85 || c == 86) return "Snow showers";
  if (c >= 95) return "Storm";
  return "?";
}
bool wxRainy() { return wx.ok && ((wx.code >= 51 && wx.code <= 67) || (wx.code >= 80 && wx.code <= 82) || wx.code >= 95); }

const char *currentTz() { return S.tz[0] ? S.tz : (autoTz[0] ? autoTz : "UTC0"); }
void applyTz() { setenv("TZ", currentTz(), 1); tzset(); }

void tgNotify(const String &text, bool kb = false) {
  if (!S.tgToken[0] || !S.tgChat[0] || !outQ) return;
  OutMsg m; copyStr(m.text, text.c_str(), sizeof(m.text)); copyStr(m.chat, S.tgChat, sizeof(m.chat)); m.kb = kb;
  xQueueSend(outQ, &m, 0);
}
void tgReply(const char *chat, const String &text, bool kb = false) {
  if (!S.tgToken[0] || !outQ) return;
  OutMsg m; copyStr(m.text, text.c_str(), sizeof(m.text)); copyStr(m.chat, chat, sizeof(m.chat)); m.kb = kb;
  xQueueSend(outQ, &m, 0);
}

// ------------------------------------------------------------ Wi-Fi
void startAP() {
  apMode = true; apStartAt = millis();
  uint8_t mac[6]; WiFi.macAddress(mac);
  char nm[20]; snprintf(nm, sizeof(nm), "Lilmate-%02X%02X", mac[4], mac[5]);
  apName = nm;
  WiFi.disconnect(true);
  WiFi.mode(WIFI_AP_STA);   // STA side only used for the network scan on the setup page
  WiFi.softAP(apName.c_str());
  delay(100);
  dns.start(53, "*", WiFi.softAPIP());
  Serial.printf("[wifi] setup hotspot %s at %s\n", apName.c_str(), WiFi.softAPIP().toString().c_str());
}

void wifiBegin() {
  WiFi.setHostname(HOSTNAME);
  if (!S.ssid[0]) { startAP(); return; }
  WiFi.mode(WIFI_STA);
  WiFi.setSleep(false);   // no modem power-save: it stalls the web server and ESP-NOW on weak signals (USB powered anyway)
  WiFi.setAutoReconnect(true);
  WiFi.begin(S.ssid, S.pass);
  wifiStartAt = millis();
  Serial.printf("[wifi] connecting to %s\n", S.ssid);
}

void onWifiUp() {
  Serial.printf("[wifi] up, IP %s\n", WiFi.localIP().toString().c_str());
  if (!wifiEver) { MDNS.begin(HOSTNAME); MDNS.addService("http", "tcp", 80); }
  wifiEver = true;
  configTzTime(currentTz(), "pool.ntp.org", "time.google.com", "time.cloudflare.com");
  wxRequest = true;
}

void wifiLoop() {
  if (apMode) {
    dns.processNextRequest();
    // saved network but stuck in hotspot (router was off): retry every 5 min if nobody is connected
    if (S.ssid[0] && millis() - apStartAt > 300000 && WiFi.softAPgetStationNum() == 0) { diagRestart(SW_AP_RETRY); ESP.restart(); }
    return;
  }
  uint32_t now = millis();
  bool up = WiFi.status() == WL_CONNECTED;
  if (up && !wifiUp) { onWifiUp(); if (offlineMode) { offlineMode = false; WiFi.setAutoReconnect(true); } wifiTryAt = 0; }
  if (!up && wifiUp) { Serial.println("[wifi] lost, reconnecting"); wifiLostAt = now; }
  wifiUp = up;
  if (up || apMode) return;
  if (!S.ssid[0]) { if (now - wifiStartAt > 3000) startAP(); return; }      // never configured: setup hotspot
  bool gaveUp = (!wifiEver && now - wifiStartAt > 25000) || (wifiEver && wifiLostAt && now - wifiLostAt > 60000);
  if (!offlineMode && gaveUp) {
    // the saved network is not here (e.g. office): keep working offline instead of the setup screen.
    // Setup hotspot stays available on demand: INFO screen, hold 4 s.
    offlineMode = true; WiFi.setAutoReconnect(false); WiFi.disconnect(false);
    wifiRetryAt = now + 300000; wifiTryAt = 0;
    Serial.println("[wifi] network not found -> offline mode (retry every 5 min)");
  }
  if (offlineMode) {
    if (!wifiTryAt && now > wifiRetryAt && !linkBusy()) { WiFi.begin(S.ssid, S.pass); wifiTryAt = now; }
    if (wifiTryAt && now - wifiTryAt > 15000) { WiFi.disconnect(false); wifiTryAt = 0; wifiRetryAt = now + 300000; }
  }
}

// ------------------------------------------------------------ HTTP helpers (net task)
bool httpGetString(const String &url, String &out) {
  WiFiClient c; HTTPClient h;
  h.setConnectTimeout(6000); h.setTimeout(8000);
  if (!h.begin(c, url)) return false;
  int code = h.GET();
  if (code == 200) out = h.getString();
  h.end();
  return code == 200;
}

String urlEncode(const char *s) {
  String o; char b[4];
  for (; *s; s++) {
    if (isalnum((uint8_t)*s) || *s == '-' || *s == '.' || *s == '_') o += *s;
    else { snprintf(b, sizeof(b), "%%%02X", (uint8_t)*s); o += b; }
  }
  return o;
}

void fetchWeather() {
  String body;
  if (S.lat == 0 && S.lon == 0) {
    JsonDocument d;
    if (S.city[0]) {
      if (!httpGetString(String("http://geocoding-api.open-meteo.com/v1/search?count=1&name=") + urlEncode(S.city), body)) return;
      if (deserializeJson(d, body) || !d["results"][0]) { Serial.println("[wx] city not found"); return; }
      S.lat = d["results"][0]["latitude"]; S.lon = d["results"][0]["longitude"];
      copyStr(wx.place, d["results"][0]["name"] | S.city, sizeof(wx.place));
    } else {  // no city set: approximate location from IP
      if (!httpGetString("http://ip-api.com/json/?fields=status,city,lat,lon", body)) return;
      if (deserializeJson(d, body) || strcmp(d["status"] | "", "success")) return;
      S.lat = d["lat"]; S.lon = d["lon"];
      copyStr(S.city, d["city"] | "", sizeof(S.city));
      copyStr(wx.place, S.city, sizeof(wx.place));
    }
    netSettingsChanged = true;
  }
  char url[300];
  snprintf(url, sizeof(url),
           "http://api.open-meteo.com/v1/forecast?latitude=%.4f&longitude=%.4f"
           "&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m"
           "&daily=temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=1",
           S.lat, S.lon);
  if (!httpGetString(url, body)) { Serial.println("[wx] fetch failed"); return; }
  JsonDocument d;
  if (deserializeJson(d, body)) return;
  wx.temp = d["current"]["temperature_2m"];
  wx.hum  = d["current"]["relative_humidity_2m"];
  wx.code = d["current"]["weather_code"];
  wx.wind = d["current"]["wind_speed_10m"];
  wx.tmax = d["daily"]["temperature_2m_max"][0];
  wx.tmin = d["daily"]["temperature_2m_min"][0];
  wx.utcOffset = d["utc_offset_seconds"] | 0;
  if (!wx.place[0]) copyStr(wx.place, S.city, sizeof(wx.place));
  wx.at = millis(); wx.ok = true;
  // auto timezone from the forecast's UTC offset (POSIX sign is inverted)
  int a = abs(wx.utcOffset), hh = a / 3600, mm = (a % 3600) / 60;
  snprintf(autoTz, sizeof(autoTz), "<%c%02d%02d>%c%d:%02d", wx.utcOffset >= 0 ? '+' : '-', hh, mm, wx.utcOffset >= 0 ? '-' : '+', hh, mm);
  if (!S.tz[0]) applyTz();
  Serial.printf("[wx] %s %.1fC %s\n", wx.place, wx.temp, wxText(wx.code));
}

// ------------------------------------------------------------ Telegram (net task)
WiFiClientSecure tls;

void tgSend(const OutMsg &m) {
  JsonDocument d;
  d["chat_id"] = m.chat;
  d["text"] = m.text;
  if (m.kb) {
    JsonObject rm = d["reply_markup"].to<JsonObject>();
    JsonArray kb = rm["keyboard"].to<JsonArray>();
    const char *rows[3][3] = { { "/status", "/tasks", "/habits" }, { "/focus", "/stop", "/weather" }, { "/reminders", "/pat", "/help" } };
    for (auto &row : rows) { JsonArray r = kb.add<JsonArray>(); for (auto b : row) r.add(b); }
    rm["resize_keyboard"] = true; rm["is_persistent"] = true;
  }
  String body; serializeJson(d, body);
  HTTPClient h; h.setConnectTimeout(8000); h.setTimeout(10000);
  if (!h.begin(tls, String("https://api.telegram.org/bot") + S.tgToken + "/sendMessage")) return;
  h.addHeader("Content-Type", "application/json");
  tgLastCode = h.POST(body);
  h.end();
}

void tgPoll(int timeoutS) {
  HTTPClient h; h.setConnectTimeout(8000); h.setTimeout((timeoutS + 8) * 1000);
  String url = String("https://api.telegram.org/bot") + S.tgToken + "/getUpdates?limit=4&timeout=" + timeoutS + "&offset=" + tgOffset;
  if (!h.begin(tls, url)) { vTaskDelay(pdMS_TO_TICKS(3000)); return; }
  int code = h.GET();
  tgLastCode = code;
  if (code != 200) { h.end(); vTaskDelay(pdMS_TO_TICKS(code == 401 || code == 404 ? 60000 : 4000)); return; }
  String body = h.getString();
  h.end();

  JsonDocument filter;
  filter["result"][0]["update_id"] = true;
  filter["result"][0]["message"]["text"] = true;
  filter["result"][0]["message"]["chat"]["id"] = true;
  filter["result"][0]["message"]["from"]["first_name"] = true;
  JsonDocument d;
  if (deserializeJson(d, body, DeserializationOption::Filter(filter))) return;
  for (JsonObject u : d["result"].as<JsonArray>()) {
    int32_t id = u["update_id"] | 0;
    if (id >= tgOffset) { tgOffset = id + 1; tgOffsetChanged = true; }
    const char *text = u["message"]["text"];
    if (!text) continue;
    InMsg m;
    copyStr(m.text, text, sizeof(m.text));
    String chat = String(u["message"]["chat"]["id"].as<long long>());
    copyStr(m.chat, chat.c_str(), sizeof(m.chat));
    copyStr(m.from, u["message"]["from"]["first_name"] | "", sizeof(m.from));
    xQueueSend(inQ, &m, pdMS_TO_TICKS(100));
  }
}

void netTask(void *) {
  tls.setInsecure();   // no CA bundle on the C3 build; token still travels over TLS
  uint32_t lastWx = 0;
  for (;;) {
    if (apMode || WiFi.status() != WL_CONNECTED) { vTaskDelay(pdMS_TO_TICKS(1000)); continue; }
    uint32_t now = millis();
    if (wxRequest || now - lastWx > WEATHER_EVERY_MS || (!wx.ok && now - lastWx > 60000)) {
      wxRequest = false; lastWx = now; diagNet(NS_WEATHER); fetchWeather();
    }
    OutMsg m;
    if (S.tgToken[0]) {
      diagNet(NS_TG_SEND);
      while (xQueueReceive(outQ, &m, 0) == pdTRUE) tgSend(m);
      diagNet(NS_TG_POLL);
      tgPoll(uxQueueMessagesWaiting(outQ) ? 0 : 5);
    } else {
      while (xQueueReceive(outQ, &m, 0) == pdTRUE) {}
      vTaskDelay(pdMS_TO_TICKS(500));
    }
    diagNet(NS_IDLE);
    vTaskDelay(pdMS_TO_TICKS(30));
  }
}

void netBegin() {
  inQ = xQueueCreate(4, sizeof(InMsg));
  outQ = xQueueCreate(5, sizeof(OutMsg));
  applyTz();
  wifiBegin();
  xTaskCreate(netTask, "net", 12288, nullptr, 1, nullptr);
}
