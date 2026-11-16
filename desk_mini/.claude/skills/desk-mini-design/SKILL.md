---
name: desk-mini-design
description: Work on the Desk Mini v2 lilmate desk buddy: change its CAD, check component fit, re-export STLs, reprint or re-slice the final 3mf (DESK_MINI_V2_FINAL.3mf). Use this whenever the user mentions desk mini, Desk Mini v2, its enclosure, dimensions, components, or its final print file, even if they do not name the project folder.
---

# Desk Mini v2

Small desk gadget built by editing imported STL parts: body, back plate, 0.96" display bezel with crush ribs, and a shell with a buzzer holder.

Project folder: `desk_mini/` (layout: `3d/` = CAD, print files and archive; `firmware/`; `hardware/`; `docs/`; `packaging/`).

## Final print file
- `3d/output/DESK_MINI_V2_FINAL.3mf`
- Plate contents: one "OpenSCAD Model" object: body, back plate, display bezel and shell laid out apart (exploded layout)
- Print settings read from the file: The final 3mf is model geometry only (no slicer settings). Use the same defaults as the other lilmate prints: Bambu Lab A1 mini, 0.4 nozzle, PLA, 0.12 mm layers, 3 walls, 15% gyroid.
- Estimated: not sliced yet

## Dimensions


Printed parts, bounding box in mm (W = X, D = Y, H = Z, print orientation):

| Part | W | D | H |
|---|---|---|---|
| Shell | 46.68 | 38.00 | 40.99 |
| Body | 38.99 | 34.00 | 44.95 |
| Bezel | 30.00 | 30.43 | 6.00 |
| Plate | 29.00 | 34.00 | 5.00 |
| Shell + buzzer holder | 46.68 | 38.00 | 40.99 |

## Components inside the enclosure
Cavity sizes (the Desk Mini source is an exploded STL layout, so there are no placed positions).

| Part | Size | Component fit |
|---|---|---|
| Body (main enclosure) | 38.99 x 34.0 x 44.95 | Holds all electronics; 2 snap pins (pin Ø2.6, head Ø3.5) at local x=6.0, y=4.05 / 30.05 |
| Back plate | 29.0 x 34.0 x 5.0 | Board opening 20 mm wide (widened 18->20), USB notch, 2 holes Ø3 (counterbore Ø4.4) |
| Display cover / bezel | 30.0 x 30.43 x 6.0 | OLED 0.96" cavity 27.0 x 27.4 (open end z=6), walls 1.5, 8 crush ribs 0.3 mm |
| Shell (front cover with buzzer) | 46.68 x 38.0 x 40.99 | Buzzer pocket Ø11.7 x 3 deep (buzzer Ø11.5), holder ring Ø13.5, 6 sound holes Ø2 inside the pocket |
| Buzzer | Ø11.5 x ~3 | Seats on the shell plate (plate 2 thick), pocket clearance 0.2 total |
| Tray (obj_1, removed) | 34.0 x 34.4 | No longer used in the project |

Full drawings (front, side, top views with the components placed): `docs/dimensions/desk_mini_enclosure_fit.png` and `docs/dimensions/desk_mini_dimensions.png`.

## Component details and housing
Each component: its size, then how the enclosure holds it (pockets, slots, clearances, stops, snaps). Sizes in mm.

### 0.96" OLED module
- Housing (bezel / display cover): cavity 27.0 x 27.4, open end at z = 6, walls 1.5, 8 crush ribs 0.3 mm (taper at the open end) hold the module without glue; the two 4.8 mm wall notches were filled. The tray (obj_1) was removed from the project.

### Buzzer (round, 11.5 mm)
- Size: diameter 11.5, about 3 high.
- Housing: pocket diameter 11.7 (0.2 total gap), 3 deep on the 2 mm shell plate, full holder ring outer diameter 13.5 (wall 0.9), moved 10 mm away from the USB slot; six sound holes diameter 2 in a 2 x 3 grid (pitch 4 x 3.2) all inside the pocket.

### Controller board and USB
- Housing: back plate board opening 20 wide (widened from 18), U-wall and USB notch stretch with it; plate 29 x 34 x 5.

### Mounting
- Screwless: two split snap pins (shaft 2.6, head 3.5, slit 0.7) in relief wells 4.2 wide replace the M2 pilot holes; plate holes diameter 3 with a 4.4 counterbore leaving a 0.5 ledge. The board type itself is not named in the sources, so confirm its size before changing the opening.

## How to change or rebuild
- `3d/src/desk_mini_v2.scad` with `part = all | shell | plate | body | tray | bezel` (`all` is the exploded layout that became the final 3mf).
- `3d/src/desk_mini_issues.scad` is the older issue-review view.
- STL exports per part are in `3d/output/` (`v2_body.stl`, `v2_plate.stl`, `v2_bezel.stl`, `v2_shell.stl`).
- Run OpenSCAD from inside `3d/src/` so relative imports resolve, for example `cd 3d/src && openscad -o ../output/x.stl -D 'part="..."' main.scad`.
- After a CAD change: re-export the STLs into `3d/output/`, re-run the clash check where the project has one, re-slice, and save the new final file under the same `_FINAL` name (move the old one to `3d/print/older/`).
- Keep a copy of the previous source in `3d/archive/src/` as `main_before_<change>.scad` before large edits.

## Design rules and gotchas
- The source STLs in `3d/reference/original/` stay untouched; v2 edits are made in scad on top of them.
- Plate board opening was widened 18 -> 20 mm; buzzer holder moved 10 mm; the six sound holes sit inside the 11.7 mm buzzer pocket.
- Screwless mounting: two split snap pins replace the M2 pilot holes (pin 2.6, head 3.5).
- The tray (obj_1) was removed from the project on request.

## Firmware and hardware
- `hardware/`: `bom.csv` (parts), `pinout.md` (GPIO and power path), `components.md` (sizes and housing), `datasheets/`.
- `firmware/`: sketch folder `firmware/desk_mini/desk_mini.ino` when it exists, `README.md` with board, libraries and arduino-cli commands. Pin changes go in `hardware/pinout.md` first.
- A firmware change of 30+ lines counts as a major change: the auto-commit pushes it.

## Where things are
- `docs/`: design notes and concept scad. `docs/dimensions/`: dimension sheets. `packaging/` (Deck Buddy, Elephant, Desk Mini only): box and cutting template.
- `3d/reference/`: look references and third-party originals (read only).
- `3d/print/`: sliced files, `3d/print/tests/` test coupons, `3d/print/slice/` slicer profiles and scripts.
- `3d/archive/`: older source copies and backups; do not edit.
