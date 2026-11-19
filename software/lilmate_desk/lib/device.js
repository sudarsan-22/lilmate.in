// Link to the lil.mate buddy: USB cable (serial lines) or Wi-Fi (HTTP). Same API either way.
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

class UsbLink extends EventEmitter {
  constructor(path) {
    super();
    this.kind = 'usb'; this.path = path; this.buf = ''; this.queue = []; this.alive = false;
  }
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
    if (!line.startsWith('@')) this.emit('log', line);
  }
  _failAll(why) { for (const w of this.queue) { clearTimeout(w.timer); w.reject(new Error(why)); } this.queue = []; }
  _request(line, tag, ms = 2500) {
    return new Promise((resolve, reject) => {
      if (!this.alive) return reject(new Error('usb closed'));
      if (this.updating) return reject(new Error('updating'));
      const w = { tag, resolve, reject };
      w.timer = setTimeout(() => { this.queue = this.queue.filter(x => x !== w); reject(new Error('usb timeout')); }, ms);
      this.queue.push(w);
      this.port.write(line.replace(/\n/g, ' ') + '\n');
    });
  }
  _send(line) { if (this.alive && !this.updating) this.port.write(line.replace(/\n/g, ' ') + '\n'); }
  state() { return this._request('@state', '@st', 3000); }
  async cmd(text) { const r = await this._request('@cmd ' + text, '@re', 4000); return r.r; }
  event(ev) { this._send('@ev ' + JSON.stringify(ev)); return Promise.resolve(true); }
  pc(p) { this._send('@pc ' + JSON.stringify(p)); return Promise.resolve(); }
  cal(evs) { this._send('@cal ' + JSON.stringify({ ev: evs })); return Promise.resolve(); }
  syncTime() { this._send('/time ' + Math.floor(Date.now() / 1000)); }
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

class WifiLink extends EventEmitter {
  constructor(host) { super(); this.kind = 'wifi'; this.host = host; this.alive = true; }
  async _fetch(path, opts = {}, ms = 3000) {
    const ctl = new AbortController(); const t = setTimeout(() => ctl.abort(), ms);
    try { const r = await fetch(`http://${this.host}${path}`, { ...opts, signal: ctl.signal }); return await r.text(); }
    finally { clearTimeout(t); }
  }
  async state() { return JSON.parse(await this._fetch('/api/state')); }
  cmd(text) { return this._fetch('/api/cmd', { method: 'POST', headers: { 'Content-Type': 'text/plain' }, body: text }, 5000); }
  async event(ev) { await this._fetch('/api/agent', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(ev) }); return true; }
  async decision(rid) { return JSON.parse(await this._fetch('/api/agent/decision?rid=' + rid)).d; }
  async pc(p) { await this._fetch('/api/pc', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(p) }); }
  async cal(evs) { await this._fetch('/api/cal', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ ev: evs }) }); }
  syncTime() {}
  setWifi() {}
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
  try { const l = new WifiLink(host); const s = await l.state(); return s && s.fw ? l : null; } catch (e) { return null; }
}

// Try USB first (works without any network), then saved / discovered Wi-Fi addresses.
async function connect(settings) {
  const port = settings.forceWifi ? null : await findUsbPort();
  if (port) {
    try { const l = await new UsbLink(port).open(); l.syncTime(); return l; } catch (e) { /* busy or no permission */ }
  }
  for (const cand of [settings.host, 'lilmate.local']) {
    const ip = await resolveHost(cand);
    if (!ip) continue;
    const l = await wifiAlive(ip);
    if (l) return l;
  }
  return null;
}

module.exports = { connect, findUsbPort, UsbLink, WifiLink };
