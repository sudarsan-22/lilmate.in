# Lilmate OS

A Troko-style desk companion firmware for the **Beetle ESP32-C3 + 0.96" OLED + TTP223 touch** stack
(minimo, elephant, pengu_chubby). No mic or speaker needed: the face, touch, your phone and your PC do the talking.

## Hardware

| Part | Pin |
|---|---|
| SSD1306 128×64 I2C OLED | SDA → GPIO 8, SCL → GPIO 9, VCC 3V3, GND |
| TTP223 touch | OUT → GPIO 2, VCC 3V3, GND |

## Flash

```bash
./flash.sh              # build + flash, keeps settings
./flash.sh --erase      # factory reset first
./flash.sh --monitor    # open the USB console afterwards (type /help)
```
Later updates can go over Wi-Fi: dashboard → Settings → Firmware → upload `build/lilmate_os.ino.bin`.

## First boot

1. The OLED shows a QR code. Scan it with your phone to join the **Lilmate-XXXX** hotspot.
2. The setup page opens (or go to `192.168.4.1`). Pick your 2.4 GHz Wi-Fi, enter your name and city (optional; it uses your IP's location if left blank).
3. Lilmate restarts and joins your Wi-Fi. Open **http://lilmate.local** (or the IP on the INFO screen; hold on INFO to show a QR).

Over USB instead: `/wifi MyNetwork|password` in the serial console.

## Touch controls

| Where | Tap | 2 taps | 3 taps | Hold | Hold 4 s |
|---|---|---|---|---|---|
| Anywhere | | next screen | back to face | | |
| Face | pat (happy reaction) | | play: fly / ball | cuddle (hearts) | dizzy |
| Clock | refresh weather | | | | |
| Focus | start / pause | | | stop / start break | |
| Tasks | next task | | | done / undo | |
| Habits | next habit | | | +1 | |
| Game | turn around (start) | | | exit | |
| Info | | | | dashboard QR | Wi-Fi setup hotspot |
| Alert | dismiss | | | snooze 10 min | |

**Star Catch from the dashboard:** the game card (Home tab) drives the game on the OLED. Laptop keys: `←`/`A` steer left,
`→`/`D` steer right, `Space`/`Enter` start / turn, `Esc` quit. On a phone use the big ◀ Play ▶ buttons. Live score, lives and best score
update on the card. Touch on the device still works at the same time. API: `GET /api/game?k=L|R|T|X`.

Screens: **Face → AI agents → Clock+weather → Focus → Tasks → Habits → PC → Star Catch → Team → Info**. Any screen falls back to the face after 45 s.

## Telegram bot (optional, recommended)

1. In Telegram, message **@BotFather** → `/newbot` → copy the token.
2. Dashboard → Settings → paste the token → Save.
3. Send `/start` to your new bot. The first chat to do this is paired; everyone else is ignored.

Then just chat: `remind me in 20 min to drink water`, `/task buy milk`, `/focus`, `/log water`, `/status`.
Plain messages pop up on the screen. Reminders and focus-done alerts arrive on your phone. Every morning
(08:00 by default) you get a summary of weather, tasks, reminders and habits.

## Commands (Telegram, dashboard "Command" box, USB serial, PC agent)

```
/status  /help
/task buy milk   /tasks   /done 2   /undone 2   /del 2   /clear
/remind 10m stretch   /remind 18:30 call mom   /remind daily 08:00 meds
remind me in 1 hour 30 min to call   remind me to stretch at 6pm
/reminders   /unremind 1
/habit water 8   /habits   /log water   /unhabit 1
/focus [min]   /break [min]   /pause   /stop
/say hello   /face happy|love|cool|sad|angry|laugh|wink|sleep|dizzy|...
/pat   /play fly|ball   /screen clock|focus|tasks|habits|pc|game|info|face
/weather   /city Chennai|auto   /name Sudarsan   /tz IST-5:30|auto
/brightness 0-255   /sleep   /wake   /unpair   /info   /resets   /reboot   /wifireset
USB only: /wifi SSID|password   /sim tap|double|triple|long|vlong   /state
```

## AI agent buddy (Claude Code first; Copilot / Cursor / Codex next)

```bash
python3 pc_agent/lilmate_agent.py install-claude       # once (backs up ~/.claude/settings.json first)
python3 pc_agent/lilmate_agent.py run                  # bridge: USB cable (office) or Wi-Fi (home)
python3 pc_agent/lilmate_agent.py test-agent           # demo session
```
| Claude Code | lil.mate |
|---|---|
| you send a prompt | thinking face + `project 1m20` timer; after 45 s it suggests a micro-break |
| finished | happy face, "project is done! tap = ok" |
| question / waiting | flashes, "Feed me! project needs you"; sad after 1 min; Telegram ping after 2 min |
| permission prompt | **APPROVE?** screen with the command: **hold = allow, 2 taps = deny** (a pat never approves); also Allow/Deny on the dashboard and `/allow <id>` in Telegram. No answer in 30 s → normal terminal prompt |

Hooks never slow Claude down: if lil.mate is off they finish in ~0.07 s. `--no-approve` skips the approve feature;
`--project DIR` installs for one project only; `uninstall-claude` removes everything.
If Claude Code runs in auto mode, it asks for permission rarely, so you mostly see done / needs-you.

### Copilot, Cursor, Codex
```bash
python3 pc_agent/lilmate_agent.py install-copilot     # VS Code agent hooks (preview): working + done
python3 pc_agent/lilmate_agent.py install-cursor      # working + done; add --approve to route shell commands to the buddy
python3 pc_agent/lilmate_agent.py install-codex       # done (Codex only reports "turn complete")
```
Copilot has no "waiting for approval" event, so approve-from-desk is Claude Code (and optional for Cursor).

## Everyday desk life

| Feature | How |
|---|---|
| **Busy face for coworkers** (🚫 + "busy - in the zone") | automatic while you type steadily (≥60% of the last 3 min), in a focus session or in a meeting. Dashboard switch Auto / DND / Off, or `/dnd on|off|auto`. Busy buddies auto-decline game invites and go quiet |
| **Meeting heads-up** | `lilmate_agent.py set-calendar "<private ICS link>"` (Google Calendar: Settings → your calendar → *Secret address in iCal format*; Outlook: *Publish calendar* → ICS). 5-min warning + "meeting now", "Team sync in 9m" on the face, busy during meetings. `/meetings` |
| **Breathe with me** | hold lil.mate 4 s, or `/breathe`: 1 minute of slow breathing (4 s in, 6 s out) |
| **End-of-day wrap-up** | weekdays at `/workend 18:30`: "Work's done?" hold = wrap (summary to Telegram), tap = later. Nudges "working late?" if you keep typing an hour after |
| **Team pings** | TEAM screen: ☕ Tea break / 🍱 Lunch call to everyone (others hold = "I'm in"), or hold a buddy → Play a game / Wave hello. A wave can be waved back with one tap |

`/ok` dismisses whatever is on screen; `/later` postpones the wrap-up.

## Battery

Battery models: Li-ion → TP4056 → switch → ESP32 5V. Optional battery sense: **B+ —100k— GPIO3 —100k— GND**.
- On a computer's USB: full power. Otherwise **battery saver**: Wi-Fi power save, 16 fps, screen off 4 min after sleep (full power during team games).
- With the divider: battery icon (+ charging bolt), 15% alert ("feed me a charger" + Telegram), deep sleep below 3.35 V, touch to wake.
- `/power` shows it; `/power full|saver|auto`; USB console `/sim bat 3.7` simulates a battery for 2 min.

## Office: no Wi-Fi needed

- If the saved Wi-Fi isn't around, lil.mate stays a normal buddy (offline mode) and retries every 5 min.
  The setup hotspot only opens on demand (INFO screen, hold 4 s).
- Plug it into the laptop and run `lilmate_agent.py run`: hooks, PC stats and clock sync go over the USB cable
  (`pip install pyserial`). It shows up as a plain USB serial device; no driver.

## Play with your team (buddy to buddy, no router)

Buddies talk directly over ESP-NOW (~20–50 m indoors). **PLAY screen**: tap = next buddy, hold = invite.
The other buddy flashes "Sudarsan wants to play!": hold = yes, 2 taps = no. Best of 3: **Quick Draw**
(tap first after GO, too early = foul) and **Tug of War** (tap fast for 7 s). Keyboard: Space on the dashboard.
`lil.bot` is always there to practise against.
Both buddies must be offline (radio channel 1) or on the same Wi-Fi, and in the same team (`/team name`, default `lilmate`).

## PC agent

```bash
python3 pc_agent/lilmate_agent.py                 # CPU/RAM/battery on the PC screen + focus guard
python3 pc_agent/lilmate_agent.py say "Lunch!"    # message on the OLED
python3 pc_agent/lilmate_agent.py done -- make    # Lilmate tells you when a long command finishes
```
**Focus guard:** during a focus session, if the active window is YouTube, Instagram, Netflix and so on,
Lilmate gets angry and says "Back to focus!". This needs X11 `xdotool` on Linux; it works natively on macOS and Windows.

## How it maps to Troko

| Troko | Lilmate OS |
|---|---|
| Voice chat via the xiaozhi cloud | Telegram chat + phone dashboard (no mic or speaker) |
| ~18 expressions, idle games | 16 tweened moods, blink and glances, fly and ball toys, pet happiness, Star Catch game |
| Tasks, habits, reminders, timers | Same, with natural-language reminders and daily repeats |
| Pomodoro (testing) | Full 25/5 focus cycle with stats, plus a focus guard |
| Telegram alerts and commands | Same, plus a reply keyboard and a morning summary |
| Weather idle screen | Clock + Open-Meteo weather, auto location and timezone |
| Troko Center (USB web flasher) | Wi-Fi setup QR, `lilmate.local` dashboard, browser firmware update |
| PC agent (open apps, tidy files) | PC stats, focus guard, `say` and `done` notifications |
| Daily summary (planned) | Done |
| Web search, music, camera | Not possible without a mic or speaker (see xiaozhi + INMP441/MAX98357A path) |

## Files

`lilmate_os.ino` main loop · `face.h` eye engine · `touch.h` gestures · `apps.h` screens, focus, alerts, game, brain ·
`commands.h` command language · `net.h` Wi-Fi, weather, Telegram task · `web.h` dashboard and API · `store.h` NVS storage

Notes: the dashboard has no password, so anyone on your Wi-Fi can use it. The Telegram connection uses TLS without
certificate pinning (the C3 build has no CA bundle).
