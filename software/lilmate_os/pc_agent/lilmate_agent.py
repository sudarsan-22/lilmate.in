#!/usr/bin/env python3
"""
lil.mate PC agent - connects your computer (and your AI coding agents) to your lil.mate desk buddy.

  python3 lilmate_agent.py install-claude      # one time: Claude Code reports to lil.mate (done / needs you / approve)
  python3 lilmate_agent.py run                 # bridge: USB (office, no Wi-Fi) or Wi-Fi, PC stats, clock sync, focus guard
  python3 lilmate_agent.py test-agent          # fake Claude session to see the buddy react
  python3 lilmate_agent.py say "Lunch time!"   # message on the OLED
  python3 lilmate_agent.py cmd "/task review PR"
  python3 lilmate_agent.py done -- make build  # tell me when a long command finishes
  python3 lilmate_agent.py uninstall-claude

Connection: USB cable is used automatically when lil.mate is plugged in and `run` is active
(needs `pip install pyserial`). Otherwise Wi-Fi: --host / LILMATE_HOST / ~/.lilmate.json {"host": "192.168.0.18"}.
Hooks never break Claude Code: if lil.mate can't be reached they exit silently in well under a second.
"""
import argparse, json, os, platform, random, re, shutil, socket, subprocess, sys, threading, time
import urllib.parse, urllib.request
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

BRIDGE_PORT = 47823
BRIDGE = f"http://127.0.0.1:{BRIDGE_PORT}"
CONF_PATH = os.path.expanduser("~/.lilmate.json")
LOG_PATH = os.path.expanduser("~/.lilmate/agent.log")
DEFAULT_BLOCK = "youtube,instagram,netflix,twitch,reddit,facebook,twitter,x.com,tiktok,prime video,hotstar"
HOOK_MARK = "lilmate_agent.py"

try:
    import psutil  # optional
except ImportError:
    psutil = None


def conf():
    try:
        with open(CONF_PATH) as f:
            return json.load(f)
    except (OSError, ValueError):
        return {}


def device_host(args_host=None):
    return args_host or os.environ.get("LILMATE_HOST") or conf().get("host") or "lilmate.local"


def log(msg):
    try:
        os.makedirs(os.path.dirname(LOG_PATH), exist_ok=True)
        with open(LOG_PATH, "a") as f:
            f.write(time.strftime("%Y-%m-%d %H:%M:%S ") + msg + "\n")
    except OSError:
        pass


# ----------------------------------------------------------------- http helpers
def http(method, url, body=None, ctype="text/plain", timeout=4):
    data = body.encode() if isinstance(body, str) else body
    req = urllib.request.Request(url, data=data, method=method, headers={"Content-Type": ctype} if data is not None else {})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return r.read().decode("utf-8", "replace")


def cmd(host, text):
    return http("POST", f"http://{host}/api/cmd", text)


# ----------------------------------------------------------------- system stats
_prev_cpu = None


def cpu_percent():
    global _prev_cpu
    if psutil:
        return psutil.cpu_percent(interval=None)
    try:
        with open("/proc/stat") as f:
            vals = list(map(int, f.readline().split()[1:]))
        idle, total = vals[3] + vals[4], sum(vals)
        if _prev_cpu is None:
            _prev_cpu = (idle, total)
            return 0.0
        di, dt = idle - _prev_cpu[0], total - _prev_cpu[1]
        _prev_cpu = (idle, total)
        return 100.0 * (1 - di / dt) if dt else 0.0
    except OSError:
        return 0.0


def ram_percent():
    if psutil:
        return psutil.virtual_memory().percent
    try:
        info = {}
        with open("/proc/meminfo") as f:
            for line in f:
                k, v = line.split(":")
                info[k] = int(v.split()[0])
        return 100.0 * (1 - info["MemAvailable"] / info["MemTotal"])
    except (OSError, KeyError, ValueError):
        return 0.0


def battery():
    if psutil and hasattr(psutil, "sensors_battery"):
        b = psutil.sensors_battery()
        if b:
            return int(b.percent), bool(b.power_plugged)
    base = "/sys/class/power_supply"
    try:
        for d in os.listdir(base):
            if d.startswith("BAT"):
                cap = int(open(f"{base}/{d}/capacity").read().strip())
                st = open(f"{base}/{d}/status").read().strip()
                return cap, st in ("Charging", "Full")
    except OSError:
        pass
    return -1, False


def active_window_title():
    sysname = platform.system()
    try:
        if sysname == "Windows":
            import ctypes
            u32 = ctypes.windll.user32
            hwnd = u32.GetForegroundWindow()
            n = u32.GetWindowTextLengthW(hwnd)
            buf = ctypes.create_unicode_buffer(n + 1)
            u32.GetWindowTextW(hwnd, buf, n + 1)
            return buf.value
        if sysname == "Darwin":
            script = ('tell application "System Events" to tell (first process whose frontmost is true) '
                      'to get value of attribute "AXTitle" of front window')
            return subprocess.run(["osascript", "-e", script], capture_output=True, text=True, timeout=2).stdout.strip()
        if shutil.which("xdotool"):
            return subprocess.run(["xdotool", "getactivewindow", "getwindowname"], capture_output=True, text=True, timeout=2).stdout.strip()
    except Exception:
        pass
    return ""


# ----------------------------------------------------------------- keyboard / mouse activity ("in the zone")
_xss = None


def idle_seconds():
    """seconds since the last keyboard/mouse input, or None if unknown"""
    global _xss
    sysname = platform.system()
    try:
        if sysname == "Windows":
            import ctypes
            class LII(ctypes.Structure):
                _fields_ = [("cbSize", ctypes.c_uint), ("dwTime", ctypes.c_uint)]
            li = LII(); li.cbSize = ctypes.sizeof(LII)
            ctypes.windll.user32.GetLastInputInfo(ctypes.byref(li))
            return (ctypes.windll.kernel32.GetTickCount() - li.dwTime) / 1000.0
        if sysname == "Darwin":
            out = subprocess.run(["ioreg", "-c", "IOHIDSystem"], capture_output=True, text=True, timeout=2).stdout
            m = re.search(r'"HIDIdleTime" = (\d+)', out)
            return int(m.group(1)) / 1e9 if m else None
        if os.environ.get("DISPLAY"):   # Linux / X11 via the XScreenSaver extension (no extra install)
            import ctypes
            if _xss is None:
                class XSSInfo(ctypes.Structure):
                    _fields_ = [("window", ctypes.c_ulong), ("state", ctypes.c_int), ("kind", ctypes.c_int),
                                ("til_or_since", ctypes.c_ulong), ("idle", ctypes.c_ulong), ("eventMask", ctypes.c_ulong)]
                x11 = ctypes.cdll.LoadLibrary("libX11.so.6"); xss = ctypes.cdll.LoadLibrary("libXss.so.1")
                x11.XOpenDisplay.restype = ctypes.c_void_p
                x11.XDefaultRootWindow.argtypes = [ctypes.c_void_p]; x11.XDefaultRootWindow.restype = ctypes.c_ulong
                xss.XScreenSaverAllocInfo.restype = ctypes.POINTER(XSSInfo)
                xss.XScreenSaverQueryInfo.argtypes = [ctypes.c_void_p, ctypes.c_ulong, ctypes.POINTER(XSSInfo)]
                dpy = x11.XOpenDisplay(None)
                if not dpy:
                    _xss = False
                    return None
                _xss = (xss, dpy, x11.XDefaultRootWindow(dpy), xss.XScreenSaverAllocInfo())
            if not _xss:
                return None
            xss, dpy, root, info = _xss
            xss.XScreenSaverQueryInfo(dpy, root, info)
            return info.contents.idle / 1000.0
    except Exception:
        return None
    return None


class Activity:
    """fraction of the last 3 minutes with keyboard/mouse input (FlowLight-style 'in the zone' signal)"""

    def __init__(self, window=180):
        self.samples, self.window, self.ok = [], window, None
        threading.Thread(target=self._run, daemon=True).start()

    def _run(self):
        while True:
            idle = idle_seconds()
            self.ok = idle is not None
            if self.ok:
                self.samples.append(1 if idle < 3 else 0)
                self.samples = self.samples[-self.window:]
            time.sleep(1)

    def value(self):
        return round(sum(self.samples) / len(self.samples), 2) if self.samples else 0.0


ACTIVITY = None


def pc_payload():
    bat, chg = battery()
    p = {"cpu": round(cpu_percent(), 1), "ram": round(ram_percent(), 1), "bat": bat, "charging": chg,
         "host": socket.gethostname()[:20], "title": active_window_title()[:46]}
    if ACTIVITY is not None:
        p["act"] = ACTIVITY.value()
    return p


# ----------------------------------------------------------------- calendar (private ICS link from Google / Outlook)
def _ics_unfold(text):
    out = []
    for line in text.splitlines():
        if line[:1] in (" ", "\t") and out:
            out[-1] += line[1:]
        else:
            out.append(line)
    return out


def _ics_dt(value, params):
    from datetime import datetime, timezone
    if params.get("VALUE") == "DATE" or len(value) == 8:
        return None                                   # all-day: not a meeting
    v = value.strip()
    if v.endswith("Z"):
        return datetime.strptime(v[:15], "%Y%m%dT%H%M%S").replace(tzinfo=timezone.utc)
    dt = datetime.strptime(v[:15], "%Y%m%dT%H%M%S")
    tzid = params.get("TZID")
    if tzid:
        try:
            from zoneinfo import ZoneInfo
            return dt.replace(tzinfo=ZoneInfo(tzid.strip('"')))
        except Exception:
            pass
    return dt.astimezone()                            # floating / unknown zone: treat as local


def _ics_duration(v):
    m = re.match(r"P(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?)?", v or "")
    if not m:
        return None
    d, h, mi, se = (int(x or 0) for x in m.groups())
    return d * 86400 + h * 3600 + mi * 60 + se


def parse_ics(text, horizon_h=36):
    """upcoming timed events within the horizon: [(start_epoch, end_epoch, summary)], RRULE DAILY/WEEKLY/MONTHLY aware"""
    from datetime import datetime, timedelta, timezone
    now = datetime.now(timezone.utc); end_w = now + timedelta(hours=horizon_h)
    events, cur = [], None
    for line in _ics_unfold(text):
        if line == "BEGIN:VEVENT":
            cur = {"EXDATE": []}
        elif line == "END:VEVENT" and cur is not None:
            events.append(cur); cur = None
        elif cur is not None and ":" in line:
            head, val = line.split(":", 1)
            parts = head.split(";")
            name = parts[0].upper()
            params = dict(x.split("=", 1) for x in parts[1:] if "=" in x)
            if name == "EXDATE":
                for v in val.split(","):
                    d = _ics_dt(v, params)
                    if d: cur["EXDATE"].append(d)
            else:
                cur[name] = (val, params)
    overrides = {}
    for e in events:
        if "RECURRENCE-ID" in e and "UID" in e:
            rid = _ics_dt(*e["RECURRENCE-ID"])
            if rid: overrides.setdefault(e["UID"][0], set()).add(rid.timestamp())
    out = []
    WD = {"MO": 0, "TU": 1, "WE": 2, "TH": 3, "FR": 4, "SA": 5, "SU": 6}
    for e in events:
        if "DTSTART" not in e or e.get("STATUS", ("",))[0].upper() == "CANCELLED":
            continue
        st = _ics_dt(*e["DTSTART"])
        if not st:
            continue
        if "DTEND" in e:
            en = _ics_dt(*e["DTEND"]); dur = (en - st).total_seconds() if en else 1800
        else:
            dur = _ics_duration(e.get("DURATION", ("",))[0]) or 1800
        title = re.sub(r"\\([,;nN])", lambda m: " " if m.group(1) in "nN" else m.group(1), e.get("SUMMARY", ("meeting",))[0])
        skip = {d.timestamp() for d in e["EXDATE"]} | overrides.get(e.get("UID", ("",))[0], set()) if "RECURRENCE-ID" not in e else set()
        starts = [st]
        if "RRULE" in e and "RECURRENCE-ID" not in e:
            r = dict(x.split("=", 1) for x in e["RRULE"][0].split(";") if "=" in x)
            freq, step = r.get("FREQ", ""), int(r.get("INTERVAL", "1"))
            count = int(r["COUNT"]) if "COUNT" in r else None
            until = _ics_dt(r["UNTIL"], {}) if "UNTIL" in r and len(r["UNTIL"]) > 8 else None
            if "UNTIL" in r and len(r["UNTIL"]) == 8:
                until = datetime.strptime(r["UNTIL"], "%Y%m%d").replace(tzinfo=timezone.utc) + timedelta(days=1)
            bydays = [WD[d[-2:]] for d in r.get("BYDAY", "").split(",") if d[-2:] in WD]
            starts, n, k = [], 0, 0
            while k < 4000:
                if freq == "DAILY":
                    cands = [st + timedelta(days=k * step)]
                elif freq == "WEEKLY":
                    wk0 = st - timedelta(days=st.weekday()) + timedelta(weeks=k * step)
                    cands = [wk0 + timedelta(days=d) for d in sorted(bydays or [st.weekday()])]
                    cands = [c for c in cands if c >= st]
                elif freq == "MONTHLY":
                    y, mo = divmod(st.month - 1 + k * step, 12)
                    try:
                        cands = [st.replace(year=st.year + y, month=mo + 1)]
                    except ValueError:
                        cands = []
                else:
                    cands = [st] if k == 0 else []
                stop = False
                for c in cands:
                    if (until and c > until) or c > end_w:
                        stop = True; break
                    n += 1
                    if count and n > count:
                        stop = True; break
                    starts.append(c)
                if stop or (freq not in ("DAILY", "WEEKLY", "MONTHLY")):
                    break
                k += 1
        for s0 in starts:
            if s0.timestamp() in skip:
                continue
            t0, t1 = s0.timestamp(), s0.timestamp() + dur
            if t1 > now.timestamp() and s0 <= end_w:
                out.append((int(t0), int(t1), title.strip()[:31] or "meeting"))
    return sorted(set(out))[:6]


def fetch_calendar():
    urls = conf().get("ics") or []
    if isinstance(urls, str):
        urls = [urls]
    evs = []
    for u in urls:
        try:
            req = urllib.request.Request(u, headers={"User-Agent": "lilmate-agent"})
            with urllib.request.urlopen(req, timeout=15) as r:
                evs += parse_ics(r.read().decode("utf-8", "replace"))
        except Exception as e:
            log(f"calendar fetch failed: {e}")
            return None
    return sorted(set(evs))[:6]


# ----------------------------------------------------------------- transports
class UsbLink:
    """lil.mate over the USB cable (ESP32-C3 USB serial). Lines: '@ev {...}' out, '@dec {...}' in."""

    def __init__(self, port):
        import serial  # pyserial
        s = serial.Serial()
        s.port, s.baudrate, s.timeout = port, 115200, 0.2
        # keep DTR/RTS at their defaults: forcing them low pulses the ESP32-C3 reset line (tested)
        s.open()
        self.ser, self.port = s, port
        self.lock = threading.Lock()
        self.decisions, self.focus, self.alive = {}, False, True
        threading.Thread(target=self._reader, daemon=True).start()

    @staticmethod
    def find_port():
        try:
            from serial.tools import list_ports
        except ImportError:
            return None
        for p in list_ports.comports():
            if p.vid == 0x303A:   # Espressif USB serial/JTAG
                return p.device
        return None

    def _reader(self):
        buf = b""
        while self.alive:
            try:
                buf += self.ser.read(256)
            except Exception as e:
                log(f"usb read error: {e}")
                self.alive = False
                return
            while b"\n" in buf:
                line, buf = buf.split(b"\n", 1)
                line = line.decode("utf-8", "replace").strip()
                if line and not line.startswith(("@ok", "@pcr")):
                    log("device: " + line)
                if line.startswith("@dec "):
                    try:
                        d = json.loads(line[5:])
                        self.decisions[int(d["rid"])] = d["d"]
                    except (ValueError, KeyError):
                        pass
                elif line.startswith("@pcr "):
                    try:
                        self.focus = bool(json.loads(line[5:]).get("focus"))
                    except ValueError:
                        pass

    def send_line(self, line):
        with self.lock:
            self.ser.write((line.replace("\n", " ") + "\n").encode())

    def event(self, ev):
        self.send_line("@ev " + json.dumps(ev, separators=(",", ":")))

    def decision(self, rid):
        return self.decisions.get(int(rid), "pending")

    def command(self, text):
        self.send_line(text)
        return "sent over USB"

    def pc(self, payload):
        self.send_line("@pc " + json.dumps(payload, separators=(",", ":")))
        return self.focus

    def sync_time(self):
        self.send_line(f"/time {int(time.time())}")

    def calendar(self, evs):
        self.send_line("@cal " + json.dumps({"ev": [{"t": t, "e": e, "s": s} for t, e, s in evs]}, separators=(",", ":")))


class WifiLink:
    def __init__(self, host):
        self.host = host
        self.port = f"http://{host}"

    def event(self, ev):
        http("POST", f"http://{self.host}/api/agent", json.dumps(ev), "application/json", timeout=2)

    def decision(self, rid):
        return json.loads(http("GET", f"http://{self.host}/api/agent/decision?rid={rid}", timeout=2)).get("d", "none")

    def command(self, text):
        return cmd(self.host, text)

    def pc(self, payload):
        r = json.loads(http("POST", f"http://{self.host}/api/pc", json.dumps(payload), "application/json"))
        return bool(r.get("focus"))

    def sync_time(self):
        pass   # on Wi-Fi the buddy uses NTP

    def calendar(self, evs):
        http("POST", f"http://{self.host}/api/cal", json.dumps({"ev": [{"t": t, "e": e, "s": s} for t, e, s in evs]}), "application/json")


# ----------------------------------------------------------------- bridge daemon (run)
class Bridge:
    def __init__(self, a):
        self.a, self.link, self.lock = a, None, threading.Lock()

    def connect(self):
        port = None if self.a.wifi else (self.a.port or UsbLink.find_port())
        if port:
            try:
                self.link = UsbLink(port)
                time.sleep(0.3)
                self.link.sync_time()
                print(f"lil.mate connected over USB ({port})")
                return
            except Exception as e:
                print(f"USB {port} not usable ({e}); trying Wi-Fi")
        self.link = WifiLink(device_host(self.a.host))
        print(f"lil.mate over Wi-Fi at {self.link.host}")

    def serve(self):
        bridge = self

        class H(BaseHTTPRequestHandler):
            def log_message(self, *a):
                pass

            def reply(self, code, obj):
                b = json.dumps(obj).encode()
                self.send_response(code)
                self.send_header("Content-Type", "application/json")
                self.send_header("Content-Length", str(len(b)))
                self.end_headers()
                self.wfile.write(b)

            def do_GET(self):
                u = urllib.parse.urlparse(self.path)
                q = urllib.parse.parse_qs(u.query)
                try:
                    if u.path == "/ping":
                        return self.reply(200, {"ok": True, "via": bridge.link.port})
                    if u.path == "/decision":
                        return self.reply(200, {"d": bridge.link.decision(q.get("rid", ["0"])[0])})
                except Exception as e:
                    return self.reply(502, {"error": str(e)})
                self.reply(404, {})

            def do_POST(self):
                n = int(self.headers.get("Content-Length", 0))
                body = self.rfile.read(n).decode("utf-8", "replace")
                try:
                    if self.path == "/event":
                        bridge.link.event(json.loads(body))
                        return self.reply(200, {"ok": True})
                    if self.path == "/cmd":
                        return self.reply(200, {"reply": bridge.link.command(body)})
                except Exception as e:
                    return self.reply(502, {"error": str(e)})
                self.reply(404, {})

        srv = ThreadingHTTPServer(("127.0.0.1", BRIDGE_PORT), H)
        threading.Thread(target=srv.serve_forever, daemon=True).start()

    def loop(self):
        block = [w.strip().lower() for w in self.a.block.split(",") if w.strip()]
        last_nudge, last_time, last_cal, cal_evs, cal_sent = 0, time.time(), 0, None, None
        cpu_percent()
        while True:
            try:
                if isinstance(self.link, UsbLink) and not self.link.alive:
                    print("USB link lost, reconnecting...")
                    time.sleep(2)
                    self.connect()
                p = pc_payload()
                focus = self.link.pc(p)
                if self.a.guard and focus and p["title"]:
                    hit = next((w for w in block if w in p["title"].lower()), None)
                    if hit and time.time() - last_nudge > 60:
                        last_nudge = time.time()
                        self.link.command(f"/nudge ({hit})")
                if time.time() - last_time > 6 * 3600:
                    last_time = time.time()
                    self.link.sync_time()
                if conf().get("ics") and time.time() - last_cal > 600:
                    last_cal = time.time()
                    got = fetch_calendar()
                    if got is not None:
                        cal_evs = got
                if cal_evs is not None and (cal_sent != (id(self.link), cal_evs) or time.time() - last_cal < 1):
                    self.link.calendar(cal_evs)
                    cal_sent = (id(self.link), cal_evs)
            except Exception as e:
                print(f"[{time.strftime('%H:%M:%S')}] lil.mate not reachable: {e}")
                time.sleep(8)
                try:
                    self.connect()
                except Exception:
                    pass
            time.sleep(self.a.interval)


def run_bridge(a):
    global ACTIVITY
    ACTIVITY = Activity()
    b = Bridge(a)
    b.connect()
    try:
        b.serve()
        print(f"bridge for hooks on {BRIDGE}  (Ctrl+C to stop)")
    except OSError:
        print(f"another bridge already runs on port {BRIDGE_PORT}; this one only sends PC stats")
    time.sleep(1.5)
    if ACTIVITY.ok is False:
        print("note: keyboard/mouse activity unavailable here, so the automatic 'busy' face is off (DND switch still works)")
    if conf().get("ics"):
        print("calendar: syncing your meetings every 10 min")
    if not psutil and platform.system() != "Linux":
        print("tip: `pip install psutil` gives better CPU/RAM stats")
    b.loop()


# ----------------------------------------------------------------- hook (called by Claude Code etc.)
OFFLINE_MARK = os.path.expanduser("~/.lilmate/offline")


def deliver(ev, host):
    """bridge on localhost first (USB or Wi-Fi), then the buddy directly over Wi-Fi.
    A failed Wi-Fi attempt is remembered for 60 s so hooks stay instant while the buddy is off."""
    try:
        http("POST", BRIDGE + "/event", json.dumps(ev), "application/json", timeout=0.3)
        return "bridge"
    except Exception:
        pass
    try:
        if time.time() - os.path.getmtime(OFFLINE_MARK) < 60:
            return None
    except OSError:
        pass
    try:
        http("POST", f"http://{host}/api/agent", json.dumps(ev), "application/json", timeout=1.0)
        try:
            os.remove(OFFLINE_MARK)
        except OSError:
            pass
        return "wifi"
    except Exception:
        try:
            os.makedirs(os.path.dirname(OFFLINE_MARK), exist_ok=True)
            open(OFFLINE_MARK, "w").close()
        except OSError:
            pass
        return None


def poll_decision(via, rid, host):
    try:
        if via == "bridge":
            return json.loads(http("GET", f"{BRIDGE}/decision?rid={rid}", timeout=1)).get("d", "none")
        return WifiLink(host).decision(rid)
    except Exception:
        return "error"


def describe_tool(name, inp):
    if not isinstance(inp, dict):
        return name
    for k in ("command", "file_path", "path", "url", "pattern", "query", "description"):
        if inp.get(k):
            return f"{name}: {inp[k]}"
    return f"{name}: {json.dumps(inp)[:80]}"


def run_hook(a):
    if a.tool == "codex":                                   # Codex passes its JSON as an argument
        try:
            data = json.loads(a.payload or "{}")
        except ValueError:
            return 0
        if data.get("type") == "agent-turn-complete":
            cwd = data.get("cwd") or os.getcwd()
            deliver({"sid": str(data.get("thread-id") or data.get("turn-id") or "codex")[:12], "name": os.path.basename(cwd.rstrip("/\\"))[:19] or "codex",
                     "tool": "codex", "ev": "stop", "msg": re.sub(r"\s+", " ", str(data.get("last-assistant-message") or ""))[:90]}, device_host(a.host))
        return 0
    try:
        data = json.load(sys.stdin)
    except ValueError:
        return 0
    host = device_host(a.host)
    if a.tool == "copilot":
        return copilot_hook(a, data, host)
    if a.tool == "cursor":
        return cursor_hook(a, data, host)
    evname = data.get("hook_event_name", "")
    cwd = data.get("cwd") or os.getcwd()
    base = {"sid": str(data.get("session_id", "default"))[:12], "name": os.path.basename(cwd.rstrip("/\\"))[:19] or "agent", "tool": a.tool}
    try:
        if evname == "UserPromptSubmit":
            deliver({**base, "ev": "start"}, host)
        elif evname in ("PreToolUse", "PostToolUse", "PostToolUseFailure"):
            deliver({**base, "ev": "tool"}, host)
        elif evname == "Stop":
            msg = str(data.get("last_assistant_message") or "")
            deliver({**base, "ev": "stop", "msg": re.sub(r"\s+", " ", msg)[:90]}, host)
        elif evname == "StopFailure":
            deliver({**base, "ev": "error", "msg": str(data.get("error") or "API error")[:90]}, host)
        elif evname == "Notification":
            t = str(data.get("notification_type") or data.get("type") or "")
            msg = str(data.get("message") or "")
            kind = "permission" if "permission" in t or "permission" in msg.lower() else "idle" if "idle" in t else "question"
            deliver({**base, "ev": "needs", "kind": kind, "msg": msg[:90]}, host)
        elif evname == "SessionEnd":
            deliver({**base, "ev": "end"}, host)
        elif evname == "PermissionRequest":
            return permission_hook(a, data, base, host)
    except Exception as e:
        log(f"hook {evname}: {e}")
    return 0


def copilot_hook(a, data, host):
    """VS Code / Copilot agent hooks (camelCase events: the event name comes from --event)"""
    cwd = data.get("cwd") or os.getcwd()
    base = {"sid": str(data.get("sessionId") or data.get("session_id") or "copilot")[:12], "name": os.path.basename(cwd.rstrip("/\\"))[:19] or "copilot", "tool": "copilot"}
    ev = {"userPromptSubmitted": "start", "postToolUse": "tool", "agentStop": "stop", "sessionEnd": "end"}.get(a.event or "")
    try:
        if ev:
            deliver({**base, "ev": ev}, host)
    except Exception as e:
        log(f"copilot hook {a.event}: {e}")
    return 0


def cursor_hook(a, data, host):
    evname = a.event or data.get("hook_event_name", "")
    roots = data.get("workspace_roots") or [os.getcwd()]
    base = {"sid": str(data.get("conversation_id") or "cursor")[:12], "name": os.path.basename(str(roots[0]).rstrip("/\\"))[:19] or "cursor", "tool": "cursor"}
    try:
        if evname == "beforeSubmitPrompt":
            deliver({**base, "ev": "start"}, host)
            print(json.dumps({"continue": True}))
        elif evname == "stop":
            deliver({**base, "ev": "error" if data.get("status") == "error" else "stop"}, host)
        elif evname == "sessionEnd":
            deliver({**base, "ev": "end"}, host)
        elif evname == "beforeShellExecution":           # only installed with --approve
            d = ask_buddy(a, base, host, "Shell: " + str(data.get("command", ""))[:88])
            print(json.dumps({"permission": d if d in ("allow", "deny") else "ask",
                              **({"user_message": "Denied from your lil.mate desk buddy."} if d == "deny" else {})}))
    except Exception as e:
        log(f"cursor hook {evname}: {e}")
        if evname == "beforeSubmitPrompt":
            print(json.dumps({"continue": True}))
    return 0


def ask_buddy(a, base, host, what):
    """show an approve prompt on the buddy; returns allow / deny / None (no answer)"""
    rid = random.randint(1000, 999999)
    via = deliver({**base, "ev": "perm", "rid": rid, "ttl": a.ttl, "msg": what[:95]}, host)
    if not via:
        return None
    end = time.time() + a.ttl
    while time.time() < end:
        d = poll_decision(via, rid, host)
        if d in ("allow", "deny"):
            log(f"{base['tool']} permission {rid} {d}: {what}")
            return d
        if d == "error":
            break
        time.sleep(0.4)
    deliver({**base, "ev": "permdone", "rid": rid, "answered": False}, host)
    return None


def permission_hook(a, data, base, host):
    rid = random.randint(1000, 999999)
    ttl = a.ttl
    what = describe_tool(data.get("tool_name", "tool"), data.get("tool_input"))
    via = deliver({**base, "ev": "perm", "rid": rid, "ttl": ttl, "msg": what[:95]}, host)
    if not via:
        return 0                       # buddy not reachable: normal Claude prompt, no delay
    end = time.time() + ttl
    while time.time() < end:
        d = poll_decision(via, rid, host)
        if d in ("allow", "deny"):
            out = {"hookSpecificOutput": {"hookEventName": "PermissionRequest", "decision": {"behavior": d}}}
            if d == "deny":
                out["hookSpecificOutput"]["decision"]["message"] = "The user denied this from their lil.mate desk buddy."
            print(json.dumps(out))
            log(f"permission {rid} {d}: {what}")
            return 0
        if d == "error":
            break
        time.sleep(0.4)
    deliver({**base, "ev": "permdone", "rid": rid, "answered": False}, host)
    return 0                           # no answer: Claude shows its normal permission prompt


# ----------------------------------------------------------------- install into Claude Code
EVENTS_ASYNC = ["UserPromptSubmit", "PostToolUse"]                       # frequent: never block Claude
EVENTS_SYNC = ["Stop", "StopFailure", "Notification", "SessionEnd"]      # must arrive: short, bounded


def settings_path(a):
    if a.project:
        return os.path.join(os.path.abspath(a.project), ".claude", "settings.local.json")
    return os.path.expanduser("~/.claude/settings.json")


def strip_ours(hooks):
    for ev in list(hooks):
        groups = []
        for g in hooks[ev]:
            hs = [h for h in g.get("hooks", []) if HOOK_MARK not in str(h.get("command", ""))]
            if hs:
                groups.append({**g, "hooks": hs})
        if groups:
            hooks[ev] = groups
        else:
            del hooks[ev]


def install_claude(a, remove=False):
    path = settings_path(a)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    cfg = {}
    if os.path.exists(path):
        with open(path) as f:
            raw = f.read()
        cfg = json.loads(raw) if raw.strip() else {}
        backup = path + time.strftime(".bak-%Y%m%d-%H%M%S")
        with open(backup, "w") as f:
            f.write(raw)
        print(f"backup: {backup}")
    hooks = cfg.setdefault("hooks", {})
    strip_ours(hooks)
    if not remove:
        exe, script = sys.executable or "python3", os.path.abspath(__file__)
        q = (lambda s: f'"{s}"') if platform.system() == "Windows" else (lambda s: "'" + s.replace("'", "'\\''") + "'")
        hostarg = f" --host {a.host}" if a.host else ""
        base = f"{q(exe)} {q(script)} hook --tool claude{hostarg}"
        for ev in EVENTS_ASYNC:
            hooks.setdefault(ev, []).append({"hooks": [{"type": "command", "command": base, "async": True}]})
        for ev in EVENTS_SYNC:
            hooks.setdefault(ev, []).append({"hooks": [{"type": "command", "command": base, "timeout": 5}]})
        if a.approve:
            hooks.setdefault("PermissionRequest", []).append(
                {"hooks": [{"type": "command", "command": f"{base} --ttl {a.ttl}", "timeout": a.ttl + 15}]})
    if not hooks:
        cfg.pop("hooks", None)
    with open(path, "w") as f:
        json.dump(cfg, f, indent=2)
        f.write("\n")
    if remove:
        print(f"removed lil.mate hooks from {path}")
    else:
        print(f"lil.mate hooks installed in {path}")
        print("  events: " + ", ".join(EVENTS_ASYNC + EVENTS_SYNC + (["PermissionRequest (approve from desk)"] if a.approve else [])))
        print("  restart Claude Code (or run /hooks) to load them.")
        if a.host:
            with open(CONF_PATH, "w") as f:
                json.dump({**conf(), "host": a.host}, f)


def _hook_cmd(tool, event=None, extra=""):
    exe, script = sys.executable or "python3", os.path.abspath(__file__)
    q = (lambda s: f'"{s}"') if platform.system() == "Windows" else (lambda s: "'" + s.replace("'", "'\\''") + "'")
    return f"{q(exe)} {q(script)} hook --tool {tool}" + (f" --event {event}" if event else "") + extra


def _backup(path):
    if os.path.exists(path):
        b = path + time.strftime(".bak-%Y%m%d-%H%M%S")
        shutil.copy2(path, b)
        print(f"backup: {b}")


def install_copilot(a, remove=False):
    """VS Code / GitHub Copilot agent hooks, personal level: ~/.copilot/hooks/lilmate.json"""
    path = os.path.expanduser("~/.copilot/hooks/lilmate.json")
    if remove:
        if os.path.exists(path):
            os.remove(path)
        print(f"removed {path}")
        return
    os.makedirs(os.path.dirname(path), exist_ok=True)
    hostarg = f" --host {a.host}" if a.host else ""
    cfg = {"version": 1, "hooks": {ev: [{"type": "command", "command": _hook_cmd("copilot", ev, hostarg), "timeoutSec": 5}]
                                   for ev in ("userPromptSubmitted", "agentStop", "sessionEnd")}}
    with open(path, "w") as f:
        json.dump(cfg, f, indent=2); f.write("\n")
    print(f"lil.mate hooks for Copilot (VS Code agent) written to {path}")
    print("  shows: working, done. (Copilot has no 'waiting for approval' event, so approve-from-desk stays Claude/Cursor.)")
    print("  agent hooks are a VS Code preview feature: reload VS Code to load them.")


def install_cursor(a, remove=False):
    path = os.path.expanduser("~/.cursor/hooks.json")
    cfg = {"version": 1, "hooks": {}}
    if os.path.exists(path):
        with open(path) as f:
            raw = f.read()
        cfg = json.loads(raw) if raw.strip() else cfg
        _backup(path)
    hooks = cfg.setdefault("hooks", {})
    for ev in list(hooks):
        hooks[ev] = [h for h in hooks[ev] if HOOK_MARK not in str(h.get("command", ""))]
        if not hooks[ev]:
            del hooks[ev]
    if not remove:
        hostarg = f" --host {a.host}" if a.host else ""
        for ev in ("beforeSubmitPrompt", "stop", "sessionEnd"):
            hooks.setdefault(ev, []).append({"command": _hook_cmd("cursor", ev, hostarg), "timeout": 5})
        if a.approve:
            hooks.setdefault("beforeShellExecution", []).append({"command": _hook_cmd("cursor", "beforeShellExecution", f"{hostarg} --ttl {a.ttl}"), "timeout": a.ttl + 10})
    cfg.setdefault("version", 1)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        json.dump(cfg, f, indent=2); f.write("\n")
    print(("removed lil.mate hooks from " if remove else "lil.mate hooks for Cursor written to ") + path)
    if not remove and a.approve:
        print("  approve-from-desk ON: every shell command waits for your hold (or 'ask' after the timeout).")


def install_codex(a, remove=False):
    path = os.path.expanduser("~/.codex/config.toml")
    lines = open(path).read().splitlines() if os.path.exists(path) else []
    lines = [l for l in lines if HOOK_MARK not in l]
    if not remove:
        if any(re.match(r"\s*notify\s*=", l) for l in lines):
            print("~/.codex/config.toml already has a 'notify' setting; add lil.mate to it by hand:")
            print("  " + json.dumps([sys.executable, os.path.abspath(__file__), "hook", "--tool", "codex"]))
            return
        lines.insert(0, "notify = " + json.dumps([sys.executable, os.path.abspath(__file__), "hook", "--tool", "codex"]))
    if os.path.exists(path):
        _backup(path)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        f.write("\n".join(lines) + "\n")
    print(("removed lil.mate from " if remove else "lil.mate notify added to ") + path + ("" if remove else "  (Codex reports 'turn complete' only)"))


def set_calendar(a):
    c = conf()
    if a.url == "off":
        c.pop("ics", None)
    else:
        c["ics"] = a.url
    with open(CONF_PATH, "w") as f:
        json.dump(c, f)
    try:
        os.chmod(CONF_PATH, 0o600)               # the private ICS link is a secret
    except OSError:
        pass
    if a.url == "off":
        print("calendar sync off"); return
    evs = fetch_calendar()
    if evs is None:
        print("saved, but the link couldn't be read right now (see ~/.lilmate/agent.log)"); return
    print(f"saved. Next {len(evs)} meeting(s) in 36 h:")
    for t, e, s in evs:
        print("  " + time.strftime("%a %H:%M", time.localtime(t)) + f"-{time.strftime('%H:%M', time.localtime(e))}  {s}")
    print("lil.mate gets them while `lilmate_agent.py run` is running.")


# ----------------------------------------------------------------- demo / test
def test_agent(a):
    host = device_host(a.host)
    base = {"sid": "demo" + str(random.randint(10, 99)), "name": "demo-project", "tool": "claude"}
    steps = [("start", {}, "Claude starts working (thinking face + timer)", 6),
             ("stop", {"msg": "Refactor finished, 12 files changed"}, "Claude finished: happy face, tap to say OK", 8),
             ("start", {}, "working again", 4),
             ("needs", {"kind": "question", "msg": "Which database should I use?"}, "Claude has a question: hungry face 'Feed me!'", 8)]
    for ev, extra, note, wait in steps:
        via = deliver({**base, "ev": ev, **extra}, host)
        print(f"-> {ev:6} {note}  [{via or 'NOT DELIVERED'}]")
        if not via:
            return 1
        time.sleep(wait)
    rid = random.randint(1000, 999999)
    via = deliver({**base, "ev": "perm", "rid": rid, "ttl": 25, "msg": "Bash: npm test -- --watch=false"}, host)
    print("-> perm   approval prompt on the buddy: HOLD = allow, 2 TAPS = deny (25 s)")
    end = time.time() + 25
    while time.time() < end:
        d = poll_decision(via, rid, host)
        if d in ("allow", "deny"):
            print(f"   you chose: {d.upper()}")
            break
        time.sleep(0.4)
    else:
        print("   no answer (timed out) -> Claude would show its normal prompt")
        deliver({**base, "ev": "permdone", "rid": rid}, host)
    time.sleep(2)
    deliver({**base, "ev": "end"}, host)
    print("-> end    demo session removed")
    return 0


def run_done(a):
    if not a.command:
        sys.exit("usage: lilmate_agent.py done -- <command ...>")
    t0 = time.time()
    rc = subprocess.call(a.command)
    dt = int(time.time() - t0)
    name = os.path.basename(a.command[0])
    msg = f"{name} {'done' if rc == 0 else 'FAILED'} in {dt // 60}m{dt % 60:02d}s"
    send_cmd(a, f"/face {'happy' if rc == 0 else 'sad'}")
    print(send_cmd(a, f"/say {msg}"))
    sys.exit(rc)


def send_cmd(a, text):
    try:
        return json.loads(http("POST", BRIDGE + "/cmd", text, timeout=1)).get("reply", "")
    except Exception:
        pass
    try:
        return cmd(device_host(a.host), text)
    except Exception as e:
        return f"can't reach lil.mate: {e}"


def main():
    p = argparse.ArgumentParser(description="lil.mate PC agent")
    p.add_argument("--host", default=None, help="buddy IP / hostname for Wi-Fi (default: LILMATE_HOST, ~/.lilmate.json, lilmate.local)")
    sub = p.add_subparsers(dest="mode")
    r = sub.add_parser("run", help="bridge: USB/Wi-Fi link, PC stats, focus guard")
    r.add_argument("--port", help="USB serial port (auto-detected)")
    r.add_argument("--wifi", action="store_true", help="never use USB")
    r.add_argument("--interval", type=float, default=5)
    r.add_argument("--no-guard", dest="guard", action="store_false")
    r.add_argument("--block", default=DEFAULT_BLOCK)
    h = sub.add_parser("hook", help="called by Claude Code hooks (reads JSON on stdin)")
    h.add_argument("--tool", default="claude")
    h.add_argument("--ttl", type=int, default=30, help="seconds to wait for a desk approval")
    h.add_argument("--event", default=None, help="event name (Copilot / Cursor hooks)")
    h.add_argument("payload", nargs="?", default=None, help="JSON payload (Codex notify)")
    for name in ("install-claude", "uninstall-claude"):
        i = sub.add_parser(name)
        i.add_argument("--project", help="install into <project>/.claude/settings.local.json instead of ~/.claude")
        i.add_argument("--no-approve", dest="approve", action="store_false", help="don't route permission prompts to the buddy")
        i.add_argument("--ttl", type=int, default=30)
    for name in ("install-copilot", "uninstall-copilot", "install-cursor", "uninstall-cursor", "install-codex", "uninstall-codex"):
        i = sub.add_parser(name)
        i.add_argument("--approve", action="store_true", help="(cursor) route shell commands to the buddy for approval")
        i.add_argument("--ttl", type=int, default=30)
        i.add_argument("--host", default=argparse.SUPPRESS)
    sc = sub.add_parser("set-calendar", help="sync meetings from your private ICS link (Google / Outlook), or 'off'")
    sc.add_argument("url")
    sub.add_parser("test-agent", help="fake Claude session to see the buddy react")
    s = sub.add_parser("say"); s.add_argument("text", nargs="+")
    c = sub.add_parser("cmd"); c.add_argument("text", nargs="+")
    d = sub.add_parser("done"); d.add_argument("command", nargs=argparse.REMAINDER)
    for x in (h, sub.choices["install-claude"], sub.choices["uninstall-claude"], r, s, c, d):
        x.add_argument("--host", default=argparse.SUPPRESS)
    a = p.parse_args()
    if a.mode == "hook":
        sys.exit(run_hook(a))
    if a.mode == "install-claude":
        return install_claude(a)
    if a.mode == "uninstall-claude":
        return install_claude(a, remove=True)
    for tool, fn in (("copilot", install_copilot), ("cursor", install_cursor), ("codex", install_codex)):
        if a.mode == f"install-{tool}":
            return fn(a)
        if a.mode == f"uninstall-{tool}":
            return fn(a, remove=True)
    if a.mode == "set-calendar":
        return set_calendar(a)
    if a.mode == "test-agent":
        sys.exit(test_agent(a))
    if a.mode == "say":
        print(send_cmd(a, "/say " + " ".join(a.text)))
    elif a.mode == "cmd":
        print(send_cmd(a, " ".join(a.text)))
    elif a.mode == "done":
        if a.command and a.command[0] == "--":
            a.command = a.command[1:]
        run_done(a)
    else:
        if a.mode is None:
            a = p.parse_args(["run"] + sys.argv[1:])
        try:
            run_bridge(a)
        except KeyboardInterrupt:
            pass


if __name__ == "__main__":
    main()
