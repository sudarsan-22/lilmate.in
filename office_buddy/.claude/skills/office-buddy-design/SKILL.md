---
name: office-buddy-design
description: Work on the Office Buddy v1 lilmate desk buddy: change its CAD, check component fit, re-export STLs, reprint or re-slice the final 3mf (OFFICE_BUDDY_FINAL.gcode.3mf). Use this whenever the user mentions office buddy, Office Buddy v1, its enclosure, dimensions, components, or its final print file, even if they do not name the project folder.
---

# Office Buddy v1

Retro-PC office buddy, wider than the Music Player (base 74 mm): 1.3" OLED, buzzer, ESP32-C3, TP4056 on a pin-mounted carrier, 4 keys and a volume knob.

Project folder: `office_buddy/` (layout: `3d/` = CAD, print files and archive; `firmware/`; `hardware/`; `docs/`; `packaging/`).

## Final print file
- `3d/print/OFFICE_BUDDY_FINAL.gcode.3mf`
- Plate contents: print_base, print_deck, print_keyplate, print_carrier, print_shell, print_back, print_key0-3, print_knob, print_pin
- Print settings read from the file: 0.12 mm layers (first 0.2), 3 walls, 15% gyroid, 6 top / 5 bottom shells, no supports, auto brim, PLA 220 C / bed 60 C (Cool Plate), outer wall 200 mm/s, process "0.12mm Fine (lilmate retro pc)", Bambu Lab A1 mini, 0.4 nozzle
- Estimated: about 3 h 07 min, 58 g

## Dimensions
Assembled enclosure: **W 74.0 x D 67.0 x H 65.0** mm.

Printed parts, bounding box in mm (W = X, D = Y, H = Z, print orientation):

| Part | W | D | H |
|---|---|---|---|
| Shell | 58.00 | 28.00 | 50.00 |
| Back | 58.00 | 50.00 | 28.50 |
| Base | 74.00 | 67.00 | 15.00 |
| Deck | 70.20 | 40.80 | 6.49 |
| Keyplate | 70.20 | 21.79 | 9.55 |
| Carrier | 63.40 | 14.40 | 4.50 |
| Key (x4) | 13.50 | 15.30 | 7.20 |
| Knob | 13.93 | 13.93 | 7.00 |
| Pin | 2.50 | 2.50 | 3.40 |

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
- Housing: slot length 26.5 from the plate, lip 1.0 over the edge, shelf 1.0 under it, 0.2 clearance per side, guide walls 1.2, PCB end 0.7 from the plate inner face; four vertical lock pins (shaft 1.5, head 2.5, socket 1.65) through the mounting holes into blocks under the board. Board at local z 14. Tuned with the `3d/print/tests/` coupons.

### ESP32-C3 Super Mini
- Size: PCB 18 W x 22 L x 1, USB-C opening 9.6 x 3.9, plug niche 13.5 x 7.8. Slot 22 deep, USB-C end closed so the board is held, not stopped; board at local z 26.

### SS-12F15 slide switch (locking housing)
- Size: body 11 x 5 x 5, lever 3 x 3 x 4, travel 3.2. Housing = the tested Deck Buddy/Elephant design: pocket 12.1 x 5.8, lips 0.6 per side, lip walls 0.8, lever slot 7 x 3.6, plate 1.4, finger niche 1.6, housing depth 6.5; at x 13, z 7 (local).

### Li-Po 503450 battery
- Size: 5 x 34 x 50 (modelled 51 x 34 x 5). Housing: base bay 52 x 35 x 6 at y0 = 3.

### Keys (4x 11x11x4.3 four-pin DIP tact switches, sizes assumed from the listing, CONFIRM WITH CALIPERS)
- Size: body 11 x 11 x 3.3, button diameter 6 standing 1.0 above, legs trimmed to 3.
- Housing: one printed carrier 64.4 x 16.4 x 4.5, pocket 13 x 12 per switch (1.5 gap), walls 1.2, support ledge 0.8 with four 4 mm tabs (reach 3.5), switch drops in from the top, body top 0.4 below the rim, 1.5 gap to the key plate for keycap flange and travel. Keycap 13.5 at 16 mm pitch, key plate 1.8, cap height 4.5, slope 12 deg.

## How to change or rebuild
- `3d/src/main.scad`: same `part` modes as Music Player plus `carrier`, `print_carrier`, `print_pin`.
- `3d/build/check.scad` runs the clash check; `3d/build/export_parts.sh` exports all parts.
- Exports: `3d/output/v1/*.stl`; test coupons (`3d/output/test_key`, `3d/output/test_tp`) and their sliced files are in `3d/print/tests/`.
- Design notes: `docs/design_proposal.md`; look reference: `3d/reference/look_reference_retro_pc.png`.
- Run OpenSCAD from inside `3d/src/` so relative imports resolve, for example `cd 3d/src && openscad -o ../output/x.stl -D 'part="..."' main.scad`.
- After a CAD change: re-export the STLs into `3d/output/`, re-run the clash check where the project has one, re-slice, and save the new final file under the same `_FINAL` name (move the old one to `3d/print/older/`).
- Keep a copy of the previous source in `3d/archive/src/` as `main_before_<change>.scad` before large edits.

## Design rules and gotchas
- TP4056 is held on 4 pins (`print_pin`) in the base sockets; the charger slot, key pockets and switch lock were tuned with the test prints in `3d/print/tests/`. Re-run a coupon before changing those sizes.
- Battery is a Li-Po 503450 flat in the base; wired audio only.
- Many `main_before_*` snapshots of past tweaks are in `3d/archive/src/`.

## Firmware and hardware
- `hardware/`: `bom.csv` (parts), `pinout.md` (GPIO and power path), `components.md` (sizes and housing), `datasheets/`.
- `firmware/`: sketch folder `firmware/office_buddy/office_buddy.ino` when it exists, `README.md` with board, libraries and arduino-cli commands. Pin changes go in `hardware/pinout.md` first.
- A firmware change of 30+ lines counts as a major change: the auto-commit pushes it.

## Where things are
- `docs/`: design notes and concept scad. `docs/dimensions/`: dimension sheets. `packaging/` (Deck Buddy, Elephant, Desk Mini only): box and cutting template.
- `3d/reference/`: look references and third-party originals (read only).
- `3d/print/`: sliced files, `3d/print/tests/` test coupons, `3d/print/slice/` slicer profiles and scripts.
- `3d/archive/`: older source copies and backups; do not edit.
