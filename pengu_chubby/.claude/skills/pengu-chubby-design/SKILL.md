---
name: pengu-chubby-design
description: Work on the Pengu Chubby v3 lilmate desk buddy: change its CAD, check component fit, re-export STLs, reprint or re-slice the final 3mf (PENGU_V3_FINAL.gcode.3mf). Use this whenever the user mentions pengu chubby, Pengu Chubby v3, its enclosure, dimensions, components, or its final print file, even if they do not name the project folder.
---

# Pengu Chubby v3

Chubby sitting penguin desk buddy: one-piece front body (wings built in) plus snap-on back lid. This is the proven electronics layout that Ellie and Deck Buddy copy.

Project folder: `pengu_chubby/` (standard layout: `src/ docs/ reference/ previews/ output/ print/ build/ archive/`).

## Final print file
- `print/PENGU_V3_FINAL.gcode.3mf`
- Plate contents: pengu_v3_body_upright, pengu_v3_lid_upright
- Print settings read from the file: 0.12 mm layers (first 0.2), 3 walls, 15% gyroid, 5 top / 5 bottom shells, tree(auto) supports ON, brim outer only, PLA 220 C / bed 60 C (Textured PEI), outer wall 60 mm/s, process "ellie v3 bambu supports", Bambu Lab A1 mini, 0.4 nozzle
- Estimated: about 6 h 10 min, 73 g

## Dimensions
Assembled enclosure: **W 62.0 x D 57.9 x H 97.6** mm.

Printed parts, bounding box in mm (W = X, D = Y, H = Z, print orientation):

| Part | W | D | H |
|---|---|---|---|
| Body (upright) | 61.99 | 42.80 | 97.65 |
| Lid (upright) | 56.59 | 18.15 | 84.73 |

## Components inside the enclosure
Positions are from the CAD: X from the centre line, depth from the front face, height from the table (mm).

| # | Component | W x D x H | X from centre | Depth from front | Height from base |
|---|---|---|---|---|---|
| 1 | OLED 1.3" glass (view window behind visor) | 34.5 x 1.5 x 23.0 | -17.2..17.2 | 8.6..10.1 | 50.5..73.5 |
| 2 | OLED 1.3" PCB | 35.4 x 1.2 x 33.5 | -17.7..17.7 | 10.1..11.3 | 45.2..78.8 |
| 3 | ESP32-C3 Super Mini | 18.0 x 22.0 x 1.0 | -9.0..9.0 | 17.8..39.8 | 16.9..17.9 |
| 4 | ESP32 USB-C plug zone | 9.0 x 7.3 x 3.3 | -4.5..4.5 | 33.0..40.3 | 17.9..21.2 |
| 5 | TP4056 USB-C charger | 17.0 x 27.0 x 1.0 | -8.5..8.5 | 12.8..39.8 | 11.0..12.0 |
| 6 | TP4056 USB-C plug zone | 9.0 x 7.3 x 3.3 | -4.5..4.5 | 33.1..40.4 | 12.0..15.3 |
| 7 | Li-Po battery (502030 bay) | 20.0 x 30.0 x 5.0 | -10.0..10.0 | 14.8..44.8 | 2.5..7.5 |
| 8 | SS-12F15 slide switch (+lever) | 10.5 x 9.1 x 4.5 | -5.2..5.2 | 45.3..54.4 | 58.8..63.2 |
| 9 | TTP223 touch pad (head top) | 15.0 x 11.0 x 1.6 | -7.5..7.5 | 16.3..27.3 | 81.5..83.1 |

Full drawings (front, side, top views with the components placed): `docs/dimensions/pengu_chubby_enclosure_fit.png` and `docs/dimensions/pengu_chubby_dimensions.png`.

## Component details and housing
Each component: its size, then how the enclosure holds it (pockets, slots, clearances, stops, snaps). Sizes in mm.

### 1.3" I2C OLED (SH1106, 4-pin)
- Size: PCB 35.4 x 33.5 x 1.2, glass 34.5 x 23 x 1.5 (centred on the PCB), visible window 31 x 17. Module 2.7 thick (3.3 with the thicker glass used in Deck Buddy).
- Housing: holder bay = PCB + 0.6 mm clearance per side (36.6 x 34.7 inside), bay wall 1.4, bay depth 3.5 behind the PCB (short, easy to fit), visor recess 1.2 in the front skin, PCB corners keep at least 1 mm of skin outside.
- Placement: glass front plane y = -18.2 (2 mm closer to the visor than before), visor half size 21.5 x 10.8 radius 9.5, centre z = 62 (head z 63, visor offset -1).

### ESP32-C3 Super Mini
- Size: PCB 18 W x 22 L x 1, USB-C plug zone 9 x 7.3 x 3.3.
- Housing: slides in from the back along a slot (0.2 clearance per side, 0.3 above under the lip, front stop 2.0 reaching 2.5 over the edge, spine 1.6); back edge flush with the body opening at Y = 13; USB-C opening 9.6 x 3.9, plug niche 13.5 x 7.8; board at z 16.9-17.9.

### TP4056 USB-C charger
- Size: PCB 17 W x 27 L x 1, USB-C plug zone 9 x 7.3 x 3.3; board at z 11-12; both boards' back edges end flush with the body opening. The only exposed port.

### Li-Po 502030 battery
- Size: 20.0 x 30.0 x 5.0 modelled; bay 20.5 x 30.5 x 5.5, lies front-to-back, leads at the back end, floor at z 2.5-7.5, battery ribs front and back.

### SS-12F15 slide switch
- Size: body 10.5 x 4.5 x 5.1, lever 3 x 3 x 4, travel 3.2.
- Housing: pocket 11.8 x 5.2 (includes bent ears + clearance), depth 5.1, lever slot 7 x 3.6, plate 1.4, at z 61 on the back of the head.

### TTP223 touch pad
- Size: 15 x 11 x 1.6; pocket box 17 x 12.5 under the head top (centre y = -5), skin over the pad 1.6.

## How to change or rebuild
- `src/main.scad`: `part = assembly | front | back | print_front | print_back | rim | check_front | check_back | check_all`.
- Final STLs: `output/pengu_v3_body_upright.stl`, `output/pengu_v3_lid_upright.stl`.
- Run OpenSCAD from inside `src/` so relative imports resolve, for example `cd src && openscad -o ../output/x.stl -D 'part="..."' main.scad`.
- After a CAD change: re-export the STLs into `output/`, re-run the clash check where the project has one, re-slice, and save the new final file under the same `_FINAL` name (move the old one to `print/older/`).
- Keep a copy of the previous source in `archive/src/` as `main_before_<change>.scad` before large edits.

## Design rules and gotchas
- Same axes, split plane (Y = 13), snap closure and board slots as Elephant. A change to the electronics layout here usually has to be mirrored in `elephant` and `deck_buddy`.
- OLED glass plane y_if = -18.2; slide switch SS-12F15 pocket 11.8 x 5.2.

## Where things are
- `docs/`: design notes and concept scad. `docs/dimensions/`: dimension sheets.
- `reference/`: look references and third-party originals (read only).
- `print/`: sliced files, `print/tests/` test coupons, `print/slice/` slicer profiles and scripts.
- `archive/`: older source copies and backups; do not edit.
