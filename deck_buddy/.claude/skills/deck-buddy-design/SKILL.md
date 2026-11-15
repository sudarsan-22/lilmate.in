---
name: deck-buddy-design
description: Work on the Deck Buddy (1.3" OLED, SA body) lilmate desk buddy: change its CAD, check component fit, re-export STLs, reprint or re-slice the final 3mf (DECK_BUDDY_SA_OLED13_FINAL.gcode.3mf). Use this whenever the user mentions deck buddy, Deck Buddy, its enclosure, dimensions, components, or its final print file, even if they do not name the project folder.
---

# Deck Buddy (1.3" OLED, SA body)

Yeti desk buddy: original Yeti body modified (SA), new 1.3" OLED bezel and display bracket with locking pins, Ellie-style two-board stack (TP4056 + ESP32-C3 Mini) and a snap-on back lid with an SPDT slide switch.

Project folder: `deck_buddy/` (standard layout: `src/ docs/ reference/ previews/ output/ print/ build/ archive/`).

## Final print file
- `print/DECK_BUDDY_SA_OLED13_FINAL.gcode.3mf`
- Plate contents: deck_buddy_SA_body_upright, back_lid_switch, bezel_obj8, bracket_obj1, block_obj3, plate_obj5, plate_obj6 (obj3/5/6 are untouched originals from the Yeti set)
- Print settings read from the file: 0.12 mm layers (first 0.2), 3 walls, 15% gyroid, 6 top / 5 bottom shells, no supports, brim outer only, PLA 220 C / bed 60 C (Cool Plate), outer wall 200 mm/s, Bambu Lab A1 mini, 0.4 nozzle, filament "Bambu PLA Basic @BBL A1M (pengu)"
- Estimated: about 4 h 49 min, 64 g

## Dimensions
Assembled enclosure: **W 74.9 x D 40.6 x H 74.7** mm.

Printed parts, bounding box in mm (W = X, D = Y, H = Z, print orientation):

| Part | W | D | H |
|---|---|---|---|
| Body (upright) | 74.89 | 40.65 | 74.72 |
| Back lid (switch) | 51.12 | 56.23 | 9.50 |
| Bezel OLED 1.3" | 37.64 | 28.74 | 4.00 |
| Bracket OLED 1.3" | 39.70 | 30.60 | 41.90 |
| Test: hook lid piece | 15.55 | 26.00 | 7.00 |
| Test: hook rim piece | 8.26 | 26.00 | 7.00 |
| Test: switch coupon | 22.00 | 13.00 | 9.50 |

## Components inside the enclosure
Positions are from the CAD: X from the centre line, depth from the front face, height from the table (mm).

| # | Component | W x D x H | X from centre | Depth from front | Height from base |
|---|---|---|---|---|---|
| 1 | OLED 1.3" glass | 34.5 x 2.1 x 23.0 | -17.3..17.2 | 11.4..13.5 | 22.3..45.3 |
| 2 | OLED 1.3" PCB | 35.4 x 1.2 x 33.5 | -17.8..17.7 | 13.5..14.7 | 17.1..50.6 |
| 3 | TP4056 charger | 17.0 x 27.0 x 1.0 | -8.5..8.4 | 13.6..40.6 | 54.2..55.2 |
| 4 | TP4056 USB-C plug zone | 9.0 x 7.0 x 3.3 | -4.5..4.4 | 33.6..40.6 | 50.9..54.2 |
| 5 | ESP32-C3 Mini | 18.0 x 22.0 x 1.0 | -9.0..8.9 | 18.6..40.6 | 48.3..49.3 |
| 6 | ESP32 USB-C plug zone | 9.0 x 7.0 x 3.3 | -4.5..4.4 | 33.6..40.6 | 45.0..48.3 |
| 7 | Display bracket (printed insert) | 36.5 x 30.6 x 41.9 | -18.3..18.2 | 10.0..40.6 | 16.9..58.8 |

Full drawings (front, side, top views with the components placed): `docs/dimensions/deck_buddy_enclosure_fit.png` and `docs/dimensions/deck_buddy_dimensions.png`.

## Component details and housing
Each component: its size, then how the enclosure holds it (pockets, slots, clearances, stops, snaps). Sizes in mm.

### 1.3" I2C OLED (SH1106)
- Size: PCB 35.4 x 33.5 x 1.2, glass 34.5 x 23 x 2.1 (module 3.3 thick), window 31 x 17, two 4 mm mounting holes 30 mm apart, 3 mm below the top edge (assumed).
- Housing (bracket): front plate 3.5 thick = glass pocket 2.3 deep (34.9 x 23.4) + 1.2 skin, window 31 x 17 with a sloped top (no 31 mm bridge), PCB bay 36.0 x 34.1 (0.3 clearance per side), centre height 25. Two split locking pins go through the holes: OD 3.6, bore 2.0, head 4.5 (0.25 over the hole edge), tip 3.2, X-shaped 0.8 slit, flat catch 0.1 behind the PCB, 45 deg lead-in; the module tilts in bottom first.
- Bezel: 37.4 x 28.5 outline grown 0.12 per side for a press fit, window 31.4 x 17.4.

### ESP32-C3 Super Mini
- Size: PCB 18 W x 22 L x 1, USB-C zone 9 x 7 x 3.3.
- Housing: slot in the bracket, slides in from the back opening; 0.2 clearance per side, 0.3 above under the lip, lip 1.0 over the board edge, 45 deg shelf under the edge, side walls 1.2, stack inner width 20.5. No front stop (user decision). Board z0 = 9.55.

### TP4056 USB-C charger
- Size: PCB 17 W x 27 L x 1, USB-C zone 9 x 7 x 3.3.
- Housing: lower slot of the same stack, keeps its 2.0 long front stop (reach 2.5); board z0 = 3.65 so the USB-C centre lines up with the lid's USB-C slot (y = 140).

### SS-12F15 slide switch (back lid)
- Size: body 11 x 5 x 5, lever 3 x 3 x 4, travel 3.2.
- Housing: pocket 12.1 x 5.8 sunk 2.0 into the 4 mm lid, locking lips reach 0.6 per side (0.2 overlap), lip underside 0.4 behind the switch back, lip walls 0.8, tower 5.5 above the lid face, lever slot 7 x 3.6, plate 1.4, finger niche 0.6 deep, switch centred 17.5 above the USB-C.
- Lid closure: 4 snap arms with asymmetric bump (0.4 high, 27 deg ramp) into dimples in the body rim; no screws.

Battery: not modelled in these sources.

## How to change or rebuild
- Body: `src/deck_buddy_SA.scad` (`view="print"` gives the upright print STL).
- Bracket and bezel: `src/deck_buddy_oled13.scad` with `view="bracket"` or `view="bezel"`. Check views: `asm`, `clash_body`, `clash_boards`, `clash_slide_tp`, `clash_slide_esp`, `clash_bezel`.
- Lid: `src/back_lid_switch_FINAL.scad`.
- Re-slice everything into the final 3mf: `print/slice/slice_SA13.sh` (writes `print/DECK_BUDDY_SA_OLED13_print.gcode.3mf`; rename it to `_FINAL` when you accept it).
- Run OpenSCAD from inside `src/` so relative imports resolve, for example `cd src && openscad -o ../output/x.stl -D 'part="..."' main.scad`.
- After a CAD change: re-export the STLs into `output/`, re-run the clash check where the project has one, re-slice, and save the new final file under the same `_FINAL` name (move the old one to `print/older/`).
- Keep a copy of the previous source in `archive/src/` as `main_before_<change>.scad` before large edits.

## Design rules and gotchas
- The original Yeti STLs in `reference/original/` are the source for the body, bracket and bezel frames. Never edit them; the scad files import and modify them.
- Display module is 3.3 mm thick (PCB 1.2 + glass 2.1); locking pins go through the 4 mm holes, 30 mm apart.
- Boards slide in from the back opening: TP4056 slot keeps its front stop, the ESP32 slot has none.
- No battery is modelled in these sources; confirm its place before adding one.

## Where things are
- `docs/`: design notes and concept scad. `docs/dimensions/`: dimension sheets.
- `reference/`: look references and third-party originals (read only).
- `print/`: sliced files, `print/tests/` test coupons, `print/slice/` slicer profiles and scripts.
- `archive/`: older source copies and backups; do not edit.
