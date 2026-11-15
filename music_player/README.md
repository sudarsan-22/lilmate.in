# Music Player (Retro PC v2)

Tiny retro-PC music player: 1.3" OLED, YX6300 MP3 module, ESP32-C3, TP4056, 503450 battery, 4 keys and a volume knob.

Printer: Bambu Lab A1 mini. Material: PLA. Units: mm.

## Folder layout
| Folder | What is in it |
|---|---|
| `src/` | Current CAD source only. Entry point: src/main.scad (set part = assembly | exploded | section | print_*) |
| `docs/` | Design notes, concept `.scad` files and images. `docs/dimensions/` has the dimension sheets (parts and enclosure fit) |
| `reference/` | Look references and third-party originals. reference/yx6300_amazon = module photos; docs/components_L_retro_pc.md = parts list |
| `previews/` | Renders and screenshots |
| `output/` | Exported STL / model 3MF files, grouped by version where there is more than one |
| `print/` | Sliced `*.gcode.3mf` files. `print/tests/` has test coupons, `print/slice/` has slicer profiles, scripts and slicer output |
| `build/` | Scratch and check files. Safe to delete |
| `archive/` | Old versions: `archive/src/` has the `*_before_*.scad` copies, `archive/backups/` has the `backup_before_*` folders |
