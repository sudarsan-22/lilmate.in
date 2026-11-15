# Elephant (Ellie v3)

Round sitting elephant desk buddy: one-piece body plus snap-on back lid, 1.3" OLED, ESP32-C3, TP4056, 502030 battery, slide switch, TTP223 touch.

Printer: Bambu Lab A1 mini. Material: PLA. Units: mm.

## Folder layout
| Folder | What is in it |
|---|---|
| `src/` | Current CAD source only. Entry point: src/main.scad (set part = assembly | print_front | print_back | ...) |
| `docs/` | Design notes, concept `.scad` files and images. `docs/dimensions/` has the dimension sheets (parts and enclosure fit) |
| `reference/` | Look references and third-party originals. reference/reference.jpeg = the look reference |
| `previews/` | Renders and screenshots |
| `output/` | Exported STL / model 3MF files, grouped by version where there is more than one |
| `print/` | Sliced `*.gcode.3mf` files. `print/tests/` has test coupons, `print/slice/` has slicer profiles, scripts and slicer output |
| `build/` | Scratch and check files. Safe to delete |
| `archive/` | Old versions: `archive/src/` has the `*_before_*.scad` copies, `archive/backups/` has the `backup_before_*` folders |
