// Private ICS calendar link -> upcoming timed meetings [{t, e, s}] (epoch seconds), RRULE DAILY/WEEKLY/MONTHLY aware.
'use strict';

function unfold(text) {
  const out = [];
  for (const line of text.split(/\r?\n/)) {
    if ((line[0] === ' ' || line[0] === '\t') && out.length) out[out.length - 1] += line.slice(1);
    else out.push(line);
  }
  return out;
}

// wall-clock time in an IANA zone -> UTC ms (two passes handle DST edges)
function zonedToUtc(y, mo, d, h, mi, s, tz) {
  let guess = Date.UTC(y, mo - 1, d, h, mi, s);
  for (let i = 0; i < 2; i++) {
    const parts = Object.fromEntries(new Intl.DateTimeFormat('en-US', { timeZone: tz, hourCycle: 'h23', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' })
      .formatToParts(new Date(guess)).filter(p => p.type !== 'literal').map(p => [p.type, +p.value]));
    const asUtc = Date.UTC(parts.year, parts.month - 1, parts.day, parts.hour % 24, parts.minute, parts.second);
    guess += Date.UTC(y, mo - 1, d, h, mi, s) - asUtc;
  }
  return guess;
}

function parseDt(value, params) {
  if (params.VALUE === 'DATE' || value.length === 8) return null;          // all-day: not a meeting
  const m = /^(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})(\d{2})(Z?)/.exec(value.trim());
  if (!m) return null;
  const [y, mo, d, h, mi, s] = m.slice(1, 7).map(Number);
  if (m[7] === 'Z') return Date.UTC(y, mo - 1, d, h, mi, s);
  const tz = (params.TZID || '').replace(/"/g, '');
  if (tz) { try { return zonedToUtc(y, mo, d, h, mi, s, tz); } catch (e) { /* unknown zone name: local */ } }
  return new Date(y, mo - 1, d, h, mi, s).getTime();
}

function parseDuration(v) {
  const m = /^P(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?)?/.exec(v || '');
  if (!m) return null;
  const [d, h, mi, s] = m.slice(1).map(x => +(x || 0));
  return ((d * 24 + h) * 60 + mi) * 60 + s;
}

const DAY = 86400000;
const WD = { SU: 0, MO: 1, TU: 2, WE: 3, TH: 4, FR: 5, SA: 6 };

function parseIcs(text, horizonH = 36) {
  const now = Date.now(), endW = now + horizonH * 3600000;
  const events = []; let cur = null;
  for (const line of unfold(text)) {
    if (line === 'BEGIN:VEVENT') cur = { EXDATE: [] };
    else if (line === 'END:VEVENT' && cur) { events.push(cur); cur = null; }
    else if (cur && line.includes(':')) {
      const i = line.indexOf(':'); const head = line.slice(0, i), val = line.slice(i + 1);
      const parts = head.split(';'); const name = parts[0].toUpperCase();
      const params = Object.fromEntries(parts.slice(1).filter(p => p.includes('=')).map(p => [p.split('=')[0].toUpperCase(), p.slice(p.indexOf('=') + 1)]));
      if (name === 'EXDATE') { for (const v of val.split(',')) { const t = parseDt(v, params); if (t) cur.EXDATE.push(t); } }
      else cur[name] = [val, params];
    }
  }
  const overrides = {};
  for (const e of events) if (e['RECURRENCE-ID'] && e.UID) { const t = parseDt(...e['RECURRENCE-ID']); if (t) (overrides[e.UID[0]] = overrides[e.UID[0]] || new Set()).add(t); }
  const out = [];
  for (const e of events) {
    if (!e.DTSTART || (e.STATUS && e.STATUS[0].toUpperCase() === 'CANCELLED')) continue;
    const st = parseDt(...e.DTSTART); if (!st) continue;
    let dur = 1800;
    if (e.DTEND) { const en = parseDt(...e.DTEND); if (en) dur = (en - st) / 1000; }
    else if (e.DURATION) dur = parseDuration(e.DURATION[0]) || 1800;
    const title = (e.SUMMARY ? e.SUMMARY[0] : 'meeting').replace(/\\([,;nN])/g, (_, c) => (c === 'n' || c === 'N') ? ' ' : c).trim().slice(0, 31) || 'meeting';
    const isOverride = !!e['RECURRENCE-ID'];
    const skip = isOverride ? new Set() : new Set([...e.EXDATE, ...((e.UID && overrides[e.UID[0]]) || [])]);
    let starts = [st];
    if (e.RRULE && !isOverride) {
      const r = Object.fromEntries(e.RRULE[0].split(';').filter(x => x.includes('=')).map(x => x.split('=')));
      const freq = r.FREQ, step = +(r.INTERVAL || 1), count = r.COUNT ? +r.COUNT : null;
      let until = null;
      if (r.UNTIL) until = r.UNTIL.length === 8 ? Date.UTC(+r.UNTIL.slice(0, 4), +r.UNTIL.slice(4, 6) - 1, +r.UNTIL.slice(6, 8)) + DAY : parseDt(r.UNTIL, {});
      const byday = (r.BYDAY || '').split(',').map(x => WD[x.slice(-2)]).filter(x => x !== undefined).sort();
      starts = []; let n = 0;
      const s0 = new Date(st);
      for (let k = 0; k < 4000; k++) {
        let cands = [];
        if (freq === 'DAILY') cands = [new Date(s0.getTime()).setDate(s0.getDate() + k * step)];
        else if (freq === 'WEEKLY') {
          const wk0 = new Date(s0); wk0.setDate(s0.getDate() - s0.getDay() + k * 7 * step);
          cands = (byday.length ? byday : [s0.getDay()]).map(dw => new Date(wk0).setDate(wk0.getDate() + dw)).filter(c => c >= st);
        } else if (freq === 'MONTHLY') { const c = new Date(s0); c.setMonth(s0.getMonth() + k * step); if (c.getDate() === s0.getDate()) cands = [c.getTime()]; }
        else cands = k === 0 ? [st] : [];
        let stop = false;
        for (const c of cands) {
          if ((until && c > until) || c > endW) { stop = true; break; }
          if (count && ++n > count) { stop = true; break; }
          starts.push(c);
        }
        if (stop || !['DAILY', 'WEEKLY', 'MONTHLY'].includes(freq)) break;
      }
    }
    for (const s of starts) {
      if (skip.has(s)) continue;
      if (s + dur * 1000 > now && s <= endW) out.push({ t: Math.floor(s / 1000), e: Math.floor(s / 1000 + dur), s: title });
    }
  }
  const seen = new Set();
  return out.sort((a, b) => a.t - b.t).filter(x => { const k = x.t + x.s; if (seen.has(k)) return false; seen.add(k); return true; }).slice(0, 6);
}

async function fetchCalendar(url) {
  const ctl = new AbortController(); const t = setTimeout(() => ctl.abort(), 15000);
  try { const r = await fetch(url, { signal: ctl.signal, headers: { 'User-Agent': 'lilmate-desk' } }); return parseIcs(await r.text()); }
  finally { clearTimeout(t); }
}

module.exports = { parseIcs, fetchCalendar };
