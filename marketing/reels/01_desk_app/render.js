// Renders reel.html frame by frame (headless Chromium) and pipes the frames into ffmpeg.
// usage: NODE_PATH=<dir with playwright-core> node render.js [out.mp4] [--stills 1,7.6,10.5] [--from 0 --to 22]
const { chromium } = require('playwright-core');
const { spawn } = require('child_process');
const path = require('path');
const os = require('os');

const FPS = 30, DUR = 22;
const args = process.argv.slice(2);
const opt = k => { const i = args.indexOf(k); return i >= 0 ? args[i + 1] : null; };
const out = args[0] && !args[0].startsWith('--') ? args[0] : path.join(__dirname, 'out', 'video_only.mp4');
const stills = opt('--stills');
const from = +(opt('--from') || 0), to = +(opt('--to') || DUR);
const exe = process.env.CHROME || path.join(os.homedir(), '.cache/ms-playwright/chromium-1254/chrome-linux64/chrome');

(async () => {
  const browser = await chromium.launch({ executablePath: exe, args: ['--force-color-profile=srgb', '--font-render-hinting=none'] });
  const page = await browser.newPage({ viewport: { width: 1080, height: 1920 }, deviceScaleFactor: 1 });
  page.on('console', m => console.log('[page]', m.text()));
  page.on('pageerror', e => { console.error('[page error]', e.message); process.exit(1); });
  await page.goto('file://' + path.join(__dirname, 'reel.html'));
  console.log('measured', JSON.stringify(await page.evaluate(() => setup())));

  if (stills) {
    for (const s of stills.split(',')) {
      await page.evaluate(t => render(t), +s);
      const f = path.join(path.dirname(out), `still_${s}.png`);
      await page.screenshot({ path: f });
      console.log('still', f);
    }
    return browser.close();
  }

  const ff = spawn('ffmpeg', ['-y', '-loglevel', 'error', '-f', 'image2pipe', '-framerate', String(FPS), '-c:v', 'png', '-i', '-',
    '-c:v', 'libx264', '-preset', 'slow', '-crf', '15', '-pix_fmt', 'yuv420p', '-profile:v', 'high',
    '-colorspace', 'bt709', '-color_primaries', 'bt709', '-color_trc', 'bt709', '-movflags', '+faststart', out], { stdio: ['pipe', 'inherit', 'inherit'] });
  const n0 = Math.round(from * FPS), n1 = Math.round(to * FPS), t0 = Date.now();
  for (let n = n0; n < n1; n++) {
    await page.evaluate(t => render(t), n / FPS);
    const buf = await page.screenshot({ type: 'png' });
    if (!ff.stdin.write(buf)) await new Promise(r => ff.stdin.once('drain', r));
    if (n % 60 === 0) console.log(`frame ${n}/${n1} (${((Date.now() - t0) / 1000).toFixed(0)}s)`);
  }
  ff.stdin.end();
  await new Promise(r => ff.on('close', r));
  await browser.close();
  console.log('wrote', out);
})();
