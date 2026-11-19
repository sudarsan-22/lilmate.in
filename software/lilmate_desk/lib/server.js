// Local hook server on 127.0.0.1:47823 — AI tools report here, the app forwards to the buddy.
'use strict';
const http = require('http');
const path = require('path');
const { PORT } = require('./hooks');

const base = (sid, cwd, tool) => ({ sid: String(sid || tool).slice(0, 12), name: (path.basename(String(cwd || '').replace(/[\\/]+$/, '')) || tool).slice(0, 19), tool });
const clean = s => String(s || '').replace(/\s+/g, ' ').trim();

function describeTool(name, input) {
  if (input && typeof input === 'object') {
    for (const k of ['command', 'file_path', 'path', 'url', 'pattern', 'query', 'description']) if (input[k]) return `${name}: ${input[k]}`;
    return `${name}: ${JSON.stringify(input).slice(0, 80)}`;
  }
  return String(name || 'tool');
}

// app = { event(ev), ask(ev) -> Promise<'allow'|'deny'|null>, cmd(text), decide(rid,d), link() }
function start(app) {
  async function route(url, body) {
    const p = url.pathname;
    // ---------------- Claude Code (native HTTP hooks: raw hook JSON)
    if (p === '/hook/claude') {
      const b = base(body.session_id, body.cwd, 'claude');
      switch (body.hook_event_name) {
        case 'UserPromptSubmit': app.event({ ...b, ev: 'start' }); break;
        case 'PostToolUse': case 'PostToolUseFailure': app.event({ ...b, ev: 'tool' }); break;
        case 'Stop': app.event({ ...b, ev: 'stop', msg: clean(body.last_assistant_message).slice(0, 90) }); break;
        case 'StopFailure': app.event({ ...b, ev: 'error', msg: clean(body.error || 'API error').slice(0, 90) }); break;
        case 'SessionEnd': app.event({ ...b, ev: 'end' }); break;
        case 'Notification': {
          const t = String(body.notification_type || ''); const msg = clean(body.message);
          const kind = t.includes('permission') || /permission/i.test(msg) ? 'permission' : t.includes('idle') ? 'idle' : 'question';
          app.event({ ...b, ev: 'needs', kind, msg: msg.slice(0, 90) }); break;
        }
        case 'PermissionRequest': {
          const d = await app.ask({ ...b, msg: describeTool(body.tool_name, body.tool_input).slice(0, 95) });
          if (!d) return {};                                   // no answer: Claude shows its normal prompt
          const decision = { behavior: d };
          if (d === 'deny') decision.message = 'The user denied this from their lil.mate desk buddy.';
          return { hookSpecificOutput: { hookEventName: 'PermissionRequest', decision } };
        }
      }
      return {};
    }
    // ---------------- GitHub Copilot in VS Code (camelCase payloads, event in the URL)
    let m;
    if ((m = /^\/hook\/copilot\/(\w+)$/.exec(p))) {
      const ev = { userPromptSubmitted: 'start', postToolUse: 'tool', agentStop: 'stop', sessionEnd: 'end' }[m[1]];
      if (ev) app.event({ ...base(body.sessionId || body.session_id, body.cwd, 'copilot'), ev });
      return {};
    }
    // ---------------- Cursor
    if ((m = /^\/hook\/cursor\/(\w+)$/.exec(p))) {
      const b = base(body.conversation_id, (body.workspace_roots || [])[0], 'cursor');
      if (m[1] === 'beforeSubmitPrompt') { app.event({ ...b, ev: 'start' }); return { continue: true }; }
      if (m[1] === 'stop') { app.event({ ...b, ev: body.status === 'error' ? 'error' : 'stop' }); return {}; }
      if (m[1] === 'sessionEnd') { app.event({ ...b, ev: 'end' }); return {}; }
      if (m[1] === 'beforeShellExecution') {
        const d = await app.ask({ ...b, msg: ('Shell: ' + (body.command || '')).slice(0, 95) });
        return d ? { permission: d, ...(d === 'deny' ? { user_message: 'Denied from your lil.mate desk buddy.' } : {}) } : { permission: 'ask' };
      }
      return {};
    }
    // ---------------- Codex (notify: JSON payload)
    if (p === '/hook/codex') {
      if (body.type === 'agent-turn-complete') app.event({ ...base(body['thread-id'] || body['turn-id'], body.cwd || '', 'codex'), ev: 'stop', msg: clean(body['last-assistant-message']).slice(0, 90) });
      return {};
    }
    // ---------------- older lilmate_agent.py hooks + scripts keep working
    if (p === '/event') { app.event(body); return { ok: true }; }
    if (p === '/ping') { const l = app.link(); return { ok: true, via: l ? l.kind : 'none' }; }
    if (p === '/cmd') return { reply: await app.cmd(typeof body === 'string' ? body : body.text || '') };
    return null;
  }

  const server = http.createServer((req, res) => {
    let raw = '';
    req.on('data', c => { raw += c; if (raw.length > 1e6) req.destroy(); });
    req.on('end', async () => {
      const url = new URL(req.url, 'http://127.0.0.1');
      let body = {};
      try { body = raw ? JSON.parse(raw) : {}; } catch (e) { body = raw; }
      try {
        const out = await route(url, body);
        if (out === null) { res.writeHead(404); return res.end(); }
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(out));
      } catch (e) { res.writeHead(500, { 'Content-Type': 'application/json' }); res.end('{}'); }
    });
  });
  server.on('error', e => console.error('[server]', e.message));
  server.listen(PORT, '127.0.0.1');
  return server;
}

module.exports = { start };
