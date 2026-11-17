# Elephant (Ellie v3)

Round sitting elephant desk buddy: one-piece body plus snap-on back lid, 1.3" OLED, ESP32-C3, TP4056, 502030 battery, slide switch, TTP223 touch.

Printer: Bambu Lab A1 mini. Material: PLA. Units: mm.

## Folder layout
| Folder | What is in it |
|---|---|
| `3d/` | All CAD work: `src/` current source, `output/` STL and model 3MF, `print/` sliced `*_FINAL` files (`print/tests/` coupons, `print/slice/` profiles and scripts), `previews/`, `reference/` (look images, third-party originals), `build/` (scratch), `archive/` (old sources and backups) |
| `firmware/` | Microcontroller sketch and flashing notes (see its README) |
| `hardware/` | `bom.csv`, `pinout.md`, `components.md` (sizes and housing), `soldering_sop.png` (wiring + soldering steps), `datasheets/` |
| `docs/` | Design notes, concept scad, `docs/dimensions/` dimension sheets |
| `packaging/` | Box and cutting template |
| `.claude/skills/` | Project skill for Claude Code |

Closure: 4 x M2 x 10 screws (v10, replaces the snap fit). See `docs/elephant_screw_fit_FINAL.png`. USB-C niche 7.25 mm deep: `docs/usb_niche_before_after.png`.
