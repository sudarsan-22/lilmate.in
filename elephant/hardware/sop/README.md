# Elephant - soldering steps (images)

Follow the images in order. Each one shows the real board shapes, numbered solder points, wire colours and lengths, a close-up of the joint, and the checks.

1. `step1_prepare.png` - tools, how to make one joint, the 12 wires to cut and pre-tin
2. `step2_battery_to_charger.png` - battery leads to TP4056 B+ / B-
3. `step3_switch_and_power.png` - TP4056 OUT through the slide switch to the ESP32, power test
4. `step4_display.png` - OLED (SDA GPIO8, SCL GPIO9, VCC/GND via splices)
5. `step5_touch_pad.png` - TTP223 (I/O GPIO2, VCC/GND via splices)
6. `step6_finish_and_check.png` - checks, insulation, order of fitting into the Elephant

Board pad layouts are typical: always match the printed labels on YOUR TP4056, OLED, switch and TTP223. GPIO numbers are the ones in `../pinout.md` (confirm against the firmware).
Regenerate: `python3 .claude/skills/solder-sop/scripts/make_steps_elephant.py`. The overview sheet is `../soldering_sop.png`.
