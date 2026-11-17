# 0.96" I2C OLED (SSD1306, 4-pin, 128x64) - reference model

Reference part for Desk Mini (and any other 0.96" design). Design reference only, not a printed part.

| File | What |
|---|---|
| `oled_096_ssd1306.step` | Module 2.8 thick (PCB 1.2 + 0.15 adhesive + glass 1.45) |
| `oled_096_ssd1306.stl` | Same, for OpenSCAD `import()` |
| `make_oled_step.py` | Generator (CadQuery). Edit the numbers at the top and re-run. |
| `datasheet_EastRising_ER-OLEDM0.96-1.pdf` | Source drawing (section 1.4.2, page 6) |
| `oled_096_ssd1306_preview.png` | Front / back / angled previews |

## Coordinates
Origin = centre of the PCB outline. +Y = header edge (top). +Z = toward the viewer. Z = 0 = PCB back face.

## STEP parts (each one can be hidden on its own)
`pcb`, `glass`, `viewing_area_border`, `active_area_128x64`, `adhesive`, `fpc`, `header_1x4_optional`, `keepout_back_smd` (approximate 1.1 tall zone for the regulator and caps).

## Dimensions (mm)
| Feature | Value | Source |
|---|---|---|
| PCB | 27.3 W x 27.8 H x 1.2 (+-0.3) | drawing |
| Mounting holes | 4 x Ø2.0 (Ø3.5 pad), 2.0 from every edge, pitch 23.3 x 23.8 | drawing |
| Glass | 26.7 x 19.26 x 1.45, 4.27 below the top edge, 0.3 in from the sides (centred both ways) | drawing |
| Viewing area | 23.744 x 12.864, 5.37 below the PCB top edge | drawing |
| Active area | 21.744 x 10.864 (128 x 64 px, 0.17 pitch), 6.37 below the PCB top edge | drawing |
| Module thickness | 2.8 (+-0.15) | drawing |
| Header | 1x4, pitch 2.54, centred, row 1.51 from the top edge. Usually GND VCC SCL SDA (check your silkscreen) | measured from the drawing |
| FPC notch | 14.1 wide x 2.0 deep, centred on the bottom edge; FPC about 11 wide | measured from the drawing |

The drawing is for the 7-pin SPI board; the 4-pin I2C board uses the same PCB outline, holes and glass. Measure your own board to confirm.
