#!/usr/bin/env bash
# Rebuild a project's FINAL 3mf from its current CAD source.
# usage: build_final.sh <project> [--out DIR]     (DIR = write the new file there instead of replacing the real FINAL; for testing)
# Steps: export print STLs (OpenSCAD) -> slice with Bambu Studio using the project's profiles -> replace *_FINAL file
#        (previous one kept as print/older/<name>_prev) -> record a hash of the CAD source in print/.final_src.sha1
set -u
ROOT="$(cd "$(dirname "$0")/../../../.." && pwd)"
P="${1:?project}"; shift; OUT=""; MARK=0
while [ $# -gt 0 ]; do case "$1" in --out) OUT="$2"; shift;; --mark) MARK=1;; esac; shift; done
OS=~/.local/opt/openscad-nightly/OpenSCAD.AppImage; BS=~/.local/bin/bambu-studio
cd "$ROOT/$P" || exit 1
log() { echo "[$(date +%H:%M:%S)] $P: $*"; }
ex() { # ex <scad> <outfile> [-D args...]
  local scad="$1" out="$2"; shift 2
  ( cd "$(dirname "$scad")" && "$OS" --backend Manifold "$@" -o "$out" "$(basename "$scad")" 2>&1 | grep -iE "^ERROR" ) && return 1
  [ -s "$out" ] || return 1
}
src_hash() { cat src/*.scad 2>/dev/null | sha1sum | cut -d' ' -f1; }
newhash="$(src_hash)"
[ "$MARK" = 1 ] && { echo "$newhash" > print/.final_src.sha1; log "marked in sync"; exit 0; }   # --mark: declare the current FINAL up to date

slice() { # slice <name> <process.json> <outdir> stl...
  local name="$1" proc="$2" od="$3"; shift 3
  rm -rf "$od/slice_tmp"; mkdir -p "$od/slice_tmp"
  ( cd print/slice && "$BS" --orient 0 --arrange 1 --load-settings "machine.json;$proc" --load-filaments filament.json \
      --slice 0 --outputdir "$od/slice_tmp" --export-3mf "$name.gcode.3mf" "$@" >/dev/null 2>&1 )
  [ -s "$od/slice_tmp/$name.gcode.3mf" ] || { log "slicer produced no file"; return 1; }
  python3 - "$od/slice_tmp/result.json" <<'PY' || return 1
import json,sys
d=json.load(open(sys.argv[1])); p=d['sliced_plates'][0]
if d.get('error_string') and not d['error_string'].startswith('Success'): print('slicer error:',d['error_string']); sys.exit(1)
print('sliced: %d plate(s), %.0f min, %.1f g, %s' % (len(d['sliced_plates']), p['total_predication']/60, p['filaments'][0]['total_used_g'], p.get('warning_message') or 'no warning'))
PY
}
install_final() { # install_final <built file> <final path>
  local built="$1" final="$2"
  if [ -n "$OUT" ]; then mkdir -p "$OUT"; cp "$built" "$OUT/$(basename "$final")"; log "test build written to $OUT/$(basename "$final")"; return 0; fi
  mkdir -p "$(dirname "$final")/older"
  [ -f "$final" ] && mv "$final" "$(dirname "$final")/older/$(basename "${final%%.*}")_prev.${final#*.}"
  cp "$built" "$final"; echo "$newhash" > print/.final_src.sha1; log "NEW FINAL: $final"
}

T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
case "$P" in
 music_player)
  o=output/v2; mkdir -p $o
  for s in base deck keyplate shell back; do ex src/main.scad "$ROOT/$P/$o/print_$s.stl" -D "part=\"print_$s\"" || { log "export $s failed"; exit 1; }; done
  ex src/main.scad "$ROOT/$P/$o/print_knob_orange.stl" -D 'part="print_knob"' || exit 1
  i=0; for n in prev PLAY_orange next face; do ex src/main.scad "$ROOT/$P/$o/print_key_$n.stl" -D 'part="print_keycap_i"' -D "ki=$i" || exit 1; i=$((i+1)); done
  slice RETRO_PC_V2_FINAL process_retro_pc.json "$T" $(for f in $ROOT/$P/$o/*.stl; do echo "$f"; done) || exit 1
  install_final "$T/slice_tmp/RETRO_PC_V2_FINAL.gcode.3mf" print/RETRO_PC_V2_FINAL.gcode.3mf;;
 office_buddy)
  o=output/v1; mkdir -p $o
  for s in base deck keyplate carrier shell back knob pin; do ex src/main.scad "$ROOT/$P/$o/print_$s.stl" -D "part=\"print_$s\"" || { log "export $s failed"; exit 1; }; done
  for i in 0 1 2 3; do ex src/main.scad "$ROOT/$P/$o/print_key$i.stl" -D 'part="print_keycap_i"' -D "ki=$i" || exit 1; done
  slice OFFICE_BUDDY_FINAL process_retro_pc.json "$T" $(for f in $ROOT/$P/$o/*.stl; do echo "$f"; done) || exit 1
  install_final "$T/slice_tmp/OFFICE_BUDDY_FINAL.gcode.3mf" print/OFFICE_BUDDY_FINAL.gcode.3mf;;
 elephant)
  ex src/main.scad "$ROOT/$P/output/ellie_v3_body_upright_NO_SUPPORT.stl" -D 'part="print_front"' || exit 1
  ex src/main.scad "$ROOT/$P/output/ellie_v3_lid_upright_NO_SUPPORT.stl" -D 'part="print_back"' || exit 1
  slice ELLIE_V3_FINAL process_ellie_v3_bambu_support.json "$T" "$ROOT/$P/output/ellie_v3_body_upright_NO_SUPPORT.stl" "$ROOT/$P/output/ellie_v3_lid_upright_NO_SUPPORT.stl" || exit 1
  install_final "$T/slice_tmp/ELLIE_V3_FINAL.gcode.3mf" print/ELLIE_V3_FINAL.gcode.3mf;;
 pengu_chubby)
  ex src/main.scad "$ROOT/$P/output/pengu_v3_body_upright.stl" -D 'part="print_front"' || exit 1
  ex src/main.scad "$ROOT/$P/output/pengu_v3_lid_upright.stl" -D 'part="print_back"' || exit 1
  slice PENGU_V3_FINAL process_ellie_v3_bambu_support.json "$T" "$ROOT/$P/output/pengu_v3_body_upright.stl" "$ROOT/$P/output/pengu_v3_lid_upright.stl" || exit 1
  install_final "$T/slice_tmp/PENGU_V3_FINAL.gcode.3mf" print/PENGU_V3_FINAL.gcode.3mf;;
 desk_mini)
  ex src/desk_mini_v2.scad "$T/DESK_MINI_V2_FINAL.3mf" -D 'part="all"' || { log "3mf export failed"; exit 1; }
  for s in shell plate body bezel; do ex src/desk_mini_v2.scad "$ROOT/$P/output/v2_$s.stl" -D "part=\"$s\"" || exit 1; done
  install_final "$T/DESK_MINI_V2_FINAL.3mf" output/DESK_MINI_V2_FINAL.3mf;;
 deck_buddy)
  ex src/deck_buddy_SA.scad "$ROOT/$P/output/deck_buddy_SA_body_upright.stl" -D 'view="print"' || exit 1
  ex src/deck_buddy_oled13.scad "$ROOT/$P/output/deck_buddy_bezel_oled13.stl" -D 'view="bezel"' || exit 1
  ex src/deck_buddy_oled13.scad "$ROOT/$P/output/deck_buddy_bracket_oled13.stl" -D 'view="bracket"' || exit 1
  ( cd src && "$OS" --backend Manifold -o "$ROOT/$P/output/print_back_lid_switch.stl" back_lid_switch_FINAL.scad 2>&1 | grep -iE "^ERROR" ) && exit 1
  ( cd print/slice && bash slice_SA13.sh ) || exit 1
  [ -s print/DECK_BUDDY_SA_OLED13_print.gcode.3mf ] || { log "slice failed"; exit 1; }
  install_final print/DECK_BUDDY_SA_OLED13_print.gcode.3mf print/DECK_BUDDY_SA_OLED13_FINAL.gcode.3mf; rm -f print/DECK_BUDDY_SA_OLED13_print.gcode.3mf;;
 *) log "unknown project"; exit 1;;
esac
