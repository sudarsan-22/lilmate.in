# Compose the round-4 proposal sheet from the Blender renders in previews/.
import sys
from PIL import Image, ImageDraw, ImageFont, ImageChops
base = sys.argv[1]
F = "/usr/share/fonts/truetype/dejavu/"
fb = lambda s: ImageFont.truetype(F + "DejaVuSans-Bold.ttf", s)
fr = lambda s: ImageFont.truetype(F + "DejaVuSans.ttf", s)
BG, INK, GREY = (247, 245, 241), (34, 36, 46), (110, 110, 118)
ACC = {10: (226, 96, 76), 11: (222, 112, 132), 12: (232, 118, 40)}
W, colw, top, imgh = 2700, 900, 150, 1125
S = Image.new("RGB", (W, top + imgh + 520), BG); d = ImageDraw.Draw(S)
d.text((50, 36), "Music player - round 4 (after R&D): one hero element, 2 colours, honest OLED face", font=fb(44), fill=INK)
d.text((50, 96), "Blender renders at true relative size. Parts: 1.3\" OLED, ESP32-C3, YX6300 (microSD + 3.5 mm), TP4056 + Li-Po, TTP223, switch", font=fr(26), fill=GREY)
info = {
 10: ("J  Pocket Walkman", "54 x 94 x 16 mm  |  pocket, headphones",
      ["Hero: big coral dial (EC11 encoder)", "turn = volume, press = play / pause", "nubbed side rocker = prev / next", "slide switch shows a coral ON flag", "belt clip on the back"],
      "top: 3.5 mm jack + lanyard | left: microSD | bottom: USB-C", "+ 1 EC11 rotary encoder"),
 11: ("K  Mochi Pebble", "66 x 34 x 57 mm  |  desk / hand, headphones",
      ["Hero: the soft mochi shape itself", "pat its head (TTP223) = play / pause", "3 beads = prev / play / next", "pink base = battery lid", "tiny moulded bear-ear nubs"],
      "back: 3.5 mm jack, microSD, USB-C", "+ 3 small tact switches"),
 12: ("L  Tiny Retro PC", "60 x 66 x 60 mm  |  desk, headphones",
      ["Hero: 4 chunky printed keycaps", "prev / PLAY / next / face-mode", "microSD lives in the 'floppy' drive bay", "orange knob = volume (EC11)", "CRT-style bezel + side vents"],
      "back: 3.5 mm jack, USB-C | front bay: microSD", "+ 4 tact switches + EC11"),
}
for i, k in enumerate((10, 11, 12)):
    x0 = i * colw
    im = Image.open(f"{base}/r4_{k}_front.png").convert("RGB").resize((900, 1125), Image.LANCZOS)
    S.paste(im, (x0, top))
    bk = Image.open(f"{base}/r4_{k}_back.png").convert("RGB").resize((240, 300), Image.LANCZOS)
    S.paste(bk, (x0 + colw - 260, top + imgh + 200))
    d.rectangle([x0 + colw - 260, top + imgh + 200, x0 + colw - 21, top + imgh + 499], outline=(220, 216, 208), width=2)
    name, size, lines, ports, extra = info[k]
    y = top + imgh + 24
    d.text((x0 + 40, y), name, font=fb(54), fill=ACC[k])
    d.text((x0 + 40, y + 74), size, font=fr(26), fill=GREY)
    for j, l in enumerate(lines):
        d.text((x0 + 40, y + 124 + j * 42), l, font=fr(30), fill=INK)
    d.text((x0 + 40, y + 124 + 5 * 42 + 14), ports, font=fr(22), fill=GREY)
    d.text((x0 + 40, y + 124 + 5 * 42 + 46), "parts: " + extra, font=fb(22), fill=GREY)
out = f"{base}/../proposal/music_player_concepts_round4.png"
S.save(out); print(out, S.size)
