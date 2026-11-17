"""0.96" I2C OLED module (SSD1306, 4-pin, 128x64) -> STEP reference model.

Run:  <python with cadquery> make_oled_step.py
Out:  oled_096_ssd1306.step  (module 2.8 thick)
      oled_096_ssd1306.stl   (same, for OpenSCAD import)

Source: EastRising ER-OLEDM0.96-1 datasheet, 1.4.2 mechanical drawing (hwkitchen.cz copy).
  Dimensioned values: PCB 27.3 x 27.8 x 1.2, holes 23.3 x 23.8 (Ø2, Ø3.5 ring), 2.0 from the edges,
  panel 26.7 x 19.26 x 1.45, 4.27 from the header edge, 0.3 from the sides, module 2.8 thick,
  VA 23.744 x 12.864 at 5.37 from the header edge, AA 21.744 x 10.864 at 6.37.
  Measured from a 400 dpi render (37.2 px/mm, +-0.1 mm): header row 1.51 from the top edge,
  FPC notch 14.1 x 2.0 in the bottom edge, FPC about 11 wide.
  That drawing is the 7-pin SPI board; the 4-pin I2C board uses the same PCB outline, holes and panel,
  with 4 pins centred (GND VCC SCL SDA on most boards; check the silkscreen).

Coordinates: origin = centre of the PCB outline, +Y = header edge (top), +Z = toward the viewer,
Z = 0 = PCB back face. Glass is on +Z, header plastic and SMD parts on -Z.
"""
import cadquery as cq
from pathlib import Path

OUT = Path(__file__).resolve().parent

# ---- PCB ----
W, H, T_PCB = 27.3, 27.8, 1.2
HOLE_D = 2.0
HOLE_IN_X, HOLE_TOP, HOLE_BOT = 2.0, 2.0, 2.0
NOTCH_W, NOTCH_D = 14.1, 2.0

# ---- header (1x4, 2.54), centred ----
PITCH, N_PINS, PIN_Y = 2.54, 4, 1.51
PIN_SQ, PLASTIC_H, PIN_BACK, PIN_FRONT = 0.64, 2.5, 6.0, 1.8   # plastic on the back, pins point backward

# ---- glass ----
TOTAL_T = 2.8
GLASS_W, GLASS_H, GLASS_T = 26.7, 19.26, 1.45
GLASS_TOP = 4.27                  # glass top edge from the PCB top edge (glass is centred both ways)
VA_W, VA_H, VA_TOP = 23.744, 12.864, 5.37 - 4.27   # VA top edge from the glass top edge (1.1)
AA_W, AA_H = 21.744, 10.864
INK = 0.05

# ---- flex cable ----
FPC_W, FPC_T, FPC_BACK_LEN = 11.0, 0.15, 8.0

# ---- back-side SMD keep-out (regulator, caps, resistors) - approximate ----
SMD_H, SMD_Y, SMD_X = 1.1, (3.2, 15.0), 11.0


def box(x0, x1, y0, y1, z0, z1):
    return cq.Workplane("XY").box(x1 - x0, y1 - y0, z1 - z0, centered=False).translate((x0, y0, z0))


def build():
    gap = round(TOTAL_T - T_PCB - GLASS_T, 3)
    top, bot, left = H / 2, -H / 2, -W / 2

    pcb = box(left, W / 2, bot, top, 0, T_PCB)
    holes = [(left + HOLE_IN_X, top - HOLE_TOP), (-left - HOLE_IN_X, top - HOLE_TOP),
             (left + HOLE_IN_X, bot + HOLE_BOT), (-left - HOLE_IN_X, bot + HOLE_BOT)]
    pcb = pcb.cut(cq.Workplane("XY").pushPoints(holes).circle(HOLE_D / 2).extrude(T_PCB))
    pcb = pcb.cut(box(-NOTCH_W / 2, NOTCH_W / 2, bot - 0.1, bot + NOTCH_D, -0.1, T_PCB + 0.1))
    x_p1 = -(N_PINS - 1) * PITCH / 2
    pins = [(x_p1 + i * PITCH, top - PIN_Y) for i in range(N_PINS)]
    pcb = pcb.cut(cq.Workplane("XY").pushPoints(pins).circle(0.5).extrude(T_PCB))

    z_g0 = T_PCB + gap
    z_g1 = z_g0 + GLASS_T
    g_top = top - GLASS_TOP
    g_bot = g_top - GLASS_H
    va_cy = g_top - VA_TOP - VA_H / 2
    glass = box(-GLASS_W / 2, GLASS_W / 2, g_bot, g_top, z_g0, z_g1)
    glass = glass.cut(box(-VA_W / 2, VA_W / 2, va_cy - VA_H / 2, va_cy + VA_H / 2, z_g1 - INK, z_g1))
    aa = box(-AA_W / 2, AA_W / 2, va_cy - AA_H / 2, va_cy + AA_H / 2, z_g1 - INK, z_g1)
    va = box(-VA_W / 2, VA_W / 2, va_cy - VA_H / 2, va_cy + VA_H / 2, z_g1 - INK, z_g1).cut(aa)

    # flex: from the glass bottom edge down the front, 180 deg bend inside the notch, up the back face
    r_out = (T_PCB + 2 * FPC_T) / 2
    y_bend = bot + r_out + 0.05
    fpc_front = box(-FPC_W / 2, FPC_W / 2, y_bend, g_bot, T_PCB, T_PCB + FPC_T)
    bend = (cq.Workplane("YZ").center(y_bend, T_PCB / 2)
            .circle(r_out).circle(r_out - FPC_T).extrude(FPC_W).translate((-FPC_W / 2, 0, 0))
            .cut(box(-FPC_W, FPC_W, y_bend, y_bend + 5, -5, 5)))
    fpc_back = box(-FPC_W / 2, FPC_W / 2, y_bend, bot + FPC_BACK_LEN, -FPC_T, 0)
    fpc = fpc_front.union(bend).union(fpc_back)

    hdr = box(x_p1 - PITCH / 2, -x_p1 + PITCH / 2, top - PIN_Y - 1.27, top - PIN_Y + 1.27, -PLASTIC_H, 0)
    for (x, y) in pins:
        hdr = hdr.union(box(x - PIN_SQ / 2, x + PIN_SQ / 2, y - PIN_SQ / 2, y + PIN_SQ / 2,
                            -PLASTIC_H - PIN_BACK, T_PCB + PIN_FRONT))

    smd = box(-SMD_X, SMD_X, top - SMD_Y[1], top - SMD_Y[0], -SMD_H, 0)

    asm = cq.Assembly(name="OLED_0p96_SSD1306")
    asm.add(pcb, name="pcb", color=cq.Color(0.05, 0.25, 0.65))
    asm.add(glass, name="glass", color=cq.Color(0.12, 0.12, 0.14))
    asm.add(va, name="viewing_area_border", color=cq.Color(0.02, 0.02, 0.02))
    asm.add(aa, name="active_area_128x64", color=cq.Color(0.0, 0.0, 0.0))
    if gap > 0:
        asm.add(box(-GLASS_W / 2 + 1, GLASS_W / 2 - 1, g_bot + 1, g_top - 1, T_PCB, z_g0),
                name="adhesive", color=cq.Color(0.95, 0.95, 0.95))
    asm.add(fpc, name="fpc", color=cq.Color(0.85, 0.5, 0.1))
    asm.add(hdr, name="header_1x4_optional", color=cq.Color(0.1, 0.1, 0.1))
    asm.add(smd, name="keepout_back_smd", color=cq.Color(0.6, 0.6, 0.6))
    return asm, dict(gap=gap, glass_z=(z_g0, z_g1), glass_y=(g_bot, g_top), va_cy=va_cy, holes=holes, pins=pins)


if __name__ == "__main__":
    asm, info = build()
    asm.export(str(OUT / "oled_096_ssd1306.step"))
    cq.exporters.export(asm.toCompound(), str(OUT / "oled_096_ssd1306.stl"))
    print(info)
