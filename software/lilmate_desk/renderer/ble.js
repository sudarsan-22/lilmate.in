'use strict';
// Web Bluetooth side of the buddy's Bluetooth line link (see lib/ble.js). Same service as the firmware's update service.
const SVC = '6c696c6d-6174-6501-8000-00805f9b34fb';
const LRX = '6c696c6d-6174-6505-8000-00805f9b34fb';   // we write lines here
const LTX = '6c696c6d-6174-6506-8000-00805f9b34fb';   // replies arrive as notifications
let dev = null, rx = null, chain = Promise.resolve(), gen = 0;   // gen: each connection's number, so a late event of an old one is ignored
const dec = new TextDecoder(), enc = new TextEncoder();

// called by main with a user gesture; main picks the device in select-bluetooth-device
window.bleConnect = async () => {
  try { if (dev && dev.gatt.connected) dev.gatt.disconnect(); } catch (e) {}
  const my = ++gen;
  dev = await navigator.bluetooth.requestDevice({ filters: [{ services: [SVC] }] });
  dev.addEventListener('gattserverdisconnected', () => { if (my === gen) rx = null; bleBridge.gone(my); });
  const gatt = await dev.gatt.connect();
  const svc = await gatt.getPrimaryService(SVC);
  rx = await svc.getCharacteristic(LRX);
  const tx = await svc.getCharacteristic(LTX);
  const onValue = e => { if (my === gen) bleBridge.data(my, dec.decode(e.target.value)); };
  if (tx._lilOnValue) tx.removeEventListener('characteristicvaluechanged', tx._lilOnValue);   // same object again on a reconnect
  tx._lilOnValue = onValue; tx.addEventListener('characteristicvaluechanged', onValue);
  // On a reconnect Chromium hands back the same characteristic and may think it is still subscribed, but the buddy
  // forgot the subscription when the link dropped: stop first so start really writes the subscription again.
  await tx.stopNotifications().catch(() => {});
  await tx.startNotifications();
  return { name: dev.name || '', gen: my };
};

// writes go one after another (a GATT link takes one write at a time), 180 bytes each: fits every MTU Chromium negotiates
window.bleWrite = text => {
  const bytes = enc.encode(text);
  chain = chain.then(async () => {
    for (let o = 0; o < bytes.length && rx; o += 180) await rx.writeValueWithResponse(bytes.subarray(o, o + 180));
  }).catch(() => {});
  return chain;
};

window.bleClose = () => { try { if (dev && dev.gatt.connected) dev.gatt.disconnect(); } catch (e) {} rx = null; };
