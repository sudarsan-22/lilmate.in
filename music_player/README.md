# Music Player (Retro PC v2)

Tiny retro-PC music player: 1.3" OLED, YX6300 MP3 module, ESP32-C3, TP4056, 503450 battery, 4 keys and a volume knob.

Printer: Bambu Lab A1 mini. Material: PLA. Units: mm.

## Folder layout
| Folder | What is in it |
|---|---|
| `3d/` | All CAD work: `src/` current source, `output/` STL and model 3MF, `print/` sliced `*_FINAL` files (`print/tests/` coupons, `print/slice/` profiles and scripts), `previews/`, `reference/` (look images, third-party originals), `build/` (scratch), `archive/` (old sources and backups) |
| `firmware/` | Microcontroller sketch and flashing notes (see its README) |
| `hardware/` | `bom.csv`, `pinout.md`, `components.md` (sizes and housing), `soldering_sop.png` (wiring + soldering steps), `datasheets/` |
| `docs/` | Design notes, concept scad, `docs/dimensions/` dimension sheets |
| `.claude/skills/` | Project skill for Claude Code |
