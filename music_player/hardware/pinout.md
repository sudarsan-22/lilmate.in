# Music Player (Retro PC v2) - pinout and power

Provisional map from `docs/components_L_retro_pc.md` (ESP32-C3, 13 usable GPIO: 0-10, 20, 21):

| Function | GPIO |
|---|---|
| OLED SDA / SCL | 8 / 9 |
| YX6300 RX / TX (UART1) | 21 / 20 |
| Keys prev / play / next / face | 0 / 1 / 3 / 4 (or one ADC pin with a resistor ladder) |
| EC11 A / B | 5 / 6 |
| spare | 2, 7, 10 (TTP223 not used) |

Power: Li-Po 503450 -> TP4056 -> ESP32; audio out is the YX6300 3.5 mm jack (no speaker, wired only).

## TP4056 USB-C board (from the user photo, 2026-11-16)
Blue Type-C board, USB-C at the top. Pads along the bottom edge, left to right: **OUT-, B-, B+, OUT+**. Battery goes to the MIDDLE pair (B-, B+); the OUTER pair (OUT-, OUT+) is the output to the switch and ESP32. Two mounting holes at the top corners, two LEDs on the right side. Photo: `datasheets/tp4056_usbc_board_photo.jpeg` (Elephant folder).
