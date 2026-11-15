#!/bin/bash
# Export assembled colour parts for build/render.py
OS=~/.local/opt/openscad-nightly/OpenSCAD.AppImage
cd "$(dirname "$0")/../src"; out=../build/parts; mkdir -p $out
for p in base deck keyplate shell back knob r_glass r_pix r_key0 r_key1 r_key2 r_key3; do
  $OS --backend Manifold -D "part=\"$p\"" -o $out/$p.stl main.scad >/dev/null 2>&1 || echo "fail $p"
done
ls $out
