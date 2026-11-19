// AI coding-agent watcher: Claude Code / Copilot / Cursor / Codex sessions -> face, alerts, approve from desk
// Events arrive as JSON via HTTP POST /api/agent or USB serial "@ev {...}" (sent by pc_agent/lilmate_agent.py)
//   {"sid":"ab12","name":"lilmate_os","tool":"claude","ev":"start|tool|stop|needs|perm|permdone|error|end",
//    "msg":"...", "kind":"question|permission|idle", "rid":123, "ttl":30}
#pragma once
#include "config.h"

#define MAX_SESS 6
enum AgState : uint8_t { AG_IDLE, AG_WORKING, AG_DONE, AG_NEEDS, AG_PERM, AG_ERROR };
static const char *AG_NAMES[] = { "idle", "working", "done", "needs you", "approve?", "error" };

struct AgSess {
  bool used; char sid[16]; char name[20]; char tool[10];
  AgState st; uint32_t since, lastEv; char msg[100];
  uint32_t rid; uint16_t ttl; bool acked, escalated;
};
AgSess ag[MAX_SESS];
struct AgDec { uint32_t rid; char d; };
AgDec agDec[8]; uint8_t agDecN = 0;
uint32_t agNextBreakTip = 0, agAttnSince = 0;
String agAttnKey;
bool agSerial = false;   // events came over USB -> also report decisions on USB

int agFind(const char *sid, bool create) {
  for (int i = 0; i < MAX_SESS; i++) if (ag[i].used && !strcmp(ag[i].sid, sid)) return i;
  if (!create) return -1;
  int pick = -1;
  for (int i = 0; i < MAX_SESS && pick < 0; i++) if (!ag[i].used) pick = i;
  if (pick < 0) {   // evict the stalest quiet session
    for (int i = 0; i < MAX_SESS; i++) {
      bool quiet = ag[i].st == AG_IDLE || (ag[i].st == AG_DONE && ag[i].acked);
      if (quiet && (pick < 0 || ag[i].lastEv < ag[pick].lastEv)) pick = i;
    }
    if (pick < 0) { pick = 0; for (int i = 1; i < MAX_SESS; i++) if (ag[i].lastEv < ag[pick].lastEv) pick = i; }
  }
  memset(&ag[pick], 0, sizeof(AgSess));
  ag[pick].used = true; copyStr(ag[pick].sid, sid, sizeof(ag[pick].sid));
  copyStr(ag[pick].name, "agent", sizeof(ag[pick].name)); copyStr(ag[pick].tool, "ai", sizeof(ag[pick].tool));
  return pick;
}

static int agPrio(AgState s) { return s == AG_PERM ? 4 : s == AG_NEEDS ? 3 : s == AG_ERROR ? 2 : s == AG_DONE ? 1 : 0; }
AgSess *agAttention() {   // most urgent un-acknowledged session (oldest first within a priority)
  AgSess *best = nullptr;
  for (auto &s : ag) {
    if (!s.used || s.acked || !agPrio(s.st)) continue;
    if (!best || agPrio(s.st) > agPrio(best->st) || (agPrio(s.st) == agPrio(best->st) && s.since < best->since)) best = &s;
  }
  return best;
}
int agCount(AgState st) { int n = 0; for (auto &s : ag) if (s.used && s.st == st) n++; return n; }
AgSess *agWorking() { AgSess *b = nullptr; for (auto &s : ag) if (s.used && s.st == AG_WORKING && (!b || s.since < b->since)) b = &s; return b; }

void agRecord(uint32_t rid, char d) {
  agDec[agDecN % 8] = { rid, d }; agDecN++;
  if (agSerial) Serial.printf("@dec {\"rid\":%lu,\"d\":\"%s\"}\n", (unsigned long)rid, d == 'a' ? "allow" : "deny");
}
char agDecision(uint32_t rid) { for (auto &d : agDec) if (d.rid == rid && d.d) return d.d; return 0; }

bool agDecideRid(uint32_t rid, bool allow, const char *via) {
  for (auto &s : ag) if (s.used && s.st == AG_PERM && s.rid == rid) {
    agRecord(rid, allow ? 'a' : 'd');
    s.st = AG_WORKING; s.since = millis(); s.acked = true; s.msg[0] = 0;
    setInvert(false); faceClearBubble();
    faceSetMood(allow ? M_HAPPY : M_ANGRY, 1500);
    faceSay(allow ? "Allowed! back to work" : "Denied!");
    Serial.printf("[agent] rid %lu %s via %s\n", (unsigned long)rid, allow ? "ALLOW" : "DENY", via);
    return true;
  }
  return false;
}

void agAck(AgSess &s) { s.acked = true; setInvert(false); faceClearBubble(); agAttnKey = ""; }
void agAckAll() { for (auto &s : ag) if (s.used && s.st != AG_PERM) s.acked = true; setInvert(false); faceClearBubble(); agAttnKey = ""; }

void agentEvent(JsonObjectConst e, bool viaSerial) {
  agSerial = viaSerial;
  const char *sid = e["sid"] | "default";
  String ev = e["ev"] | "";
  int i = agFind(sid, ev != "end");
  if (i < 0) return;
  AgSess &s = ag[i];
  if (e["name"].is<const char *>()) copyStr(s.name, e["name"], sizeof(s.name));
  if (e["tool"].is<const char *>()) copyStr(s.tool, e["tool"], sizeof(s.tool));
  uint32_t now = millis();
  s.lastEv = now;
  const char *msg = e["msg"] | "";
  bool attention = false;

  if (ev == "start") { s.st = AG_WORKING; s.since = now; s.msg[0] = 0; s.acked = s.escalated = false; }
  else if (ev == "tool") {
    if (s.st != AG_WORKING) { s.st = AG_WORKING; s.since = now; s.msg[0] = 0; }
  } else if (ev == "stop") {
    s.st = AG_DONE; s.since = now; s.acked = s.escalated = false; copyStr(s.msg, msg, sizeof(s.msg)); attention = true;
  } else if (ev == "needs") {
    String kind = e["kind"] | "question";
    if (s.st == AG_PERM) return;                       // the approve prompt already covers it
    if (kind == "idle" && s.st == AG_DONE) return;     // "still waiting" after done: escalation timer handles it
    s.st = AG_NEEDS; s.since = now; s.acked = s.escalated = false; copyStr(s.msg, msg, sizeof(s.msg)); attention = true;
  } else if (ev == "perm") {
    s.st = AG_PERM; s.since = now; s.acked = s.escalated = false;
    s.rid = e["rid"] | 0; s.ttl = e["ttl"] | 30; copyStr(s.msg, msg, sizeof(s.msg)); attention = true;
  } else if (ev == "permdone") {                      // hook gave up / answered in terminal
    if (s.st == AG_PERM && s.rid == (uint32_t)(e["rid"] | 0)) {
      if (e["answered"] | false) { s.st = AG_WORKING; s.since = now; s.acked = true; }
      else { s.st = AG_NEEDS; s.since = now; copyStr(s.msg, "answer in the terminal", sizeof(s.msg)); }
    }
  } else if (ev == "error") {
    s.st = AG_ERROR; s.since = now; s.acked = s.escalated = false; copyStr(s.msg, msg, sizeof(s.msg)); attention = true;
  } else if (ev == "end") { s.used = false; return; }

  if (attention) {
    wakeUp(false);
    if (screen != S_AGENTS) screen = S_FACE;
    agAttnKey = "";   // force the bubble to refresh
  }
}

String agWait(uint32_t ms) { uint32_t s = ms / 1000; return s < 60 ? String(s) + "s" : String(s / 60) + "m" + (s % 60 < 10 ? "0" : "") + String(s % 60); }

// ------------------------------------------------------------ per-second brain
void agentTick(uint32_t now) {
  now = millis();
  for (auto &s : ag) {
    if (!s.used) continue;
    uint32_t wait = now - s.since;
    if ((s.st == AG_NEEDS || s.st == AG_PERM) && !s.acked && !s.escalated && wait > 120000) {
      s.escalated = true;
      String t = String("🍽 ") + s.name + " (" + s.tool + ") has been waiting for you " + agWait(wait) + (s.msg[0] ? String(": ") + s.msg : String(""));
      if (s.st == AG_PERM) t += "\nReply /allow " + String(s.rid) + " or /deny " + String(s.rid);
      tgNotify(t);
    }
    if (s.st == AG_DONE && !s.acked && !s.escalated && wait > 300000) { s.escalated = true; tgNotify(String("✅ ") + s.name + " finished " + agWait(wait) + " ago."); }
    if (s.st == AG_PERM && wait > (uint32_t)s.ttl * 1000 + 5000) { s.st = AG_NEEDS; copyStr(s.msg, "answer in the terminal", sizeof(s.msg)); }
    if (s.st == AG_WORKING && now - s.lastEv > 1800000) s.st = AG_IDLE;                 // stale
    if (s.st == AG_DONE && s.acked && wait > 900000) s.st = AG_IDLE;
    if (s.st == AG_IDLE && now - s.lastEv > 7200000) s.used = false;
  }

  AgSess *a = agAttention();
  if (a && !al.active) {
    uint32_t wait = now - a->since;
    Mood m = a->st == AG_PERM ? M_ALERT : a->st == AG_ERROR ? M_DIZZY : a->st == AG_DONE ? M_HAPPY : (wait < 60000 ? M_ALERT : M_SAD);
    faceSetMood(m, 2500);
    String key = String(a->sid) + a->st + (wait > 180000 ? "h" : "");
    if (key != agAttnKey && a->st != AG_PERM) {
      agAttnKey = key;
      String t = a->st == AG_DONE ? String(a->name) + " is done! tap = ok"
               : a->st == AG_ERROR ? String(a->name) + " hit an error"
               : wait > 180000 ? String("Starving! ") + a->name + " waits " + agWait(wait)
               : String("Feed me! ") + a->name + " needs you" + (a->msg[0] ? String(": ") + a->msg : String(""));
      faceSay(t, 0, true);
      agAttnSince = now;
    }
    bool flashy = a->st == AG_PERM || a->st == AG_NEEDS;
    setInvert(flashy && now - a->since < 6000 ? !inverted : false);
  } else if (!a && agAttnKey.length()) { agAttnKey = ""; faceClearBubble(); setInvert(false); }

  // working: thinking face + timer on top; suggest a micro-break while the agent cooks
  AgSess *w = agWorking();
  if (!a && w && !fx.running && !asleep) {
    char nm[12]; copyStr(nm, w->name, sizeof(nm));
    topLine = String(nm) + " " + agWait(now - w->since) + (agCount(AG_WORKING) > 1 ? " +" + String(agCount(AG_WORKING) - 1) : String(""));
    faceSetRest(M_THINK);
    if (now - w->since > 45000 && now > agNextBreakTip && screen == S_FACE && !al.active && !faceBubbleOn(now)) {
      static const char *tips[] = { "Agent's cooking. Stretch?", "Sip some water :)", "Look far away 20s", "Roll your shoulders", "Stand up for a bit" };
      faceSay(tips[random(0, 5)]);
      agNextBreakTip = now + 1200000;
    }
  } else if (!w && restMood == M_THINK && !fx.running) faceSetRest(M_NEUTRAL);
}

// ------------------------------------------------------------ touch + screens
bool agentTouch(TouchEv e) {
  AgSess *a = agAttention();
  if (a && a->st == AG_PERM) {   // approve prompt: a pat must never approve
    if (e == T_LONG) agDecideRid(a->rid, true, "touch");
    else if (e == T_TAP2) agDecideRid(a->rid, false, "touch");
    else if (e == T_TAP1) faceSay("hold = allow, 2 taps = deny");
    return e != T_PRESS && e != T_RELEASE;
  }
  if (a && e == T_TAP1 && screen == S_FACE && !workOverlay()) { agAck(*a); faceSetMood(M_HAPPY, 1200); faceSay("On it!"); return true; }
  if (screen == S_AGENTS) {
    if (e == T_TAP1) { agAckAll(); return true; }
    if (e == T_LONG) { for (auto &s : ag) if (s.used && s.st != AG_WORKING && s.st != AG_PERM) s.used = false; return true; }
  }
  return false;
}

void drawWrapped(int x, int y, int lineH, int maxLines, int cols, const char *txt) {
  String t = asciiOnly(txt); int line = 0, pos = 0;
  while (pos < (int)t.length() && line < maxLines) {
    int n = min(cols, (int)t.length() - pos);
    if (pos + n < (int)t.length()) { int sp = t.lastIndexOf(' ', pos + n); if (sp > pos + cols / 2) n = sp - pos + 1; }
    String part = t.substring(pos, pos + n); part.trim();
    if (line == maxLines - 1 && pos + n < (int)t.length()) { part = part.substring(0, max(0, cols - 3)) + "..."; }
    oled.drawStr(x, y + line * lineH, part.c_str());
    pos += n; line++;
  }
}

bool agentDraw(uint32_t now) {   // full-screen approve prompt
  now = millis();
  AgSess *a = agAttention();
  if (!a || a->st != AG_PERM || al.active) return false;
  char h[24]; snprintf(h, sizeof(h), "%s", a->tool);
  header("APPROVE?", h);
  oled.setFont(u8g2_font_5x7_tr);
  char nm[26]; copyStr(nm, a->name, sizeof(nm)); oled.drawStr(0, 20, nm);
  oled.setFont(u8g2_font_6x10_tr);
  drawWrapped(0, 31, 10, 2, 21, a->msg);
  uint32_t left = (uint32_t)a->ttl * 1000 > now - a->since ? a->ttl * 1000 - (now - a->since) : 0;
  bar(0, 47, 128, 8, a->ttl ? (float)left / (a->ttl * 1000) : 0);
  oled.setFont(u8g2_font_5x7_tr);
  oled.drawStr(0, 63, (now / 600) % 2 ? "HOLD = YES" : "hold = yes");
  oled.drawStr(73, 63, "2 TAPS = NO");
  return true;
}

void drawAgents(uint32_t now) {
  char r[20]; snprintf(r, sizeof(r), "%d busy", agCount(AG_WORKING));
  header("AI AGENTS", r);
  int row = 0;
  oled.setFont(u8g2_font_5x7_tr);
  for (auto &s : ag) {
    if (!s.used || row >= 4) continue;
    int y = 22 + row * 11;
    static const char *SPIN[] = { "|", "/", "-", "\\" };
    const char *ic = s.st == AG_WORKING ? SPIN[(now / 150) % 4]
                   : s.st == AG_DONE ? "v" : s.st == AG_NEEDS ? "!" : s.st == AG_PERM ? "?" : s.st == AG_ERROR ? "x" : "-";
    if ((s.st == AG_NEEDS || s.st == AG_PERM) && !s.acked && (now / 400) % 2) oled.drawBox(0, y - 7, 7, 9), oled.setDrawColor(0);
    oled.drawStr(1, y, ic); oled.setDrawColor(1);
    static const char *SHORT[] = { "idle", "busy", "done", "needs", "ask?", "error" };
    char nm[11]; copyStr(nm, s.name, sizeof(nm)); oled.drawStr(10, y, nm);
    char st[20]; snprintf(st, sizeof(st), "%s %s", SHORT[s.st], agWait(now - s.since).c_str());
    oled.drawStr(128 - oled.getStrWidth(st), y, st);
    row++;
  }
  if (!row) {
    centerStr(32, u8g2_font_6x10_tr, "No agents yet");
    centerStr(46, u8g2_font_5x7_tr, "run: lilmate_agent.py");
    centerStr(55, u8g2_font_5x7_tr, "install-claude");
  }
  if (row) centerStr(64, u8g2_font_5x7_tr, "tap: seen  hold: clear");
}

String agentList() {
  String s; uint32_t now = millis();
  for (auto &a : ag) if (a.used) s += String("• ") + a.name + " (" + a.tool + "): " + AG_NAMES[a.st] + " " + agWait(now - a.since) + (a.st == AG_PERM ? "  rid " + String(a.rid) : String("")) + (a.msg[0] ? String(" — ") + a.msg : String("")) + "\n";
  return s.length() ? "🤖 Agents\n" + s : String("🤖 No agent sessions. Install the hooks: python3 lilmate_agent.py install-claude");
}

void agentJson(JsonArray arr) {
  uint32_t now = millis();
  for (auto &s : ag) if (s.used) {
    JsonObject o = arr.add<JsonObject>();
    o["sid"] = s.sid; o["name"] = s.name; o["tool"] = s.tool; o["st"] = AG_NAMES[s.st]; o["wait"] = (now - s.since) / 1000;
    o["msg"] = s.msg; o["acked"] = s.acked;
    if (s.st == AG_PERM) { o["rid"] = s.rid; o["ttl"] = s.ttl; }
  }
}
