'use strict';
const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('lil', {
  mode: m => ipcRenderer.invoke('mode', m),
  dragMove: (x, y) => ipcRenderer.send('drag:move', x, y),
  dragEnd: () => ipcRenderer.send('drag:end'),
  displays: () => ipcRenderer.invoke('island:displays'),
  moveTo: id => ipcRenderer.invoke('island:move', id),
  resetPos: () => ipcRenderer.invoke('island:reset'),
  cmd: t => ipcRenderer.invoke('cmd', t),
  decide: (rid, d) => ipcRenderer.invoke('decide', rid, d),
  hooks: () => ipcRenderer.invoke('hooks:status'),
  setHook: (tool, on) => ipcRenderer.invoke('hooks:set', tool, on),
  settings: () => ipcRenderer.invoke('settings:get'),
  setSettings: p => ipcRenderer.invoke('settings:set', p),
  setWifi: (s, p) => ipcRenderer.invoke('wifi:set', s, p),
  openDashboard: () => ipcRenderer.invoke('open:dashboard'),
  update: () => ipcRenderer.invoke('update:get'),
  checkUpdates: () => ipcRenderer.invoke('update:check'),
  updateApp: () => ipcRenderer.invoke('update:app'),
  updateFirmware: force => ipcRenderer.invoke('update:fw', force),
  battery: b => ipcRenderer.send('battery', b),
  on: (ch, fn) => { const ok = ['state', 'mode', 'asks', 'link', 'update', 'goto', 'toast']; if (ok.includes(ch)) ipcRenderer.on(ch, (_e, d) => fn(d)); },
});
