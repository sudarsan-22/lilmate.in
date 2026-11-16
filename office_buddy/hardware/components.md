# Office Buddy v1 - components and housing (mm)

Sizes and how the enclosure holds each part. Source: CAD in `../3d/src` and the dimension sheets in `../docs/dimensions/`.

## Components inside the enclosure
Positions are from the CAD: X from the centre line, depth from the front face, height from the table (mm).

| # | Component | W x D x H | X from centre | Depth from front | Height from base |
|---|---|---|---|---|---|
| 1 | OLED 1.3" PCB + glass (+wires) | 35.4 x 12.7 x 32.7 | -17.7..17.7 | 31.2..43.9 | 22.8..55.5 |
| 2 | Buzzer passive, diameter 12 | 12.0 x 12.0 x 8.5 | -25.2..-13.2 | 36.5..48.5 | 15.2..23.7 |
| 3 | EC11 rotary encoder (body+shaft) | 22.0 x 12.0 x 12.0 | 17.0..39.0 | 37.6..49.6 | 29.0..41.0 |
| 4 | Volume knob (printed) | 7.0 x 13.9 x 13.9 | 29.4..36.4 | 36.7..50.5 | 28.1..41.9 |
| 5 | TP4056 USB-C charger | 17.0 x 23.8 x 4.2 | -8.5..8.5 | 39.2..63.0 | 29.0..33.2 |
| 6 | ESP32-C3 Super Mini | 18.0 x 22.3 x 4.2 | -9.0..9.0 | 40.7..63.0 | 41.0..45.2 |
| 7 | SS-12F15 slide switch | 11.0 x 9.0 x 5.0 | 7.5..18.5 | 57.0..66.0 | 19.5..24.5 |
| 8 | Li-Po 503450 battery | 51.0 x 34.0 x 5.0 | -25.5..25.5 | 28.5..62.5 | 1.7..6.7 |
| 9 | Switch carrier + 4 tact switches (11x11x4.3) | 59.0 x 11.4 x 8.3 | -29.5..29.5 | 8.4..19.9 | 2.3..10.7 |

Full drawings (front, side, top views with the components placed): `docs/dimensions/office_buddy_enclosure_fit.png` and `docs/dimensions/office_buddy_dimensions.png`.

## Component details and housing
Each component: its size, then how the enclosure holds it (pockets, slots, clearances, stops, snaps). Sizes in mm.

### 1.3" I2C OLED (SH1106, 4-pin)
- Size: PCB 35.4 x 33.5 x 1.2, glass 34.5 x 23 x 1.5 (centred on the PCB), visible window 31 x 17. Module 2.7 thick (3.3 with the thicker glass used in Deck Buddy).
- Housing: holder bay = PCB + 0.6 mm clearance per side (36.6 x 34.7 inside), bay wall 1.4, bay depth 3.5 behind the PCB (short, easy to fit), visor recess 1.2 in the front skin, PCB corners keep at least 1 mm of skin outside.
- Placement: front face leans back 15 deg; front wall 4 around the screen, pad area 48 x 36, CRT bezel recess 46 x 31 x 1.4 (45 deg chamfer), screen window 32 x 20; PCB bottom 9.5 above the deck.

### Buzzer (passive, 12 mm)
- Size: diameter 12, 8.5 high. Housing: stands on the deck beside the left wall at x -19.2, y 17.5, z 0.2 (clears the deck lip and the OLED bay wall). The YX6300 MP3 module is NOT used in this product.

### EC11 rotary encoder (right wall)
- Size: body 6.5 deep x 12 x 12, pins 3.5 long, shaft diameter 6 (12 long) with a D-flat, nut about 11 across.
- Housing: hole diameter 7.4 in the right wall at y 18.6, z 20 (local); the printed knob (diameter 13.93 x 7, knurled, orange) presses onto the D-shaft.

### TP4056 USB-C charger (shortened)
- Size: PCB 17 W x 23.5 L x 1 (cut down 4 mm; 24.1 overall with the USB port), mounting holes diameter 1.3 (assumed, confirm) 1.5 from the long edges (14 apart) and 1.95 from each end.
- Housing: slot length 26.5 from the plate, lip 1.0 over the edge, shelf 1.0 under it, 0.2 clearance per side, guide walls 1.2, PCB end 0.7 from the plate inner face; four vertical lock pins (shaft 1.5, head 2.5, socket 1.65) through the mounting holes into blocks under the board. Board at local z 14. Tuned with the `print/tests/` coupons.

### ESP32-C3 Super Mini
- Size: PCB 18 W x 22 L x 1, USB-C opening 9.6 x 3.9, plug niche 13.5 x 7.8. Slot 22 deep, USB-C end closed so the board is held, not stopped; board at local z 26.

### SS-12F15 slide switch (locking housing)
- Size: body 11 x 5 x 5, lever 3 x 3 x 4, travel 3.2. Housing = the tested Deck Buddy/Elephant design: pocket 12.1 x 5.8, lips 0.6 per side, lip walls 0.8, lever slot 7 x 3.6, plate 1.4, finger niche 1.6, housing depth 6.5; at x 13, z 7 (local).

### Li-Po 503450 battery
- Size: 5 x 34 x 50 (modelled 51 x 34 x 5). Housing: base bay 52 x 35 x 6 at y0 = 3.

### Keys (4x 11x11x4.3 four-pin DIP tact switches, sizes assumed from the listing, CONFIRM WITH CALIPERS)
- Size: body 11 x 11 x 3.3, button diameter 6 standing 1.0 above, legs trimmed to 3.
- Housing: one printed carrier 64.4 x 16.4 x 4.5, pocket 13 x 12 per switch (1.5 gap), walls 1.2, support ledge 0.8 with four 4 mm tabs (reach 3.5), switch drops in from the top, body top 0.4 below the rim, 1.5 gap to the key plate for keycap flange and travel. Keycap 13.5 at 16 mm pitch, key plate 1.8, cap height 4.5, slope 12 deg.

