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

if (process.platform === 'linux') {
  app.commandLine.appendSwitch('no-sandbox');                 // Ubuntu 24+ blocks the setuid sandbox for AppImages
  app.commandLine.appendSwitch('enable-transparent-visuals');
}
if (!app.requestSingleInstanceLock()) app.quit();

// ------------------------------------------------------------ settings
const SETTINGS = path.join(app.getPath('userData'), 'settings.json');
let settings = { host: '', forceWifi: false, ics: '', autostart: true, approve: true, first: true, autoCheck: true };
try { settings = { ...settings, ...JSON.parse(fs.readFileSync(SETTINGS, 'utf8')) }; } catch (e) {}
function saveSettings() { fs.mkdirSync(path.dirname(SETTINGS), { recursive: true }); fs.writeFileSync(SETTINGS, JSON.stringify(settings, null, 2), { mode: 0o600 }); }

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
function placeWindow() {
  if (dragging) return;
  const d = anchorDisplay();
  const [w, h] = SIZES[mode];
  const frac = settings.anchor && typeof settings.anchor.frac === 'number' ? settings.anchor.frac : 0.5;
  const cx = d.bounds.x + frac * d.bounds.width;
  const x = Math.min(Math.max(cx - w / 2, d.workArea.x), d.workArea.x + d.workArea.width - w);   // never off the screen
  win.setBounds({ x: Math.round(x), y: topOf(d), width: w, height: h });
}
let dragging = false;
function dragMove(x, y) { dragging = true; const [w, h] = SIZES[mode]; win.setBounds({ x: Math.round(x), y: Math.round(y), width: w, height: h }); }
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
function setMode(m) { if (!SIZES[m] || !win) return; mode = m; placeWindow(); win.webContents.send('mode', m); }

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
    if (!app.isPackaged) return;                                // never register the dev build
    if (settings.autostart) { fs.mkdirSync(dir, { recursive: true }); fs.writeFileSync(f, `[Desktop Entry]\nType=Application\nName=lil.mate Desk\nExec="${exe}" --no-sandbox\nX-GNOME-Autostart-enabled=true\n`); }
    else { try { fs.unlinkSync(f); } catch (e) {} }
  } else if (app.isPackaged) app.setLoginItemSettings({ openAtLogin: !!settings.autostart });
}

// ------------------------------------------------------------ link to the buddy
let link = null, connecting = false, lastState = null, lastStateAt = 0;
const send = (ch, data) => { if (win && !win.isDestroyed()) win.webContents.send(ch, data); };

async function ensureLink() {
  if ((link && link.alive) || connecting) return;
  connecting = true;
  try {
    link = await device.connect(settings);
    if (link) {
      link.on('decision', (rid, d) => resolveAsk(rid, d));
      link.on('lost', () => { link = null; send('link', { kind: 'none' }); });
      send('link', { kind: link.kind, where: link.kind === 'usb' ? link.path : link.host });
      calSent = 0;
    }
  } finally { connecting = false; }
}

async function pollState() {
  if (link && link.updating) return;
  await ensureLink();
  if (!link) { send('state', { offline: true }); return; }
  try {
    const s = await link.state();
    lastState = s; lastStateAt = Date.now();
    noteFirmware(s);
    if (s.ip && s.ip !== '0.0.0.0' && s.ip !== settings.host) { settings.host = s.ip; saveSettings(); }   // remember for Wi-Fi later
    send('state', { ...s, conn: { kind: link.kind, where: link.kind === 'usb' ? link.path : link.host } });
  } catch (e) {
    if (link && link.kind === 'wifi') link = null;
    send('state', { offline: true });
  }
}

// ------------------------------------------------------------ PC stats + "in the zone" activity
let prevCpu = null, battery = { level: -1, charging: false };
const activity = [];
function cpuPercent() {
  const t = os.cpus().reduce((a, c) => { for (const k in c.times) a[k] = (a[k] || 0) + c.times[k]; return a; }, {});
  const total = Object.values(t).reduce((a, b) => a + b, 0), idle = t.idle;
  let p = 0; if (prevCpu) { const dt = total - prevCpu.total; p = dt ? 100 * (1 - (idle - prevCpu.idle) / dt) : 0; }
  prevCpu = { total, idle }; return Math.round(p * 10) / 10;
}
setInterval(() => { activity.push(powerMonitor.getSystemIdleTime() < 3 ? 1 : 0); if (activity.length > 180) activity.shift(); }, 1000);
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

const appApi = {
  event: ev => { ensureLink().then(() => link && link.event(ev).catch(() => {})); setTimeout(pollState, 300); },
  ask, link: () => link,
  cmd: async text => { await ensureLink(); return link ? link.cmd(text) : 'lil.mate is not connected'; },
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
  if (!force && upd.fw.current && !updater.newer(fw.version, upd.fw.current)) { upd.error = 'lil.mate is already up to date'; return pushUpd(); }
  upd.busy = { what: 'fw', stage: 'downloading', pct: 0, to: fw.version }; upd.error = ''; pushUpd();
  try {
    const file = await updater.download(fw, p => { upd.busy.pct = Math.round(p * 100); send('update', upd); });
    const bin = fs.readFileSync(file); fs.rmSync(path.dirname(file), { recursive: true, force: true });
    const md5 = require('crypto').createHash('md5').update(bin).digest('hex');
    if (fw.md5 && fw.md5 !== md5) throw new Error('Download did not match, try again');
    upd.busy = { what: 'fw', stage: 'sending', pct: 0, to: fw.version, via: link.kind }; pushUpd();
    const prog = p => { upd.busy.pct = Math.round(p * 100); send('update', upd); };
    try { await link.flash(bin, md5, prog); }
    catch (e) {
      if (!(e.old && settings.host)) throw e;                 // older firmware has no cable update: use Wi-Fi once
      upd.busy.via = 'wifi'; pushUpd();
      await new device.WifiLink(settings.host).flash(bin, md5, prog);
    }
    upd.busy = { what: 'fw', stage: 'restarting', pct: 100, to: fw.version }; pushUpd();
    if (link && link.kind === 'wifi') { link.close(); link = null; }
    setTimeout(() => { if (upd.busy && upd.busy.stage === 'restarting') { upd.busy = null; upd.error = 'lil.mate restarted but has not reported back yet'; pushUpd(); } }, 60000);
  } catch (e) { upd.busy = null; upd.error = e.message; pushUpd(); }
}

// ------------------------------------------------------------ IPC from the island UI
ipcMain.handle('mode', (_e, m) => setMode(m));
ipcMain.on('drag:move', (_e, x, y) => dragMove(x, y));
ipcMain.on('drag:end', () => dragEnd());
ipcMain.handle('island:displays', () => displayList());
ipcMain.handle('island:move', (_e, id) => moveToDisplay(id));
ipcMain.handle('island:reset', () => resetPosition());
ipcMain.handle('cmd', (_e, text) => appApi.cmd(text));
ipcMain.handle('decide', (_e, rid, d) => decideFromDesktop(rid, d));
ipcMain.handle('hooks:status', () => hooks.status());
ipcMain.handle('hooks:set', (_e, tool, on) => { try { return { ok: true, status: hooks.set(tool, on, { approve: settings.approve }) }; } catch (e) { return { ok: false, error: e.message, status: hooks.status() }; } });
ipcMain.handle('settings:get', () => ({ ...settings, ics: settings.ics ? 'set' : '', version: app.getVersion(), platform: process.platform }));
ipcMain.handle('settings:set', async (_e, patch) => {
  if ('ics' in patch) { settings.ics = patch.ics; calFetched = 0; calSent = 0; }
  for (const k of ['host', 'forceWifi', 'autostart', 'approve', 'first', 'autoCheck']) if (k in patch) settings[k] = patch[k];
  saveSettings(); applyAutostart();
  if ('host' in patch || 'forceWifi' in patch) { if (link) link.close(); link = null; }
  if ('ics' in patch && settings.ics) { try { calEvents = await fetchCalendar(settings.ics); calFetched = Date.now(); calTick(); return { ok: true, meetings: calEvents }; } catch (e) { return { ok: false, error: 'Could not read that calendar link' }; } }
  return { ok: true };
});
const calTick = () => calendarTick().catch(() => {});
ipcMain.handle('wifi:set', async (_e, ssid, pass) => { await ensureLink(); if (!link || link.kind !== 'usb') return { ok: false, error: 'Plug lil.mate into this computer with the USB cable first' }; link.setWifi(ssid, pass); return { ok: true }; });
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
  createWindow(); createTray(); applyAutostart();
  server.start(appApi);
  migrateOldHooks();
  pollState(); setInterval(pollState, 2000);
  setInterval(pushPc, 5000);
  setInterval(calTick, 30000); calTick();
  setInterval(() => { if (link && link.kind === 'usb') link.syncTime(); }, 6 * 3600000);
  const autoCheck = () => { if (settings.autoCheck !== false) checkUpdates(false); };
  setTimeout(autoCheck, 20000); setInterval(autoCheck, 6 * 3600000);
});
// ------------------------------------------------------------ dev-only screenshot hook (LILMATE_DEBUG=1)
if (process.env.LILMATE_DEBUG) {
  require('http').createServer(async (req, res) => {
    const u = new URL(req.url, 'http://x');
    if (u.searchParams.get('upd')) { res.writeHead(200, { 'Content-Type': 'application/json' }); return res.end(JSON.stringify(upd)); }
    if (u.searchParams.get('bounds')) { res.writeHead(200, { 'Content-Type': 'application/json' }); return res.end(JSON.stringify({ win: win.getBounds(), mode, display: screen.getPrimaryDisplay().bounds })); }
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
