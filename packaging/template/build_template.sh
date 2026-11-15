#!/usr/bin/env bash
# usage: build_template.sh <product> <Lo> <Wo> <Ho>   -> ../<product>/template/ (tile STLs, key, sliced 3mf)
set -eu
HERE="$(cd "$(dirname "$0")" && pwd)"; P="$1"; Lo="$2"; Wo="$3"; Ho="$4"
OUT="$HERE/../$P/template"; mkdir -p "$OUT/stl"; NAME="$(echo "$P" | tr a-z A-Z)_BOX_TEMPLATE_FINAL"
OS=~/.local/opt/openscad-nightly/OpenSCAD.AppImage; BS=~/.local/bin/bambu-studio
cd "$HERE"
for p in front sideR back sideL lid base key; do
  "$OS" --backend Manifold -D "part=\"$p\"" -D Lo=$Lo -D Wo=$Wo -D Ho=$Ho -o "$OUT/stl/$P-$p.stl" box_template.scad 2>&1 | grep -iE "^ERROR" && exit 1
done
rm -rf "$OUT/stl/keys"; mkdir -p "$OUT/stl/keys"; for i in 01 02 03 04 05 06 07 08 09 10 11 12; do cp "$OUT/stl/$P-key.stl" "$OUT/stl/keys/key_$i.stl"; done
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
"$BS" --orient 0 --arrange 1 --load-settings "machine.json;process_template.json" --load-filaments filament.json --slice 0 --outputdir "$T" --export-3mf "$NAME.gcode.3mf" "$OUT"/stl/$P-{front,sideR,back,sideL,lid,base}.stl "$OUT"/stl/keys/*.stl >/dev/null 2>&1 || true
[ -s "$T/$NAME.gcode.3mf" ] || { echo "slicing failed"; exit 1; }
cp "$T/$NAME.gcode.3mf" "$OUT/$NAME.gcode.3mf"
python3 - "$T/result.json" <<'PY'
import json,sys
d=json.load(open(sys.argv[1]));pl=d['sliced_plates']
print('error:',d['error_string'],'| plates',len(pl),'| total %.0f min, %.1f g'%(sum(p['total_predication'] for p in pl)/60,sum(p['filaments'][0]['total_used_g'] for p in pl)),'|',[p.get('warning_message') for p in pl if p.get('warning_message')] or 'no warnings')
PY
