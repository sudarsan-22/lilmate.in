# Pengu Chubby v3

Chubby sitting penguin desk buddy: one-piece body plus snap-on back lid, 1.3" OLED, ESP32-C3, TP4056, battery, switch, touch.

Printer: Bambu Lab A1 mini. Material: PLA. Units: mm.

## Folder layout
| Folder | What is in it |
|---|---|
| `3d/` | All CAD work: `src/` current source, `output/` STL and model 3MF, `print/` sliced `*_FINAL` files (`print/tests/` coupons, `print/slice/` profiles and scripts), `previews/`, `reference/` (look images, third-party originals), `build/` (scratch), `archive/` (old sources and backups) |
| `firmware/` | Microcontroller sketch and flashing notes (see its README) |
| `hardware/` | `bom.csv`, `pinout.md`, `components.md` (sizes and housing), `datasheets/` |
| `docs/` | Design notes, concept scad, `docs/dimensions/` dimension sheets |
| `.claude/skills/` | Project skill for Claude Code |
