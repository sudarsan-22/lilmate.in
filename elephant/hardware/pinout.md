# Elephant (Ellie v3) - pinout and power

| Function | GPIO | Source |
|---|---|---|
| OLED SDA / SCL (I2C) | 8 / 9 | ESP32-C3 default I2C; same as `minimo_bear.ino` (confirm) |
| TTP223 touch | 2 | `minimo_bear.ino` (confirm for this product) |
| Slide switch | power path (battery to charger/ESP), no GPIO | design |
| Battery / charging | Li-Po 502030 -> TP4056 -> ESP32 5V/3V3 | design |
