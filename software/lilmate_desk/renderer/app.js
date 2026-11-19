'use strict';
const $ = s => document.querySelector(s);
const $$ = s => [...document.querySelectorAll(s)];
const esc = s => String(s ?? '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
let S = {}, U = null, mode = 'pill', pinned = false, asks = [], leaveTimer = null;
// the lilmate.in logo, with eyes that follow the buddy's mood
const EYE = {
  open: '<path d="M24.5 25.5V31"/><path d="M39.5 25.5V31"/>',
  happy: '<path d="M21 31Q24.5 25 28 31"/><path d="M36 31Q39.5 25 43 31"/>',
  laugh: '<path d="M20 31.5Q24.5 23.5 29 31.5"/><path d="M35 31.5Q39.5 23.5 44 31.5"/>',
  sleep: '<path d="M21 28Q24.5 33 28 28"/><path d="M36 28Q39.5 33 43 28"/>',
  sleepy: '<path d="M21 29.5H28"/><path d="M36 29.5H43"/>',
  alert: '<circle cx="24.5" cy="28.5" r="3.2"/><circle cx="39.5" cy="28.5" r="3.2"/>',
  focus: '<path d="M21 27.5L28 29.5"/><path d="M36 29.5L43 27.5"/>',
  angry: '<path d="M21 26.5L28 30"/><path d="M36 30L43 26.5"/>',
  sad: '<path d="M21 30L28 27"/><path d="M36 27L43 30"/>',
  think: '<path d="M26.5 24V28.5"/><path d="M41.5 24V28.5"/>',
  wink: '<path d="M24.5 25.5V31"/><path d="M36 31Q39.5 25 43 31"/>',
};
const EYE_OF = { happy: 'happy', love: 'happy', cool: 'happy', laugh: 'laugh', sleep: 'sleep', sleepy: 'sleepy', alert: 'alert', surprised: 'alert', dizzy: 'alert',
  focus: 'focus', angry: 'angry', sad: 'sad', think: 'think', curious: 'think', wink: 'wink' };
function setFace(el, mood, attn) {
  const off = mood === 'off', eye = off ? 'sleep' : EYE_OF[mood] || 'open', key = eye + (mood === 'love' ? ' love' : '') + (off ? ' off' : '') + (attn ? ' attn' : '');
  if (el.dataset.k === key) return; el.dataset.k = key;
  el.setAttribute('class', 'mark ' + key);
  el.classList.toggle('open', eye === 'open');
  el.innerHTML = '<path class="head" d="M6 40C6 18 18 6 32 6C46 6 58 18 58 40"/><g class="eyes">' + EYE[eye] + '</g>' +
    '<g transform="translate(56 -16) scale(.7)"><g class="spark"><path d="M14 4L11 15"/><path d="M30 9L21 18"/><path d="M36 25L25 28"/></g></g>';
}
setFace($('#pillFace'), 'happy'); setFace($('#avFace'), 'happy'); setFace($('#askFace'), 'alert', true);
const FEEL = { neutral: 'chilling', happy: 'happy', love: 'in love', surprised: 'surprised', angry: 'grumpy', sad: 'a bit sad', sleepy: 'sleepy', sleep: 'napping', think: 'thinking', cool: 'cool', laugh: 'giggly', wink: 'playful', focus: 'focused', alert: 'calling you', dizzy: 'dizzy', curious: 'curious' };

function toast(t) { const e = $('#toast'); e.textContent = t; e.classList.add('on'); clearTimeout(e._t); e._t = setTimeout(() => e.classList.remove('on'), 2600); }
async function run(c) { if (!c.trim()) return; const r = await lil.cmd(c); toast(String(r).split('\n')[0]); }
const fmtWait = s => s < 60 ? s + 's' : Math.floor(s / 60) + 'm' + String(s % 60).padStart(2, '0');
const hhmm = t => new Date(t * 1000).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

// ------------------------------------------------------------ modes (pill / ask / panel)
function setMode(m) { mode = m; document.body.className = 'm-' + m; }
lil.on('mode', setMode);
// hover opens after a short pause (so a grab-to-drag doesn't pop the panel); a click opens at once
let openTimer = null, drag = null;
$('#pill').addEventListener('mouseenter', () => { clearTimeout(openTimer); openTimer = setTimeout(() => { if (!drag) lil.mode('panel'); }, 450); });
$('#pill').addEventListener('mouseleave', () => clearTimeout(openTimer));
// drag the pill (or the lil.mate name in the panel) along the top edge or onto another screen
for (const h of [$('#pill'), $('.me')]) {
  h.addEventListener('pointerdown', e => {
    if (e.button !== 0) return;
    clearTimeout(openTimer);
    drag = { x0: e.screenX, y0: e.screenY, ox: e.screenX - window.screenX, oy: e.screenY - window.screenY, moved: false, el: h };
    h.setPointerCapture(e.pointerId);
  });
  h.addEventListener('pointermove', e => {
    if (!drag) return;
    if (!drag.moved && Math.hypot(e.screenX - drag.x0, e.screenY - drag.y0) < 5) return;
    drag.moved = true; document.body.classList.add('dragging');
    lil.dragMove(e.screenX - drag.ox, e.screenY - drag.oy);
  });
  h.addEventListener('pointerup', () => {
    if (!drag) return;
    const moved = drag.moved, fromPill = drag.el.id === 'pill'; drag = null; document.body.classList.remove('dragging');
    if (moved) lil.dragEnd(); else if (fromPill) lil.mode('panel');
  });
}
$('#panel').addEventListener('mouseleave', () => {
  clearTimeout(leaveTimer);
  leaveTimer = setTimeout(() => { if (!drag && !pinned && !document.activeElement.matches('input, select') && mode === 'panel') lil.mode(asks.length ? 'ask' : 'pill'); }, 700);
});
$('#panel').addEventListener('mouseenter', () => clearTimeout(leaveTimer));
document.addEventListener('keydown', e => { if (e.key === 'Escape') { pinned = false; $('#pin').classList.remove('on'); lil.mode(asks.length ? 'ask' : 'pill'); } });
$('#pin').onclick = () => { pinned = !pinned; $('#pin').classList.toggle('on', pinned); $('#pin').textContent = pinned ? 'Kept open · Esc to close' : 'Keep open'; };

// ------------------------------------------------------------ navigation
function go(p) { $$('#nav a').forEach(a => a.classList.toggle('on', a.dataset.p === p)); $$('main section').forEach(s => s.classList.toggle('on', s.dataset.p === p)); if (p === 'agents') loadTools(); if (p === 'settings') loadSettings(); }
$$('#nav a').forEach(a => a.onclick = () => go(a.dataset.p));

// ------------------------------------------------------------ input
$('#talk').onsubmit = e => { e.preventDefault(); const v = $('#talkIn').value.trim(); if (!v) return; run(v); $('#talkIn').value = ''; };
$$('.addrow').forEach(f => f.onsubmit = e => { e.preventDefault(); const i = f.querySelector('input'); if (!i.value.trim()) return; run(f.dataset.pre + i.value.trim()); i.value = ''; });
$$('[data-c]').forEach(b => b.onclick = () => run(b.dataset.c));
$$('#dnd button').forEach(b => b.onclick = () => run('/dnd ' + b.dataset.d));
document.addEventListener('click', e => { const b = e.target.closest('[data-run]'); if (b) run(b.dataset.run); });

// ------------------------------------------------------------ approvals
lil.on('asks', a => { asks = a; renderAsk(); });
function renderAsk() {
  const a = asks[0]; if (!a) return;
  $('#askTitle').textContent = `${a.tool === 'cursor' ? 'Cursor' : 'Claude'} wants to run`;
  $('#askWhere').textContent = `in ${a.name}${asks.length > 1 ? ` · +${asks.length - 1} more` : ''}`;
  $('#askCmd').textContent = a.msg; $('#askCmd').title = a.msg;
}
$('#askAllow').onclick = () => asks[0] && lil.decide(asks[0].rid, 'allow');
$('#askDeny').onclick = () => asks[0] && lil.decide(asks[0].rid, 'deny');
setInterval(() => { const a = asks[0]; if (a) $('#askTtl').style.width = Math.max(0, 100 - (Date.now() - a.at) / (a.ttl * 10)) + '%'; }, 200);

// ------------------------------------------------------------ state from the buddy
lil.on('state', s => { S = s; render(); });
function render() {
  const off = S.offline;
  const conn = off ? '<span class="dot"></span> not connected' : `<span class="dot ok"></span> ${S.conn && S.conn.kind === 'usb' ? 'USB cable' : 'Wi-Fi'}`;
  $('#conn').innerHTML = conn;
  const agents = S.agents || [], att = agents.find(a => !a.acked && ['needs you', 'approve?', 'done', 'error'].includes(a.st)), work = agents.find(a => a.st === 'working');
  // pill
  const w = S.work || {}, now = Date.now() / 1000, meet = (w.meets || []).find(m => m.e > now);
  let txt = 'lil.mate', attn = false;
  const ub = U && U.busy;
  if (ub && ub.what === 'fw') txt = ub.stage === 'restarting' ? 'lil.mate is restarting…' : `updating lil.mate ${ub.pct}%`;
  else if (off) txt = 'lil.mate · not connected';
  else if (asks.length) { txt = 'needs your OK'; attn = true; }
  else if (att) { attn = att.st !== 'done'; txt = att.st === 'done' ? `${att.name} is done` : `${att.name} needs you`; }
  else if (meet && meet.t - now < 900) txt = meet.t <= now ? `in ${meet.s}` : `${meet.s} in ${Math.ceil((meet.t - now) / 60)}m`;
  else if (work) txt = `${work.name} · ${fmtWait(work.wait)}`;
  else if (w.busy) txt = `busy · ${w.reason}`;
  else if (S.time) txt = S.time + (S.wx && S.wx.ok ? ` · ${Math.round(S.wx.temp)}°` : '');
  $('#pillText').textContent = txt;
  $('#pill').classList.toggle('attn', attn);
  $('#pillDot').className = 'dot ' + (off ? '' : attn ? 'attn' : 'ok');
  setFace($('#pillFace'), off ? 'off' : S.mood, attn); setFace($('#avFace'), off ? 'off' : S.mood);
  if (off) { $('#homeStatus').textContent = 'Looking for lil.mate on USB and Wi-Fi… plug it in with the cable, or add its address in Settings.'; return; }

  // home
  const name = (S.set && S.set.owner) || 'there', hour = new Date().getHours();
  $('#hello').textContent = `${hour < 12 ? 'Good morning' : hour < 17 ? 'Hi' : 'Good evening'}, ${name}`;
  $('#today').textContent = `Your summary · ${new Date().toLocaleDateString([], { weekday: 'long', day: 'numeric', month: 'long' })}` + (S.wx && S.wx.ok ? ` · ${S.wx.place} ${Math.round(S.wx.temp)}°C` : '');
  const tasks = S.tasks || [], left = tasks.filter(t => !t.d).length, hab = (S.habits || [])[0];
  $('#cHab').textContent = hab ? `${hab.c}/${hab.g}` : '–'; $('#cHabL').textContent = hab ? hab.n + ' today' : 'add a habit';
  $('#cTask').textContent = left;
  const rem = (S.rems || [])[0];
  if (meet) { $('#cNext').textContent = hhmm(meet.t); $('#cNextL').textContent = meet.s; }
  else if (rem) { $('#cNext').textContent = (rem.w.match(/\d\d:\d\d/) || ['–'])[0]; $('#cNextL').textContent = rem.t; }
  else { $('#cNext').textContent = '–'; $('#cNextL').textContent = 'nothing scheduled'; }
  $('#cFocus').textContent = S.focus ? S.focus.today : 0;
  $$('#dnd button').forEach(b => b.classList.toggle('on', b.dataset.d === w.dnd));
  $('#homeStatus').textContent = (S.focus && S.focus.running ? `Focus running · ${fmtWait(Math.ceil(S.focus.remain / 1000))} left. ` : '') + (w.busy ? `Busy (${w.reason}). ` : '') + `lil.mate is ${FEEL[S.mood] || S.mood} · ${S.happy}% happy`;
  renderUpcoming(agents, meet, w);

  // badges
  const needs = agents.filter(a => ['needs you', 'approve?'].includes(a.st)).length;
  $('#bAg').textContent = needs || (agents.filter(a => a.st === 'working').length || '');
  $('#bTk').textContent = left || '';
  $('#bHb').textContent = hab ? `${hab.c}/${hab.g}` : '';

  // agents
  const tagCls = st => st === 'working' ? 'working' : st === 'done' ? 'done' : st === 'approve?' ? 'ask' : st === 'needs you' ? 'needs' : '';
  $('#agList').innerHTML = agents.map(a => `<li><span>${esc(a.name)} <small>${esc(a.tool)}${a.msg ? ' · ' + esc(a.msg) : ''}</small></span><em class="tag ${tagCls(a.st)}">${esc(a.st)} ${fmtWait(a.wait)}</em></li>`).join('')
    || '<li class="empty">No sessions right now. Connect a tool below, then use it as usual.</li>';
  // tasks / reminders / habits
  $('#tkList').innerHTML = tasks.map((t, i) => `<li class="${t.d ? 'done' : ''}"><button class="ck ${t.d ? 'on' : ''}" data-run="/${t.d ? 'undone' : 'done'} ${i + 1}"></button><span>${esc(t.t)}</span><button class="mini-btn" data-run="/del ${i + 1}">✕</button></li>`).join('') || '<li class="empty">Nothing to do. Nice.</li>';
  $('#rmList').innerHTML = (S.rems || []).map((r, i) => `<li><span>${esc(r.t)} <small>${esc(r.w)}${r.daily ? ' · daily' : ''}</small></span><button class="mini-btn" data-run="/unremind ${i + 1}">✕</button></li>`).join('') || '<li class="empty">No reminders.</li>';
  $('#hbList').innerHTML = (S.habits || []).map((h, i) => `<li><span>${esc(h.n)} <small>${h.c}/${h.g} today · ${h.s} day streak</small></span><button class="mini-btn go" data-run="/log ${i + 1}">+1</button><button class="mini-btn" data-run="/unhabit ${i + 1}">✕</button></li>`).join('') || '<li class="empty">No habits yet. Try "water 8".</li>';
  // team
  $('#tmList').innerHTML = ((S.link && S.link.peers) || []).map(p => `<li><span>${esc(p.name)} <small>${esc(p.st)}</small></span><button class="mini-btn" data-run="/wave ${p.i}">Wave</button><button class="mini-btn go" data-run="/invite ${p.i}">Play</button></li>`).join('') || '<li class="empty">No buddies nearby.</li>';
}

lil.on('link', l => { $('#setConn') && ($('#setConn').textContent = l.kind === 'none' ? 'Not connected' : `${l.kind === 'usb' ? 'USB cable' : 'Wi-Fi'} · ${l.where}`); });

function renderUpcoming(agents, meet, w) {
  const items = [];
  for (const a of agents.filter(a => a.st !== 'idle')) items.push(`<li><span>${esc(a.name)} <small>${esc(a.tool)}</small></span><em class="tag ${a.st === 'working' ? 'working' : a.st === 'done' ? 'done' : 'needs'}">${esc(a.st)} ${fmtWait(a.wait)}</em></li>`);
  for (const m of (w.meets || []).slice(0, 2)) items.push(`<li><span>${esc(m.s)} <small>meeting</small></span><em class="tag">${hhmm(m.t)}</em></li>`);
  for (const r of (S.rems || []).slice(0, 2)) items.push(`<li><span>${esc(r.t)} <small>reminder</small></span><em class="tag">${esc(r.w)}</em></li>`);
  $('#upList').innerHTML = items.slice(0, 4).join('') || '<li class="empty">Nothing coming up. Enjoy the calm.</li>';
}

// ------------------------------------------------------------ AI tools
const TOOL_INFO = { claude: ['Claude Code', 'done · needs you · approve'], copilot: ['GitHub Copilot', 'VS Code agent: working · done'], cursor: ['Cursor', 'working · done'], codex: ['Codex CLI', 'done'] };
async function loadTools() {
  const st = await lil.hooks();
  $('#tools').innerHTML = Object.entries(TOOL_INFO).map(([k, [n, d]]) => `<div class="tool"><span>${n}<small>${d}</small></span><button class="switch ${st[k] ? 'on' : ''}" data-tool="${k}" aria-label="${n}"></button></div>`).join('');
  $$('#tools .switch').forEach(b => b.onclick = async () => {
    const on = !b.classList.contains('on'); const r = await lil.setHook(b.dataset.tool, on);
    toast(r.ok ? `${TOOL_INFO[b.dataset.tool][0]} ${on ? 'connected. Restart it once.' : 'disconnected'}` : r.error);
    loadTools();
  });
}

// ------------------------------------------------------------ settings
async function loadSettings() {
  const s = await lil.settings();
  $('#ver').textContent = `lil.mate Desk ${s.version} · ${s.platform}`;
  $('#autoCheck').checked = s.autoCheck !== false;
  $('#host').value = s.host || ''; $('#autostart').checked = !!s.autostart; $('#approve').checked = s.approve !== false;
  const ds = await lil.displays();
  $('#screens').innerHTML = ds.map(d => `<option value="${d.id}" ${d.current ? 'selected' : ''}>${esc(d.label)}</option>`).join('');
  $('#calState').textContent = s.ics ? 'Calendar connected. Paste a new link to change it.' : 'Paste your private iCal link for meeting heads-ups.';
  $('#setConn').textContent = S.offline || !S.conn ? 'Not connected' : `${S.conn.kind === 'usb' ? 'USB cable' : 'Wi-Fi'} · ${S.conn.where || ''}`;
}
$('#hostSave').onclick = async () => { await lil.setSettings({ host: $('#host').value.trim() }); toast('Saved. Connecting…'); };
$('#wifiSave').onclick = async () => { const r = await lil.setWifi($('#ssid').value.trim(), $('#wpass').value); toast(r.ok ? 'Sent. lil.mate restarts and joins Wi-Fi.' : r.error); if (r.ok) $('#wpass').value = ''; };
$('#icsSave').onclick = async () => {
  const r = await lil.setSettings({ ics: $('#ics').value.trim() }); $('#ics').value = '';
  toast(r.ok ? (r.meetings ? `Calendar connected · ${r.meetings.length} meeting(s) in the next 36 h` : 'Calendar removed') : r.error); loadSettings();
};
$('#autostart').onchange = e => lil.setSettings({ autostart: e.target.checked });
$('#approve').onchange = e => lil.setSettings({ approve: e.target.checked });
$('#openDash').onclick = () => lil.openDashboard();
$('#screens').onchange = e => { lil.moveTo(e.target.value); toast('Moved'); };
$('#posReset').onclick = () => { lil.resetPos(); toast('Back to the centre'); setTimeout(loadSettings, 300); };

// ------------------------------------------------------------ updates (app + buddy firmware)
const STAGE = { downloading: 'Downloading', installing: 'Installing · your computer may ask for your password', sending: 'Sending to lil.mate · keep it plugged in', restarting: 'lil.mate is restarting with the new version…' };
function renderUpd() {
  const u = U; if (!u) return;
  const b = u.busy, when = u.checkedAt ? new Date(u.checkedAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : '';
  $('#updWhen').textContent = u.checking ? 'Checking…' : u.error ? u.error : when ? `Checked at ${when}` : 'Not checked yet';
  $('#updWhen').style.color = u.error ? '#b4441b' : '';
  const a = u.app, f = u.fw;
  $('#updApp').innerHTML = a.available ? `${esc(a.current)} · <small class="new">${esc(a.latest)} is ready</small>` : `${esc(a.current)}${a.latest ? ' · up to date' : ''}`;
  $('#updFw').innerHTML = !f.current ? 'connect lil.mate to see its version' : f.available ? `${esc(f.current)} · <small class="new">${esc(f.latest)} is ready</small>` : `${esc(f.current)}${f.latest ? ' · up to date' : ''}`;
  $('#updAppBtn').hidden = !a.available; $('#updFwBtn').hidden = !f.available;
  for (const id of ['#updAppBtn', '#updFwBtn', '#updCheck']) $(id).disabled = !!b || u.checking;
  $('#updBar').hidden = !b;
  if (b) { $('#updPct').style.width = (b.stage === 'restarting' ? 100 : b.pct) + '%'; $('#updStage').textContent = STAGE[b.stage] + (b.stage === 'downloading' || b.stage === 'sending' ? ` · ${b.pct}%` : ''); }
  $('#updNotes').textContent = (a.available || f.available) && u.notes ? "What's new: " + u.notes : '';
  const n = (a.available ? 1 : 0) + (f.available ? 1 : 0);
  $('#bSet').textContent = n ? 'new' : ''; $('#bSet').className = n ? 'new' : '';
  $('#updBox').classList.toggle('has', !!n);
}
lil.on('update', u => { U = u; renderUpd(); if (u.busy && u.busy.what === 'fw') render(); });
lil.on('goto', p => go(p));
lil.on('toast', t => toast(t));
lil.update().then(u => { U = u; renderUpd(); });
$('#updCheck').onclick = () => lil.checkUpdates();
$('#updAppBtn').onclick = () => lil.updateApp();
$('#updFwBtn').onclick = () => lil.updateFirmware(false);
$('#autoCheck').onchange = e => lil.setSettings({ autoCheck: e.target.checked });

// laptop battery for the buddy's PC screen
if (navigator.getBattery) navigator.getBattery().then(b => { const push = () => lil.battery({ level: Math.round(b.level * 100), charging: b.charging }); push(); b.onlevelchange = push; b.onchargingchange = push; });
lil.settings().then(s => { if (s.first) { go('agents'); lil.setSettings({ first: false }); } });
