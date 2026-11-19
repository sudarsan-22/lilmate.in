// Renders the lilmate.in logo mark into the app + tray icons.  Run:  npx electron scripts/make-icons.js
const { app, BrowserWindow } = require('electron');
const fs = require('fs'), path = require('path');
const MARK = `<svg viewBox="1.5 -16.5 83 60.5" width="350" height="255" style="overflow:visible" fill="none" stroke="#24130f" stroke-linecap="round">
  <path stroke-width="6" d="M6 40C6 18 18 6 32 6C46 6 58 18 58 40"/>
  <path stroke-width="5" d="M21 31Q24.5 25 28 31M36 31Q39.5 25 43 31"/>
  <g transform="translate(56 -16) scale(.7)" stroke="#f7931e" stroke-width="6.5"><path d="M14 4L11 15M30 9L21 18M36 25L25 28"/></g></svg>`;
const html = `<html><body style="margin:0;background:transparent"><div style="width:512px;height:512px;display:grid;place-items:center">
  <div style="width:448px;height:448px;border-radius:104px;background:#fff8ee;box-shadow:inset 0 0 0 3px rgba(36,19,15,.08);display:grid;place-items:center;box-sizing:border-box">${MARK}</div></div></body></html>`;
app.disableHardwareAcceleration();
app.whenReady().then(async () => {
  const w = new BrowserWindow({ width: 512, height: 512, show: false, transparent: true, frame: false, webPreferences: { offscreen: true } });
  await w.loadURL('data:text/html;charset=utf-8,' + encodeURIComponent(html));
  await new Promise(r => setTimeout(r, 600));
  const img = await w.webContents.capturePage({ x: 0, y: 0, width: 512, height: 512 });
  const out = path.join(__dirname, '..', 'assets');
  const big = img.resize({ width: 512, height: 512, quality: 'best' });
  fs.writeFileSync(path.join(out, 'icon.png'), big.toPNG());
  fs.writeFileSync(path.join(out, 'icon-256.png'), big.resize({ width: 256, quality: 'best' }).toPNG());
  fs.writeFileSync(path.join(out, 'tray.png'), big.resize({ width: 32, quality: 'best' }).toPNG());
  fs.writeFileSync(path.join(out, 'tray@2x.png'), big.resize({ width: 64, quality: 'best' }).toPNG());
  console.log('icons written'); app.quit();
});
