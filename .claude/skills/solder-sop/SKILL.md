---
name: solder-sop
description: Generate or update the soldering SOP (step-by-step wiring and soldering sheet with wiring diagram, per-step highlighted wires, wire cut list and safety notes) for a lilmate product. Use when the user asks how to solder or wire a lilmate product, wants the SOP, wiring diagram or wire lengths, changes a GPIO pin or a component (OLED, ESP32, TP4056, battery, switch, touch, keys, encoder, buzzer, YX6300), or after hardware/pinout.md or the component positions change, for deck_buddy, desk_mini, elephant, pengu_chubby, music_player or office_buddy.
---

# Soldering SOP

Each product has `<project>/hardware/soldering_sop.png` (+ `.md` with the same steps and the cut list). The sheet has: the full wiring diagram, one panel per step with that step's wires highlighted, a wire cut list (colour, length, step) and safety notes.

## Illustrated step images (Elephant)
`elephant/hardware/sop/step1_...step6_*.png`: one image per step with real board shapes, numbered solder points and a joint close-up. Regenerate with `python3 .claude/skills/solder-sop/scripts/make_steps_elephant.py`. Other products still have the single overview sheet only.

## Regenerate
```bash
python3 .claude/skills/solder-sop/scripts/make_sop.py [project ...]     # default: all six
```
The script reads component positions from `<project>/hardware/components.md` (wire length = CAD distance x 1.2 + 15 mm slack, rounded up to 5 mm; parts without a CAD position get a default and "(set on assembly)").

## Where the wiring comes from
- Power chain (all products): battery > TP4056 B+/B-, TP4056 OUT+ > switch COM, switch ON > ESP32 5V pin, TP4056 OUT- > ESP32 GND.
- Display on the ESP32-C3 I2C defaults: SDA GPIO8, SCL GPIO9, VCC 3V3.
- Other GPIOs: Elephant/Pengu touch on GPIO2 (from `minimo_bear.ino`); Music Player map from `docs/components_L_retro_pc.md`; Office Buddy and Desk Mini are proposed. Each sheet carries a yellow CHECK banner saying which numbers are unconfirmed.
- To change a pin: edit `product()` in `make_sop.py` (and `hardware/pinout.md`), then regenerate. Never leave the SOP and `pinout.md` disagreeing.

## Rules for the sheet
- Solder with the battery disconnected until the power test (step 3), and verify polarity with a multimeter.
- Keep GND/3V3 as splices, one wire each to the ESP32 pad (the module has few power pads).
- Mark anything not confirmed from the sources instead of presenting it as fact (Desk Mini controller, Office Buddy GPIOs, Deck Buddy battery).
