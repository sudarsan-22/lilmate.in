// Link to the lil.mate buddy: USB cable or Bluetooth (the same text lines) or Wi-Fi (HTTP). Same API every way.
'use strict';
const { EventEmitter } = require('events');
const dns = require('dns').promises;

let SerialPort = null;
try { ({ SerialPort } = require('serialport')); } catch (e) { /* USB unavailable */ }

const ESPRESSIF_VID = '303a';

async function findUsbPort() {
  if (!SerialPort) return null;
  try {
    const ports = await SerialPort.list();
    const p = ports.find(x => (x.vendorId || '').toLowerCase() === ESPRESSIF_VID);
    return p ? p.path : null;
  } catch (e) { return null; }
}

// The line protocol ("@state" -> "@st {...}", "@cmd x" -> "@re {...}", ...). Subclasses provide _write(text).
class LineLink extends EventEmitter {
  constructor() { super(); this.buf = ''; this.queue = []; this.alive = false; }
  _data(chunk) {
    this.buf += chunk.toString('utf8');
    let i;
    while ((i = this.buf.indexOf('\n')) >= 0) {
      const line = this.buf.slice(0, i).replace(/\r$/, ''); this.buf = this.buf.slice(i + 1);
      this._line(line);
    }
    if (this.buf.length > 20000) this.buf = '';
  }
  _line(line) {
    if (this.hook && this.hook(line)) return;              // firmware update in progress
    if (line.startsWith('@dec ')) { try { const d = JSON.parse(line.slice(5)); this.emit('decision', Number(d.rid), d.d); } catch (e) {} return; }
    const waiting = this.queue[0];
    if (waiting && line.startsWith(waiting.tag)) {
      this.queue.shift(); clearTimeout(waiting.timer);
      try { waiting.resolve(waiting.tag === '@ok' ? true : JSON.parse(line.slice(waiting.tag.length + 1))); } catch (e) { waiting.reject(e); }
      return;
    }
    if (waiting && line.startsWith('@err')) { this.queue.shift(); clearTimeout(waiting.timer); waiting.reject(new Error(line)); return; }
    if (!line.startsWith('@')) this.emit('log', line);
  }
  _failAll(why) { for (const w of this.queue) { clearTimeout(w.timer); w.reject(new Error(why)); } this.queue = []; }
  _request(line, tag, ms = 2500) {
    return new Promise((resolve, reject) => {
      if (!this.alive) return reject(new Error(this.kind + ' closed'));
      if (this.updating) return reject(new Error('updating'));
      const w = { tag, resolve, reject };
      w.timer = setTimeout(() => { this.queue = this.queue.filter(x => x !== w); reject(new Error(this.kind + ' timeout')); }, ms);
      this.queue.push(w);
      this._write(line.replace(/\n/g, ' ') + '\n');
    });
  }
  _send(line) { if (this.alive && !this.updating) this._write(line.replace(/\n/g, ' ') + '\n'); }
  state() { return this._request('@state', '@st', 3000); }
  async cmd(text) { const r = await this._request('@cmd ' + text, '@re', 4000); return r.r; }
  hello() { return this._request('@hello', '@hi', 2500); }   // {fw, name, id} (+ key, ssid, ip over USB)
  event(ev) { this._send('@ev ' + JSON.stringify(ev)); return Promise.resolve(true); }
  pc(p) { this._send('@pc ' + JSON.stringify(p)); return Promise.resolve(); }
  cal(evs) { this._send('@cal ' + JSON.stringify({ ev: evs })); return Promise.resolve(); }
  syncTime() { this._send('/time ' + Math.floor(Date.now() / 1000)); }
  look(x, y) { this._send(`@look ${x.toFixed(2)} ${y.toFixed(2)}`); return Promise.resolve(); }
  key(k) { this._send('@key ' + k); return Promise.resolve(); }          // games from the keyboard (fire and forget = no lag)
  tap() { this._send('@tap'); return Promise.resolve(); }
  gm() { return this._request('@gm', '@gm', 1500); }
}

class UsbLink extends LineLink {
  constructor(path) { super(); this.kind = 'usb'; this.path = path; this.where = path; }
  _write(text) { this.port.write(text); }
  open() {
    return new Promise((resolve, reject) => {
      // default DTR/RTS handling: forcing them low resets the ESP32-C3 (tested on hardware)
      this.port = new SerialPort({ path: this.path, baudRate: 115200, autoOpen: false });
      this.port.open(err => {
        if (err) return reject(err);
        this.alive = true;
        this.port.on('data', d => this._data(d));
        this.port.on('close', () => { this.alive = false; this._failAll('closed'); this.emit('lost'); });
        this.port.on('error', () => {});
        resolve(this);
      });
    });
  }
  setWifi(ssid, pass) { this._send(`/wifi ${ssid}|${pass}`); }
  close() { try { this.port.close(); } catch (e) {} }

  // wait for a line that `match` accepts, after optionally writing something
  _expect(match, ms, write) {
    return new Promise((resolve, reject) => {
      const t = setTimeout(() => { this.hook = null; reject(new Error('lil.mate stopped answering')); }, ms);
      this.hook = line => { if (!match(line)) return false; clearTimeout(t); this.hook = null; resolve(line); return true; };
      if (write) this.port.write(write);
    });
  }
  // firmware update over the cable: "@ota size md5", then 1 KB chunks, each acknowledged
  async flash(bin, md5, onProgress) {
    this.updating = true; this._failAll('updating');
    const CH = 1024, isOta = l => l.startsWith('@ota ');
    try {
      let r;
      try { r = await this._expect(isOta, 6000, `@ota ${bin.length} ${md5}\n`); }
      catch (e) { const x = new Error('This lil.mate needs one update over Wi-Fi first'); x.old = true; throw x; }
      r = JSON.parse(r.slice(5)); if (!r.ok) throw new Error('lil.mate said: ' + r.e);
      for (let off = 0; off < bin.length; off += CH) {
        const line = await this._expect(l => l.startsWith('@ok ') || isOta(l), 10000, bin.subarray(off, off + CH));
        if (isOta(line)) throw new Error('lil.mate said: ' + JSON.parse(line.slice(5)).e);
        onProgress && onProgress(Number(line.slice(4)) / bin.length);
      }
      r = JSON.parse((await this._expect(isOta, 20000)).slice(5));   // checks the whole image + md5
      if (!r.ok || !r.done) throw new Error('lil.mate said: ' + (r.e || 'not finished'));
      return true;
    } finally { this.hook = null; this.updating = false; }
  }
}

// Bluetooth (office, no Wi-Fi): lib/ble.js carries the same lines; "@auth <key>" unlocks the buddy first.
class BleLink extends LineLink {
  constructor(id, key) { super(); this.kind = 'ble'; this.id = id; this.key = key; this.where = 'lil.mate ' + id; }
  _write(text) { this.ble.write(text); }
  async open() {
    this.ble = require('./ble');
    // a scan or GATT connect can hang on some Bluetooth stacks: give up after 20 s so USB / Wi-Fi reconnects aren't blocked
    let timer;
    const c = await Promise.race([this.ble.open([this.id]), new Promise((_, rej) => { timer = setTimeout(() => rej(new Error('Bluetooth took too long')), 20000); })])
      .catch(e => { this.ble.close(); throw e; }).finally(() => clearTimeout(timer));
    this.gen = c.gen; this.where = c.name || this.where;
    this._onData = (g, t) => { if (g === this.gen) this._data(t); };
    this._onGone = g => {   // g = -1: the Bluetooth window itself died
      if ((g !== this.gen && g !== -1) || !this.alive) return;
      this.alive = false; this._off(); this._failAll('closed'); this.emit('lost');
    };
    this.ble.bus.on('data', this._onData); this.ble.bus.on('gone', this._onGone);
    this.alive = true;
    try { await this._request('@auth ' + this.key, '@ok', 4000); }
    catch (e) { this.close(); throw new Error(/key/.test(e.message) ? 'lil.mate did not accept this computer (plug it in by USB once)' : e.message); }
    return this;
  }
  _off() { if (this.ble) { this.ble.bus.off('data', this._onData); this.ble.bus.off('gone', this._onGone); } }
  setWifi() {}
  async flash() { throw new Error('Updates go over the USB cable or Wi-Fi, not Bluetooth from Desk'); }
  close() { this.alive = false; this._off(); if (this.ble) this.ble.close(); this._failAll('closed'); }
}

class WifiLink extends EventEmitter {
  constructor(host) { super(); this.kind = 'wifi'; this.host = host; this.where = host; this.alive = true; this.busy = 0; this.waiting = []; }
  // The buddy's web server answers one request at a time: at most 2 in flight, the rest wait their turn
  // (a burst of requests otherwise times out all together and the link looks dead).
  async _fetch(path, opts = {}, ms = 3000) {
    const t0 = Date.now();
    if (this.busy >= 2) {
      if (this.waiting.length >= 20) throw new Error('lil.mate is busy');   // buddy not answering: don't pile up
      await new Promise(r => this.waiting.push(r));
    }
    // the time limit counts from the call, waiting included: a switched-off buddy must show up as gone quickly
    const left = ms - (Date.now() - t0);
    if (left < 300) { const next = this.waiting.shift(); if (next) next(); throw new Error('lil.mate is not answering'); }
    this.busy++;
    const ctl = new AbortController(); const t = setTimeout(() => ctl.abort(), left);
    try { const r = await fetch(`http://${this.host}${path}`, { ...opts, signal: ctl.signal }); return await r.text(); }
    finally { clearTimeout(t); this.busy--; const next = this.waiting.shift(); if (next) next(); }
  }
  async state() { return JSON.parse(await this._fetch('/api/state?desk=1')); }   // desk=1: if we go quiet, the buddy turns Bluetooth on for us
  cmd(text) { return this._fetch('/api/cmd', { method: 'POST', headers: { 'Content-Type': 'text/plain' }, body: text }, 5000); }
  async event(ev) { await this._fetch('/api/agent', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(ev) }); return true; }
  async decision(rid) { return JSON.parse(await this._fetch('/api/agent/decision?rid=' + rid)).d; }
  async pc(p) { await this._fetch('/api/pc', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(p) }); }
  async cal(evs) { await this._fetch('/api/cal', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ ev: evs }) }); }
  syncTime() {}
  setWifi() {}
  // eyes following the mouse is a nicety: skip it while anything else is on its way, so it never delays the status
  async look(x, y) { if (this.busy) return; await this._fetch(`/api/look?x=${x.toFixed(2)}&y=${y.toFixed(2)}`, { method: 'POST' }, 1500); }
  async key(k) { await this._fetch('/api/game?k=' + k, {}, 1500); }
  async tap() { await this._fetch('/api/link?do=tap', { method: 'POST' }, 1500); }
  async gm() { if (this.busy >= 2) throw new Error('busy'); return { game: JSON.parse(await this._fetch('/api/game', {}, 1500)) }; }   // never queue up score checks   // link state comes with the normal poll
  // firmware update over Wi-Fi: the same /update upload the phone page uses, plus the md5 check
  flash(bin, md5, onProgress) {
    const http = require('http');
    const b = '----lilmate' + Date.now().toString(16);
    const head = Buffer.from(`--${b}\r\nContent-Disposition: form-data; name="fw"; filename="lilmate_os.ino.bin"\r\nContent-Type: application/octet-stream\r\n\r\n`);
    const tail = Buffer.from(`\r\n--${b}--\r\n`);
    this.updating = true;
    return new Promise((resolve, reject) => {
      const req = http.request({ host: this.host, port: 80, path: '/update?md5=' + md5, method: 'POST', timeout: 60000,
        headers: { 'Content-Type': 'multipart/form-data; boundary=' + b, 'Content-Length': head.length + bin.length + tail.length } }, res => {
        let body = ''; res.on('data', d => { body += d; });
        res.on('end', () => { this.updating = false; /Updated/.test(body) ? resolve(true) : reject(new Error(body.replace(/^\W+/, '') || 'update failed')); });
      });
      req.on('error', e => { this.updating = false; reject(new Error('Lost lil.mate on Wi-Fi: ' + e.message)); });
      req.on('timeout', () => req.destroy(new Error('timeout')));
      req.write(head);
      let off = 0; const CH = 16384;
      const pump = () => {
        while (off < bin.length) {
          const ok = req.write(bin.subarray(off, off + CH)); off += CH;
          onProgress && onProgress(Math.min(off, bin.length) / bin.length * 0.97);
          if (!ok) return req.once('drain', pump);
        }
        req.end(tail);
      };
      pump();
    });
  }
  close() {}
}

async function resolveHost(h) {
  if (!h) return null;
  if (/^\d+\.\d+\.\d+\.\d+$/.test(h)) return h;
  try { const r = await dns.lookup(h, { family: 4 }); return r.address; } catch (e) { return null; }
}

async function wifiAlive(host) {
  try { const l = new WifiLink(host); const s = await l.state(); if (!s || !s.fw) return null; l.id = s.id || ''; return l; } catch (e) { return null; }
}

// All Wi-Fi checks at once (last address, a network question, the buddies' names, the old shared name), 3.5 s at most:
// one by one they took ~15 s when the buddy is away (each failed .local lookup waits 5 s), which delayed Bluetooth.
// With several buddies on the same Wi-Fi it prefers ours: the last one used, then any we know, then any.
function findWifi(settings) {
  const known = settings.buddies || {}, want = settings.lastBuddy;
  const lookup = h => Promise.race([resolveHost(h), new Promise(r => setTimeout(() => r(null), 2500))]);
  return new Promise(resolve => {
    const got = [], tried = new Set(); let open = 0, done = false;
    const finish = () => {
      if (done) return; done = true; clearTimeout(deadline);
      const rank = l => (want && l.id === want ? 0 : known[l.id] ? 1 : 2);
      resolve(got.sort((a, b) => rank(a) - rank(b))[0] || null);
    };
    const probe = ip => {
      if (!ip || tried.has(ip) || done) return;
      tried.add(ip); open++;
      wifiAlive(ip).then(l => { if (l) got.push(l); if (l && (!want || l.id === want)) finish(); })
        .finally(() => { if (--open === 0 && pending === 0) finish(); });
    };
    let pending = 0;
    const later = p => { pending++; p.then(x => { pending--; [].concat(x || []).forEach(probe); if (open === 0 && pending === 0) finish(); }); };
    later(lookup(settings.host));
    later(require('./mdns').discover(1200).then(f => f.map(x => x.ip)));
    for (const id of Object.keys(known)) later(lookup(`lilmate-${id}.local`));
    later(lookup('lilmate.local'));                                              // firmware before 0.3.1
    const deadline = setTimeout(finish, 3500);
  });
}

// Try USB first (works without any network), then saved / discovered Wi-Fi addresses, then Bluetooth.
// settings.buddies = { "<id>": { key, name, ssid, ip } }: learnt over USB (see learn()); Bluetooth needs the key.
let bleRetryAt = 0;
let log = () => {};
const hint = { text: '' };   // why we can't link, for the panel (e.g. the buddy refused our Bluetooth key)
const setLog = f => { log = f; };   // main.js hands in its desk.log writer
async function connect(settings) {
  const port = settings.forceWifi ? null : await findUsbPort();
  if (port) {
    try { const l = await new UsbLink(port).open(); l.syncTime(); return l; } catch (e) { /* busy or no permission */ }
  }
  const mine = settings.lastBuddy;
  const w = process.env.LILMATE_NO_WIFI ? null : await findWifi(settings);   // LILMATE_NO_WIFI: test the Bluetooth path
  if (w && (!mine || !w.id || w.id === mine)) return w;
  // our buddy isn't on Wi-Fi: reach it over Bluetooth before settling for another buddy that is (two buddies at home)
  const b = await connectBle(settings, !!w);
  return b || w;
}

// Bluetooth: the buddy we used last first. A scan takes up to ~9 s; after a miss the next try is 8 s later
// (unless `now`: another buddy is the only other option, so it's worth a scan right away).
async function connectBle(settings, now) {
  const keyed = Object.entries(settings.buddies || {}).filter(([, b]) => b.key);
  if (settings.ble === false || !keyed.length || (!now && Date.now() < bleRetryAt)) return null;
  keyed.sort(([a], [b]) => (b === settings.lastBuddy) - (a === settings.lastBuddy));
  for (const [id, b] of keyed) {
    const t0 = Date.now();
    try { const l = await new BleLink(id, b.key).open(); l.syncTime(); hint.text = ''; log(`bluetooth: linked ${id} in ${Date.now() - t0} ms`); return l; }
    catch (e) {
      if (/did not accept/.test(e && e.message)) hint.text = 'lil.mate is nearby but doesn\'t know this computer yet: plug it in with the USB cable once, then Bluetooth works by itself.';
      log(`bluetooth: ${id} not reached (${(e && (e.message || e.name)) || (typeof e === 'object' ? JSON.stringify(e) : e)}) after ${Date.now() - t0} ms`);
    }
  }
  bleRetryAt = Date.now() + 8000;
  return null;
}

// Over the USB cable the buddy tells us its id and its Bluetooth key: remember them so Bluetooth works when unplugged.
// Returns true if settings changed.
async function learn(link, settings) {
  if (!link || link.kind !== 'usb') return false;
  let hi; try { hi = await link.hello(); } catch (e) { return false; }
  if (!hi || !hi.id || !hi.key) return false;                     // older firmware: no Bluetooth link yet
  hint.text = '';
  const all = settings.buddies || (settings.buddies = {});
  const before = JSON.stringify(all[hi.id] || {});
  all[hi.id] = { ...(all[hi.id] || {}), key: hi.key, name: hi.name || '', ssid: hi.ssid || '', ip: hi.ip || (all[hi.id] || {}).ip || '' };
  const changed = before !== JSON.stringify(all[hi.id]) || settings.lastBuddy !== hi.id;
  settings.lastBuddy = hi.id;
  return changed;
}

module.exports = { connect, learn, findWifi, setLog, hint, findUsbPort, UsbLink, BleLink, WifiLink };
