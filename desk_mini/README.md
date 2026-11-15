# Desk Mini v2

Small desk gadget built by editing imported STL parts: body, back plate, display bezel and a shell with a buzzer holder.

Printer: Bambu Lab A1 mini. Material: PLA. Units: mm.

## Folder layout
| Folder | What is in it |
|---|---|
| `src/` | Current CAD source only. Entry point: src/desk_mini_v2.scad (set part = all | shell | plate | body | tray | bezel) |
| `docs/` | Design notes, concept `.scad` files and images. `docs/dimensions/` has the dimension sheets (parts and enclosure fit) |
| `reference/` | Look references and third-party originals. reference/original = the original STLs and the OLED 0.96 case 3MF |
| `previews/` | Renders and screenshots |
| `output/` | Exported STL / model 3MF files, grouped by version where there is more than one |
| `print/` | Sliced `*.gcode.3mf` files. `print/tests/` has test coupons, `print/slice/` has slicer profiles, scripts and slicer output |
| `build/` | Scratch and check files. Safe to delete |
| `archive/` | Old versions: `archive/src/` has the `*_before_*.scad` copies, `archive/backups/` has the `backup_before_*` folders |
