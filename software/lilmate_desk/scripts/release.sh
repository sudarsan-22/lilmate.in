#!/usr/bin/env bash
# Build a lil.mate release: buddy firmware + Linux app + the lilmate.json update manifest.
#   npm run release -- "What's new, in one or two short lines"
#   npm run release -- "notes" --publish      also uploads it as a GitHub release (needs: gh auth login)
# Bump "version" in package.json first (and FW_VERSION in ../lilmate_os/config.h if the firmware changed).
# Customers' apps read the *latest* release, so every release needs a new app version.
set -euo pipefail
cd "$(dirname "$0")/.."
NOTES="${1:-Bug fixes and improvements}"
VER=$(node -p "require('./package.json').version")
REPO=$(node -p "require('./package.json').lilmate.updateRepo")
FW=../lilmate_os
FQBN="esp32:esp32:esp32c3:CDCOnBoot=cdc,PartitionScheme=min_spiffs,FlashMode=dio"
FW_VER=$(sed -n 's/^#define FW_VERSION *"\(.*\)".*/\1/p' "$FW/config.h")
OUT=dist/release
rm -rf "$OUT"; mkdir -p "$OUT"

echo "== lil.mate firmware $FW_VER"
arduino-cli compile -b "$FQBN" --output-dir "$FW/build" "$FW" | tail -2
cp "$FW/build/lilmate_os.ino.bin" "$OUT/lilmate-os-$FW_VER.bin"

echo "== lil.mate Desk $VER for Linux"
npx electron-builder --linux AppImage deb >/dev/null
cp dist/lilmate-desk-"$VER"-*.deb dist/lilmate-desk-"$VER"-*.AppImage "$OUT/"
# The Windows installer is built on Windows (npm run dist:win); put it in dist/ before running this to include it
cp dist/lilmate-desk-"$VER"-*.exe "$OUT/" 2>/dev/null || echo "   no Windows .exe in dist/: Windows users will not see this update"

node scripts/make-manifest.js "$OUT" "$NOTES"
ls -la "$OUT"

if [[ " $* " == *" --publish "* ]]; then
  gh release create "v$VER" "$OUT"/* --repo "$REPO" --title "lil.mate $VER" --notes "$NOTES"
  echo "== published: https://github.com/$REPO/releases/tag/v$VER"
else
  echo "== ready in $OUT. Upload every file there to a new release on https://github.com/$REPO/releases/new (tag v$VER)"
fi
