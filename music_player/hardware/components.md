# Music Player (Retro PC v2) - components and housing (mm)

Sizes and how the enclosure holds each part. Source: CAD in `../3d/src` and the dimension sheets in `../docs/dimensions/`.

## Components inside the enclosure
Positions are from the CAD: X from the centre line, depth from the front face, height from the table (mm).

| # | Component | W x D x H | X from centre | Depth from front | Height from base |
|---|---|---|---|---|---|
| 1 | OLED 1.3" PCB + glass (+wires) | 35.4 x 12.7 x 32.7 | -17.7..17.7 | 31.2..43.9 | 22.8..55.5 |
| 2 | YX6300 MP3 module + SD + jack | 46.0 x 25.0 x 9.2 | -26.5..19.5 | 29.2..54.2 | 17.7..26.9 |
| 3 | EC11 rotary encoder (body+shaft) | 22.0 x 12.0 x 12.0 | 17.0..39.0 | 37.6..49.6 | 29.0..41.0 |
| 4 | Volume knob (printed) | 7.0 x 13.9 x 13.9 | 29.4..36.4 | 36.7..50.5 | 28.1..41.9 |
| 5 | TP4056 USB-C charger | 17.0 x 27.3 x 4.2 | -8.5..8.5 | 35.7..63.0 | 29.0..33.2 |
| 6 | ESP32-C3 Super Mini | 18.0 x 22.3 x 4.2 | -9.0..9.0 | 40.7..63.0 | 41.0..45.2 |
| 7 | SS-12F15 slide switch | 10.5 x 9.1 x 4.5 | 7.8..18.2 | 57.9..67.0 | 19.8..24.2 |
| 8 | Li-Po 503450 battery | 51.0 x 34.0 x 5.0 | -25.5..25.5 | 28.5..62.5 | 1.7..6.7 |
| 9 | Perfboard + 4 tact switches (6x6x5) | 54.0 x 13.0 x 8.2 | -27.0..27.0 | 7.9..20.9 | 4.3..12.4 |

Full drawings (front, side, top views with the components placed): `docs/dimensions/music_player_enclosure_fit.png` and `docs/dimensions/music_player_dimensions.png`.

## Component details and housing
Each component: its size, then how the enclosure holds it (pockets, slots, clearances, stops, snaps). Sizes in mm.

### 1.3" I2C OLED (SH1106, 4-pin)
- Size: PCB 35.4 x 33.5 x 1.2, glass 34.5 x 23 x 1.5 (centred on the PCB), visible window 31 x 17. Module 2.7 thick (3.3 with the thicker glass used in Deck Buddy).
- Housing: holder bay = PCB + 0.6 mm clearance per side (36.6 x 34.7 inside), bay wall 1.4, bay depth 3.5 behind the PCB (short, easy to fit), visor recess 1.2 in the front skin, PCB corners keep at least 1 mm of skin outside.
- Placement: front face leans back 15 deg; front wall 4 around the screen, pad area 48 x 36, CRT bezel recess 46 x 31 x 1.4 (45 deg chamfer), screen window 32 x 20; PCB bottom 9.5 above the deck.

### YX6300 serial MP3 module (HW-311 layout)
- Size: PCB about 43 x 25 x 1.6 (from photos and the Catalex manual, CONFIRM WITH CALIPERS); microSD socket 14 x 15 x 1.8 under the board; 3.5 mm jack nose sticks out 3 mm past the board edge, jack centre 12.5 from the front edge, 2.8 above the board.
- Housing: board bottom at z 4.5 (socket hangs below) on the deck, front edge at y 4.2 (clears the slanted front wall); held by two ledges at the front and a hook with a ramp at the right end; card enters from the front "floppy" slot (26 x 5.4 recess), jack exits at the monitor side.

### EC11 rotary encoder (right wall)
- Size: body 6.5 deep x 12 x 12, pins 3.5 long, shaft diameter 6 (12 long) with a D-flat, nut about 11 across.
- Housing: hole diameter 7.4 in the right wall at y 18.6, z 20 (local); the printed knob (diameter 13.93 x 7, knurled, orange) presses onto the D-shaft.

### ESP32-C3 Super Mini
- Size: PCB 18 W x 22 L x 1, USB-C opening 9.6 x 3.9, plug niche 13.5 x 7.8. Board at local z 26 in the back cover.

### TP4056 USB-C charger
- Size: PCB 17 W x 27 L x 1. Board bottom at local z 14, guided on rails 18 long in the back cover; USB-C opening 9.6 x 3.9.

### SS-12F15 slide switch
- Size: body 10.5 x 4.5 x 5.1, lever 3 x 3 x 4, travel 3.2. Pocket 11.8 x 5.2, depth 5.1, in the back plate at x 13, z 7 (local).

### Li-Po 503450 battery
- Size: 5 x 34 x 50 (modelled 51 x 34 x 5). Housing: base bay 52 x 35 x 6 at y0 = 3, floor 1.6.

### Keys (4x 6x6x5 tact switches on perfboard)
- Size: tact 6 x 6, body 3.5 high, 5 with plunger; perfboard 54 x 13 x 1.6, switches at 14 mm pitch, centred; keycap 12 x 12 x 4.5 (plate hole 12.4), key plate 1.8 thick on the 12 deg slope. PLAY keycap and knob are the orange parts.

