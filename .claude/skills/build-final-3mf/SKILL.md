---
name: build-final-3mf
description: Rebuild a lilmate project's FINAL 3mf after any design change. Use this every time CAD source (3d/src/*.scad) of deck_buddy, desk_mini, elephant, music_player, office_buddy or pengu_chubby is edited, when the user says "rebuild the final", "update the 3mf", "re-slice", or after any dimension, component-fit, snap, slot or key change, even if they do not ask for the 3mf explicitly. The final 3mf must always match the current source.
---

# Rebuild the FINAL 3mf (every design change)

Rule: the `*_FINAL` file of a project must always be built from the current `src/`. A design change is not finished until its FINAL is rebuilt.

## Do it
```bash
bash .claude/skills/build-final-3mf/scripts/build_final.sh <project>
# projects: deck_buddy | desk_mini | elephant | music_player | office_buddy | pengu_chubby
# add  --out DIR  to write a test build somewhere else without touching the real FINAL
```
The script (run from `lilmate_3D_design/`):
1. exports the print STLs with OpenSCAD (`part=print_*` or `view=...`) into the project's `3d/output/`
2. slices them with Bambu Studio using the project's `3d/print/slice/` profiles (`machine.json`, `filament.json`, process json), checks the slicer result for errors
3. replaces the FINAL file, keeping the previous one as `3d/print/older/<name>_prev.*` (Desk Mini: `3d/output/older/`)
4. records a hash of `3d/src/*.scad` in `3d/print/.final_src.sha1` so the build knows the FINAL is in sync

If a step fails the old FINAL is left untouched and the script exits non-zero: report it, do not hand-edit the 3mf.

| Project | FINAL produced |
|---|---|
| deck_buddy | `3d/print/DECK_BUDDY_SA_OLED13_FINAL.gcode.3mf` (runs `3d/print/slice/slice_SA13.sh`, manual plate layout + per-object supports) |
| desk_mini | `3d/output/DESK_MINI_V2_FINAL.3mf` (model only, `part=all`) |
| elephant | `3d/print/ELLIE_V3_FINAL.gcode.3mf` (Bambu tree supports) |
| music_player | `3d/print/RETRO_PC_V2_FINAL.gcode.3mf` |
| office_buddy | `3d/print/OFFICE_BUDDY_FINAL.gcode.3mf` |
| pengu_chubby | `3d/print/PENGU_V3_FINAL.gcode.3mf` |

Reference check (final built from current source): Music Player 167 min / 51.4 g, Office Buddy 186 min / 57.9 g, Elephant 413 min / 86.9 g, Deck Buddy 289 min / 64.1 g all match the earlier finals. Pengu rebuilds at 391 min / 75.4 g against 370 min / 73.0 g in the earlier final, so compare when you next change Pengu. Office Buddy reports a "floating regions" warning on `print_back.stl`; check the back cover orientation if it matters.

## After a design change
1. Edit `3d/src/` (keep the previous copy in `3d/archive/src/` as `main_before_<change>.scad` for big edits).
2. Run the clash check where it exists (`part=check` for music_player/office_buddy, `check_*` for elephant/pengu); it must come out empty.
3. Run `build_final.sh <project>`.
4. Refresh `docs/dimensions/` and the project's `SKILL.md` tables if sizes changed.
5. The commit-design skill commits and pushes (see that skill).

## Automatic
A Stop hook (`.claude/settings.json` -> `scripts/on_stop.sh`) compares each project's `3d/src/*.scad` hash with `3d/print/.final_src.sha1` at the end of every Claude turn. If a project is out of sync it rebuilds that FINAL in the background (log: `/tmp/lilmate_auto.log`), then runs the commit-design auto-commit. To declare a FINAL in sync without rebuilding: `build_final.sh <project> --mark`.
