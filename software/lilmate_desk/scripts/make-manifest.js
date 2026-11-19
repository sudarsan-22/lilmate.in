// Writes lilmate.json (the update manifest) for every file in a release folder.
//   node scripts/make-manifest.js dist/release "What's new"
'use strict';
const fs = require('fs'), path = require('path'), crypto = require('crypto');
const dir = process.argv[2] || 'dist/release', notes = process.argv[3] || 'Bug fixes and improvements';
const version = require('../package.json').version;
const info = f => { const b = fs.readFileSync(path.join(dir, f)); return { file: f, size: b.length, sha256: crypto.createHash('sha256').update(b).digest('hex'), md5: crypto.createHash('md5').update(b).digest('hex') }; };
const files = fs.readdirSync(dir).filter(f => f !== 'lilmate.json');
const pick = re => { const f = files.find(x => re.test(x)); if (!f) return undefined; const { md5, ...e } = info(f); return e; };
const m = { version, notes, date: new Date().toISOString().slice(0, 10), app: {} };
for (const [k, re] of [['deb', new RegExp(`^lilmate-desk-${version}-.*\\.deb$`)], ['appimage', new RegExp(`^lilmate-desk-${version}-.*\\.AppImage$`)],
                       ['win', new RegExp(`^lilmate-desk-${version}-.*\\.exe$`)], ['mac', new RegExp(`^lilmate-desk-${version}-.*\\.dmg$`)]]) { const e = pick(re); if (e) m.app[k] = e; }
const fw = files.find(f => /^lilmate-os-[\d.]+\.bin$/.test(f));
if (fw) m.firmware = { version: fw.match(/^lilmate-os-([\d.]+)\.bin$/)[1], ...info(fw) };
fs.writeFileSync(path.join(dir, 'lilmate.json'), JSON.stringify(m, null, 2) + '\n');
console.log(`lilmate.json: app ${version} [${Object.keys(m.app).join(', ') || 'none'}]` + (m.firmware ? `, firmware ${m.firmware.version}` : ', no firmware'));
