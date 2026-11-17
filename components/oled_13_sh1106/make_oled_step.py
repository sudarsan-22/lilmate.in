"""1.3" I2C OLED module (SH1106, 4-pin, 128x64) -> STEP reference model.

Run:  <python with cadquery> make_oled_step.py
Out:  oled_13_sh1106_3p3mm.step  (module 3.3 thick, measured on the Deck Buddy display 2026-11-15)
      oled_13_sh1106_2p7mm.step  (module 2.7 thick, manufacturer "2.70 max", Ellie)
      oled_13_sh1106_3p3mm.stl   (preview only)

Sources:
  - outline 35.4 x 33.5 x 1.2, glass 34.5 x 23: user measurement (bom.csv) = manufacturer listing 35.40 x 33.50 x 2.70 max
  - holes, header, glass position, viewing area, FPC notch: ETT "OLED 1.3 I2C" datasheet drawing
    (zbotic.in mirror), measured from a 300 dpi render, 28.5 px/mm, so +-0.1 mm
  - viewing/active area: standard 1.3" 128x64 panel (VA 31.42 x 16.70, AA 29.42 x 14.70)

Coordinates: origin = centre of the PCB outline, +Y = header edge (top), +Z = toward the viewer,
Z = 0 = PCB back face. Glass is on +Z, header plastic and SMD parts on -Z.
"""
import cadquery as cq
from pathlib import Path

OUT = Path(__file__).resolve().parent

# ---- PCB ----
W, H, T_PCB = 35.4, 33.5, 1.2
HOLE_D = 3.0                      # drawn ring 3.0 ID / 3.9 OD -> MEASURE your board
HOLE_IN_X = 2.1                   # hole centre from left/right edge
HOLE_TOP, HOLE_BOT = 3.1, 2.05    # hole centre from top / bottom edge
NOTCH_W, NOTCH_D = 14.3, 4.0      # FPC cut-out in the bottom edge, centred

# ---- header (1x4, 2.54) ----
PITCH, PIN1_X, PIN_Y = 2.54, 13.94, 1.30   # pin 1 (VDD) centre from left edge, row from top edge
PIN_SQ, PLASTIC_H, PIN_BACK, PIN_FRONT = 0.64, 2.5, 6.0, 1.8   # pins point backward (plastic on the back)

# ---- glass ----
GLASS_W, GLASS_H, GLASS_T = 34.5, 23.0, 1.5
GLASS_TOP = 6.3                   # glass top edge from PCB top edge (drawing; glass sits ~0.9 below centre)
VA_W, VA_H, VA_TOP = 31.42, 16.70, 1.0     # viewing area, its top edge from the glass top edge
AA_W, AA_H = 29.42, 14.70                   # active (pixel) area, concentric with VA
INK = 0.05                        # depth of the VA/AA "ink" bodies inside the glass top

# ---- flex cable ----
FPC_W, FPC_T, FPC_BACK_LEN = 12.0, 0.15, 10.0

# ---- back-side SMD keep-out (caps, resistors, regulator) ----
SMD_H, SMD_Y = 0.8, (4.2, 14.0)   # from the top edge
SMD_X = 15.0                      # half width


def box(x0, x1, y0, y1, z0, z1):
    return cq.Workplane("XY").box(x1 - x0, y1 - y0, z1 - z0, centered=False).translate((x0, y0, z0))


def build(total_t):
    gap = round(total_t - T_PCB - GLASS_T, 3)   # adhesive foam between PCB and glass
    assert gap >= 0, total_t
    top, bot, left = H / 2, -H / 2, -W / 2

    # PCB with 4 holes and the FPC notch
    pcb = box(left, W / 2, bot, top, 0, T_PCB)
    holes = [(left + HOLE_IN_X, top - HOLE_TOP), (-left - HOLE_IN_X, top - HOLE_TOP),
             (left + HOLE_IN_X, bot + HOLE_BOT), (-left - HOLE_IN_X, bot + HOLE_BOT)]
    pcb = pcb.cut(cq.Workplane("XY").pushPoints(holes).circle(HOLE_D / 2).extrude(T_PCB))
    pcb = pcb.cut(box(-NOTCH_W / 2, NOTCH_W / 2, bot - 0.1, bot + NOTCH_D, -0.1, T_PCB + 0.1))
    pins = [(left + PIN1_X + i * PITCH, top - PIN_Y) for i in range(4)]
    pcb = pcb.cut(cq.Workplane("XY").pushPoints(pins).circle(0.5).extrude(T_PCB))

    # glass with the viewing/active area as thin bodies set into its top face
    z_g0 = T_PCB + gap
    z_g1 = z_g0 + GLASS_T
    g_top = top - GLASS_TOP
    g_bot = g_top - GLASS_H
    va_cy = g_top - VA_TOP - VA_H / 2
    glass = box(-GLASS_W / 2, GLASS_W / 2, g_bot, g_top, z_g0, z_g1)
    glass = glass.cut(box(-VA_W / 2, VA_W / 2, va_cy - VA_H / 2, va_cy + VA_H / 2, z_g1 - INK, z_g1))
    aa = box(-AA_W / 2, AA_W / 2, va_cy - AA_H / 2, va_cy + AA_H / 2, z_g1 - INK, z_g1)
    va = box(-VA_W / 2, VA_W / 2, va_cy - VA_H / 2, va_cy + VA_H / 2, z_g1 - INK, z_g1).cut(aa)

    # flex: down from the glass bottom edge, 180 deg bend inside the notch, up the back face
    r_out = (T_PCB + 2 * FPC_T) / 2
    y_bend = bot + r_out + 0.05
    fpc_front = box(-FPC_W / 2, FPC_W / 2, y_bend, g_bot, T_PCB, T_PCB + FPC_T)
    bend = (cq.Workplane("YZ").center(y_bend, T_PCB / 2)
            .circle(r_out).circle(r_out - FPC_T).extrude(FPC_W).translate((-FPC_W / 2, 0, 0))
            .cut(box(-FPC_W, FPC_W, y_bend, y_bend + 5, -5, 5)))
    fpc_back = box(-FPC_W / 2, FPC_W / 2, y_bend, bot + FPC_BACK_LEN, -FPC_T, 0)
    fpc = fpc_front.union(bend).union(fpc_back)

    # header: plastic on the back, long pins backward, short tails through the front
    plastic = box(left + PIN1_X - PITCH / 2, left + PIN1_X + 3.5 * PITCH, top - PIN_Y - 1.27, top - PIN_Y + 1.27,
                  -PLASTIC_H, 0)
    hdr = plastic
    for (x, y) in pins:
        hdr = hdr.union(box(x - PIN_SQ / 2, x + PIN_SQ / 2, y - PIN_SQ / 2, y + PIN_SQ / 2,
                            -PLASTIC_H - PIN_BACK, T_PCB + PIN_FRONT))

    smd = box(-SMD_X, SMD_X, top - SMD_Y[1], top - SMD_Y[0], -SMD_H, 0)

    asm = cq.Assembly(name=f"OLED_1p3_SH1106_{str(total_t).replace('.', 'p')}mm")
    asm.add(pcb, name="pcb", color=cq.Color(0.05, 0.25, 0.65))
    asm.add(glass, name="glass", color=cq.Color(0.12, 0.12, 0.14))
    asm.add(va, name="viewing_area_border", color=cq.Color(0.02, 0.02, 0.02))
    asm.add(aa, name="active_area_128x64", color=cq.Color(0.0, 0.0, 0.0))
    if gap > 0:
        asm.add(box(-GLASS_W / 2 + 1, GLASS_W / 2 - 1, g_bot + 1, g_top - 1, T_PCB, z_g0),
                name="adhesive_foam", color=cq.Color(0.95, 0.95, 0.95))
    asm.add(fpc, name="fpc", color=cq.Color(0.85, 0.5, 0.1))
    asm.add(hdr, name="header_1x4_optional", color=cq.Color(0.1, 0.1, 0.1))
    asm.add(smd, name="keepout_back_smd", color=cq.Color(0.6, 0.6, 0.6))
    return asm, dict(gap=gap, glass_z=(z_g0, z_g1), glass_y=(g_bot, g_top), va_cy=va_cy,
                     holes=holes, pins=pins)


if __name__ == "__main__":
    for t in (3.3, 2.7):
        asm, info = build(t)
        tag = str(t).replace(".", "p")
        step = OUT / f"oled_13_sh1106_{tag}mm.step"
        asm.save(str(step))
        print(step.name, info)
        if t == 3.3:
            cq.exporters.export(asm.toCompound(), str(OUT / f"oled_13_sh1106_{tag}mm.stl"))
