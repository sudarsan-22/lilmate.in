#!/usr/bin/env bash
# Build + flash Lilmate OS to a Beetle ESP32-C3 over USB.
#   ./flash.sh            build and flash (keeps saved Wi-Fi, tasks, habits)
#   ./flash.sh --erase    wipe everything first (factory reset)
#   ./flash.sh --monitor  flash, then open the serial console
#   PORT=/dev/ttyACM1 ./flash.sh
set -euo pipefail
cd "$(dirname "$0")"
FQBN="esp32:esp32:esp32c3:CDCOnBoot=cdc,PartitionScheme=min_spiffs,FlashMode=dio"
PORT="${PORT:-$(ls /dev/ttyACM* /dev/ttyUSB* 2>/dev/null | head -1 || true)}"
if [ -z "$PORT" ]; then
  echo "No board found. Plug the C3 in with a data USB-C cable."
  echo "If it still doesn't show up: hold BOOT, tap RESET, release BOOT, run again."
  exit 1
fi
echo "== build"
arduino-cli compile -b "$FQBN" --output-dir build .
if [[ " $* " == *" --erase "* ]]; then
  echo "== erase $PORT"
  esptool --chip esp32c3 -p "$PORT" erase-flash || esptool.py --chip esp32c3 -p "$PORT" erase_flash
fi
echo "== flash $PORT"
arduino-cli upload -b "$FQBN" -p "$PORT" --input-dir build .
echo "== done. Lilmate is booting."
if [[ " $* " == *" --monitor "* ]]; then
  sleep 2
  arduino-cli monitor -p "$PORT" -c baudrate=115200
else
  echo "Serial console: arduino-cli monitor -p $PORT -c baudrate=115200   (type /help)"
fi
