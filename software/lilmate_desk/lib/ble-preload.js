'use strict';
// Bridge for the hidden Bluetooth window (renderer/ble.html): notifications and disconnects go to the main process.
const { contextBridge, ipcRenderer } = require('electron');
contextBridge.exposeInMainWorld('bleBridge', {
  data: (gen, text) => ipcRenderer.send('ble:data', gen, text),
  gone: gen => ipcRenderer.send('ble:gone', gen),
});
