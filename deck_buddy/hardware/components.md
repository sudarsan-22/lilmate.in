# Deck Buddy - components and housing (mm)

Sizes and how the enclosure holds each part. Source: CAD in `../3d/src` and the dimension sheets in `../docs/dimensions/`.

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

