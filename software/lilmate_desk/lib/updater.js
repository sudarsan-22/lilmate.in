// Updates for lil.mate Desk and the lil.mate buddy, from the GitHub releases of our repo.
//
// Every release carries a small manifest, lilmate.json:
//   { "version": "0.2.0", "notes": "…", "date": "2026-11-20",
//     "app": { "deb": {file, sha256, size}, "appimage": {…}, "win": {…}, "mac": {…} },
//     "firmware": { "version": "0.2.0", "file": "lilmate-os-0.2.0.bin", "sha256": "…", "md5": "…", "size": 1488224 } }
// It is read from  https://github.com/<repo>/releases/latest/download/lilmate.json  (no API, no rate limit)
// and every file is fetched next to it, then checked against its sha256 before it is used.
'use strict';
const { app, net, shell } = require('electron');
const crypto = require('crypto');
const fs = require('fs');
const os = require('os');
const path = require('path');
const { spawn } = require('child_process');

const pkg = require('../package.json');
const REPO = (pkg.lilmate && pkg.lilmate.updateRepo) || 'lilmate/lilmate-desk';
const FEED = (process.env.LILMATE_UPDATE_FEED || `https://github.com/${REPO}/releases/latest/download/`).replace(/\/?$/, '/');
const RELEASES_PAGE = `https://github.com/${REPO}/releases/latest`;

// "0.10.2" > "0.9.9"; anything after a dash (0.2.0-beta) sorts before the plain version
function newer(a, b) {
  const p = v => String(v || '0').replace(/^v/, '').split('-');
  const [ma, ra] = p(a), [mb, rb] = p(b);
  const na = ma.split('.').map(Number), nb = mb.split('.').map(Number);
  for (let i = 0; i < 3; i++) { if ((na[i] || 0) !== (nb[i] || 0)) return (na[i] || 0) > (nb[i] || 0); }
  if (ra && !rb) return false; if (!ra && rb) return true;
  return (ra || '') > (rb || '');
}
// the firmware reports "ver" (0.2.0+) or only "fw": "Lilmate OS 0.1.0"
function fwVersion(state) {
  if (!state) return null;
  if (state.ver) return state.ver;
  const m = String(state.fw || '').match(/(\d+\.\d+\.\d+)/); return m ? m[1] : null;
}

// how this copy of the app was installed decides which file updates it
function installKind() {
  if (process.env.LILMATE_UPDATE_KIND) return process.env.LILMATE_UPDATE_KIND;   // testing
  if (!app.isPackaged) return 'dev';
  if (process.platform === 'win32') return 'win';
  if (process.platform === 'darwin') return 'mac';
  if (process.env.APPIMAGE) return 'appimage';
  return 'deb';
}

async function fetchManifest() {
  const r = await net.fetch(FEED + 'lilmate.json?t=' + Date.now(), { cache: 'no-store' });
  if (r.status === 404) throw new Error('No releases published yet');
  if (!r.ok) throw new Error(`Update server said ${r.status}`);
  const m = await r.json();
  if (!m || !m.version) throw new Error('The update info looks broken');
  return m;
}

// download a release file into a private temp folder, checking size and sha256
async function download(entry, onProgress) {
  if (!entry || !entry.file || !/^[\w.+-]+$/.test(entry.file) || !/^[0-9a-f]{64}$/i.test(entry.sha256 || '')) throw new Error('The update info looks broken');
  const r = await net.fetch(FEED + entry.file, { cache: 'no-store' });
  if (!r.ok) throw new Error(`Download failed (${r.status})`);
  const total = entry.size || Number(r.headers.get('content-length')) || 0;
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'lilmate-update-'));
  const file = path.join(dir, entry.file);
  const out = fs.createWriteStream(file, { mode: 0o644 });
  const hash = crypto.createHash('sha256');
  const reader = r.body.getReader();
  let got = 0, lastTick = 0;
  try {
    for (;;) {
      const { done, value } = await reader.read();
      if (done) break;
      hash.update(value); got += value.length;
      if (!out.write(Buffer.from(value))) await new Promise(res => out.once('drain', res));
      if (onProgress && Date.now() - lastTick > 150) { lastTick = Date.now(); onProgress(total ? got / total : 0); }
    }
  } finally { await new Promise(res => out.end(res)); }
  if (entry.size && got !== entry.size) throw new Error('Download was incomplete, try again');
  if (hash.digest('hex') !== entry.sha256.toLowerCase()) { fs.rmSync(dir, { recursive: true, force: true }); throw new Error('Download did not match, try again'); }
  onProgress && onProgress(1);
  return file;
}

function run(cmd, args) {
  return new Promise(res => {
    let p; try { p = spawn(cmd, args, { stdio: ['ignore', 'ignore', 'pipe'] }); } catch (e) { return res({ code: -1, err: e.message }); }
    let err = ''; p.stderr.on('data', d => { err += d; });
    p.on('error', e => res({ code: -1, err: e.message }));
    p.on('close', code => res({ code, err }));
  });
}

// put the downloaded app in place; returns { ok, restart } or { ok:false, error, file }
async function installApp(file, kind) {
  if (kind === 'deb') {
    // pkexec shows the system password box; apt keeps dependencies right
    const r = await run('pkexec', ['apt-get', 'install', '-y', '--allow-downgrades', file]);
    if (r.code === 0) return { ok: true, restart: true };
    if (r.code === 126 || r.code === 127) return { ok: false, error: 'Update cancelled', file };   // password box closed / not allowed
    shell.openPath(file);                                    // fall back to the Software app
    return { ok: false, error: 'Opened the installer: click Install there', file };
  }
  if (kind === 'appimage') {
    const target = process.env.APPIMAGE;
    try {
      fs.copyFileSync(file, target + '.new'); fs.chmodSync(target + '.new', 0o755); fs.renameSync(target + '.new', target);
      return { ok: true, restart: true, execPath: target };
    } catch (e) { shell.showItemInFolder(file); return { ok: false, error: 'Could not replace the app file; the new one is in the folder that just opened', file }; }
  }
  if (kind === 'win') {
    // the one-click installer: silent, then starts the new version itself
    spawn(file, ['/S', '--updated', '--force-run'], { detached: true, stdio: 'ignore' }).unref();
    return { ok: true, restart: false, quit: true };
  }
  shell.openExternal(RELEASES_PAGE);
  return { ok: false, error: 'Opened the download page', file };
}

module.exports = { FEED, REPO, RELEASES_PAGE, newer, fwVersion, installKind, fetchManifest, download, installApp };
