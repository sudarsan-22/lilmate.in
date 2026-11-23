// Find lil.mate buddies on the local Wi-Fi without any library: one mDNS question ("_lilmate._tcp.local, who's there?")
// on 224.0.0.251:5353, then read the A records in the answers. Each buddy is called lilmate-<id>.local (id = 4 hex digits).
// Resolves with [{ id, ip }] after `ms`.
'use strict';
const dgram = require('dgram');

function question(name) {
  const head = Buffer.from([0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]);                 // id 0, flags 0, 1 question
  const labels = Buffer.concat(name.split('.').map(l => Buffer.concat([Buffer.from([l.length]), Buffer.from(l)])));
  return Buffer.concat([head, labels, Buffer.from([0, 0, 12, 0, 1])]);              // end of name, type PTR, class IN
}

// read a (possibly compressed) name at offset o; returns [name, offset after it]
function readName(b, o) {
  const parts = []; let jumped = false, end = o, guard = 0;
  while (o < b.length && guard++ < 64) {
    const len = b[o];
    if (len === 0) { if (!jumped) end = o + 1; break; }
    if ((len & 0xc0) === 0xc0) { if (!jumped) end = o + 2; o = ((len & 0x3f) << 8) | b[o + 1]; jumped = true; continue; }
    parts.push(b.toString('utf8', o + 1, o + 1 + len)); o += 1 + len;
  }
  return [parts.join('.'), end];
}

function parse(b, found) {
  if (b.length < 12) return;
  const qd = b.readUInt16BE(4), n = b.readUInt16BE(6) + b.readUInt16BE(8) + b.readUInt16BE(10);
  let o = 12;
  for (let i = 0; i < qd; i++) { o = readName(b, o)[1] + 4; }
  for (let i = 0; i < n && o + 10 <= b.length; i++) {
    const [name, p] = readName(b, o);
    const type = b.readUInt16BE(p), len = b.readUInt16BE(p + 8), data = p + 10;
    const m = /^lilmate-([0-9a-f]{4})\.local$/i.exec(name);
    if (type === 1 && len === 4 && m) found.set(m[1].toLowerCase(), [...b.subarray(data, data + 4)].join('.'));
    o = data + len;
  }
}

function discover(ms = 1500) {
  return new Promise(resolve => {
    const found = new Map();
    let sock;
    const done = () => { try { sock.close(); } catch (e) {} resolve([...found].map(([id, ip]) => ({ id, ip }))); };
    try {
      sock = dgram.createSocket({ type: 'udp4', reuseAddr: true });
      sock.on('error', done);
      sock.on('message', msg => { try { parse(msg, found); } catch (e) {} });
      sock.bind(0, () => {                                                         // any port: answers come back to us directly
        const q = question('_lilmate._tcp.local');
        sock.send(q, 5353, '224.0.0.251'); setTimeout(() => sock.send(q, 5353, '224.0.0.251'), 400);
        setTimeout(done, ms);
      });
    } catch (e) { resolve([]); }
  });
}

module.exports = { discover };
