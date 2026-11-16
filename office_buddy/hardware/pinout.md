# Office Buddy v1 - pinout and power

Based on the Music Player map; the YX6300 is not used and a buzzer is added.

| Function | GPIO |
|---|---|
| OLED SDA / SCL | 8 / 9 (assumed) |
| 4 keys | TBD (Music Player used 0 / 1 / 3 / 4) |
| EC11 A / B | TBD (Music Player used 5 / 6) |
| Buzzer | TBD |

Power: Li-Po 503450 -> TP4056 (4 mounting pins) -> ESP32.

## TP4056 USB-C board (from the user photo, 2026-11-16)
Blue Type-C board, USB-C at the top. Pads along the bottom edge, left to right: **OUT-, B-, B+, OUT+**. Battery goes to the MIDDLE pair (B-, B+); the OUTER pair (OUT-, OUT+) is the output to the switch and ESP32. Two mounting holes at the top corners, two LEDs on the right side. Photo: `datasheets/tp4056_usbc_board_photo.jpeg` (Elephant folder).
