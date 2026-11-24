// Bluetooth transport for lil.mate Desk: a hidden window runs Chromium's Web Bluetooth (renderer/ble.html).
// No native module, so the same code works on Windows, macOS and Linux.
// The buddy advertises as "lil.mate <name> <id>" (id = 4 hex digits of its MAC); we only pick buddies we know.
'use strict';
const { BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const { EventEmitter } = require('events');

const bus = new EventEmitter();
let win = null, ready = null, wanted = [], pick = null;

function ensureWindow() {
  if (win && !win.isDestroyed()) return ready;
  win = new BrowserWindow({ show: false, width: 200, height: 100, skipTaskbar: true,
    webPreferences: { preload: path.join(__dirname, 'ble-preload.js'), contextIsolation: true, sandbox: false, backgroundThrottling: false } });
  // Chromium asks which device to use; we answer with the first known buddy it sees (or nothing after the scan window)
  win.webContents.on('select-bluetooth-device', (event, devices, callback) => {
    event.preventDefault();
    if (!pick) { pick = { callback, timer: setTimeout(() => { const p = pick; pick = null; if (p) p.callback(''); }, 9000) }; }
    else pick.callback = callback;
    const named = x => (x.deviceName || '').toLowerCase();
    // '*pair' / '*setup': any buddy waiting to pair or to be set up ("lil.mate pair <id>", "lil.mate setup <id>"); else one of ours by id
    const d = devices.find(x => wanted.some(id => id === '*pair' ? named(x).startsWith('lil.mate pair ') : id === '*setup' ? named(x).startsWith('lil.mate setup ') : named(x).endsWith(' ' + id)));
    if (d) { clearTimeout(pick.timer); const p = pick; pick = null; p.callback(d.deviceId); }
  });
  // its page crashed: forget the window, the next connect makes a fresh one (and the link reports itself lost)
  win.webContents.on('render-process-gone', () => { const w = win; win = null; bus.emit('gone', -1); try { w.destroy(); } catch (e) {} });
  ready = win.loadFile(path.join(__dirname, '..', 'renderer', 'ble.html'));
  return ready;
}

ipcMain.on('ble:data', (_e, gen, text) => bus.emit('data', gen, text));
ipcMain.on('ble:gone', (_e, gen) => bus.emit('gone', gen));

// Find and connect one of the buddies with these ids. Resolves with { name, gen }, rejects if none answered.
// gen numbers the connection: data and 'gone' events carry it, so an old connection's late events are ignored.
async function open(ids) {
  await ensureWindow();
  wanted = ids.map(x => String(x).toLowerCase());
  // userGesture = true: Web Bluetooth only scans after a gesture; this is the app's own hidden window
  return win.webContents.executeJavaScript('bleConnect()', true);
}
const write = text => { if (win && !win.isDestroyed()) win.webContents.executeJavaScript(`bleWrite(${JSON.stringify(text)})`).catch(() => {}); };
const close = () => { if (win && !win.isDestroyed()) win.webContents.executeJavaScript('bleClose()').catch(() => {}); };

module.exports = { open, write, close, bus };
