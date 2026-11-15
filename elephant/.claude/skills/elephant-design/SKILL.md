---
name: elephant-design
description: Work on the Elephant (Ellie v3) lilmate desk buddy: change its CAD, check component fit, re-export STLs, reprint or re-slice the final 3mf (ELLIE_V3_FINAL.gcode.3mf). Use this whenever the user mentions elephant, Elephant, its enclosure, dimensions, components, or its final print file, even if they do not name the project folder.
---

# Elephant (Ellie v3)

Round sitting elephant desk buddy: one-piece front body with built-in wings plus a snap-on back lid. Look approved from `docs/look_front.png`.

Project folder: `elephant/` (standard layout: `src/ docs/ reference/ previews/ output/ print/ build/ archive/`).

## Final print file
- `print/ELLIE_V3_FINAL.gcode.3mf`
- Plate contents: ellie_v3_body_upright_NO_SUPPORT, ellie_v3_lid_upright_NO_SUPPORT (supports come from the slicer, not the model)
- Print settings read from the file: 0.12 mm layers (first 0.2), 3 walls, 15% gyroid, 5 top / 5 bottom shells, tree(auto) supports ON, brim outer only, PLA 220 C / bed 60 C (Textured PEI), outer wall 60 mm/s, process "ellie v3 bambu supports", Bambu Lab A1 mini, 0.4 nozzle
- Estimated: about 6 h 53 min, 87 g

## Dimensions
Assembled enclosure: **W 105.8 x D 65.7 x H 92.2** mm.

Printed parts, bounding box in mm (W = X, D = Y, H = Z, print orientation):

| Part | W | D | H |
|---|---|---|---|
| Body (upright) | 105.85 | 50.55 | 92.22 |
| Lid (upright) | 61.24 | 18.15 | 89.53 |

## Components inside the enclosure
Positions are from the CAD: X from the centre line, depth from the front face, height from the table (mm).

| # | Component | W x D x H | X from centre | Depth from front | Height from base |
|---|---|---|---|---|---|
| 1 | OLED 1.3" glass (view window behind visor) | 34.5 x 1.5 x 23.0 | -17.2..17.2 | 15.3..16.8 | 53.5..76.5 |
| 2 | OLED 1.3" PCB | 35.4 x 1.2 x 33.5 | -17.7..17.7 | 16.8..18.0 | 48.2..81.8 |
| 3 | ESP32-C3 Super Mini | 18.0 x 22.0 x 1.0 | -9.0..9.0 | 25.6..47.6 | 16.9..17.9 |
| 4 | ESP32 USB-C plug zone | 9.0 x 7.3 x 3.3 | -4.5..4.5 | 40.8..48.1 | 17.9..21.2 |
| 5 | TP4056 USB-C charger | 17.0 x 27.0 x 1.0 | -8.5..8.5 | 25.6..52.6 | 11.0..12.0 |
| 6 | TP4056 USB-C plug zone | 9.0 x 7.3 x 3.3 | -4.5..4.5 | 45.9..53.2 | 12.0..15.3 |
| 7 | Li-Po battery (502030 bay) | 20.0 x 30.0 x 5.0 | -10.0..10.0 | 22.6..52.6 | 2.5..7.5 |
| 8 | SS-12F15 slide switch (+lever) | 10.5 x 9.0 x 4.5 | -5.2..5.2 | 55.6..64.6 | 58.8..63.2 |
| 9 | TTP223 touch pad (head top) | 15.0 x 11.1 x 3.1 | -7.5..7.5 | 24.1..35.2 | 86.9..90.0 |

Full drawings (front, side, top views with the components placed): `docs/dimensions/elephant_enclosure_fit.png` and `docs/dimensions/elephant_dimensions.png`.

## How to change or rebuild
- `src/main.scad`: `part = assembly | front | back | print_front | print_back | rim | check_front | check_back | check_all`. `check_*` must come out EMPTY of clashes with the component dummies.
- Final STLs: `output/ellie_v3_body_upright_NO_SUPPORT.stl`, `output/ellie_v3_lid_upright_NO_SUPPORT.stl`.
- Slicer profile: `print/slice/process_ellie_v3_bambu_support.json`.
- Run OpenSCAD from inside `src/` so relative imports resolve, for example `cd src && openscad -o ../output/x.stl -D 'part="..."' main.scad`.
- After a CAD change: re-export the STLs into `output/`, re-run the clash check where the project has one, re-slice, and save the new final file under the same `_FINAL` name (move the old one to `print/older/`).
- Keep a copy of the previous source in `archive/src/` as `main_before_<change>.scad` before large edits.

## Design rules and gotchas
- Axes: X left-right, -Y front (face), +Y back, Z up; the body splits from the lid at Y = 13.
- Snap closure: front lip + bumps into back rebate + dimples (snap_h 0.6, lip_clr 0.12). Do not tighten it without a coupon print.
- Boards (ESP 18x22x1, TP4056 17x27x1) slide in from the back opening into slots; ports sit flush with the opening.
- Battery lies in the floor bay 20.5 x 30.5 x 5.5; older `main_before_*` copies are in `archive/src/`.

## Where things are
- `docs/`: design notes and concept scad. `docs/dimensions/`: dimension sheets.
- `reference/`: look references and third-party originals (read only).
- `print/`: sliced files, `print/tests/` test coupons, `print/slice/` slicer profiles and scripts.
- `archive/`: older source copies and backups; do not edit.
