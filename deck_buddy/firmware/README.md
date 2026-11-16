# Deck Buddy - firmware

Status: no sketch yet for this product.

- Target board: ESP32-C3 Super Mini (Arduino-ESP32 core, board "ESP32C3 Dev Module", USB CDC on boot: enabled).
- Display: U8g2 library (the Minimo sketches use `U8G2_SSD1306_128X64_NONAME_F_HW_I2C`; the 1.3" modules here are SH1106, use the `SH1106` constructor).
- Pin map: see `../hardware/pinout.md`.
- Layout when a sketch exists: `firmware/deck_buddy/deck_buddy.ino` (the sketch folder name must match the .ino name), libraries listed in this README.
- Compile / flash with arduino-cli:
  `arduino-cli compile --fqbn esp32:esp32:esp32c3 firmware/deck_buddy`
  `arduino-cli upload  --fqbn esp32:esp32:esp32c3 -p /dev/ttyACM0 firmware/deck_buddy`
- Existing sketches outside this folder that could be the base (not copied): `../../minimo/*/*.ino` (bear, girly, keychain, eye animation, I2C and pin tests) and `../../music_player/music_player.ino` (older ESP32 Bluetooth music controller).
