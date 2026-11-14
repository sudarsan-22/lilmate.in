# L "Tiny Retro PC" – component list (draft, 2026-11-14)

The user chose concept L. Look: proposal/look4.scad (design=12), render: previews/r4_12_front.png.
Outer size 68.4 W (with knob) × 67 D × 65 H mm. v2 (2026-11-14): the screen face leans back 15° (wedge monitor, 28 mm deep at the deck, 14.6 at the top).

## Electronics
| # | Part | Qty | Size (mm) | Source of size | Where it goes |
|---|---|---|---|---|---|
| 1 | 1.3" I2C OLED, 4-pin (SH1106) | 1 | PCB 35.4 × 33.5 × 1.2, glass 1.5, window 31 × 17 | measured (Pengu/Ellie) | behind the CRT glass, monitor front |
| 2 | ESP32-C3 Super Mini (Robocraze) | 1 | 22 × 18 × 1 (+ USB-C) | measured (Ellie) | monitor, behind the OLED; USB-C reachable from the back for flashing |
| 3 | YX6300 serial MP3 module, OceanLabz (Amazon B0D5BC4YV2), Catalex "Serial MP3 Player" / HW-311 layout | 1 | PCB about 43 × 25 × 1.6; overall about 49 × 24 × 8.5 including the jack overhang (Catalex manual). Top side: 3.5 mm jack on one short edge, 4-pin RX/TX/VCC/GND header on the other short edge. Underside: microSD socket in the middle, mouth toward one long edge. 4 corner holes | photos + manual, **confirm with calipers** | flat on the monitor floor, long axis left–right; card enters from the front "floppy" slot, jack out the monitor side |
| 4 | TP4056 USB-C charger (with protection) | 1 | 27 × 17 × 1 | measured (Ellie) | base or monitor, USB-C out the back |
| 5 | Li-Po **503450** (about 1000 mAh, with protection board) | 1 | 5 × 34 × 50 (bay 52 × 35 × 6) | the user decided on 2026-11-14 | flat in the base under the monitor |
| 6 | Slide switch SS-12F15 (ears bent) | 1 | body 10.5 × 4.5 × 5.1, lever 3 × 3 × 4, travel 3.2 | datasheet (Pengu) | back of the monitor |
| 7 | 6×6×**5** mm tactile switch (5 mm total height) | 4 | 6 × 6 body 3.5 high, plunger to 5 | standard | under the 4 keycaps, on a perfboard strip on the 12° slope |
| 8 | EC11 rotary encoder, horizontal shaft | 1 | body 12 × 12 × ~7, 6 mm D-shaft 15–20 long | standard | right side, inside the orange volume knob |
| 9 | ~~TTP223~~: **not used** (the user decided on 2026-11-14) | – | – | – | – |
| 10 | Perfboard strip for the keys | 1 | **54 × 13**, switches at 14 mm pitch, centred | cut to fit | snaps into the key-plate frame |
| 11 | Wires (silicone 28–30 AWG), heat-shrink | – | – | – | – |

## Printed parts (single colour, painted or multi-colour later)
- Monitor shell (front, bezel, floppy bay, vents)
- Monitor back cover (CRT taper; ports: TP4056 USB-C, 3.5 mm jack, switch)
- Base / keyboard wedge (battery bay, key perfboard)
- 4 keycaps (dished; one orange PLAY)
- Volume knob (knurled, orange), pressed onto the EC11 D-shaft
- Eject button and power-LED pip (decorative or a real LED)

## Power and runtime (rough)
- ESP32-C3 at about 20–25 mA (Wi-Fi off), OLED at about 10–15 mA, and YX6300 playing into headphones at about 20–30 mA add up to roughly 60–70 mA.
- 300 mAh gives about 4 h of playback. A 1000 mAh cell gives about 13 h, if a flat one fits in the base.

## Provisional ESP32-C3 pin map (13 usable GPIO: 0–10, 20, 21)
| Function | GPIO |
|---|---|
| OLED SDA / SCL | 8 / 9 |
| YX6300 RX / TX (UART1) | 21 / 20 |
| Keys prev / play / next / face | 0 / 1 / 3 / 4 (or all on one ADC pin with a resistor ladder) |
| EC11 A / B | 5 / 6 |
| TTP223 | 10 |
| spare | 2, 7 |

## Open questions
1. ~~YX6300 size~~: the board is the HW-311 layout (photos in reference/yx6300_amazon/). Confirm 43×25 PCB and the hole spacing with calipers when it arrives.
2. ~~Speaker~~: **NO speaker** (the user decided on 2026-11-14). Listening is through headphones (3.5 mm) or Bluetooth.
2b. ~~Bluetooth~~: **A, wired only** (the user decided on 2026-11-14). For reference: the ESP32-C3 has only BLE, and the YX6300 has no BT, so neither can stream music to BT headphones. Options: (A) wired only; (B) the user plugs a 3.5 mm BT transmitter dongle into the jack; (C) build in a KCX_BT_EMITTER module (about 23×15 mm, line-in from the YX6300 jack pads, pairing pin to a spare GPIO).
3. Battery: keep the 300 mAh, or use a bigger flat cell in the base?
4. Keys: 6×6 tact switches (cheap) or Kailh Choc low-profile (real keyboard click)?
5. Keep the TTP223 "pat" touch?
6. Closure: snap-fit like Pengu/Ellie (no screws)?
