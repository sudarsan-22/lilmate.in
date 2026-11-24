#!/usr/bin/env bash
# Sound for reel 02: a soft warm pad, a gentle "boop" each time a finger pats Minimo, a whoosh into the end card and a chime on the logo spark.
# Times are in the edited reel (see SHOTS in reel.html). Writes out/sfx.wav, then muxes the final reel.
set -euo pipefail
cd "$(dirname "$0")"
D=20

pad='0.05*(sin(2*PI*130.8*t)+sin(2*PI*131.1*t)+0.6*sin(2*PI*196*t)+0.5*sin(2*PI*261.6*t)+0.35*sin(2*PI*329.6*t)+0.2*sin(2*PI*392.4*t))*(0.82+0.18*sin(2*PI*0.18*t))'
boop='0.30*sin(2*PI*(520*t+700*t*t))*exp(-16*t)+0.10*sin(2*PI*1040*t)*exp(-24*t)'
ding='0.16*(sin(2*PI*1318.5*t)+0.45*sin(2*PI*2637*t)+0.25*sin(2*PI*1975.5*t))*exp(-3.5*t)'

ins=() ; fil='' ; n=0
add() {  # start dur expr [extra filters]
  ins+=(-f lavfi -t "$2" -i "aevalsrc=exprs='$3':s=48000")
  fil+="[$n]${4:-anull},adelay=$(printf '%.0f' "$(echo "$1*1000" | bc)"):all=1[a$n];"
  n=$((n+1))
}
whoosh() {
  local s; s=$(echo "$1-0.45" | bc)
  ins+=(-f lavfi -t 0.85 -i "anoisesrc=d=0.85:c=pink:a=0.6:r=48000")
  fil+="[$n]highpass=f=250,lowpass=f=2400,afade=t=in:d=0.45:curve=exp,afade=t=out:st=0.45:d=0.4,volume=0.45,adelay=$(printf '%.0f' "$(echo "$s*1000" | bc)"):all=1[a$n];"
  n=$((n+1))
}

add 0 $D "$pad" "lowpass=f=1500,aecho=0.8:0.6:80|160:0.25|0.15,afade=t=in:d=1.5,afade=t=out:st=17.5:d=2.5"
for b in 3.3 5.35 10.4 12.65 15.45; do add $b 0.35 "$boop"; done
whoosh 16.3
add 18.85 1.6 "$ding"

mix=''; for ((i=0;i<n;i++)); do mix+="[a$i]"; done
ffmpeg -y -loglevel error "${ins[@]}" -filter_complex "${fil}${mix}amix=inputs=$n:normalize=0:duration=longest,atrim=0:$D,aformat=channel_layouts=stereo,loudnorm=I=-18:TP=-1.5:LRA=11,aresample=48000[out]" \
  -map "[out]" -c:a pcm_s16le out/sfx.wav

ffmpeg -y -loglevel error -i out/video_only.mp4 -i out/sfx.wav -map 0:v -map 1:a -c:v copy -c:a aac -b:a 192k -ar 48000 -shortest -movflags +faststart out/lilmate_minimo_reel_02.mp4
cp out/video_only.mp4 out/lilmate_minimo_reel_02_no_audio.mp4
echo "wrote out/lilmate_minimo_reel_02.mp4 and out/lilmate_minimo_reel_02_no_audio.mp4"
