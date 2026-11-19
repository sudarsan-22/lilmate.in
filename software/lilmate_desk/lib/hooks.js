// One-click connect / disconnect for AI coding tools. Every hook points at this app on 127.0.0.1,
// so customers need no Python: Claude Code uses native HTTP hooks, the others a one-line curl.
'use strict';
const fs = require('fs');
const os = require('os');
const path = require('path');

const PORT = 47823;
const BASE = `http://127.0.0.1:${PORT}`;
const MARK = '127.0.0.1:47823';           // how we recognise our own hooks
const HOME = os.homedir();
const WIN = process.platform === 'win32';
const CURL = WIN ? 'curl.exe' : 'curl';   // Windows 10+ ships curl.exe

function readJson(p, dflt) {
  try { const raw = fs.readFileSync(p, 'utf8'); return raw.trim() ? JSON.parse(raw) : dflt; } catch (e) { return dflt; }
}
function backup(p) {
  if (fs.existsSync(p)) {
    const stamp = new Date().toISOString().replace(/[-:]/g, '').replace(/\..+/, '').replace('T', '-');
    fs.copyFileSync(p, `${p}.bak-${stamp}`);
  }
}
function writeJson(p, obj) { fs.mkdirSync(path.dirname(p), { recursive: true }); fs.writeFileSync(p, JSON.stringify(obj, null, 2) + '\n'); }
const ours = h => JSON.stringify(h).includes(MARK);
function curlPost(url) { return `${CURL} -s -m 3 -X POST -H "Content-Type: application/json" --data-binary @- ${url}`; }

// ------------------------------------------------------------ Claude Code (~/.claude/settings.json, HTTP hooks)
const CLAUDE = path.join(HOME, '.claude', 'settings.json');
const CLAUDE_EVENTS = { UserPromptSubmit: 5, PostToolUse: 5, Stop: 5, StopFailure: 5, Notification: 5, SessionEnd: 5 };

function stripClaude(cfg) {
  const hooks = cfg.hooks || {};
  for (const ev of Object.keys(hooks)) {
    hooks[ev] = (hooks[ev] || []).map(g => ({ ...g, hooks: (g.hooks || []).filter(h => !ours(h) && !String(h.command || '').includes('lilmate_agent.py')) }))
                                 .filter(g => g.hooks.length);
    if (!hooks[ev].length) delete hooks[ev];
  }
  if (Object.keys(hooks).length) cfg.hooks = hooks; else delete cfg.hooks;
  return cfg;
}
function claude(install, opts = {}) {
  const cfg = stripClaude(readJson(CLAUDE, {}));
  if (install) {
    cfg.hooks = cfg.hooks || {};
    for (const [ev, t] of Object.entries(CLAUDE_EVENTS)) (cfg.hooks[ev] = cfg.hooks[ev] || []).push({ hooks: [{ type: 'http', url: `${BASE}/hook/claude`, timeout: t }] });
    if (opts.approve !== false) (cfg.hooks.PermissionRequest = cfg.hooks.PermissionRequest || []).push({ hooks: [{ type: 'http', url: `${BASE}/hook/claude`, timeout: 45 }] });
  }
  backup(CLAUDE); writeJson(CLAUDE, cfg);
}
function claudeInstalled() { return JSON.stringify(readJson(CLAUDE, {}).hooks || {}).includes(MARK); }

// ------------------------------------------------------------ GitHub Copilot in VS Code (~/.copilot/hooks/lilmate.json)
const COPILOT = path.join(HOME, '.copilot', 'hooks', 'lilmate.json');
function copilot(install) {
  if (!install) { try { fs.unlinkSync(COPILOT); } catch (e) {} return; }
  const hooks = {};
  for (const ev of ['userPromptSubmitted', 'agentStop', 'sessionEnd']) hooks[ev] = [{ type: 'command', command: curlPost(`${BASE}/hook/copilot/${ev}`), timeoutSec: 5 }];
  writeJson(COPILOT, { version: 1, hooks });
}
const copilotInstalled = () => fs.existsSync(COPILOT);

// ------------------------------------------------------------ Cursor (~/.cursor/hooks.json)
const CURSOR = path.join(HOME, '.cursor', 'hooks.json');
function cursor(install, opts = {}) {
  const cfg = readJson(CURSOR, { version: 1, hooks: {} });
  cfg.hooks = cfg.hooks || {};
  for (const ev of Object.keys(cfg.hooks)) { cfg.hooks[ev] = cfg.hooks[ev].filter(h => !ours(h)); if (!cfg.hooks[ev].length) delete cfg.hooks[ev]; }
  if (install) {
    for (const ev of ['beforeSubmitPrompt', 'stop', 'sessionEnd']) (cfg.hooks[ev] = cfg.hooks[ev] || []).push({ command: curlPost(`${BASE}/hook/cursor/${ev}`), timeout: 5 });
    if (opts.approve) (cfg.hooks.beforeShellExecution = cfg.hooks.beforeShellExecution || []).push({ command: curlPost(`${BASE}/hook/cursor/beforeShellExecution`), timeout: 45 });
  }
  cfg.version = cfg.version || 1;
  backup(CURSOR); writeJson(CURSOR, cfg);
}
const cursorInstalled = () => JSON.stringify(readJson(CURSOR, {})).includes(MARK);

// ------------------------------------------------------------ Codex CLI (~/.codex/config.toml: notify appends the JSON as the last argument)
const CODEX = path.join(HOME, '.codex', 'config.toml');
function codex(install) {
  let lines = fs.existsSync(CODEX) ? fs.readFileSync(CODEX, 'utf8').split(/\r?\n/) : [];
  lines = lines.filter(l => !l.includes(MARK));
  if (install) {
    if (lines.some(l => /^\s*notify\s*=/.test(l))) throw new Error('Codex already has a "notify" setting; add lil.mate by hand');
    lines.unshift('notify = ' + JSON.stringify([CURL, '-s', '-m', '3', '-H', 'Content-Type: application/json', `${BASE}/hook/codex`, '-d']));
  }
  backup(CODEX); fs.mkdirSync(path.dirname(CODEX), { recursive: true });
  fs.writeFileSync(CODEX, lines.join('\n').replace(/\n*$/, '\n'));
}
const codexInstalled = () => fs.existsSync(CODEX) && fs.readFileSync(CODEX, 'utf8').includes(MARK);

const TOOLS = {
  claude: { name: 'Claude Code', set: claude, installed: claudeInstalled, approve: true },
  copilot: { name: 'GitHub Copilot (VS Code)', set: copilot, installed: copilotInstalled, approve: false },
  cursor: { name: 'Cursor', set: cursor, installed: cursorInstalled, approve: 'optional' },
  codex: { name: 'Codex CLI', set: codex, installed: codexInstalled, approve: false },
};
function status() { const o = {}; for (const [k, t] of Object.entries(TOOLS)) { try { o[k] = t.installed(); } catch (e) { o[k] = false; } } return o; }
function set(tool, on, opts) { TOOLS[tool].set(on, opts || {}); return status(); }

module.exports = { PORT, TOOLS, status, set };
