# Deck Buddy

Yeti-style desk buddy with a 1.3" OLED, ESP32-C3 Mini and TP4056 stack, and a snap-on back lid with a slide switch.

Printer: Bambu Lab A1 mini. Material: PLA. Units: mm.

## Folder layout
| Folder | What is in it |
|---|---|
| `src/` | Current CAD source only. Entry point: src/deck_buddy_oled13.scad (bracket + bezel), src/deck_buddy_SA.scad (body), src/back_lid_switch_FINAL.scad (lid) |
| `docs/` | Design notes, concept `.scad` files and images. `docs/dimensions/` has the dimension sheets (parts and enclosure fit) |
| `reference/` | Look references and third-party originals. reference/original = the original Yeti STLs |
| `previews/` | Renders and screenshots |
| `output/` | Exported STL / model 3MF files, grouped by version where there is more than one |
| `print/` | Sliced `*.gcode.3mf` files. `print/tests/` has test coupons, `print/slice/` has slicer profiles, scripts and slicer output |
| `build/` | Scratch and check files. Safe to delete |
| `archive/` | Old versions: `archive/src/` has the `*_before_*.scad` copies, `archive/backups/` has the `backup_before_*` folders |
