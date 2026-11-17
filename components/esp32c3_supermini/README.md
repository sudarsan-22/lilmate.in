# ESP32-C3 Super Mini - reference model

Shared reference part (Deck Buddy, Elephant, Pengu, Music Player, Office Buddy). Design reference only.

| File | What |
|---|---|
| `esp32c3_supermini.step` | Board + USB-C + buttons + chip/crystal/regulator + antenna + optional 2x8 headers |
| `esp32c3_supermini.stl` | Same, for OpenSCAD `import()` |
| `make_esp32c3_step.py` | Generator (CadQuery). Edit the numbers at the top and re-run. |
| `source_size_drawing.jpg`, `source_pinout.jpg` | Source images (mischianti.org) |
| `esp32c3_supermini_preview.png` | Front / back / angled previews |

## Coordinates
Origin = centre of the PCB outline. +Y = USB-C end. +Z = component side. Z = 0 = PCB bottom face.

## Dimensions (mm)
| Feature | Value | Source |
|---|---|---|
| PCB | 18.0 x 22.5 x 1.0 | drawing (thickness: user) |
| Pin rows | 2 x 8, 15.24 apart (1.38 in from the long edges), pitch 2.54, hole Ø1.0 + castellated edge | drawing |
| First pin | 1.63 from the USB end, last pin 3.12 from the antenna end | measured from the drawing |
| USB-C | 8.94 x 7.35 x 3.26, centred, sticks out about 1.4 past the board end | drawing / standard receptacle |
| BOOT / RST buttons | 4.4 x 3.0 x 2.0, 7.3-10.3 below the USB end | measured from the drawing |
| Tallest point | 4.26 above the PCB bottom (USB-C) | model |

## Pins (USB at the top, components facing you)
| Left (top -> bottom) | 5 | 6 | 7 | 8 (LED, SDA) | 9 (BOOT, SCL) | 10 | 20 (RX) | 21 (TX) |
|---|---|---|---|---|---|---|---|---|
| **Right (top -> bottom)** | **5V** | **GND** | **3V3** | **4** | **3** | **2** | **1** | **0** |

## To confirm on the real board
- Length: drawing 22.5, your note says 22.0.
- USB-C overhang: the drawing shows about 1.4; the Elephant CAD uses about 0.5.
