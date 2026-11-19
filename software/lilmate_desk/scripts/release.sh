#!/usr/bin/env bash
# Build a lil.mate release: buddy firmware + Linux app + the lilmate.json update manifest.
#   npm run release -- "What's new, in one or two short lines"
#   npm run release -- "notes" --publish      also publishes it: firmware + lilmate.json go to the repo's `updates` branch
#   npm run release -- "notes" --fw-only --publish   buddy firmware only (no app build)
# App installers (>90 MB) go on a GitHub Release named v<version>: upload them there FIRST, then --publish;
# installers that are not uploaded yet are left out of lilmate.json so nobody gets a broken link.
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

if [[ " $* " != *" --fw-only "* ]]; then
  echo "== lil.mate Desk $VER for Linux"
  npx electron-builder --linux AppImage deb >/dev/null
  cp dist/lilmate-desk-"$VER"-*.deb dist/lilmate-desk-"$VER"-*.AppImage "$OUT/"
  # The Windows installer is built on Windows (npm run dist:win); put it in dist/ before running this to include it
  cp dist/lilmate-desk-"$VER"-*.exe "$OUT/" 2>/dev/null || echo "   no Windows .exe in dist/: Windows users will not see this update"
fi

node scripts/make-manifest.js "$OUT" "$NOTES"
ls -la "$OUT"

if [[ " $* " == *" --publish "* ]]; then
  # keep only installers that are really downloadable from the GitHub Release
  node -e '
    const fs = require("fs"), f = process.argv[1], m = JSON.parse(fs.readFileSync(f));
    (async () => {
      for (const [k, e] of Object.entries(m.app)) {
        const r = await fetch(e.url, { method: "HEAD", redirect: "follow" }).catch(() => ({ ok: false }));
        if (!r.ok) { console.log("   " + e.file + " is not on the v" + m.version + " Release yet: left out"); delete m.app[k]; }
      }
      fs.writeFileSync(f, JSON.stringify(m, null, 2) + "\n");
    })();' "$OUT/lilmate.json"
  ROOT=$(git rev-parse --show-toplevel); URL=$(git -C "$ROOT" remote get-url origin); U=dist/updates-branch
  if [ ! -d "$U/.git" ]; then
    git clone -q --branch updates --single-branch "$URL" "$U" 2>/dev/null || { rm -rf "$U"; mkdir -p "$U"; git -C "$U" init -q -b updates; git -C "$U" remote add origin "$URL"; }
  fi
  git -C "$U" pull -q origin updates 2>/dev/null || true
  rm -f "$U"/lilmate-os-*.bin
  cp "$OUT/lilmate.json" "$OUT"/lilmate-os-*.bin "$U/"
  printf '# lil.mate updates\nRead by the lil.mate Desk app. Made by scripts/release.sh, do not edit by hand.\n' > "$U/README.md"
  git -C "$U" add -A
  git -C "$U" commit -q -m "release: app $VER, firmware $FW_VER" || true
  git -C "$U" push -q origin updates
  echo "== published: customers' apps will see it within a few minutes"
else
  echo "== ready in $OUT. Upload the installers to a Release v$VER on https://github.com/$REPO/releases/new, then run again with --publish"
fi
