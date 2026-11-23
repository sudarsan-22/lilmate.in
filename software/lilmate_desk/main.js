// lil.mate Desk — main process: top-of-screen island, link to the buddy, hook server, one-click setup
'use strict';
const { app, BrowserWindow, ipcMain, screen, Tray, Menu, nativeImage, powerMonitor, shell } = require('electron');
const fs = require('fs');
const os = require('os');
const path = require('path');
const device = require('./lib/device');
const hooks = require('./lib/hooks');
const server = require('./lib/server');
const { fetchCalendar } = require('./lib/ics');
const updater = require('./lib/updater');
const tidy = require('./lib/tidy');

if (process.platform === 'linux') {
  app.commandLine.appendSwitch('no-sandbox');                 // Ubuntu 24+ blocks the setuid sandbox for AppImages
  app.commandLine.appendSwitch('enable-transparent-visuals');
  app.commandLine.appendSwitch('enable-experimental-web-platform-features');   // Web Bluetooth on Linux (BlueZ); on by default on Windows / macOS
}
const primary = app.requestSingleInstanceLock();
if (!primary) app.exit(0);   // another copy is running (e.g. autostart + a manual start): leave before touching the USB port

// ------------------------------------------------------------ settings
const SETTINGS = path.join(app.getPath('userData'), 'settings.json');
let settings = { host: '', forceWifi: false, ics: '', autostart: true, approve: true, first: true, autoCheck: true, follow: true, ble: true, buddies: {}, lastBuddy: '' };
try { settings = { ...settings, ...JSON.parse(fs.readFileSync(SETTINGS, 'utf8')) }; } catch (e) {}
// written to a temp file and renamed over: a crash or power cut never leaves half a settings file
function saveSettings() {
  try {
    fs.mkdirSync(path.dirname(SETTINGS), { recursive: true });
    const tmp = SETTINGS + '.tmp';
    fs.writeFileSync(tmp, JSON.stringify(settings, null, 2), { mode: 0o600 }); fs.renameSync(tmp, SETTINGS);
  } catch (e) { log('settings not saved: ' + e.message); }
}

// ------------------------------------------------------------ log + safety net
// A small log in the app's folder (desk.log, kept under ~200 KB) instead of error dialogs: nothing unexpected may take the app down.
const LOG = path.join(app.getPath('userData'), 'desk.log');
function log(msg) {
  const line = `${new Date().toISOString()} ${msg}\n`;
  try { if (fs.statSync(LOG).size > 200000) fs.renameSync(LOG, LOG + '.old'); } catch (e) {}
  try { fs.appendFileSync(LOG, line); } catch (e) {}
  if (!app.isPackaged) process.stderr.write(line);
}
process.on('uncaughtException', e => log('uncaught: ' + (e && e.stack || e)));
device.setLog(log);
process.on('unhandledRejection', e => log('unhandled rejection: ' + (e && e.stack || e)));

// ------------------------------------------------------------ island window
let win = null, tray = null;
const PAD = { x: 16, b: 22 };   // transparent room around the island for its soft shadow
const SIZES = { pill: [240 + 2 * PAD.x, 42 + PAD.b], ask: [460 + 2 * PAD.x, 168 + PAD.b], panel: [800 + 2 * PAD.x, 520 + PAD.b] };
let mode = 'pill';

// Where the island lives: a screen + how far across it (0..1). Dragging changes it; it is remembered.
function anchorDisplay() {
  const all = screen.getAllDisplays();
  const a = settings.anchor;
  if (a) {
    const byId = all.find(d => String(d.id) === String(a.display));
    if (byId) return byId;
    if (a.point) return screen.getDisplayNearestPoint(a.point);   // screen ids can change: fall back to where it was
  }
  return screen.getPrimaryDisplay();
}
const topOf = d => process.platform === 'linux' ? d.workArea.y : d.bounds.y;   // under the GNOME top bar; very top on Windows
// Windows + Linux: the window keeps the panel's size and setShape() cuts it down to the island (outside it, clicks
// go to the apps below). Changing the shape doesn't redraw the window, so there is no blank frame when it opens or
// closes. macOS has no window shapes, so there the window itself is resized.
const USE_SHAPE = process.platform !== 'darwin';
let shown = SIZES.pill;   // the area currently given to the island (shape, or window size on macOS)
// size: the area to give the island right now (default: the current mode's); also tells the page where it sits
function placeWindow(size) {
  if (dragging) return;
  const d = anchorDisplay();
  shown = size || SIZES[mode];
  const [w, h] = USE_SHAPE ? SIZES.panel : shown;
  const frac = settings.anchor && typeof settings.anchor.frac === 'number' ? settings.anchor.frac : 0.5;
  const cx = d.bounds.x + frac * d.bounds.width;
  const x = Math.min(Math.max(cx - w / 2, d.workArea.x), d.workArea.x + d.workArea.width - w);   // never off the screen
  const nb = { x: Math.round(x), y: topOf(d), width: w, height: h }, ob = win.getBounds();
  if (nb.x !== ob.x || nb.y !== ob.y || nb.width !== ob.width || nb.height !== ob.height) win.setBounds(nb);
  const iw = SIZES[mode][0] - 2 * PAD.x, wc = x + w / 2;                                 // keep the island under its anchor, inside the window
  const shift = Math.round(Math.min(Math.max(cx, x + PAD.x + iw / 2), x + w - PAD.x - iw / 2) - wc);
  if (USE_SHAPE) {
    const sx = Math.round(w / 2 + shift - shown[0] / 2);
    win.setShape([{ x: Math.max(0, sx), y: 0, width: Math.min(shown[0], w), height: shown[1] }]);
  }
  send('mode', { m: mode, shift });
}
let dragging = false;
function dragMove(x, y) { dragging = true; const [w, h] = USE_SHAPE ? SIZES.panel : SIZES[mode]; win.setBounds({ x: Math.round(x), y: Math.round(y), width: w, height: h }); }
function dragEnd() {
  const b = win.getBounds(), center = { x: Math.round(b.x + b.width / 2), y: Math.round(b.y + 10) };
  const d = screen.getDisplayNearestPoint(center);
  settings.anchor = { display: String(d.id), frac: Math.min(Math.max((center.x - d.bounds.x) / d.bounds.width, 0), 1), point: center };
  dragging = false; saveSettings(); placeWindow(); rebuildTray();
}
function moveToDisplay(id) { const d = screen.getAllDisplays().find(x => String(x.id) === String(id)) || screen.getPrimaryDisplay();
  settings.anchor = { display: String(d.id), frac: 0.5, point: { x: d.bounds.x + d.bounds.width / 2, y: d.bounds.y } }; saveSettings(); placeWindow(); rebuildTray(); }
function resetPosition() { delete settings.anchor; saveSettings(); placeWindow(); rebuildTray(); }
function displayList() {
  const cur = anchorDisplay(), prim = screen.getPrimaryDisplay();
  return screen.getAllDisplays().sort((a, b) => a.bounds.x - b.bounds.x).map((d, i) => ({ id: String(d.id), label: `Screen ${i + 1} · ${d.bounds.width}×${d.bounds.height}${d.id === prim.id ? ' (main)' : ''}`, current: d.id === cur.id }));
}
// Growing: make the window big first (the new room is transparent), then the island animates into it.
// Shrinking: the island animates first, then the window is trimmed once the animation is over.
const ANIM_MS = 320;   // longest closing animation in app.js (spring CLOSE + fades), then the shape is trimmed
let boundsTimer = null;
function setMode(m) {
  if (!SIZES[m] || !win) return;
  mode = m; clearTimeout(boundsTimer);
  const [cw, ch] = shown, [nw, nh] = SIZES[m];
  if (cw <= nw && ch <= nh) placeWindow();
  else { placeWindow([Math.max(cw, nw), Math.max(ch, nh)]); boundsTimer = setTimeout(() => placeWindow(), ANIM_MS); }
}

function createWindow() {
  win = new BrowserWindow({
    width: SIZES.pill[0], height: SIZES.pill[1], frame: false, transparent: true, resizable: false, movable: false,
    alwaysOnTop: true, skipTaskbar: true, hasShadow: false, show: false, focusable: true, fullscreenable: false,
    backgroundColor: '#00000000', title: 'lil.mate',
    webPreferences: { preload: path.join(__dirname, 'preload.js'), contextIsolation: true, nodeIntegration: false, backgroundThrottling: false },
  });
  win.setAlwaysOnTop(true, 'screen-saver');
  win.setVisibleOnAllWorkspaces(true, { visibleOnFullScreen: true });
  if (process.env.LILMATE_DEBUG) win.webContents.on('console-message', e => console.log('[ui]', e.level, e.message, e.lineNumber));
  win.loadFile(path.join(__dirname, 'renderer', 'index.html'));
  // the island's page crashed or hung: reload it (the island would otherwise just vanish until a restart)
  win.webContents.on('render-process-gone', (_e, d) => { log('island page gone: ' + d.reason); if (!app.isQuitting) setTimeout(() => { if (win && !win.isDestroyed()) win.reload(); }, 500); });
  win.webContents.on('unresponsive', () => { log('island page unresponsive: reloading'); if (win && !win.isDestroyed()) win.webContents.forcefullyCrashRenderer(); });
  win.webContents.on('did-finish-load', () => { if (lastState) send('state', lastState.offline ? lastState : { ...lastState, conn: link ? { kind: link.kind, where: link.where } : undefined }); placeWindow(); });
  win.once('ready-to-show', () => { placeWindow(); win.showInactive(); if (settings.first) setMode('panel'); });
  for (const ev of ['display-metrics-changed', 'display-added', 'display-removed']) screen.on(ev, () => { placeWindow(); rebuildTray(); });
}

function createTray() {
  const img = nativeImage.createFromPath(path.join(__dirname, 'assets', 'tray.png'));
  tray = new Tray(img.isEmpty() ? nativeImage.createEmpty() : img);
  tray.setToolTip('lil.mate Desk');
  rebuildTray();
  tray.on('click', () => setMode(mode === 'panel' ? 'pill' : 'panel'));
}
function rebuildTray() {
  if (!tray) return;
  const menu = () => Menu.buildFromTemplate([
    { label: 'Open lil.mate', click: () => setMode('panel') },
    { label: 'Move island to', submenu: [...displayList().map(d => ({ label: d.label, type: 'radio', checked: d.current, click: () => moveToDisplay(d.id) })), { type: 'separator' }, { label: 'Reset to centre of main screen', click: resetPosition }] },
    { label: upd.app.available ? `Update lil.mate Desk to ${upd.app.latest}` : 'Check for updates', click: () => { setMode('panel'); send('goto', 'settings'); checkUpdates(true); } },
    { label: 'Start at login', type: 'checkbox', checked: !!settings.autostart, click: i => { settings.autostart = i.checked; saveSettings(); applyAutostart(); } },
    { type: 'separator' },
    { label: 'Quit', click: () => { app.isQuitting = true; app.quit(); } },
  ]);
  tray.setContextMenu(menu());
}

function applyAutostart() {
  if (process.platform === 'linux') {
    const dir = path.join(os.homedir(), '.config', 'autostart'); const f = path.join(dir, 'lilmate-desk.desktop');
    const exe = process.env.APPIMAGE || process.execPath;
    if (!app.isPackaged || (!process.env.APPIMAGE && !process.execPath.startsWith('/opt/'))) return;   // only the installed app, never a dev/test copy
    if (settings.autostart) { fs.mkdirSync(dir, { recursive: true }); fs.writeFileSync(f, `[Desktop Entry]\nType=Application\nName=lil.mate Desk\nExec="${exe}" --no-sandbox\nX-GNOME-Autostart-enabled=true\n`); }
    else { try { fs.unlinkSync(f); } catch (e) {} }
  } else if (app.isPackaged) app.setLoginItemSettings({ openAtLogin: !!settings.autostart });
}

// ------------------------------------------------------------ link to the buddy
let link = null, connecting = false, lastState = null, lastStateAt = 0;
const send = (ch, data) => { if (win && !win.isDestroyed()) win.webContents.send(ch, data); };

// Everyone who needs the buddy awaits the same connect attempt (a command sent while it reconnects waits for it
// instead of failing with "not connected").
let connectP = null;
function ensureLink() {
  if (link && link.alive) return Promise.resolve();
  if (!connectP) connectP = connectOnce().catch(e => log('connect: ' + e.message)).finally(() => { connectP = null; });
  return connectP;
}
async function connectOnce() {
  connecting = true;
  try {
    link = await device.connect(settings);
    if (link) {
      const me = link; misses = 0;
      link.on('decision', (rid, d) => resolveAsk(rid, d));
      link.on('lost', () => { if (link === me) link = null; send('link', { kind: 'none' }); });
      send('link', { kind: link.kind, where: link.where });
      calSent = 0;
      // on the cable the buddy hands over its id + Bluetooth key, so it can still link when unplugged (office, no Wi-Fi)
      if (link.kind === 'usb' && await device.learn(link, settings)) saveSettings();
      if (link && link.kind === 'ble' && settings.lastBuddy !== link.id) { settings.lastBuddy = link.id; saveSettings(); }
    }
  } finally { connecting = false; }
}

let polling = false, misses = 0, wifiCheckAt = 0;
async function pollState() {
  if (polling) return;                  // hook events ask for extra polls: never run two at once
  polling = true;
  try { await pollOnce(); } catch (e) { log('poll: ' + e.message); } finally { polling = false; }
}
async function pollOnce() {
  if (link && link.updating) return;
  // on Bluetooth and the cable just got plugged in: switch to the cable (faster, and it charges)
  if (link && link.kind === 'ble' && !connecting && !settings.forceWifi && await device.findUsbPort()) { link.close(); link = null; }
  // on Bluetooth and the same buddy is back on Wi-Fi (checked every 30 s): move to Wi-Fi, so the buddy can switch its
  // Bluetooth off again and keep that memory for updates and Telegram
  if (link && link.kind === 'ble' && !connecting && Date.now() > wifiCheckAt) {
    wifiCheckAt = Date.now() + 30000;
    const w = await device.findWifi(settings);
    if (w && link && link.kind === 'ble' && (!w.id || w.id === link.id)) { log('buddy is back on Wi-Fi: leaving Bluetooth'); link.close(); link = null; }
  }
  await ensureLink();
  if (!link) { send('state', { offline: true, hint: device.hint.text }); return; }
  try {
    const s = await link.state();
    lastState = s; lastStateAt = Date.now();
    noteFirmware(s);
    if (s.ip && s.ip !== '0.0.0.0' && s.ip !== settings.host) { settings.host = s.ip; saveSettings(); }   // remember for Wi-Fi later
    if (s.id && settings.buddies && settings.buddies[s.id] && s.ip && s.ip !== '0.0.0.0' && settings.buddies[s.id].ip !== s.ip) { settings.buddies[s.id].ip = s.ip; saveSettings(); }
    send('state', { ...s, conn: { kind: link.kind, where: link.where } });
    noteGame(s);
    misses = 0;
  } catch (e) {
    // The buddy is sometimes busy for a few seconds (weather, Telegram): one slow answer is not a lost link.
    // Wi-Fi is dropped after 2 misses in a row, cable / Bluetooth after 3; until then the panel keeps the last state
    // instead of blinking "not connected".
    if (link && ++misses >= (link.kind === 'wifi' ? 2 : 3)) {
      log(`link ${link.kind} not answering: ${e.message}`); misses = 0;
      try { link.close(); } catch (x) {} link = null; send('link', { kind: 'none' }); send('state', { offline: true });
    }
  }
}

// ------------------------------------------------------------ games from the keyboard (Star Catcher + team Quick Draw / Tug of War)
// While a game is on, the buddy is asked for the score ~3x a second, and the island takes keyboard focus once so the keys just work.
const LIVE = ['inviting', 'invited', 'countdown', 'round', 'roundend', 'matchend'];
const gameLive = s => !!(s && ((s.game && s.game.on) || (s.link && LIVE.includes(s.link.mode))));
let gameOn = false, gmBusy = false;
let gameFocused = false;
function noteGame(s) {
  gameOn = gameLive(s);
  // take the keys once when play actually starts (not for an invite, which may arrive while you're typing)
  const playing = !!(s && ((s.game && s.game.on) || (s.link && ['countdown', 'round'].includes(s.link.mode))));
  if (playing && !gameFocused && win && !win.isDestroyed()) { win.show(); win.focus(); }
  gameFocused = playing;
}
async function gameTick() {
  if (!gameOn || gmBusy || !link || link.updating) return;
  gmBusy = true;
  try { const g = await link.gm(); lastState = { ...lastState, ...g }; send('game', g); noteGame(lastState); } catch (e) {}
  gmBusy = false;
}
function gameKey(k) { if (link && !link.updating) link.key(k).catch(() => {}); setTimeout(gameTick, 60); }

// ------------------------------------------------------------ PC stats + "in the zone" activity
let prevCpu = null, battery = { level: -1, charging: false };
const activity = [];
function cpuPercent() {
  const t = os.cpus().reduce((a, c) => { for (const k in c.times) a[k] = (a[k] || 0) + c.times[k]; return a; }, {});
  const total = Object.values(t).reduce((a, b) => a + b, 0), idle = t.idle;
  let p = 0; if (prevCpu) { const dt = total - prevCpu.total; p = dt ? 100 * (1 - (idle - prevCpu.idle) / dt) : 0; }
  prevCpu = { total, idle }; return Math.round(p * 10) / 10;
}
const sampleActivity = () => { activity.push(powerMonitor.getSystemIdleTime() < 3 ? 1 : 0); if (activity.length > 180) activity.shift(); };   // started in whenReady
async function pushPc() {
  if (!link || link.updating) return;
  const act = activity.length ? Math.round(activity.reduce((a, b) => a + b, 0) / activity.length * 100) / 100 : 0;
  const p = { cpu: cpuPercent(), ram: Math.round((1 - os.freemem() / os.totalmem()) * 1000) / 10, bat: battery.level, charging: battery.charging,
              host: os.hostname().slice(0, 20), title: '', act };
  try { await link.pc(p); } catch (e) {}
}

// ------------------------------------------------------------ calendar
let calEvents = null, calFetched = 0, calSent = 0;
async function calendarTick() {
  if (!settings.ics) return;
  if (Date.now() - calFetched > 600000) {
    calFetched = Date.now();
    try { calEvents = await fetchCalendar(settings.ics); } catch (e) { calEvents = calEvents || null; }
  }
  if (link && !link.updating && calEvents && Date.now() - calSent > 600000) { calSent = Date.now(); try { await link.cal(calEvents); } catch (e) {} }
}

// ------------------------------------------------------------ approvals (Claude PermissionRequest, Cursor shell)
const pending = new Map();   // rid -> { resolve, timer, poll, ev }
let modeBeforeAsk = 'pill';
function resolveAsk(rid, d) {
  const p = pending.get(rid); if (!p) return;
  pending.delete(rid); clearTimeout(p.timer); clearInterval(p.poll);
  p.resolve(d === 'allow' || d === 'deny' ? d : null);
  send('asks', [...pending.values()].map(x => x.ev));
  if (!pending.size && mode === 'ask') setMode(modeBeforeAsk === 'panel' ? 'panel' : 'pill');
}
async function ask(ev) {
  await ensureLink();
  const rid = 1000 + Math.floor(Math.random() * 998000), ttl = 30;
  const full = { ...ev, ev: 'perm', rid, ttl };
  if (link) { try { await link.event(full); } catch (e) {} }
  return new Promise(resolve => {
    const p = { resolve, ev: { ...full, at: Date.now() } };
    p.timer = setTimeout(() => { if (link) link.event({ ...ev, ev: 'permdone', rid, answered: false }).catch(() => {}); resolveAsk(rid, null); }, ttl * 1000);
    if (link && link.kind === 'wifi') p.poll = setInterval(async () => { try { const d = await link.decision(rid); if (d === 'allow' || d === 'deny') resolveAsk(rid, d); } catch (e) {} }, 500);
    pending.set(rid, p);
    send('asks', [...pending.values()].map(x => x.ev));
    if (mode !== 'ask') { modeBeforeAsk = mode; setMode('ask'); }   // urgent: always shown, even over the open panel
  });
}
async function decideFromDesktop(rid, d) {
  if (!pending.has(rid)) return false;
  if (link) { try { await link.cmd(`/${d === 'allow' ? 'allow' : 'deny'} ${rid}`); } catch (e) {} }   // clears the buddy's prompt too
  resolveAsk(rid, d);
  return true;
}

// AI tools fire a "tool" event for every single tool call (several a second when busy). They only mean "still working",
// so at most one per session goes to the buddy every 2 s; every other event goes at once.
const lastTool = new Map();
const appApi = {
  event: ev => {
    if (ev && ev.ev === 'tool') {
      const k = ev.sid || '', t = Date.now();
      if (t - (lastTool.get(k) || 0) < 2000) return;
      lastTool.set(k, t); if (lastTool.size > 50) lastTool.delete(lastTool.keys().next().value);
    }
    ensureLink().then(() => link && link.event(ev).catch(() => {})); setTimeout(pollState, 300);
  },
  ask, link: () => link,
  cmd: async text => { await ensureLink(); if (!link) return 'lil.mate is not connected'; try { return await link.cmd(text); } catch (e) { return "lil.mate didn't answer, try again"; } },
};


// ------------------------------------------------------------ updates (app + buddy firmware) from our GitHub releases
const upd = { checking: false, checkedAt: 0, error: '', notes: '', kind: updater.installKind(),
  app: { current: app.getVersion(), latest: null, available: false },
  fw: { current: null, latest: null, available: false },
  busy: null };                                   // { what: 'app'|'fw', stage, pct }
let manifest = null;
function pushUpd() { send('update', upd); rebuildTray(); }
function noteFirmware(s) {
  const v = updater.fwVersion(s); if (!v) return;
  if (upd.busy && upd.busy.what === 'fw' && upd.busy.stage === 'restarting' && v === upd.busy.to) { upd.busy = null; upd.fw.current = v; upd.fw.available = false; pushUpd(); send('toast', `lil.mate is on ${v} now`); return; }
  if (v !== upd.fw.current) { upd.fw.current = v; upd.fw.available = !!(upd.fw.latest && updater.newer(upd.fw.latest, v)); pushUpd(); }
}
async function checkUpdates(manual) {
  if (upd.checking || upd.busy) return upd;
  upd.checking = true; upd.error = ''; pushUpd();
  try {
    manifest = await updater.fetchManifest();
    upd.notes = manifest.notes || ''; upd.date = manifest.date || '';
    upd.app.latest = manifest.version;
    upd.app.available = updater.newer(manifest.version, upd.app.current) && !!(manifest.app && manifest.app[upd.kind]);
    upd.fw.latest = manifest.firmware ? manifest.firmware.version : null;
    upd.fw.available = !!(upd.fw.latest && upd.fw.current && updater.newer(upd.fw.latest, upd.fw.current));
  } catch (e) { upd.error = manual ? (e.message.includes('fetch') || e.message.includes('ERR_') ? 'Could not reach the update server. Check the internet.' : e.message) : ''; }
  upd.checking = false; upd.checkedAt = Date.now(); pushUpd();
  return upd;
}
async function updateApp() {
  if (upd.busy) return;
  if (!manifest) await checkUpdates(true);
  const entry = manifest && manifest.app && manifest.app[upd.kind];
  if (upd.kind === 'dev') { upd.error = 'This is the developer copy: updates install in the real app'; return pushUpd(); }
  if (!entry) { upd.error = 'No update for this computer yet'; return pushUpd(); }
  upd.busy = { what: 'app', stage: 'downloading', pct: 0 }; upd.error = ''; pushUpd();
  try {
    const file = await updater.download(entry, p => { upd.busy.pct = Math.round(p * 100); send('update', upd); });
    upd.busy = { what: 'app', stage: 'installing', pct: 100 }; pushUpd();
    if (process.env.LILMATE_UPDATE_DRYRUN) { upd.busy = null; upd.error = 'dry run: downloaded ' + file; return pushUpd(); }
    const r = await updater.installApp(file, upd.kind);
    if (r.ok && r.restart) { app.relaunch(r.execPath ? { execPath: r.execPath, args: process.argv.slice(1) } : undefined); app.isQuitting = true; app.exit(0); return; }
    if (r.ok && r.quit) { app.isQuitting = true; app.quit(); return; }
    upd.busy = null; upd.error = r.error; pushUpd();
  } catch (e) { upd.busy = null; upd.error = e.message; pushUpd(); }
}
async function updateFirmware(force) {
  if (upd.busy) return;
  if (!manifest) await checkUpdates(true);
  const fw = manifest && manifest.firmware;
  if (!fw) { upd.error = 'No lil.mate firmware in this release'; return pushUpd(); }
  await ensureLink();
  if (!link) { upd.error = 'Connect lil.mate first (USB cable or same Wi-Fi)'; return pushUpd(); }
  if (link.kind === 'ble' && !settings.host) { upd.error = 'Plug lil.mate in with the USB cable to update it (Bluetooth is too slow for that)'; return pushUpd(); }
  if (!force && upd.fw.current && !updater.newer(fw.version, upd.fw.current)) { upd.error = 'lil.mate is already up to date'; return pushUpd(); }
  upd.busy = { what: 'fw', stage: 'downloading', pct: 0, to: fw.version }; upd.error = ''; pushUpd();
  try {
    const file = await updater.download(fw, p => { upd.busy.pct = Math.round(p * 100); send('update', upd); });
    const bin = fs.readFileSync(file); fs.rmSync(path.dirname(file), { recursive: true, force: true });
    const md5 = require('crypto').createHash('md5').update(bin).digest('hex');
    if (fw.md5 && fw.md5 !== md5) throw new Error('Download did not match, try again');
    upd.busy = { what: 'fw', stage: 'sending', pct: 0, to: fw.version, via: link.kind }; pushUpd();
    const prog = p => { upd.busy.pct = Math.round(p * 100); send('update', upd); };
    log(`firmware ${fw.version}: sending over ${link.kind}`);
    try {
      try { await link.flash(bin, md5, prog); }
      catch (e) {
        if (e.old && settings.host) {                           // older firmware has no cable update: use Wi-Fi once
          upd.busy.via = 'wifi'; pushUpd();
          await new device.WifiLink(settings.host).flash(bin, md5, prog);
        } else if (link && link.kind === 'wifi') {
          // one more go: a Wi-Fi upload that broke off earlier leaves the buddy's update open, and the next one
          // fails with "Not Enough Space" while closing it (firmware before 0.3.3), so the second try goes through
          log(`firmware ${fw.version}: ${e.message}, trying once more`);
          upd.busy.pct = 0; pushUpd();
          await new Promise(r => setTimeout(r, 2500));
          await new device.WifiLink(link.host).flash(bin, md5, prog);
        } else throw e;
      }
    } catch (e) { log(`firmware ${fw.version}: failed: ${e.message}`); throw e; }
    log(`firmware ${fw.version}: sent, lil.mate restarting`);
    upd.busy = { what: 'fw', stage: 'restarting', pct: 100, to: fw.version }; pushUpd();
    if (link && link.kind === 'wifi') { link.close(); link = null; }
    setTimeout(() => { if (upd.busy && upd.busy.stage === 'restarting') { upd.busy = null; upd.error = 'lil.mate restarted but has not reported back yet'; pushUpd(); } }, 60000);
  } catch (e) { upd.busy = null; upd.error = e.message; pushUpd(); }
}

// ------------------------------------------------------------ eyes follow the mouse (island + the buddy)
let lastCur = null, lastLook = 0;
function cursorTick() {
  if (!win || win.isDestroyed()) return;
  const p = screen.getCursorScreenPoint();
  if (lastCur && Math.abs(p.x - lastCur.x) + Math.abs(p.y - lastCur.y) < 4) return;
  lastCur = p;
  const b = win.getBounds();
  send('cursor', { dx: p.x - (b.x + b.width / 2), dy: p.y - (b.y + 20) });
  if (settings.follow === false || !link || link.updating || Date.now() - lastLook < ({ usb: 250, ble: 400 }[link.kind] || 800)) return;
  lastLook = Date.now();
  const all = screen.getAllDisplays(), minX = Math.min(...all.map(d => d.bounds.x)), maxX = Math.max(...all.map(d => d.bounds.x + d.bounds.width));
  const d = screen.getDisplayNearestPoint(p);
  const x = (p.x - minX) / Math.max(1, maxX - minX) * 2 - 1, y = (p.y - d.bounds.y) / d.bounds.height * 2 - 1;
  link.look(x, y * 0.8).catch(() => {});
}

// ------------------------------------------------------------ tidy Downloads / Desktop
const TIDY_LOG = path.join(app.getPath('userData'), 'tidy-undo.json');
const tidyDirs = () => [{ key: 'downloads', name: 'Downloads', dir: app.getPath('downloads') }, { key: 'desktop', name: 'Desktop', dir: app.getPath('desktop') }];
function tidyLogs() { try { return JSON.parse(fs.readFileSync(TIDY_LOG, 'utf8')); } catch (e) { return {}; } }
function tidyPlan() { const logs = tidyLogs(); return tidyDirs().map(t => { const p = tidy.plan(t.dir); return { key: t.key, name: t.name, dir: t.dir, total: p.total, missing: !!p.missing, groups: Object.fromEntries(Object.entries(p.groups).map(([g, l]) => [g, l.length])), undo: (logs[t.key] || []).length }; }); }
ipcMain.handle('tidy:plan', () => tidyPlan());
ipcMain.handle('tidy:run', (_e, key) => { const t = tidyDirs().find(x => x.key === key); if (!t) return { moved: 0 }; const log = tidy.tidy(t.dir); const logs = tidyLogs(); logs[key] = log; fs.writeFileSync(TIDY_LOG, JSON.stringify(logs)); return { moved: log.length, plan: tidyPlan() }; });
ipcMain.handle('tidy:undo', (_e, key) => { const logs = tidyLogs(); const back = tidy.undo(logs[key] || []); delete logs[key]; fs.writeFileSync(TIDY_LOG, JSON.stringify(logs)); return { back, plan: tidyPlan() }; });
ipcMain.handle('tidy:open', (_e, key) => { const t = tidyDirs().find(x => x.key === key); if (t) shell.openPath(t.dir); });

// ------------------------------------------------------------ IPC from the island UI
ipcMain.handle('mode', (_e, m) => setMode(m));
ipcMain.on('game:key', (_e, k) => { if (/^[LRTX]$/.test(k)) gameKey(k); });
ipcMain.on('game:tap', () => { if (link && !link.updating) link.tap().catch(() => {}); });
ipcMain.on('game:start', () => { gameOn = true; gameKey('T'); if (win && !win.isDestroyed()) win.focus(); });
ipcMain.on('drag:move', (_e, x, y) => dragMove(x, y));
ipcMain.on('drag:end', () => dragEnd());
ipcMain.handle('island:displays', () => displayList());
ipcMain.handle('island:move', (_e, id) => moveToDisplay(id));
ipcMain.handle('island:reset', () => resetPosition());
ipcMain.handle('cmd', (_e, text) => appApi.cmd(text));
ipcMain.handle('decide', (_e, rid, d) => decideFromDesktop(rid, d));
ipcMain.handle('hooks:status', () => hooks.status());
ipcMain.handle('hooks:set', (_e, tool, on) => { try { return { ok: true, status: hooks.set(tool, on, { approve: settings.approve }) }; } catch (e) { return { ok: false, error: e.message, status: hooks.status() }; } });
ipcMain.handle('settings:get', () => ({ ...settings, ics: settings.ics ? 'set' : '', buddies: Object.keys(settings.buddies || {}), version: app.getVersion(), platform: process.platform }));
ipcMain.handle('settings:set', async (_e, patch) => {
  if ('ics' in patch) { settings.ics = patch.ics; calFetched = 0; calSent = 0; }
  for (const k of ['host', 'forceWifi', 'autostart', 'approve', 'first', 'autoCheck', 'follow', 'ble']) if (k in patch) settings[k] = patch[k];
  saveSettings(); applyAutostart();
  if ('host' in patch || 'forceWifi' in patch || ('ble' in patch && link && link.kind === 'ble')) { if (link) link.close(); link = null; }
  if ('ics' in patch && settings.ics) { try { calEvents = await fetchCalendar(settings.ics); calFetched = Date.now(); calTick(); return { ok: true, meetings: calEvents }; } catch (e) { return { ok: false, error: 'Could not read that calendar link' }; } }
  return { ok: true };
});
const calTick = () => calendarTick().catch(() => {});
ipcMain.handle('wifi:set', async (_e, ssid, pass) => { await ensureLink(); if (!link || link.kind !== 'usb') return { ok: false, error: 'Plug lil.mate into this computer with the USB cable first' }; link.setWifi(ssid, pass); return { ok: true }; });
// the Wi-Fi this computer is on, to fill in the "Wi-Fi for lil.mate" form (the person only types the password)
ipcMain.handle('wifi:current', () => new Promise(resolve => {
  const { execFile } = require('child_process');
  const [cmd, args, pick] = process.platform === 'win32' ? ['netsh', ['wlan', 'show', 'interfaces'], o => (/^\s*SSID\s*:\s*(.+)$/m.exec(o) || [])[1]]
    : process.platform === 'darwin' ? ['/usr/sbin/networksetup', ['-getairportnetwork', 'en0'], o => (/Network:\s*(.+)$/m.exec(o) || [])[1]]
    : ['nmcli', ['-t', '-f', 'active,ssid', 'dev', 'wifi'], o => (/^yes:(.+)$/m.exec(o) || [])[1]];
  // lil.mate needs the 2.4 GHz network: "Home_5G" usually has a twin called "Home"
  execFile(cmd, args, { timeout: 4000, windowsHide: true }, (err, out) => resolve(err ? '' : (pick(String(out)) || '').trim().replace(/[\s_-]*5\s?G(Hz)?$/i, '')));
}));
ipcMain.handle('open:dashboard', () => { if (settings.host) shell.openExternal(`http://${settings.host}`); });
ipcMain.on('battery', (_e, b) => { battery = b; });
ipcMain.handle('update:get', () => upd);
ipcMain.handle('update:check', () => checkUpdates(true));
ipcMain.handle('update:app', () => updateApp());
ipcMain.handle('update:fw', (_e, force) => updateFirmware(!!force));

// ------------------------------------------------------------ move hooks made by the old Python helper over to this app
function migrateOldHooks() {
  const home = os.homedir();
  const files = { claude: path.join(home, '.claude', 'settings.json'), copilot: path.join(home, '.copilot', 'hooks', 'lilmate.json') };
  for (const [tool, f] of Object.entries(files)) {
    try { if (fs.readFileSync(f, 'utf8').includes('lilmate_agent.py')) { hooks.set(tool, true, { approve: settings.approve }); console.log('[hooks] migrated', tool); } } catch (e) {}
  }
}

// ------------------------------------------------------------ start
app.whenReady().then(() => {
  if (!primary) return;
  createWindow(); createTray(); applyAutostart();
  setInterval(sampleActivity, 1000);
  server.start(appApi);
  migrateOldHooks();
  pollState(); setInterval(pollState, 2000);
  setInterval(gameTick, 300);
  setInterval(pushPc, 5000);
  setInterval(cursorTick, 100);
  setInterval(calTick, 30000); calTick();
  setInterval(() => { if (link && link.kind !== 'wifi') link.syncTime(); }, 6 * 3600000);
  const autoCheck = () => { if (settings.autoCheck !== false) checkUpdates(false); };
  setTimeout(autoCheck, 20000); setInterval(autoCheck, 6 * 3600000);
});
// ------------------------------------------------------------ dev-only screenshot hook (LILMATE_DEBUG=1)
if (process.env.LILMATE_DEBUG) {
  require('http').createServer(async (req, res) => {
    const u = new URL(req.url, 'http://x');
    if (u.searchParams.get('upd')) { res.writeHead(200, { 'Content-Type': 'application/json' }); return res.end(JSON.stringify(upd)); }
    if (u.searchParams.get('bounds')) { res.writeHead(200, { 'Content-Type': 'application/json' }); return res.end(JSON.stringify({ win: win.getBounds(), mode, focused: win.isFocused(), display: screen.getPrimaryDisplay().bounds })); }
    if (u.searchParams.get('key')) { const k = u.searchParams.get('key'); win.webContents.sendInputEvent({ type: 'keyDown', keyCode: k }); win.webContents.sendInputEvent({ type: 'keyUp', keyCode: k }); }
    if (u.searchParams.get('mode')) setMode(u.searchParams.get('mode'));
    if (u.searchParams.get('page')) win.webContents.executeJavaScript(`go(${JSON.stringify(u.searchParams.get('page'))})`);
    if (u.searchParams.get('js')) await win.webContents.executeJavaScript(u.searchParams.get('js')).catch(() => {});
    await new Promise(r => setTimeout(r, +(u.searchParams.get('wait') || 900)));
    const img = await win.webContents.capturePage();
    res.writeHead(200, { 'Content-Type': 'image/png' }); res.end(img.toPNG());
  }).listen(47824, '127.0.0.1');
}
app.on('second-instance', () => setMode('panel'));
app.on('window-all-closed', e => { if (!app.isQuitting) e.preventDefault(); });
app.on('before-quit', () => { app.isQuitting = true; try { if (link) link.close(); } catch (e) {} });   // release the USB port / Bluetooth cleanly
