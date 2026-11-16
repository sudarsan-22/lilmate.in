# Office Buddy v1 - pinout and power

Based on the Music Player map; the YX6300 is not used and a buzzer is added.

| Function | GPIO |
|---|---|
| OLED SDA / SCL | 8 / 9 (assumed) |
| 4 keys | TBD (Music Player used 0 / 1 / 3 / 4) |
| EC11 A / B | TBD (Music Player used 5 / 6) |
| Buzzer | TBD |

Power: Li-Po 503450 -> TP4056 (4 mounting pins) -> ESP32.
