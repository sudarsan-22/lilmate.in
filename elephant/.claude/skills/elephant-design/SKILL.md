---
name: elephant-design
description: Work on the Elephant (Ellie v3) lilmate desk buddy: change its CAD, check component fit, re-export STLs, reprint or re-slice the final 3mf (ELLIE_V3_FINAL.gcode.3mf). Use this whenever the user mentions elephant, Elephant, its enclosure, dimensions, components, or its final print file, even if they do not name the project folder.
---

# Elephant (Ellie v3)

Round sitting elephant desk buddy: one-piece front body with built-in wings plus a snap-on back lid. Look approved from `docs/look_front.png`.

Project folder: `elephant/` (layout: `3d/` = CAD, print files and archive; `firmware/`; `hardware/`; `docs/`; `packaging/`).

## Final print file
- `3d/print/ELLIE_V3_FINAL.gcode.3mf`
- Plate contents: ellie_v3_body_upright_NO_SUPPORT, ellie_v3_lid_upright_NO_SUPPORT (supports come from the slicer, not the model)
- Print settings read from the file: 0.12 mm layers (first 0.2), 3 walls, 15% gyroid, 5 top / 5 bottom shells, tree(auto) supports ON, brim outer only, PLA 220 C / bed 60 C (Textured PEI), outer wall 60 mm/s, process "ellie v3 bambu supports", Bambu Lab A1 mini, 0.4 nozzle
- Estimated: about 7 h 23 min, 91 g (screw fit v10 rebuild)

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

## Component details and housing
Each component: its size, then how the enclosure holds it (pockets, slots, clearances, stops, snaps). Sizes in mm.

### 1.3" I2C OLED (SH1106, 4-pin)
- Size: PCB 35.4 x 33.5 x 1.2, glass 34.5 x 23 x 1.5 (centred on the PCB), visible window 31 x 17. Module 2.7 thick (3.3 with the thicker glass used in Deck Buddy).
- Housing: holder bay = PCB + 0.6 mm clearance per side (36.6 x 34.7 inside), bay wall 1.4, bay depth 3.5 behind the PCB (short, easy to fit), visor recess 1.2 in the front skin, PCB corners keep at least 1 mm of skin outside.
- Placement: glass front plane y = -19.3, behind the wide pill visor (half size 22 x 10.25, radius 10) at head height z 65.

### ESP32-C3 Super Mini
- Size: PCB 18 W x 22 L x 1, USB-C plug zone 9 x 7.3 x 3.3 (measured by the user 2026-11-14).
- Housing: slides in from the back opening along a slot: 0.2 mm clearance per side (slot 18.4 wide), 0.3 mm clearance above the board under the lip, lip over the board edge, front stop 2.0 long reaching 2.5 over the board edge, 1.6 spine. Back edge ends flush with the body's back opening (split plane Y = 13); USB-C opening 9.6 x 3.9, cable-plug niche 13.5 x 7.8, port wall 1.2. Board sits at z 16.9-17.9.

### TP4056 USB-C charger
- Size: PCB 17 W x 27 L x 1, USB-C plug zone 9 x 7.3 x 3.3.
- Housing: same slot rules as the ESP32, board at z 11-12; its front stopper is 22 mm in from the opening, so the 27 mm board sticks 5 mm into the lid. Its USB-C is the only exposed port, centred on the back.

### Li-Po 502030 battery (about 300 mAh)
- Size: 20.0 x 30.0 x 5.0 modelled (real cell about 20 x 30 x 5).
- Housing: floor bay 20.5 x 30.5 x 5.5 (0.25 clearance per side), lies front-to-back, leads at the back end, floor at z 2.5-7.5; battery ribs front and back hold it. TP4056 stopper sits 0.2 above the battery top.

### SS-12F15 slide switch
- Size: body 10.5 x 4.5 (measured 11 x 5 x 5), lever 3 x 3 x 4, travel 3.2.
- Housing: locking pocket 12.1 x 5.8, lips reach 0.6 per side (gap 4.6, 0.2 overlap on the 5 mm switch), lip underside 0.4 behind the switch back, the two lip walls are 0.8 thick so they flex (others 1.2), lever slot 7 x 3.6, front plate 1.4, housing depth 6.5, at z 61 on the flat vertical band at the back of the head.

### TTP223 touch pad
- Size: 15 x 11 x 1.6.
- Housing: flat seat 17 x 12.5 under the head top, cradle arms hold the board with the holding face 0.15 under it, skin over the pad kept at 1.6. (The second jaw pad is defined in the source but not used.)

## How to change or rebuild
- `3d/src/main.scad`: `part = assembly | front | back | print_front | print_back | rim | check_front | check_back | check_all`. `check_*` must come out EMPTY of clashes with the component dummies.
- Final STLs: `3d/output/ellie_v3_body_upright_NO_SUPPORT.stl`, `3d/output/ellie_v3_lid_upright_NO_SUPPORT.stl`.
- Slicer profile: `3d/print/slice/process_ellie_v3_bambu_support.json`.
- Run OpenSCAD from inside `3d/src/` so relative imports resolve, for example `cd 3d/src && openscad -o ../output/x.stl -D 'part="..."' main.scad`.
- After a CAD change: re-export the STLs into `3d/output/`, re-run the clash check where the project has one, re-slice, and save the new final file under the same `_FINAL` name (move the old one to `3d/print/older/`).
- Keep a copy of the previous source in `3d/archive/src/` as `main_before_<change>.scad` before large edits.

## Design rules and gotchas
- Axes: X left-right, -Y front (face), +Y back, Z up; the body splits from the lid at Y = 13.
- Closure (v10): 4 x M2 x 10 pan-head self-tapping screws, lid -> body (`screw_on = true`). Axes (x, z): (+-23, 72) upper, in the solid roof, (+-18, 14) lower body sides, all along Y. Body bosses OD 7.6, pilot hole 1.8 x 7.2 deep; lid bosses with 2.4 clearance hole and a 4.6 head pocket (floor `scr_floor`, 1.3 rim at the outer edge). The front lip + rebate (lip_clr 0.12) only align the lid; snap bumps/dimples are off (`snap_on = !screw_on`, the old snap failed in 3 prints). Check `part=check_parts` is empty of volume (only the seam plane touches).
- USB-C (v10): `tp_stop_depth = 27`, the TP4056 ends flush with the body opening, niche in the lid 7.25 mm deep (was 2.25). Test coupon: `docs/usb_port_test.scad`, `3d/print/tests/TEST_usb_port.gcode.3mf` (printed, fits).
- Boards (ESP 18x22x1, TP4056 17x27x1) slide in from the back opening into slots; ports sit flush with the opening.
- Battery lies in the floor bay 20.5 x 30.5 x 5.5; older `main_before_*` copies are in `3d/archive/src/`.

## Firmware and hardware
- `hardware/`: `bom.csv` (parts), `pinout.md` (GPIO and power path), `components.md` (sizes and housing), `soldering_sop.png` (wiring and soldering steps, wire cut list; regenerate with the solder-sop skill), `datasheets/`.
- `firmware/`: sketch folder `firmware/elephant/elephant.ino` when it exists, `README.md` with board, libraries and arduino-cli commands. Pin changes go in `hardware/pinout.md` first.
- A firmware change of 30+ lines counts as a major change: the auto-commit pushes it.

## Where things are
- `docs/`: design notes and concept scad. `docs/dimensions/`: dimension sheets. `packaging/` (Deck Buddy, Elephant, Desk Mini only): box and cutting template.
- `3d/reference/`: look references and third-party originals (read only).
- `3d/print/`: sliced files, `3d/print/tests/` test coupons, `3d/print/slice/` slicer profiles and scripts.
- `3d/archive/`: older source copies and backups; do not edit.
