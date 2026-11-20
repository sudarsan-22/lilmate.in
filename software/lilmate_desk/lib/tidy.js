// Tidy up Downloads / Desktop: move loose files into folders by type (Images, Documents, ...).
// Never deletes anything, skips files still downloading or just touched, and the last tidy can be undone.
'use strict';
const fs = require('fs');
const path = require('path');

const TYPES = {
  Images: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic', 'bmp', 'svg', 'tif', 'tiff', 'avif', 'raw'],
  Documents: ['pdf', 'doc', 'docx', 'odt', 'rtf', 'txt', 'md', 'ppt', 'pptx', 'odp', 'pages', 'key', 'epub'],
  Spreadsheets: ['xls', 'xlsx', 'ods', 'csv', 'numbers', 'tsv'],
  Videos: ['mp4', 'mov', 'mkv', 'avi', 'webm', 'm4v', 'wmv'],
  Music: ['mp3', 'wav', 'flac', 'm4a', 'aac', 'ogg', 'opus'],
  Archives: ['zip', 'rar', '7z', 'tar', 'gz', 'tgz', 'xz', 'bz2'],
  Installers: ['exe', 'msi', 'dmg', 'pkg', 'deb', 'rpm', 'appimage', 'apk'],
  '3D and CAD': ['stl', '3mf', 'step', 'stp', 'obj', 'gcode', 'scad', 'f3d', 'dxf'],
  Code: ['py', 'js', 'ts', 'json', 'html', 'css', 'c', 'cpp', 'h', 'ino', 'java', 'sh', 'ipynb', 'yml', 'yaml'],
};
const EXT = {}; for (const [g, list] of Object.entries(TYPES)) for (const e of list) EXT[e] = g;
const SKIP = /\.(crdownload|part|download|tmp|partial|lnk|desktop|url|webloc)$/i;   // in-progress downloads + shortcuts stay put
const RECENT_MS = 2 * 60 * 1000;

function plan(dir) {
  const groups = {};
  let names = [];
  try { names = fs.readdirSync(dir); } catch (e) { return { dir, groups, total: 0, missing: true }; }
  for (const n of names) {
    if (n.startsWith('.') || n.toLowerCase() === 'desktop.ini' || SKIP.test(n)) continue;
    const full = path.join(dir, n);
    let st; try { st = fs.lstatSync(full); } catch (e) { continue; }
    if (!st.isFile() || Date.now() - st.mtimeMs < RECENT_MS) continue;
    const g = EXT[path.extname(n).slice(1).toLowerCase()];
    if (!g) continue;                                  // unknown types are left alone
    (groups[g] = groups[g] || []).push(n);
  }
  return { dir, groups, total: Object.values(groups).reduce((a, l) => a + l.length, 0) };
}

function freeName(dir, name) {
  if (!fs.existsSync(path.join(dir, name))) return name;
  const ext = path.extname(name), base = path.basename(name, ext);
  for (let i = 2; ; i++) { const n = `${base} (${i})${ext}`; if (!fs.existsSync(path.join(dir, n))) return n; }
}

// moves the files; returns the log needed to undo it
function tidy(dir) {
  const p = plan(dir), log = [];
  for (const [g, list] of Object.entries(p.groups)) {
    const to = path.join(dir, g);
    fs.mkdirSync(to, { recursive: true });
    for (const n of list) {
      const from = path.join(dir, n), dest = path.join(to, freeName(to, n));
      try { fs.renameSync(from, dest); log.push({ from, to: dest }); } catch (e) { /* busy or no permission: skip */ }
    }
  }
  return log;
}

function undo(log) {
  let back = 0;
  for (const m of [...log].reverse()) {
    try { if (fs.existsSync(m.to) && !fs.existsSync(m.from)) { fs.renameSync(m.to, m.from); back++; } } catch (e) {}
  }
  for (const d of new Set(log.map(m => path.dirname(m.to)))) { try { if (!fs.readdirSync(d).length) fs.rmdirSync(d); } catch (e) {} }   // only folders it made and left empty
  return back;
}

module.exports = { plan, tidy, undo };
