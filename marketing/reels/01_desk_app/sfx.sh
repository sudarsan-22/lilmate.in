#!/usr/bin/env bash
# Sound design for reel 01, synced to reel.html's timeline (T = { open 7.3, close 12.6, ask 13.3, allow 14.62, askClose 14.95, focus 15.85, tick 11.55 }).
# Writes out/sfx.wav (22 s, 48 kHz stereo), then muxes the final reel.
set -euo pipefail
cd "$(dirname "$0")"
D=22

# name|start seconds|duration|expression (mono, t starts at 0 for each sound)
pad='0.05*(sin(2*PI*110*t)+sin(2*PI*110.35*t)+0.6*sin(2*PI*164.8*t)+0.5*sin(2*PI*220.3*t)+0.35*sin(2*PI*277.2*t)+0.25*sin(2*PI*329.6*t)+0.12*sin(2*PI*440.6*t))*(0.82+0.18*sin(2*PI*0.2*t))'
pop='0.32*sin(2*PI*(380*t+900*t*t))*exp(-12*t)'
drop='0.22*sin(2*PI*(720*t-500*t*t))*exp(-18*t)'
ding='0.16*(sin(2*PI*1318.5*t)+0.45*sin(2*PI*2637*t)+0.25*sin(2*PI*1975.5*t))*exp(-3.5*t)'
click='0.45*sin(2*PI*2100*t)*exp(-110*t)+0.3*sin(2*PI*700*t)*exp(-70*t)'
tick='0.07*sin(2*PI*1600*t)*exp(-140*t)'

ins=() ; fil='' ; n=0
add() {  # start dur expr [extra filters]
  ins+=(-f lavfi -t "$2" -i "aevalsrc=exprs='$3':s=48000")
  fil+="[$n]${4:-anull},adelay=$(printf '%.0f' "$(echo "$1*1000" | bc)"):all=1[a$n];"
  n=$((n+1))
}
whoosh() {  # peak time
  local s; s=$(echo "$1-0.45" | bc)
  ins+=(-f lavfi -t 0.85 -i "anoisesrc=d=0.85:c=pink:a=0.6:r=48000")
  fil+="[$n]highpass=f=250,lowpass=f=2600,afade=t=in:d=0.45:curve=exp,afade=t=out:st=0.45:d=0.4,volume=0.55,adelay=$(printf '%.0f' "$(echo "$s*1000" | bc)"):all=1[a$n];"
  n=$((n+1))
}

add 0 $D "$pad" "lowpass=f=1600,aecho=0.8:0.6:70|140:0.25|0.15,afade=t=in:d=2.5,afade=t=out:st=19.3:d=2.7"
for w in 3.2 5.25 9.45 15.3 18.6; do whoosh $w; done
bub='0.13*sin(2*PI*(900*t+2600*t*t))*exp(-30*t)'
for b in 1.3 1.45 1.6 11.65 13.85; do add $b 0.18 "$bub"; done
add 4.3 1.6 "$ding"
add 7.3 0.4 "$pop"
add 11.5 0.12 "$click"
add 12.6 0.3 "$drop"
add 13.3 0.4 "$pop"
add 14.6 0.12 "$click"
add 14.95 0.3 "$drop"
for k in 16.85 17.85; do add $k 0.08 "$tick"; done
add 20.9 1.6 "$ding"

mix=''; for ((i=0;i<n;i++)); do mix+="[a$i]"; done
ffmpeg -y -loglevel error "${ins[@]}" -filter_complex "${fil}${mix}amix=inputs=$n:normalize=0:duration=longest,atrim=0:$D,aformat=channel_layouts=stereo,loudnorm=I=-18:TP=-1.5:LRA=11,aresample=48000[out]" \
  -map "[out]" -c:a pcm_s16le out/sfx.wav

ffmpeg -y -loglevel error -i out/video_only.mp4 -i out/sfx.wav -map 0:v -map 1:a -c:v copy -c:a aac -b:a 192k -ar 48000 -shortest -movflags +faststart out/lilmate_desk_reel_01.mp4
cp out/video_only.mp4 out/lilmate_desk_reel_01_no_audio.mp4
echo "wrote out/lilmate_desk_reel_01.mp4 and out/lilmate_desk_reel_01_no_audio.mp4"
