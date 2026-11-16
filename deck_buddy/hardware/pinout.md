# Deck Buddy - pinout and power

| Function | GPIO | Source |
|---|---|---|
| OLED SDA / SCL (I2C) | 8 / 9 | assumed, same stack as Elephant |
| Slide switch | power path, no GPIO | back lid |
| Battery | not modelled in the CAD | CONFIRM |

## TP4056 USB-C board (from the user photo, 2026-11-16)
Blue Type-C board, USB-C at the top. Pads along the bottom edge, left to right: **OUT-, B-, B+, OUT+**. Battery goes to the MIDDLE pair (B-, B+); the OUTER pair (OUT-, OUT+) is the output to the switch and ESP32. Two mounting holes at the top corners, two LEDs on the right side. Photo: `datasheets/tp4056_usbc_board_photo.jpeg` (Elephant folder).
