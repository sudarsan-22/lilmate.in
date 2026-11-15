---
name: office-buddy-design
description: Work on the Office Buddy v1 lilmate desk buddy: change its CAD, check component fit, re-export STLs, reprint or re-slice the final 3mf (OFFICE_BUDDY_FINAL.gcode.3mf). Use this whenever the user mentions office buddy, Office Buddy v1, its enclosure, dimensions, components, or its final print file, even if they do not name the project folder.
---

# Office Buddy v1

Retro-PC office buddy, wider than the Music Player (base 74 mm): 1.3" OLED, buzzer, ESP32-C3, TP4056 on a pin-mounted carrier, 4 keys and a volume knob.

Project folder: `office_buddy/` (standard layout: `src/ docs/ reference/ previews/ output/ print/ build/ archive/`).

## Final print file
- `print/OFFICE_BUDDY_FINAL.gcode.3mf`
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
| 2 | Buzzer 11.5 mm | 12.0 x 12.0 x 8.5 | -25.2..-13.2 | 36.5..48.5 | 15.2..23.7 |
| 3 | EC11 rotary encoder (body+shaft) | 22.0 x 12.0 x 12.0 | 17.0..39.0 | 37.6..49.6 | 29.0..41.0 |
| 4 | Volume knob (printed) | 7.0 x 13.9 x 13.9 | 29.4..36.4 | 36.7..50.5 | 28.1..41.9 |
| 5 | TP4056 USB-C charger | 17.0 x 23.8 x 4.2 | -8.5..8.5 | 39.2..63.0 | 29.0..33.2 |
| 6 | ESP32-C3 Super Mini | 18.0 x 22.3 x 4.2 | -9.0..9.0 | 40.7..63.0 | 41.0..45.2 |
| 7 | SS-12F15 slide switch | 11.0 x 9.0 x 5.0 | 7.5..18.5 | 57.0..66.0 | 19.5..24.5 |
| 8 | Li-Po 503450 battery | 51.0 x 34.0 x 5.0 | -25.5..25.5 | 28.5..62.5 | 1.7..6.7 |
| 9 | Key perfboard + 4 tact switches | 59.0 x 11.4 x 8.3 | -29.5..29.5 | 8.4..19.9 | 2.3..10.7 |

Full drawings (front, side, top views with the components placed): `docs/dimensions/office_buddy_enclosure_fit.png` and `docs/dimensions/office_buddy_dimensions.png`.

## How to change or rebuild
- `src/main.scad`: same `part` modes as Music Player plus `carrier`, `print_carrier`, `print_pin`.
- `build/check.scad` runs the clash check; `build/export_parts.sh` exports all parts.
- Exports: `output/v1/*.stl`; test coupons (`output/test_key`, `output/test_tp`) and their sliced files are in `print/tests/`.
- Design notes: `docs/design_proposal.md`; look reference: `reference/look_reference_retro_pc.png`.
- Run OpenSCAD from inside `src/` so relative imports resolve, for example `cd src && openscad -o ../output/x.stl -D 'part="..."' main.scad`.
- After a CAD change: re-export the STLs into `output/`, re-run the clash check where the project has one, re-slice, and save the new final file under the same `_FINAL` name (move the old one to `print/older/`).
- Keep a copy of the previous source in `archive/src/` as `main_before_<change>.scad` before large edits.

## Design rules and gotchas
- TP4056 is held on 4 pins (`print_pin`) in the base sockets; the charger slot, key pockets and switch lock were tuned with the test prints in `print/tests/`. Re-run a coupon before changing those sizes.
- Battery is a Li-Po 503450 flat in the base; wired audio only.
- Many `main_before_*` snapshots of past tweaks are in `archive/src/`.

## Where things are
- `docs/`: design notes and concept scad. `docs/dimensions/`: dimension sheets.
- `reference/`: look references and third-party originals (read only).
- `print/`: sliced files, `print/tests/` test coupons, `print/slice/` slicer profiles and scripts.
- `archive/`: older source copies and backups; do not edit.
