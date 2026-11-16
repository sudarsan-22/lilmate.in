# Pengu Chubby v3 - pinout and power

| Function | GPIO | Source |
|---|---|---|
| OLED SDA / SCL (I2C) | 8 / 9 | ESP32-C3 default I2C; same as `minimo_bear.ino` (confirm) |
| TTP223 touch | 2 | `minimo_bear.ino` (confirm for this product) |
| Slide switch | power path (battery to charger/ESP), no GPIO | design |
| Battery / charging | Li-Po 502030 -> TP4056 -> ESP32 5V/3V3 | design |

## TP4056 USB-C board (from the user photo, 2026-11-16)
Blue Type-C board, USB-C at the top. Pads along the bottom edge, left to right: **OUT-, B-, B+, OUT+**. Battery goes to the MIDDLE pair (B-, B+); the OUTER pair (OUT-, OUT+) is the output to the switch and ESP32. Two mounting holes at the top corners, two LEDs on the right side. Photo: `datasheets/tp4056_usbc_board_photo.jpeg` (Elephant folder).
