# Desk Mini v2 - components and housing (mm)

Sizes and how the enclosure holds each part. Source: CAD in `../3d/src` and the dimension sheets in `../docs/dimensions/`.

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

