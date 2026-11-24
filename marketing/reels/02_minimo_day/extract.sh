#!/usr/bin/env bash
# Pulls the chosen moments out of the iPhone clips as graded, vertical JPEG frames for reel.html.
# iPhone HDR (HLG) -> SDR with tone mapping, a warm soft grade, crop to 9:16 around Minimo, 1188x2112 (10% room for push-ins).
# Slow-motion shots keep every 60 fps frame (played back at 30 fps = half speed).
# usage: ./extract.sh <folder with IMG_*.MOV> <frames out dir>
set -euo pipefail
SRC=${1:?clips folder}; OUT=${2:?frames dir}
TM="zscale=tin=arib-std-b67:min=bt2020nc:pin=bt2020:rin=tv:t=linear:npl=203,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p"
GRADE="eq=contrast=1.04:saturation=1.1:gamma=1.18,colorbalance=rm=0.03:bm=-0.04:rh=0.02:bh=-0.03,curves=all='0/0.035 0.2/0.24 0.6/0.68 1/0.98'"

# id | clip | start s | output seconds | speed (slow = half speed) | crop width (src px, 2160x3840 portrait) | crop centre x | crop centre y
SHOTS="
A|IMG_7191|12.45|2.30|slow|1300|1380|2420
B|IMG_7192|7.30|3.00|slow|1700|825|1765
C|IMG_7191|37.60|2.80|norm|2160|1080|1920
D|IMG_7191|29.60|1.20|norm|2160|1080|1920
E|IMG_7191|31.85|1.05|norm|2160|1080|1920
F|IMG_7191|33.60|0.90|norm|2160|1080|1920
G|IMG_7191|35.00|1.20|norm|2160|1080|1920
H|IMG_7192|16.00|4.00|slow|1700|825|1765
"
while IFS='|' read -r id clip ss dur speed cw cx cy; do
  [ -z "$id" ] && continue
  ch=$(( cw * 16 / 9 / 2 * 2 ))
  x=$(( cx - cw / 2 )); y=$(( cy - ch / 2 ))
  (( x < 0 )) && x=0; (( y < 0 )) && y=0
  (( x + cw > 2160 )) && x=$(( 2160 - cw )); (( y + ch > 3840 )) && y=$(( 3840 - ch ))
  n=$(python3 -c "print(round($dur*30))")
  if [ "$speed" = slow ]; then sdur=$(python3 -c "print($dur/2+0.1)"); fps=""; else sdur=$(python3 -c "print($dur+0.1)"); fps="fps=30,"; fi
  mkdir -p "$OUT/$id"; rm -f "$OUT/$id"/*.jpg
  echo "shot $id: $clip $ss +${sdur}s  crop ${cw}x${ch}+${x}+${y}  -> $n frames"
  ffmpeg -nostdin -y -loglevel error -ss "$ss" -t "$sdur" -i "$SRC/$clip.MOV" \
    -vf "${fps}crop=$cw:$ch:$x:$y,$TM,$GRADE,scale=1188:2112:flags=lanczos" -frames:v "$n" -q:v 2 "$OUT/$id/%04d.jpg"
done <<< "$SHOTS"
echo done
