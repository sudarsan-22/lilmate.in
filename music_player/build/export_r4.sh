#!/bin/bash
# Export look4.scad as one STL per colour part, for the Blender render (build/render_r4.py).
OS=~/.local/opt/openscad-nightly/OpenSCAD.AppImage
cd "$(dirname "$0")/../proposal"
out=../build/r4; mkdir -p $out
declare -A P=([10]="J_body J_acc glass pix shadow" [11]="K_body K_acc glass pix shadow" [12]="L_body L_key L_acc glass pix shadow")
for d in 10 11 12; do for part in ${P[$d]}; do
  $OS --backend Manifold -D design=$d -D "only=\"$part\"" -o $out/d${d}_$part.stl look4.scad >/dev/null 2>&1 || echo "  (no $part in $d)"
done; done
ls -la $out
