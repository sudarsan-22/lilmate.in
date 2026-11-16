#!/bin/bash
# usage: export_v1.sh <outdir> <explode> <cut> [with_electronics 0/1]
OS=~/.local/opt/openscad-nightly/OpenSCAD.AppImage
cd "$(dirname "$0")"; out=$1; e=$2; c=$3; el=${4:-0}; mkdir -p $out; rm -f $out/*.stl
sed -i 's/^part = "assembly";/part = "none";/' ../src/main.scad
P="base deck keyplate keys_grey keys_orange shell back knob"; [ "$el" = 1 ] && P="$P pcb_blue glass pix metal black pcb_tp pcb_green"
[ "$el" = 0 ] && P="$P glass pix"
for s in $P; do $OS --backend Manifold -D "sel=\"$s\"" -D e=$e -D cut=$c -o $out/$s.stl views.scad >/dev/null 2>&1; done
sed -i 's/^part = "none";/part = "assembly";/' ../src/main.scad
ls $out | tr '\n' ' '; echo
