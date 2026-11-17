# 1.3" I2C OLED (SH1106, 4-pin, 128x64) - reference model

Shared reference part for Deck Buddy, Elephant and Pengu. These are design references, not printed parts.

| File | What |
|---|---|
| `oled_13_sh1106_3p3mm.step` | Module 3.3 thick (PCB 1.2 + foam 0.6 + glass 1.5), as measured on the Deck Buddy display 2026-11-15. **Default.** |
| `oled_13_sh1106_2p7mm.step` | Module 2.7 thick (glass directly on the PCB), manufacturer "2.70 max", the Ellie value |
| `oled_13_sh1106_3p3mm.stl` | Same as the 3.3 STEP, for OpenSCAD `import()` |
| `make_oled_step.py` | Generator (CadQuery). Edit the numbers at the top and re-run. |
| `datasheet_ETT_oled13_i2c.pdf` | Source drawing (page 3) |
| `oled_13_sh1106_preview.png` | Front / back / angled previews |

## Coordinates
Origin = centre of the PCB outline. +Y = header edge (top). +Z = toward the viewer. Z = 0 = PCB back face.

## STEP parts (each one can be hidden on its own)
`pcb`, `glass`, `viewing_area_border`, `active_area_128x64`, `adhesive_foam` (3.3 only), `fpc`, `header_1x4_optional` (hide it if you solder wires straight to the pads), `keepout_back_smd` (0.8 tall zone for the back-side caps and resistors).

## Dimensions (mm)
| Feature | Value | Source |
|---|---|---|
| PCB | 35.4 x 33.5 x 1.2 | measured / manufacturer |
| Mounting holes | 4 x Ø3.0, centres 2.1 in from left/right, 3.1 from top, 2.05 from bottom -> pitch **31.2 x 28.35** | datasheet drawing |
| Glass | 34.5 x 23.0 x 1.5, top edge 6.3 below the PCB top (centre 0.9 below the PCB centre) | drawing + measured |
| Viewing area | 31.42 x 16.70, top edge 1.0 below the glass top | standard 1.3" panel |
| Active area | 29.42 x 14.70 (128 x 64 px), centred in the viewing area | standard 1.3" panel |
| Header | 1x4, pitch 2.54, pin 1 (VDD) 13.94 from the left edge, row 1.30 from the top. Order: VDD GND SCK SDA (check your silkscreen) | drawing |
| FPC notch | 14.3 wide x 4.0 deep, centred on the bottom edge | drawing |

## To confirm on the real board
- **Hole diameter** (3.0 modelled; the drawing shows a 3.0 ID / 3.9 OD ring).
- **Hole spacing**: the drawing gives 31.2 mm across. Deck Buddy's locking pins assume **30.0 mm** and a 4 mm hole (marked "assumed"). Measure before relying on either.
- **Glass position**: the drawing puts the glass 0.9 mm below the centre, but the Deck Buddy and Elephant CAD centre it.
