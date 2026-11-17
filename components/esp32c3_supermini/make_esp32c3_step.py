"""ESP32-C3 Super Mini -> STEP reference model.

Run:  <python with cadquery> make_esp32c3_step.py
Out:  esp32c3_supermini.step / .stl

Source: ESP32-C3 SuperMini size drawing (mischianti.org, ESP32-C3-SuperMini-Size.jpg):
  dimensioned 18.00 x 22.50 board, 15.24 between the pin rows.
  Measured from that image (24.55 px/mm, +-0.15 mm): first pin 1.63 from the USB end, pitch 2.54,
  USB-C 8.94 wide sticking out about 1.4 past the board edge, BOOT/RST buttons, QFN32 chip,
  crystal, regulator and chip antenna positions.
  Board thickness 1.0 and the USB-C height come from the user's measurement (bom.csv, 2026-11-14:
  18 x 22 x 1, USB-C zone 9 x 7.3 x 3.3).

Pins (USB end at the top, component side facing you):
  left  top->bottom: 5, 6, 7, 8, 9, 10, 20, 21
  right top->bottom: 5V, GND, 3V3, 4, 3, 2, 1, 0

Coordinates: origin = centre of the PCB outline, +Y = USB-C end, +Z = component side,
Z = 0 = PCB bottom face.
"""
import cadquery as cq
from pathlib import Path

OUT = Path(__file__).resolve().parent

W, L, T = 18.0, 22.5, 1.0
ROW_X = 15.24 / 2                 # pin row offset from the centre
PIN1_FROM_TOP, PITCH, N = 1.63, 2.54, 8
HOLE_D = 1.0                      # through holes for headers
CAST_D = 1.0                      # castellated half holes on the long edges

USB = dict(w=8.94, l=7.35, h=3.26, overhang=1.4)
BTN = dict(w=4.4, l=3.0, h=1.5, cap_d=1.6, cap_h=0.5, y_from_top=8.8, x_from_left=(6.4, 11.75))
CHIP = dict(s=5.0, h=0.9, x_from_left=9.9, y_from_top=14.5)   # QFN32 5x5, rotated 45 deg
XTAL = dict(w=3.2, l=2.5, h=0.8, x_from_left=4.55, y_from_top=17.5)
REG = dict(w=2.9, l=1.6, h=1.2, x_from_left=3.7, y_from_top=12.7)      # SOT23-5 LDO
ANT = dict(w=6.0, l=2.0, h=1.0, x_from_left=8.85, y_from_top=21.35)    # chip antenna

HDR = dict(plastic_h=2.5, pin_sq=0.64, pin_below=6.0, pin_above=1.0)   # optional 1x8 headers, pins down


def box(cx, cy, w, l, z0, h):
    return cq.Workplane("XY").box(w, l, h, centered=(True, True, False)).translate((cx, cy, z0))


def xy(x_from_left, y_from_top):
    return (-W / 2 + x_from_left, L / 2 - y_from_top)


def build():
    top = L / 2
    pins_y = [top - PIN1_FROM_TOP - i * PITCH for i in range(N)]
    pin_pts = [(sx * ROW_X, y) for sx in (-1, 1) for y in pins_y]

    pcb = box(0, 0, W, L, 0, T)
    pcb = pcb.cut(cq.Workplane("XY").pushPoints(pin_pts).circle(HOLE_D / 2).extrude(T))
    cast = [(sx * W / 2, y) for sx in (-1, 1) for y in pins_y]
    pcb = pcb.cut(cq.Workplane("XY").pushPoints(cast).circle(CAST_D / 2).extrude(T))

    usb_cy = top + USB["overhang"] - USB["l"] / 2
    usb = box(0, usb_cy, USB["w"], USB["l"], T, USB["h"]).edges("|Y").fillet(1.2)
    usb = usb.cut(box(0, usb_cy + 0.5, USB["w"] - 0.8, USB["l"], T + 0.4, USB["h"] - 0.8)
                  .edges("|Y").fillet(0.8))            # open socket mouth

    btns = None
    for xl in BTN["x_from_left"]:
        x, y = xy(xl, BTN["y_from_top"])
        b = box(x, y, BTN["w"], BTN["l"], T, BTN["h"]).union(
            cq.Workplane("XY").circle(BTN["cap_d"] / 2).extrude(BTN["cap_h"]).translate((x, y, T + BTN["h"])))
        btns = b if btns is None else btns.union(b)

    cx, cy = xy(CHIP["x_from_left"], CHIP["y_from_top"])
    chip = box(0, 0, CHIP["s"], CHIP["s"], T, CHIP["h"]).rotate((0, 0, 0), (0, 0, 1), 45).translate((cx, cy, 0))
    smd = chip
    for p in (XTAL, REG):
        smd = smd.union(box(*xy(p["x_from_left"], p["y_from_top"]), p["w"], p["l"], T, p["h"]))
    ant = box(*xy(ANT["x_from_left"], ANT["y_from_top"]), ANT["w"], ANT["l"], T, ANT["h"])

    hdr = None
    for sx in (-1, 1):
        h = box(sx * ROW_X, sum(pins_y) / N, 2.54, N * PITCH, -HDR["plastic_h"], HDR["plastic_h"])
        for y in pins_y:
            h = h.union(box(sx * ROW_X, y, HDR["pin_sq"], HDR["pin_sq"],
                            -HDR["plastic_h"] - HDR["pin_below"],
                            HDR["plastic_h"] + HDR["pin_below"] + T + HDR["pin_above"]))
        hdr = h if hdr is None else hdr.union(h)

    asm = cq.Assembly(name="ESP32-C3_SuperMini")
    asm.add(pcb, name="pcb", color=cq.Color(0.08, 0.08, 0.08))
    asm.add(usb, name="usb_c", color=cq.Color(0.78, 0.78, 0.8))
    asm.add(btns, name="buttons_boot_rst", color=cq.Color(0.9, 0.9, 0.9))
    asm.add(smd, name="chip_crystal_regulator", color=cq.Color(0.2, 0.2, 0.22))
    asm.add(ant, name="antenna", color=cq.Color(0.9, 0.55, 0.6))
    asm.add(hdr, name="headers_2x8_optional", color=cq.Color(0.1, 0.1, 0.1))
    return asm, dict(pins_y=[round(v, 2) for v in pins_y], usb_y=(round(usb_cy - USB["l"] / 2, 2),
                                                                round(usb_cy + USB["l"] / 2, 2)))


if __name__ == "__main__":
    asm, info = build()
    asm.export(str(OUT / "esp32c3_supermini.step"))
    cq.exporters.export(asm.toCompound(), str(OUT / "esp32c3_supermini.stl"))
    print(info)
