# Office Desk Buddy – design proposal (v0, 2026-11-15) – NOT BUILT YET, waiting for confirmation

Look: reference/look_reference_retro_pc.png (cream compact-Mac monitor, 15° slanted screen, orange accents,
side vents, floppy-slot strip, 4 keycaps in a recessed tray, orange knob on the right wall).
Sources: reference/tinytosh (Mac-128k body language: window, floppy slot, vents, snap back cover),
reference/oled_096_case (0.96" OLED window size and snap tabs; its stand is a 30° wedge).

## What it does
| Function | How |
|---|---|
| Assigned tasks | ESP32-C3 WiFi pulls a task list (Google Sheet / Todoist / small web page); OLED shows task + count, key marks it done |
| Bluetooth | BLE only (C3 has no classic BT). Works as a BLE media remote for PC/phone and as a phone task-sync link |
| Music + volume | Play/pause, prev, next on keys, volume on the side knob (push = mute) – sent over BLE HID to whatever is playing |
| Games | Snake, Pong, Flappy, Dino on the OLED with the 4 keys + knob |

## Controls (same 4-key row as the reference)
1. ◀ grey – prev / left / scroll up
2. ▶ orange – play-pause / action / mark task done
3. ▶▶ grey – next / right / scroll down
4. ☺ grey – MENU: cycles Tasks → Music → Games → Bluetooth
Knob (orange, right wall, EC11): volume, push = mute; in games it moves the paddle/cursor.

## Form factor (side view, not to scale)
```
        ______________          monitor 58 W x 30 D x 40 H
       /  ┌────────┐  |         15° slanted face (OLED + glass bezel)
      /   │ screen │  |  <- right wall: orange volume knob
     /    └────────┘  |  <- left wall: 4 vent slots
    /_[ floppy slot ●]|         eject pill + LED dimple (decor)
 ┌───────────────────────────┐
 │  [◀]  [▶]  [▶▶]  [☺]      │  base 74 W x 62 D x 18 H, keys flat in a recessed tray
 └───────────────────────────┘  overall about 74 x 62 x 58 mm
```
- Monitor sits on the back half of the base; the front ~28 mm is the key tray.
- Keycaps 13.5 x 13.5, pitch 16, 6x6x5 tact switches, thin divider ribs like the reference.
- Base corner radius 6, monitor corner radius 7, soft 45° top roundings (teardrop, upright-print safe).

## Where the parts go
| Part | Location |
|---|---|
| OLED (see Q1) | behind the slanted glass, monitor front |
| ESP32-C3 Super Mini | monitor, behind the OLED, USB-C reachable for flashing from the back |
| EC11 encoder + knob | monitor right wall |
| Slide switch | back of base |
| TP4056 (USB-C) | base rear, USB-C port out the back |
| Li-Po 503450 (~1000 mAh) | base, flat under the monitor |
| 4 tact switches on key plate | base front |
| Buzzer (optional, Q3) | base, for task alerts and game sound |
Snap-fit, no screws. Wires pass through a hole under the monitor.

## Print plan (same pipeline as the other products)
Upright on the A1 mini, no supports: base tray, key plate, monitor shell (roof down), back cover, 4 keycaps (one orange), knob.
Colours: cream body, grey keys, orange play key + knob + eject pill, black screen glass. One 3MF plate.

## Open questions (need your answer before I model anything)
1. **Screen size**: 0.96" OLED (from the downloads, window about 22x11, monitor shrinks to about 48 W, but text is tiny for tasks) or 1.3" OLED (you already have it, window 31x17, monitor 58 W, recommended).
2. **Music**: BLE remote for PC/phone (recommended, smaller, no extra module) or onboard MP3 (YX6300 + 3.5 mm jack as in music_player; monitor grows).
3. **Buzzer** for task reminders and game sound: yes / no.
4. **Tilt**: keep 15° from the reference (recommended) or 30° like the OLED stand.
5. **Keys**: the context-sensitive layout above, or 4 fixed keys (Tasks / BT / Music / Games).
