# ESP32-C3 Super Mini - original datasheet + downloaded STEP

| File | What | Source |
|---|---|---|
| `ESP32-C3_SuperMini_datasheet.pdf` | Board datasheet (vendor, 16 pages): pinout p2, **dimensions p3 (18.00 x 22.52, rows 15.24)**, schematic p2 | artronshop.co.th copy via sudo.is |
| `ESP32-C3_SuperMini_schematic.pdf` | Board schematic | mischianti.org |
| `esp32-c3_chip_datasheet_espressif.pdf` | ESP32-C3 chip datasheet | espressif.com |
| `esp32c3_supermini_printables_hefti.step` | 3D model, 221 solids (castellations, USB-C, BOOT/RST, QFN, crystal, LDO, antenna). Public Domain | printables.com/model/1360390 (Josselin Hefti) |
| `esp32c3_supermini_printables_preview.png` | Renders of that STEP | |
| `generated_fallback/` | My earlier self-made model from the size drawing (only a fallback) | |

## STEP check against the vendor datasheet
| | Datasheet | Printables STEP |
|---|---|---|
| Board | 18.00 x 22.52 | 18.00 x **22.80** x 1.01 |
| Pin row spacing | **15.24** | **14.48** (holes Ø1.2, 1.76 in from the edges) |
| Pin pitch | 2.54 | 2.54 OK |
| USB-C | - | 8.94 wide, 4.06 tall (top 4.16 above the PCB bottom), sticks out 1.40 |

STEP origin: PCB corner at (0,0,0), board along +X (USB-C at the -X end), width along +Y, components on +Z.
Use the STEP for the board outline, USB-C and component heights; if you design anything that uses the header holes, use the datasheet 15.24 and measure your board.
