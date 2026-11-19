// Web: phone dashboard (lilmate.local), Wi-Fi setup portal, JSON API, browser firmware update
#pragma once
#include <WebServer.h>
#include <Update.h>
#include "config.h"

WebServer server(80);
uint32_t restartAt = 0;

static const char CSS[] PROGMEM = R"CSS(
:root{--cream:#fff8ee;--cream2:#f7ecdb;--cream3:#efdfc6;--ink:#24130f;--soft:#6b5a4f;--orange:#f7931e;--pengu:#5b7397;--sky:#cfe4e8;--white:#fff;--sh:0 10px 30px -12px #24130f2e}
*{box-sizing:border-box}html{-webkit-text-size-adjust:100%}
body{margin:0;background:var(--cream);color:var(--ink);font:16px/1.55 Nunito,ui-rounded,system-ui,-apple-system,"Segoe UI",sans-serif}
h1,h2,h3,.f{font-family:Fredoka,ui-rounded,system-ui,sans-serif;letter-spacing:-.01em}
main{max-width:980px;margin:auto;padding:12px 16px 40px}
.nav{display:flex;align-items:center;justify-content:space-between;background:#ffffffc0;backdrop-filter:blur(16px);border:1px solid #24130f0d;border-radius:999px;padding:8px 8px 8px 18px;box-shadow:var(--sh);position:sticky;top:10px;z-index:5}
.logo{display:flex;align-items:center;gap:7px;color:var(--ink);text-decoration:none;font:600 1.5rem/1 Fredoka,ui-rounded,sans-serif}
.logo b{color:var(--orange);font-weight:600}.logo .m{position:relative;display:inline-flex}.logo .m svg+svg{position:absolute;right:-9px;top:-7px;width:13px;color:var(--orange)}
.pill{display:inline-flex;align-items:center;gap:6px;border-radius:999px;padding:7px 14px;background:var(--cream2);font-weight:700;font-size:.85rem;color:var(--soft)}
.dot{width:8px;height:8px;border-radius:50%;background:#3cb371}.off .dot{background:#d9534f}
.hero{display:grid;gap:20px;align-items:center;padding:30px 0 10px}
.stage{order:2}@media(min-width:820px){.hero{grid-template-columns:1.05fr 1fr;padding:44px 0 20px}}
.badge{display:inline-flex;align-items:center;gap:8px;background:var(--white);border:1px solid #24130f12;border-radius:999px;padding:4px 12px 4px 4px;font-weight:600;font-size:.85rem;color:var(--soft)}
.badge i{display:inline-flex;align-items:center;justify-content:center;background:var(--ink);border-radius:999px;width:34px;height:20px}
h1{font-size:clamp(2.1rem,7vw,3.3rem);line-height:1.02;margin:14px 0 12px;font-weight:700}
h1 em{font-style:normal;color:var(--orange)}
.lead{color:var(--soft);font-size:1.05rem;margin:0 0 18px}
.cta{display:flex;flex-wrap:wrap;gap:10px;margin-bottom:14px}
button,.btn,.btn2{font:700 .98rem Nunito,ui-rounded,sans-serif;border-radius:999px;cursor:pointer;border:0;transition:transform .15s,background .15s}
button:active{transform:scale(.97)}
.btn{background:var(--ink);color:var(--cream);padding:8px 8px 8px 22px;display:inline-flex;align-items:center;gap:12px}
.btn i{font-style:normal;display:inline-flex;align-items:center;justify-content:center;width:32px;height:32px;border-radius:50%;background:#ffffff1f}
.btn2{background:transparent;color:var(--ink);border:2px solid var(--cream3);padding:11px 20px}
.btn2:hover{background:var(--white)}
.chips{display:flex;flex-wrap:wrap;gap:8px}
.chip{background:var(--white);color:var(--ink);border:1px solid #24130f10;box-shadow:0 6px 18px -10px #24130f40;padding:8px 14px;font-weight:700;font-size:.88rem}
.stage{position:relative;height:290px;display:flex;align-items:center;justify-content:center}
.blob{position:absolute;width:72%;height:80%;background:var(--sky);border-radius:2.5rem;transform:rotate(-4deg)}
.blob2{position:absolute;width:58%;height:66%;background:var(--cream2);border-radius:2.2rem;transform:rotate(7deg) translate(26%,6%);opacity:.9}
.spark{position:absolute;top:6%;right:16%;width:34px;color:var(--orange)}
.body{position:relative;width:200px;height:200px;border-radius:26px;background:linear-gradient(#4a403b,#2e2622);box-shadow:0 30px 50px -20px #24130f80;display:flex;align-items:center;justify-content:center}
.scr{width:160px;height:100px;background:#0d0b0a;border-radius:12px;display:flex;align-items:center;justify-content:center;gap:20px;box-shadow:inset 0 0 0 3px #1a1513}
.eye{display:block;width:32px;height:40px;background:#fff;border-radius:10px;transition:all .35s cubic-bezier(.3,1.4,.5,1);animation:blink 5s infinite;font:700 34px/40px Fredoka,sans-serif;color:#fff;text-align:center;font-style:normal}
@keyframes blink{0%,93%,100%{transform:scaleY(1)}96%{transform:scaleY(.08)}}
.m-happy .eye,.m-wink .eye:first-child{height:24px;background:none;border:8px solid #fff;border-bottom:0;border-radius:30px 30px 0 0;animation:none}
.m-sleep .eye,.m-wink .eye:last-child{height:5px;border-radius:3px;animation:none}
.m-sleepy .eye{height:13px;border-radius:6px}
.m-surprised .eye,.m-alert .eye{width:38px;height:46px;border-radius:50%}
.m-angry .eye:first-child,.m-focus .eye:first-child{clip-path:polygon(0 0,100% 45%,100% 100%,0 100%)}
.m-angry .eye:last-child,.m-focus .eye:last-child{clip-path:polygon(0 45%,100% 0,100% 100%,0 100%)}
.m-focus .eye{height:24px}
.m-sad .eye:first-child{clip-path:polygon(0 42%,100% 0,100% 100%,0 100%)}.m-sad .eye:last-child{clip-path:polygon(0 0,100% 42%,100% 100%,0 100%)}
.m-think .eye{animation:none;transform:translate(7px,-8px)}.m-think .eye:first-child{height:28px}
.m-curious .eye:last-child{height:28px;width:28px}
.m-cool .scr{gap:6px}.m-cool .eye{width:52px;height:20px;border-radius:6px}
.g .eye{background:none;width:auto;height:auto;animation:none;border:0}
.m-love .eye{color:#ff5c7a;animation:beat .9s infinite}@keyframes beat{50%{transform:scale(1.18)}}
.fl{position:absolute;font-size:.85rem}.fl1{left:2%;top:18%}.fl2{right:0;top:46%}.fl3{left:4%;bottom:12%}
.grid{display:grid;gap:14px}@media(min-width:820px){.grid{grid-template-columns:1fr 1fr}}
.card{background:var(--white);border:1px solid #24130f0d;border-radius:28px;padding:20px;box-shadow:var(--sh)}
.card h2{font-size:1.3rem;margin:0 0 4px;font-weight:600}.card .sub{color:var(--soft);font-size:.9rem;margin:0 0 12px}
.row{display:flex;gap:8px;align-items:center}.row>*{min-width:0}
input,select{flex:1;width:100%;background:var(--cream);border:2px solid var(--cream2);color:var(--ink);border-radius:16px;padding:11px 14px;font:600 .98rem Nunito,ui-rounded,sans-serif;outline:none;transition:border .15s}
input:focus,select:focus{border-color:var(--orange)}
.add{background:var(--orange);color:var(--white);padding:12px 18px}
.mini{background:var(--cream);color:var(--soft);padding:8px 12px;font-size:.85rem}
ul{list-style:none;margin:0 0 12px;padding:0}
li{display:flex;gap:10px;align-items:center;padding:10px 4px;border-bottom:1px dashed var(--cream3)}li:last-child{border:0}
li span{flex:1;overflow-wrap:anywhere;font-weight:600}li small{color:var(--soft);font-weight:600}
.done span{text-decoration:line-through;color:#b3a59a}
.ck{appearance:none;-webkit-appearance:none;flex:none;width:24px;height:24px;border-radius:50%;border:2px solid var(--cream3);background:var(--white);display:grid;place-content:center;cursor:pointer;margin:0;padding:0}
.ck:checked{background:var(--orange);border-color:var(--orange)}.ck:checked::after{content:"";width:6px;height:11px;border:solid #fff;border-width:0 3px 3px 0;transform:rotate(45deg) translate(-1px,-1px)}
.prog{display:flex;gap:4px}.prog i{width:10px;height:10px;border-radius:50%;background:var(--cream2)}.prog i.on{background:var(--orange)}
.stats{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin-top:4px}
.stat{background:var(--cream);border-radius:20px;padding:12px;text-align:center}.stat b{display:block;font:600 1.4rem Fredoka,sans-serif}.stat small{color:var(--soft);font-weight:700;font-size:.78rem}
label{font-size:.8rem;font-weight:700;color:var(--soft);display:block;margin:0 0 4px 4px}
.fg{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:10px}
details summary{cursor:pointer;list-style:none;font:600 1.3rem Fredoka,sans-serif}details summary::after{content:" +";color:var(--orange)}details[open] summary::after{content:" –"}
pre{white-space:pre-wrap;margin:10px 0 0;color:var(--soft);font:600 .88rem/1.5 Nunito,sans-serif;background:var(--cream);border-radius:16px;padding:10px 14px}pre:empty{display:none}
.foot{text-align:center;color:var(--soft);font-size:.85rem;font-weight:600;margin-top:22px}
#toast{position:fixed;left:50%;bottom:18px;transform:translate(-50%,20px);background:var(--ink);color:var(--cream);padding:12px 18px;border-radius:999px;opacity:0;transition:.3s;max-width:92%;font-weight:700;white-space:pre-wrap;pointer-events:none;z-index:9}
#toast.on{opacity:1;transform:translate(-50%,0)}

/* ---- mobile app navigation ---- */
.tabs{display:none}
@media(max-width:819px){
main{padding-bottom:110px}
.tabs{display:flex;position:fixed;left:12px;right:12px;bottom:calc(10px + env(safe-area-inset-bottom));z-index:8;background:#ffffffe6;backdrop-filter:blur(16px);-webkit-backdrop-filter:blur(16px);border:1px solid #24130f12;border-radius:26px;box-shadow:0 14px 34px -14px #24130f55;padding:6px}
.tabs button{flex:1;position:relative;display:flex;flex-direction:column;align-items:center;gap:2px;background:none;color:var(--soft);font:700 .72rem Nunito,sans-serif;padding:7px 0 6px;border-radius:20px}
.tabs svg{width:24px;height:24px;fill:none;stroke:currentColor;stroke-width:2;stroke-linecap:round;stroke-linejoin:round}
.tabs button.on{color:var(--ink);background:var(--cream2)}.tabs button.on svg{stroke:var(--orange)}
.tabs b{position:absolute;top:2px;left:calc(50% + 6px);min-width:18px;height:18px;padding:0 5px;border-radius:9px;background:var(--orange);color:#fff;font:800 .68rem/18px Nunito,sans-serif}
body:not([data-tab=home]) [data-t=home],body:not([data-tab=tasks]) [data-t=tasks],body:not([data-tab=rem]) [data-t=rem],body:not([data-tab=hab]) [data-t=hab],body:not([data-tab=more]) [data-t=more]{display:none}
body:not([data-tab=home]) .grid{margin-top:16px}
.qa{flex-wrap:nowrap;overflow-x:auto;margin:0 -16px;padding:4px 16px 10px;scrollbar-width:none}.qa::-webkit-scrollbar{display:none}.qa .chip{flex:none}
.stage{height:250px}.body{width:176px;height:176px}.scr{width:140px;height:90px}
.hero{padding:18px 0 4px}h1{margin:10px 0 8px}
.card{border-radius:24px;padding:18px}
#toast{bottom:calc(96px + env(safe-area-inset-bottom))}
input,select{font-size:16px}
}
.hero>*,.grid>*{min-width:0}.tabs b:empty{display:none}
.live{font:700 .75rem Nunito,sans-serif;color:var(--soft);background:var(--cream);border-radius:999px;padding:3px 10px;vertical-align:middle;margin-left:6px}
.gcard.on,#agc.on,#plc.on{outline:3px solid var(--orange);outline-offset:-3px}#agc.on .live,#plc.on .live{background:var(--orange);color:#fff}.gcard.on .live{background:var(--orange);color:#fff}
.pad{display:flex;gap:10px;align-items:center;justify-content:center;margin:14px 0 6px;user-select:none;-webkit-user-select:none;touch-action:manipulation}
.padb{width:64px;height:56px;border-radius:20px;background:var(--cream2);color:var(--ink);font-size:1.4rem;flex:none}
.padb.hit,.padm.hit{transform:scale(.9);background:var(--orange);color:#fff}
.padm{flex:1;max-width:200px;justify-content:space-between;height:56px}
.keys{text-align:center;margin:6px 0 0}kbd{display:inline-block;background:var(--cream);border:1px solid var(--cream3);border-bottom-width:3px;border-radius:7px;padding:0 6px;font:700 .78rem Nunito,sans-serif;margin:0 2px}
@media(max-width:819px){.keys{display:none}}
.busyrow{display:flex;gap:8px;align-items:center;justify-content:space-between;flex-wrap:wrap;margin-top:12px}
.seg{display:inline-flex;background:var(--cream);border-radius:999px;padding:3px}.seg button{background:none;padding:6px 12px;font-size:.82rem;color:var(--soft)}.seg button.on{background:var(--ink);color:var(--cream)}
)CSS";

static const char DASH[] PROGMEM = R"HTML(<!doctype html><html lang=en><head><meta charset=utf-8><meta name=viewport content="width=device-width,initial-scale=1"><meta name=theme-color content="#fff8ee"><title>lil.mate</title>
<link rel=preconnect href=https://fonts.gstatic.com crossorigin><link rel=stylesheet href="https://fonts.googleapis.com/css2?family=Fredoka:wght@500;600;700&family=Nunito:wght@600;700&display=swap"><link rel=stylesheet href=/s.css></head><body><main>
<nav class=nav><a class=logo href=/><span class=m><svg viewBox="0 0 64 44" width=32 height=24><path d="M6 40 C6 18 18 6 32 6 C46 6 58 18 58 40" fill=none stroke=currentColor stroke-width=5 stroke-linecap=round /><path d="M21 31 Q24.5 25 28 31" fill=none stroke=currentColor stroke-width=4 stroke-linecap=round /><path d="M36 31 Q39.5 25 43 31" fill=none stroke=currentColor stroke-width=4 stroke-linecap=round /></svg><svg viewBox="0 0 40 40"><g stroke=currentColor stroke-width=5 stroke-linecap=round><path d="M14 4 L11 15"/><path d="M30 9 L21 18"/><path d="M36 25 L25 28"/></g></svg></span><span>lil<b>.</b>mate</span></a><span class=pill id=on><i class=dot></i><span id=clk>connecting</span></span></nav>
<section class=hero data-t=home>
<div class=stage><div class=blob></div><div class=blob2></div><svg class=spark viewBox="0 0 40 40"><g stroke=currentColor stroke-width=5 stroke-linecap=round><path d="M14 4 L11 15"/><path d="M30 9 L21 18"/><path d="M36 25 L25 28"/></g></svg>
<div class=body onclick="cmd('/pat')" title="pat"><div class=scr id=scr><i class=eye></i><i class=eye></i></div></div>
<span class="chip pill fl fl1" id=c1>♥ happy</span><span class="chip pill fl fl2" id=c2>💛 joy</span><span class="chip pill fl fl3">👆 tap my head</span></div>
<div><span class=badge><i><svg viewBox="0 0 64 30" width=22 height=12><path d="M8 22 Q16 8 24 22" fill=none stroke=#fff stroke-width=6 stroke-linecap=round /><path d="M40 22 Q48 8 56 22" fill=none stroke=#fff stroke-width=6 stroke-linecap=round /></svg></i>Desk buddies with feelings</span>
<h1>Hi <span id=hn>there</span>, your <em>lil mate</em> is <span id=hm>waking up</span>.</h1>
<p class=lead id=lead>Loading…</p>
<div class=cta><button class=btn onclick="cmd('/pat')">Give a pat <i>→</i></button><button class=btn2 id=fbtn onclick="cmd(S.focus&&S.focus.running?'/stop':'/focus')">Start focus</button></div>
<div class="chips qa"><button class="chip pill" onclick="cmd('/break')">☕ Break</button><button class="chip pill" onclick="cmd('/pause')">⏯ Pause</button><button class="chip pill" onclick="cmd('/play fly')">🪰 Fly</button><button class="chip pill" onclick="cmd('/play ball')">⚽ Ball</button><button class="chip pill" onclick="cmd('/sleep')">😴 Nap</button><button class="chip pill" onclick="cmd('/wake')">☀️ Wake</button></div></div>
</section>
<div class=grid>
<div class=card data-t=home id=agc><h2>AI agents <span class=live id=agLive>idle</span></h2><p class=sub>Your buddy watches Claude Code and pings you when it's done or needs you.</p><ul id=agl></ul></div>
<div class=card data-t=home><h2>Say something</h2><p class=sub>Pops up on the little screen.</p><div class=row><input id=say placeholder="Message for your lil mate"><button class=add onclick="sendIn('say','/say ')">Send</button></div>
<div class=row style="margin-top:10px"><select id=face></select><button class=mini onclick="cmd('/face '+$('#face').value)">Face</button><select id=scrn></select><button class=mini onclick="cmd('/screen '+$('#scrn').value)">Show</button></div></div>
<div class=card data-t=home><h2>Today</h2><p class=sub id=wx>…</p><div class=stats><div class=stat><b id=sF>0</b><small>focus min</small></div><div class=stat><b id=sT>0</b><small>tasks left</small></div><div class=stat><b id=sP>0</b><small>pats</small></div></div><p class=sub id=pcl style="margin:12px 0 0"></p>
<div class=busyrow><span id=bz class="pill">…</span><span class=seg id=dnd><button data-d=auto>Auto</button><button data-d=on>DND</button><button data-d=off>Off</button></span></div>
<p class=sub id=mt style="margin:8px 0 0"></p>
<div class=chips style="margin-top:10px"><button class="chip pill" onclick="cmd('/breathe')">🫁 Breathe 1 min</button><button class="chip pill" onclick="cmd('/wrap')">🌙 Wrap up day</button><button class="chip pill" id=we onclick="const v=prompt('Work ends at (HH:MM, or off)',this.dataset.v||'18:30');if(v)cmd('/workend '+v)">⏰ ends</button></div></div>
<div class="card gcard" data-t=home id=gcard><h2>Star Catch <span class=live id=gLive>on Lilmate</span></h2><p class=sub>Catch the stars, dodge the rocks. Plays on Lilmate's screen.</p>
<div class=stats><div class=stat><b id=gS>0</b><small>score</small></div><div class=stat><b id=gL>♥♥♥</b><small>lives</small></div><div class=stat><b id=gB>0</b><small>best</small></div></div>
<div class=pad><button class=padb data-k=L aria-label=left>◀</button><button class="btn padm" data-k=T id=gP>Play <i>★</i></button><button class=padb data-k=R aria-label=right>▶</button></div>
<p class="sub keys"><kbd>←</kbd><kbd>→</kbd> steer · <kbd>Space</kbd> start / turn · <kbd>Esc</kbd> quit</p></div>
<div class=card data-t=home id=plc><h2>Play with your team <span class=live id=plLive>team</span></h2><p class=sub>Wave, call a tea break, or play Quick Draw + Tug of War on both buddies. No Wi-Fi needed.</p><div class=chips id=plt style="margin-bottom:6px"><button class="chip pill" onclick="post('/api/link?do=tea')">☕ Tea break call</button><button class="chip pill" onclick="post('/api/link?do=lunch')">🍱 Lunch call</button></div><ul id=pll></ul><div id=plm></div></div>
<div class=card data-t=tasks><h2>Tasks</h2><p class=sub>Hold on the Tasks screen to tick one off.</p><ul id=tasks></ul><div class=row><input id=tk placeholder="Add a task"><button class=add onclick="sendIn('tk','/task ')">Add</button></div></div>
<div class=card data-t=rem><h2>Reminders</h2><p class=sub>Try "10m", "1h30m" or "18:30".</p><ul id=rems></ul><div class=row><input id=rt placeholder="What"><input id=rw placeholder="when" style="max-width:96px"></div>
<div class=row style="margin-top:10px"><label class=row style="flex:1;margin:0"><input type=checkbox id=rd class=ck> every day</label><button class=add onclick="addRem()">Add</button></div></div>
<div class=card data-t=hab><h2>Habits</h2><p class=sub>Hold on the Habits screen to log +1.</p><ul id=habs></ul><div class=row><input id=hn2 placeholder="Habit, e.g. water"><input id=hg type=number min=1 max=20 value=1 style="max-width:70px"><button class=add onclick="addHab()">Add</button></div></div>
<div class=card data-t=more><h2>Command</h2><p class=sub>Same as Telegram. Try /help</p><div class=row><input id=cl placeholder="/status"><button class=mini onclick="sendIn('cl','')">Run</button></div><pre id=out></pre></div>
</div>
<details class=card data-t=more id=setd style="margin-top:14px"><summary>Settings</summary><form id=sf onsubmit="return saveSet(event)" style="margin-top:14px">
<div class=fg><div><label>Your name</label><input name=owner></div><div><label>City (blank = auto)</label><input name=city></div>
<div><label>Focus minutes</label><input name=focusMin type=number></div><div><label>Break minutes</label><input name=breakMin type=number></div>
<div><label>Night from (hour)</label><input name=sleepFrom type=number></div><div><label>Night until (hour)</label><input name=sleepTo type=number></div>
<div><label>Brightness 1-255</label><input name=contrast type=number></div><div><label>Morning summary hour</label><input name=summaryHour type=number placeholder=off></div></div>
<label>Timezone (POSIX, blank = auto)</label><input name=tz>
<div style="margin-top:10px"><label>Telegram bot token <span id=tgs></span></label><input name=tgToken placeholder="paste from @BotFather, blank = keep, - = remove"></div>
<div class=chips style="margin-top:14px"><button class=btn>Save <i>✓</i></button><button type=button class=btn2 onclick="cmd('/unpair')">Unpair phone</button><button type=button class=btn2 onclick="location='/update'">Firmware</button><button type=button class=btn2 onclick="if(confirm('Forget Wi-Fi and open the setup hotspot?'))cmd('/wifireset')">Reset Wi-Fi</button></div>
</form></details>
<p class=foot id=ft>Designed &amp; 3D-printed in India</p></main>
<nav class=tabs id=tabs>
<button data-go=home><svg viewBox="0 0 24 24"><path d="M3 11.5 12 4l9 7.5"/><path d="M5.5 10v9.5h13V10"/></svg>Home</button>
<button data-go=tasks><svg viewBox="0 0 24 24"><rect x="4" y="4" width="16" height="16" rx="5"/><path d="m8.5 12 2.5 2.5 4.5-5"/></svg>Tasks<b id=bT></b></button>
<button data-go=rem><svg viewBox="0 0 24 24"><path d="M6 16.5V11a6 6 0 0 1 12 0v5.5l1.5 1.5h-15z"/><path d="M10 20.5h4"/></svg>Remind<b id=bR></b></button>
<button data-go=hab><svg viewBox="0 0 24 24"><path d="M12 3c1 3.5 5 5.5 5 10a5 5 0 0 1-10 0c0-2.5 1.5-4 2.5-5 .5 2 1.5 3 2.5 3-1-3 0-6 0-8z"/></svg>Habits<b id=bH></b></button>
<button data-go=more><svg viewBox="0 0 24 24"><circle cx="5.5" cy="12" r="1.6"/><circle cx="12" cy="12" r="1.6"/><circle cx="18.5" cy="12" r="1.6"/></svg>More</button>
</nav><div id=toast></div>
<script>
const $=s=>document.querySelector(s);let S={},filled=0;
const esc=s=>String(s).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const MW={neutral:'chilling',happy:'happy',love:'in love',surprised:'surprised',angry:'grumpy',sad:'a bit sad',sleepy:'sleepy',sleep:'napping',think:'thinking',cool:'feeling cool',laugh:'laughing',wink:'winking',focus:'focused',alert:'calling you',dizzy:'dizzy',curious:'curious'};
const GL={love:['♥','♥'],laugh:['>','<'],dizzy:['@','@']};
function toast(t){const e=$('#toast');e.textContent=t;e.classList.add('on');clearTimeout(e._t);e._t=setTimeout(()=>e.classList.remove('on'),2800)}
async function cmd(c){if(!c.trim())return;try{const r=await fetch('/api/cmd',{method:'POST',headers:{'Content-Type':'text/plain'},body:c});const t=await r.text();toast(t);$('#out').textContent=t}catch(e){toast('Lilmate is not reachable')}load()}
function sendIn(id,p){const e=$('#'+id);if(!e.value.trim())return;cmd(p+e.value.trim());e.value=''}
function addRem(){const t=$('#rt').value.trim(),w=$('#rw').value.trim();if(!t||!w)return toast('Need what + when');cmd('/remind '+($('#rd').checked?'daily ':'')+w+' '+t);$('#rt').value=$('#rw').value=''}
function addHab(){const n=$('#hn2').value.trim();if(!n)return;cmd('/habit '+n+' '+($('#hg').value||1));$('#hn2').value=''}
const mmss=ms=>{const s=Math.ceil(ms/1000);return String(Math.floor(s/60)).padStart(2,'0')+':'+String(s%60).padStart(2,'0')};
function face(m){const s=$('#scr'),g=GL[m];s.className='scr m-'+m+(g?' g':'');const e=s.querySelectorAll('.eye');e[0].textContent=g?g[0]:'';e[1].textContent=g?g[1]:''}
function render(s){S=s;const f=s.focus,w=s.wx,left=s.tasks.filter(t=>!t.d).length;
$('#on').className='pill';const pw=s.power||{};$('#clk').textContent=(s.time||'--:--')+' · '+(pw.bat?(pw.chg?'⚡':'🔋')+pw.pct+'%':pw.usb?'online':(pw.saver?'saver':'online'));
face(s.mood);$('#hn').textContent=s.set.owner||'there';$('#hm').textContent=MW[s.mood]||s.mood;
$('#c1').textContent=(s.mood=='love'?'♥ ':'✦ ')+(MW[s.mood]||s.mood);$('#c2').textContent='💛 '+s.happy+'% happy';
$('#lead').textContent=(f.running?(f.brk?'☕ On a break, ':'🎯 Focusing, ')+mmss(f.remain)+' left'+(f.paused?' (paused)':'')+'. ':'')+(w.ok?w.place+' is '+w.temp.toFixed(0)+'°C and '+w.text.toLowerCase()+'. ':'')+(left?left+' task'+(left>1?'s':'')+' to go.':'All tasks done!');
$('#fbtn').textContent=f.running?'Stop focus':'Start focus';
$('#wx').textContent=w.ok?`${w.place} · ${w.temp.toFixed(0)}°C ${w.text} · H${w.max.toFixed(0)} L${w.min.toFixed(0)}`:'Weather: '+(s.set.city?'loading…':'set a city in Settings');
$('#sF').textContent=f.today;$('#sT').textContent=left;$('#sP').textContent=s.pats;
$('#pcl').textContent=s.pc.online?`💻 PC · CPU ${s.pc.cpu.toFixed(0)}% · RAM ${s.pc.ram.toFixed(0)}%`+(s.pc.bat>=0?` · battery ${s.pc.bat}%`:''):'💻 PC agent offline';
$('#tasks').innerHTML=s.tasks.map((t,i)=>`<li class="${t.d?'done':''}"><input type=checkbox class=ck ${t.d?'checked':''} onchange="cmd('/${t.d?'undone':'done'} ${i+1}')"><span>${esc(t.t)}</span><button class=mini onclick="cmd('/del ${i+1}')">✕</button></li>`).join('')||'<li><small>Nothing yet. Add your first task.</small></li>';
$('#rems').innerHTML=s.rems.map((r,i)=>`<li><span>${esc(r.t)}<br><small>⏰ ${esc(r.w)}${r.daily?' · every day':''}</small></span><button class=mini onclick="cmd('/unremind ${i+1}')">✕</button></li>`).join('')||'<li><small>No reminders.</small></li>';
$('#habs').innerHTML=s.habits.map((h,i)=>`<li><span>${esc(h.n)} <small>${h.c}/${h.g} · 🔥 ${h.s}d</small><div class=prog>${Array.from({length:Math.min(h.g,12)},(_,k)=>`<i class="${k<h.c?'on':''}"></i>`).join('')}</div></span><button class=add style="padding:8px 14px" onclick="cmd('/log ${i+1}')">+1</button><button class=mini onclick="cmd('/unhabit ${i+1}')">✕</button></li>`).join('')||'<li><small>No habits yet. Try water, 8.</small></li>';
$('#tgs').textContent=s.tg.set?(s.tg.paired?'· paired ✓':'· send /start to your bot'):'· off';
if(s.game)gRender(s.game);if(s.work)wkRender(s.work);if(s.agents)agRender(s.agents);if(s.link)plRender(s.link);badge('#bT',left);badge('#bR',s.rems.length);badge('#bH',s.habits.filter(h=>h.c<h.g).length);
$('#ft').textContent=`Designed & 3D-printed in India · ${s.fw} · ${s.ip}`;
if(!filled){filled=1;for(const k in s.set){const e=$('#sf [name='+k+']');if(e)e.value=s.set[k]}
$('#face').innerHTML=s.moods.map(m=>`<option value=${m}>${MW[m]||m}</option>`).join('');$('#scrn').innerHTML=s.screens.map(m=>`<option>${m}</option>`).join('')}}
async function load(){try{render(await(await fetch('/api/state')).json())}catch(e){$('#on').className='pill off';$('#clk').textContent='offline'}}
async function saveSet(e){e.preventDefault();const r=await fetch('/api/settings',{method:'POST',body:new URLSearchParams(new FormData($('#sf')))});toast(await r.text());$('#sf [name=tgToken]').value='';filled=0;load();return false}
document.querySelectorAll('input:not([type=checkbox])').forEach(i=>i.addEventListener('keydown',e=>{if(e.key=='Enter'){const b=i.parentElement.querySelector('button');if(b&&i.form==null){e.preventDefault();b.click()}}}));
let gArm=0,gBusy=0;
function gRender(g){if(!g)return;$('#gS').textContent=g.s;$('#gL').textContent=g.p||g.o?('♥'.repeat(Math.max(0,g.l))||'–'):'♥♥♥';$('#gB').textContent=g.b;
$('#gP').innerHTML=(g.p?'Turn':g.o?'Again':'Play')+' <i>★</i>';$('#gcard').classList.toggle('on',!!g.on);$('#gLive').textContent=g.p?'● playing':g.o?'game over':'on Lilmate';if(g.on)gArm=1}
async function gk(k){gArm=1;try{const r=await fetch('/api/game?k='+k,{cache:'no-store'});gRender(await r.json())}catch(e){}}
document.querySelectorAll('[data-k]').forEach(b=>b.addEventListener('pointerdown',e=>{e.preventDefault();b.classList.add('hit');setTimeout(()=>b.classList.remove('hit'),120);gk(b.dataset.k)}));
const KM={ArrowLeft:'L',a:'L',A:'L',ArrowRight:'R',d:'R',D:'R',' ':'T',Enter:'T',Escape:'X'};
document.addEventListener('keydown',e=>{if(e.target.closest('input,select,textarea,summary'))return;const k=KM[e.key];if(!k)return;
if(!gArm&&k!='L'&&k!='R')return;e.preventDefault();if(e.repeat)return;if(k=='X')gArm=0;gk(k)});
setInterval(async()=>{if(!gArm||gBusy||document.hidden)return;gBusy=1;try{const g=await(await fetch('/api/game',{cache:'no-store'})).json();gRender(g);if(!g.on)gArm=0}catch(e){}gBusy=0},450);
let LM='idle';
function wkRender(w){$('#bz').textContent=w.busy?'🚫 busy · '+w.reason:'✅ free to chat';$('#bz').style.background=w.busy?'#ffe2bf':'';
document.querySelectorAll('#dnd button').forEach(b=>b.classList.toggle('on',b.dataset.d==w.dnd));
const tf=t=>new Date(t*1000).toLocaleTimeString([],{hour:'2-digit',minute:'2-digit'}),now=Date.now()/1000,m=w.meets.find(x=>x.e>now);
$('#mt').textContent=m?(m.t<=now?'📅 In meeting: '+m.s+' (till '+tf(m.e)+')':'📅 Next: '+tf(m.t)+' '+m.s):'📅 No meetings synced';
$('#we').textContent='⏰ ends '+w.workEnd;$('#we').dataset.v=w.workEnd}
document.querySelectorAll('#dnd button').forEach(b=>b.onclick=()=>cmd('/dnd '+b.dataset.d));
async function post(u){try{const r=await fetch(u,{method:'POST'});const t=await r.text();if(t&&t!='tap')toast(t)}catch(e){}}
function agRender(a){$('#agLive').textContent=a.some(x=>x.st=='approve?')?'● needs approval':a.some(x=>x.st=='needs you')?'● waiting for you':a.some(x=>x.st=='working')?'● working':'idle';
$('#agc').classList.toggle('on',a.some(x=>x.st=='approve?'||x.st=='needs you'));
const fw=s=>s<60?s+'s':Math.floor(s/60)+'m';
$('#agl').innerHTML=a.map(x=>`<li><span>${esc(x.name)} <small>${esc(x.tool)} · ${esc(x.st)} · ${fw(x.wait)}</small>${x.msg?`<br><small>${esc(x.msg)}</small>`:''}</span>${x.st=='approve?'?`<button class=add style="padding:8px 14px" onclick="post('/api/agent/decide?rid=${x.rid}&d=allow')">Allow</button><button class=mini onclick="post('/api/agent/decide?rid=${x.rid}&d=deny')">Deny</button>`:''}</li>`).join('')||'<li><small>No agent sessions yet. Run <b>python3 lilmate_agent.py install-claude</b> once, then use Claude Code as usual.</small></li>'}
function plRender(l){LM=l.mode;const m=l.mode;$('#plLive').textContent=m=='idle'?'team '+l.team:m=='invited'?'● invite!':m=='inviting'?'calling…':'● '+l.opp+' '+l.me+'-'+l.them;
$('#plc').classList.toggle('on',m!='idle');
$('#pll').innerHTML=m!='idle'?'':l.peers.map(p=>`<li><span>${esc(p.name)} <small>${esc(p.st)}</small></span><button class=mini onclick="post('/api/link?do=wave&i=${p.i}')">👋</button><button class=add style="padding:8px 14px" onclick="post('/api/link?do=invite&i=${p.i}')">Play</button></li>`).join('');
$('#plm').innerHTML=m=='invited'?`<p class=sub><b>${esc(l.opp)}</b> wants to play!</p><div class=chips><button class=btn onclick="post('/api/link?do=accept')">Let's play <i>→</i></button><button class=btn2 onclick="post('/api/link?do=decline')">Not now</button></div>`
:m=='inviting'?`<div class=chips><button class=btn2 onclick="post('/api/link?do=cancel')">Cancel invite</button></div>`
:m=='idle'?(l.call?`<p class=sub><b>${esc(l.call)}</b> is going for ${l.callKind}!</p><div class=chips><button class=btn onclick="post('/api/link?do=join')">I'm in <i>→</i></button><button class=btn2 onclick="post('/api/link?do=nocall')">Not now</button></div>`:''):`<div class=pad><button class="btn padm" data-tap style="max-width:none" onpointerdown="event.preventDefault();post('/api/link?do=tap')">TAP <i>⚡</i></button></div><p class="sub keys"><kbd>Space</kbd> = tap · round ${l.round} · ${l.kind=='quick'?'Quick Draw':'Tug of War'}</p>`}
document.addEventListener('keydown',e=>{if(!['countdown','round'].includes(LM)||e.key!=' '||e.repeat||e.target.closest('input,select,textarea'))return;e.preventDefault();e.stopImmediatePropagation();post('/api/link?do=tap')},true);
setInterval(async()=>{if(LM=='idle'||document.hidden)return;try{const s=await(await fetch('/api/state')).json();plRender(s.link);agRender(s.agents)}catch(e){}},700);
const TABS=['home','tasks','rem','hab','more'];
function go(t,push){if(!TABS.includes(t))t='home';document.body.dataset.tab=t;document.querySelectorAll('#tabs button').forEach(b=>b.classList.toggle('on',b.dataset.go==t));if(t=='more')$('#setd').open=true;if(push!==false&&location.hash!='#'+t)history.pushState(null,'','#'+t);window.scrollTo({top:0})}
document.querySelectorAll('#tabs button').forEach(b=>b.onclick=()=>go(b.dataset.go));
window.addEventListener('popstate',()=>go(location.hash.slice(1),false));
function badge(id,n){const e=$(id);e.textContent=n>0?n:'';e.style.display=n>0?'':'none'}
go(location.hash.slice(1)||'home',false);load();setInterval(load,3000);
</script></body></html>)HTML";

static const char SETUP[] PROGMEM = R"HTML(<!doctype html><html lang=en><head><meta charset=utf-8><meta name=viewport content="width=device-width,initial-scale=1"><meta name=theme-color content="#fff8ee"><title>lil.mate</title><link rel=stylesheet href="https://fonts.googleapis.com/css2?family=Fredoka:wght@500;600;700&family=Nunito:wght@600;700&display=swap"><link rel=stylesheet href=/s.css></head><body><main style="max-width:520px"><nav class=nav><a class=logo href=/><span class=m><svg viewBox="0 0 64 44" width=32 height=24><path d="M6 40 C6 18 18 6 32 6 C46 6 58 18 58 40" fill=none stroke=currentColor stroke-width=5 stroke-linecap=round /><path d="M21 31 Q24.5 25 28 31" fill=none stroke=currentColor stroke-width=4 stroke-linecap=round /><path d="M36 31 Q39.5 25 43 31" fill=none stroke=currentColor stroke-width=4 stroke-linecap=round /></svg><svg viewBox="0 0 40 40"><g stroke=currentColor stroke-width=5 stroke-linecap=round><path d="M14 4 L11 15"/><path d="M30 9 L21 18"/><path d="M36 25 L25 28"/></g></svg></span><span>lil<b>.</b>mate</span></a></nav>
<div class=hero style="padding:26px 0 8px"><div><span class=badge><i><svg viewBox="0 0 64 30" width=22 height=12><path d="M8 22 Q16 8 24 22" fill=none stroke=#fff stroke-width=6 stroke-linecap=round /><path d="M40 22 Q48 8 56 22" fill=none stroke=#fff stroke-width=6 stroke-linecap=round /></svg></i>Let's get you online</span>
<h1>Hello! I'm your <em>lil mate</em>.</h1><p class=lead>Pick your home Wi-Fi (2.4 GHz) and I'll be on your desk in a minute.</p></div></div>
<div class=card><label>Network</label><select id=ss onchange="$('#ssid').value=this.value"><option>Looking around…</option></select>
<div style="margin-top:10px"><label>or type the name</label><input id=ssid></div><div style="margin-top:10px"><label>Password</label><input id=pw type=password></div>
<div class=fg style="margin-top:10px"><div><label>Your name</label><input id=ow></div><div><label>City (optional)</label><input id=ct></div></div>
<button class=btn style="width:100%;justify-content:space-between" onclick="save()">Connect <i>→</i></button><pre id=msg></pre></div><p class=foot>Designed &amp; 3D-printed in India</p></main>
<script>const $=s=>document.querySelector(s);
fetch('/api/scan').then(r=>r.json()).then(l=>{$('#ss').innerHTML='<option value="">Choose a network…</option>'+l.map(n=>'<option>'+n.replace(/</g,'&lt;')+'</option>').join('')});
async function save(){const b=new URLSearchParams({ssid:$('#ssid').value,pass:$('#pw').value,owner:$('#ow').value,city:$('#ct').value});
if(!b.get('ssid'))return $('#msg').textContent='Pick a network first';const r=await fetch('/api/wifi',{method:'POST',body:b});$('#msg').textContent=await r.text()}
</script></body></html>)HTML";

static const char UPDATE_PAGE[] PROGMEM = R"HTML(<!doctype html><html lang=en><head><meta charset=utf-8><meta name=viewport content="width=device-width,initial-scale=1"><meta name=theme-color content="#fff8ee"><title>lil.mate</title><link rel=stylesheet href="https://fonts.googleapis.com/css2?family=Fredoka:wght@500;600;700&family=Nunito:wght@600;700&display=swap"><link rel=stylesheet href=/s.css></head><body><main style="max-width:520px"><nav class=nav><a class=logo href=/><span class=m><svg viewBox="0 0 64 44" width=32 height=24><path d="M6 40 C6 18 18 6 32 6 C46 6 58 18 58 40" fill=none stroke=currentColor stroke-width=5 stroke-linecap=round /><path d="M21 31 Q24.5 25 28 31" fill=none stroke=currentColor stroke-width=4 stroke-linecap=round /><path d="M36 31 Q39.5 25 43 31" fill=none stroke=currentColor stroke-width=4 stroke-linecap=round /></svg><svg viewBox="0 0 40 40"><g stroke=currentColor stroke-width=5 stroke-linecap=round><path d="M14 4 L11 15"/><path d="M30 9 L21 18"/><path d="M36 25 L25 28"/></g></svg></span><span>lil<b>.</b>mate</span></a></nav>
<div class=hero style="padding:26px 0 8px"><div><h1>Firmware <em>update</em></h1><p class=lead>Pick <b>lilmate_os.ino.bin</b> (not the merged file). Your settings, tasks and habits stay.</p></div></div>
<div class=card><input type=file id=f accept=.bin><button class=btn style="width:100%;justify-content:space-between;margin-top:12px" onclick="up()">Upload <i>↑</i></button>
<div class=prog style="margin-top:14px;height:10px;background:var(--cream2);border-radius:99px;overflow:hidden"><i id=bar style="width:0;height:10px;border-radius:99px;background:var(--orange);transition:width .2s"></i></div><pre id=m></pre></div>
<p class=foot><a href=/ style="color:inherit">← back to dashboard</a></p></main>
<script>function up(){const f=document.getElementById('f').files[0];if(!f)return;const fd=new FormData();fd.append('fw',f);const x=new XMLHttpRequest(),m=document.getElementById('m'),b=document.getElementById('bar');
x.upload.onprogress=e=>{const p=Math.round(e.loaded/e.total*100);b.style.width=p+'%';m.textContent='Uploading '+p+'%'};
x.onload=()=>{m.textContent=x.responseText;if(x.status==200)setTimeout(()=>location='/',9000)};x.open('POST','/update');x.send(fd)}</script></body></html>)HTML";

// ------------------------------------------------------------ handlers
void gameJson(JsonObject g) {
  g["s"] = gm.score; g["l"] = gm.lives; g["b"] = pet.gameBest; g["p"] = gm.playing; g["o"] = gm.over; g["on"] = screen == S_GAME;
}
void buildState(JsonDocument &d) {
  struct tm tm; char tb[8] = "";
  if (localNow(tm)) strftime(tb, sizeof(tb), "%H:%M", &tm);
  d["fw"] = FW_NAME " " FW_VERSION; d["ver"] = FW_VERSION; d["ip"] = WiFi.localIP().toString(); d["rssi"] = WiFi.RSSI(); d["up"] = millis() / 1000;
  d["time"] = tb; d["mood"] = MOOD_NAMES[mood]; d["screen"] = SCREEN_NAMES[screen];
  d["boot"] = bootCount; d["lastReset"] = resetLine(lastReset); d["minHeap"] = ESP.getMinFreeHeap();
  d["happy"] = pet.happy; d["pats"] = pet.pats; d["asleep"] = asleep;
  JsonObject w = d["wx"].to<JsonObject>();
  w["ok"] = wx.ok; w["temp"] = wx.temp; w["text"] = wxText(wx.code); w["place"] = wx.place; w["max"] = wx.tmax; w["min"] = wx.tmin;
  JsonObject f = d["focus"].to<JsonObject>();
  f["running"] = fx.running; f["paused"] = fx.paused; f["brk"] = fx.isBreak; f["remain"] = focusRemain(); f["today"] = focusToday();
  JsonArray ta = d["tasks"].to<JsonArray>();
  for (int i = 0; i < nTasks; i++) { JsonObject o = ta.add<JsonObject>(); o["t"] = tasks[i].text; o["d"] = tasks[i].done; }
  JsonArray ra = d["rems"].to<JsonArray>();
  for (int i = 0; i < nRems; i++) { JsonObject o = ra.add<JsonObject>(); o["t"] = rems[i].text; o["w"] = fmtDue(rems[i].due); o["daily"] = rems[i].daily; }
  JsonArray ha = d["habits"].to<JsonArray>();
  for (int i = 0; i < nHabits; i++) { habitRoll(habits[i]); JsonObject o = ha.add<JsonObject>(); o["n"] = habits[i].name; o["c"] = habits[i].count; o["g"] = habits[i].goal; o["s"] = habits[i].streak; }
  gameJson(d["game"].to<JsonObject>());
  agentJson(d["agents"].to<JsonArray>());
  workJson(d["work"].to<JsonObject>());
  powerJson(d["power"].to<JsonObject>());
  linkJson(d["link"].to<JsonObject>());
  JsonObject p = d["pc"].to<JsonObject>(); p["online"] = pcOnline(); p["cpu"] = pc.cpu; p["ram"] = pc.ram; p["bat"] = pc.bat;
  JsonObject tg = d["tg"].to<JsonObject>(); tg["set"] = S.tgToken[0] != 0; tg["paired"] = S.tgChat[0] != 0; tg["code"] = tgLastCode;
  JsonObject s = d["set"].to<JsonObject>();
  s["owner"] = S.owner; s["city"] = S.city; s["tz"] = S.tz; s["focusMin"] = S.focusMin; s["breakMin"] = S.breakMin;
  s["sleepFrom"] = S.sleepFrom; s["sleepTo"] = S.sleepTo; s["contrast"] = S.contrast;
  if (S.summaryHour < 24) s["summaryHour"] = S.summaryHour; else s["summaryHour"] = "";
  JsonArray ms = d["moods"].to<JsonArray>(); for (auto m : MOOD_NAMES) ms.add(m);
  JsonArray ss = d["screens"].to<JsonArray>(); for (auto m : SCREEN_NAMES) ss.add(m);
}
void sendState() {
  JsonDocument d; buildState(d);
  String o; serializeJson(d, o);
  server.send(200, "application/json", o);
}

void handleSettings() {
  auto has = [](const char *k) { return server.hasArg(k); };
  if (has("owner") && server.arg("owner").length()) copyStr(S.owner, server.arg("owner").c_str(), sizeof(S.owner));
  if (has("city") && strcmp(server.arg("city").c_str(), S.city)) {
    copyStr(S.city, server.arg("city").c_str(), sizeof(S.city)); S.lat = S.lon = 0; wx.ok = false; wx.place[0] = 0; wxRequest = true;
  }
  if (has("tz")) { copyStr(S.tz, server.arg("tz").c_str(), sizeof(S.tz)); applyTz(); }
  if (has("focusMin") && server.arg("focusMin").toInt() > 0) S.focusMin = constrain(server.arg("focusMin").toInt(), 1, 180);
  if (has("breakMin") && server.arg("breakMin").toInt() > 0) S.breakMin = constrain(server.arg("breakMin").toInt(), 1, 60);
  if (has("sleepFrom") && server.arg("sleepFrom").length()) S.sleepFrom = constrain(server.arg("sleepFrom").toInt(), 0, 23);
  if (has("sleepTo") && server.arg("sleepTo").length()) S.sleepTo = constrain(server.arg("sleepTo").toInt(), 0, 23);
  if (has("contrast") && server.arg("contrast").toInt() > 0) { S.contrast = constrain(server.arg("contrast").toInt(), 1, 255); if (!asleep) oled.setContrast(S.contrast); }
  if (has("summaryHour")) S.summaryHour = server.arg("summaryHour").length() ? constrain(server.arg("summaryHour").toInt(), 0, 23) : 255;
  if (has("tgToken")) {
    String t = server.arg("tgToken"); t.trim();
    if (t == "-") { S.tgToken[0] = 0; S.tgChat[0] = 0; }
    else if (t.length() > 20 && t.indexOf(':') > 0 && t != S.tgToken) { copyStr(S.tgToken, t.c_str(), sizeof(S.tgToken)); tgOffset = 0; markDirty(D_TG); }
  }
  markDirty(D_SET);
  server.send(200, "text/plain; charset=utf-8", "✅ Saved");
}

void handleWifi() {
  if (!server.hasArg("ssid") || !server.arg("ssid").length()) { server.send(400, "text/plain", "ssid missing"); return; }
  copyStr(S.ssid, server.arg("ssid").c_str(), sizeof(S.ssid));
  copyStr(S.pass, server.arg("pass").c_str(), sizeof(S.pass));
  if (server.arg("owner").length()) copyStr(S.owner, server.arg("owner").c_str(), sizeof(S.owner));
  if (server.arg("city").length()) { copyStr(S.city, server.arg("city").c_str(), sizeof(S.city)); S.lat = S.lon = 0; }
  markDirty(D_SET); storeFlush();
  server.send(200, "text/plain; charset=utf-8",
              "✅ Saved! Lilmate is restarting and joining \"" + server.arg("ssid") + "\".\nReconnect your phone to your normal Wi-Fi, then open http://lilmate.local "
              "(or the IP shown on Lilmate's INFO screen). If it can't connect, the setup hotspot comes back.");
  diagRestart(SW_WIFI_SAVE); restartAt = millis() + 1500;
}

void handleScan() {
  int n = WiFi.scanNetworks();
  JsonDocument d; JsonArray a = d.to<JsonArray>();
  for (int i = 0; i < n; i++) {
    String s = WiFi.SSID(i); if (!s.length()) continue;
    bool dup = false; for (JsonVariant v : a) if (s == v.as<const char *>()) dup = true;
    if (!dup) a.add(s);
  }
  WiFi.scanDelete();
  String o; serializeJson(d, o);
  server.send(200, "application/json", o);
}

bool pcUpdate(JsonObjectConst d) {   // shared by HTTP and USB; returns "focus session running"
  pc.cpu = d["cpu"] | 0.0f; pc.ram = d["ram"] | 0.0f; pc.act = d["act"] | 0.0f; pc.bat = d["bat"] | -1; pc.charging = d["charging"] | false;
  copyStr(pc.host, d["host"] | "PC", sizeof(pc.host)); copyStr(pc.title, d["title"] | "", sizeof(pc.title));
  pc.at = millis();
  return fx.running && !fx.isBreak && !fx.paused;
}
void workJson(JsonObject o); void calSet(JsonArrayConst arr);
void handlePc() {
  JsonDocument d;
  if (deserializeJson(d, server.arg("plain"))) { server.send(400, "text/plain", "bad json"); return; }
  bool focus = pcUpdate(d.as<JsonObjectConst>());
  JsonDocument r; r["focus"] = focus; r["mood"] = MOOD_NAMES[mood];
  String o; serializeJson(r, o);
  server.send(200, "application/json", o);
}

void handleGame() {   // GET /api/game?k=L|R|T|X  (k optional = just read the score)
  if (server.hasArg("k") && server.arg("k").length()) gameKey(toupper(server.arg("k")[0]));
  JsonDocument d; gameJson(d.to<JsonObject>());
  String o; serializeJson(d, o);
  server.sendHeader("Cache-Control", "no-store");
  server.send(200, "application/json", o);
}

void webBegin() {
  server.on("/", HTTP_GET, [] { server.send_P(200, "text/html; charset=utf-8", apMode ? SETUP : DASH); });
  server.on("/s.css", HTTP_GET, [] { server.sendHeader("Cache-Control", "max-age=86400"); server.send_P(200, "text/css", CSS); });
  server.on("/api/state", HTTP_GET, sendState);
  server.on("/api/cmd", HTTP_POST, [] {
    // text/plain body (dashboard, agent) or form field c=... (curl -d, HTML forms)
    String body = server.hasArg("c") ? server.arg("c") : server.arg("plain");
    if (!body.length() && server.args() > 0) body = server.argName(0) + (server.arg(0).length() ? "=" + server.arg(0) : String(""));
    String r = runCommand(body, SRC_WEB, "");
    server.send(200, "text/plain; charset=utf-8", r);
  });
  server.on("/api/settings", HTTP_POST, handleSettings);
  server.on("/api/wifi", HTTP_POST, handleWifi);
  server.on("/api/scan", HTTP_GET, handleScan);
  server.on("/api/pc", HTTP_POST, handlePc);
  server.on("/api/game", HTTP_GET, handleGame);
  server.on("/api/screen", HTTP_GET, [] {   // 128x64 frame buffer as hex (SSD1306 page layout) for screenshots
    static const char *H = "0123456789abcdef";
    const uint8_t *b = oled.getBufferPtr();
    String o; o.reserve(2048);
    for (int i = 0; i < 1024; i++) { o += H[b[i] >> 4]; o += H[b[i] & 15]; }
    server.sendHeader("Cache-Control", "no-store");
    server.send(200, "text/plain", o);
  });
  server.on("/api/agent", HTTP_POST, [] {
    JsonDocument d;
    if (deserializeJson(d, server.arg("plain"))) { server.send(400, "application/json", "{\"ok\":false}"); return; }
    agentEvent(d.as<JsonObjectConst>(), false);
    server.send(200, "application/json", "{\"ok\":true}");
  });
  server.on("/api/agent/decision", HTTP_GET, [] {
    uint32_t rid = strtoul(server.arg("rid").c_str(), nullptr, 10);
    char d = agDecision(rid);
    bool pending = false; for (auto &s : ag) if (s.used && s.st == AG_PERM && s.rid == rid) pending = true;
    server.sendHeader("Cache-Control", "no-store");
    server.send(200, "application/json", String("{\"d\":\"") + (d == 'a' ? "allow" : d == 'd' ? "deny" : pending ? "pending" : "none") + "\"}");
  });
  server.on("/api/agent/decide", HTTP_POST, [] {
    bool ok = agDecideRid(strtoul(server.arg("rid").c_str(), nullptr, 10), server.arg("d") == "allow", "dashboard");
    server.send(200, "text/plain; charset=utf-8", ok ? (server.arg("d") == "allow" ? "✅ Allowed" : "⛔ Denied") : "Nothing waiting");
  });
  server.on("/api/cal", HTTP_POST, [] {
    JsonDocument d;
    if (deserializeJson(d, server.arg("plain"))) { server.send(400, "text/plain", "bad json"); return; }
    calSet(d["ev"].as<JsonArrayConst>());
    server.send(200, "application/json", "{\"ok\":true}");
  });
  server.on("/api/link", HTTP_POST, [] {
    String r = linkAction(server.arg("do"), server.hasArg("i") ? server.arg("i").toInt() : -1);
    server.send(200, "text/plain; charset=utf-8", r);
  });
  server.on("/update", HTTP_GET, [] { server.send_P(200, "text/html; charset=utf-8", UPDATE_PAGE); });
  server.on("/update", HTTP_POST,
    [] {
      bool ok = !Update.hasError();
      server.send(200, "text/plain; charset=utf-8", ok ? "✅ Updated! Restarting…" : String("❌ Update failed: ") + Update.errorString());
      if (ok) { diagRestart(SW_OTA); restartAt = millis() + 1000; }
    },
    [] {
      HTTPUpload &u = server.upload();
      if (u.status == UPLOAD_FILE_START) {
        Serial.printf("[ota] %s\n", u.filename.c_str());
        oled.clearBuffer(); centerStr(30, u8g2_font_7x14B_tr, "UPDATING..."); centerStr(46, u8g2_font_5x7_tr, "don't unplug me"); oled.sendBuffer();
        if (!Update.begin(UPDATE_SIZE_UNKNOWN)) Update.printError(Serial);
        else if (server.hasArg("md5") && server.arg("md5").length() == 32) Update.setMD5(server.arg("md5").c_str());   // lil.mate Desk sends it
      } else if (u.status == UPLOAD_FILE_WRITE) {
        if (Update.write(u.buf, u.currentSize) != u.currentSize) Update.printError(Serial);
      } else if (u.status == UPLOAD_FILE_END) {
        if (!Update.end(true)) Update.printError(Serial);
      }
    });
  server.onNotFound([] {
    if (apMode) { server.sendHeader("Location", "http://192.168.4.1/"); server.send(302, "text/plain", ""); }
    else server.send(404, "text/plain", "not found");
  });
  server.begin();
}
