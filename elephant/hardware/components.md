# Elephant (Ellie v3) - components and housing (mm)

Sizes and how the enclosure holds each part. Source: CAD in `../3d/src` and the dimension sheets in `../docs/dimensions/`.

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
- Housing: same slot rules as the ESP32, board at z 11-12; v10: its front stopper is 27 mm in from the opening, so the board ends flush with the body opening (like Pengu) and the lid niche is 7.25 mm deep (guide plate 1.2 with the 9.6 x 3.9 hole). Its USB-C is the only exposed port, centred on the back.

### Li-Po 502030 battery (about 300 mAh)
- Size: 20.0 x 30.0 x 5.0 modelled (real cell about 20 x 30 x 5).
- Housing: floor bay 20.5 x 30.5 x 5.5 (0.25 clearance per side), lies front-to-back, leads at the back end, floor at z 2.5-7.5; battery ribs front and back hold it. TP4056 stopper sits 0.2 above the battery top.

### SS-12F15 slide switch
- Size: body 10.5 x 4.5 (measured 11 x 5 x 5), lever 3 x 3 x 4, travel 3.2.
- Housing: locking pocket 12.1 x 5.8, lips reach 0.6 per side (gap 4.6, 0.2 overlap on the 5 mm switch), lip underside 0.4 behind the switch back, the two lip walls are 0.8 thick so they flex (others 1.2), lever slot 7 x 3.6, front plate 1.4, housing depth 6.5, at z 61 on the flat vertical band at the back of the head.

### TTP223 touch pad
- Size: 15 x 11 x 1.6.
- Housing: flat seat 17 x 12.5 under the head top, cradle arms hold the board with the holding face 0.15 under it, skin over the pad kept at 1.6. (The second jaw pad is defined in the source but not used.)

### Lid screws (M2 x 10, 4 pcs)
- Housing: bosses OD 7.6 at (x, z) (+-23, 60) and (+-18, 14); body pilot hole 1.8 x 7.2, lid clearance hole 2.4, head pocket 4.6 (see `docs/elephant_screw_fit_FINAL.png`).
