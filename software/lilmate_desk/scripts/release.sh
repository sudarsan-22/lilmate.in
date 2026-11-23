#!/usr/bin/env bash
# Build a lil.mate release: buddy firmware + Linux app + the lilmate.json update manifest.
#   npm run release -- "What's new, in one or two short lines"
#   npm run release -- "notes" --publish      also publishes it: firmware + lilmate.json go to the repo's `updates` branch
#   npm run release -- "notes" --fw-only --publish   buddy firmware only
# App installers come from the GitHub Release v<version>, which GitHub Actions builds when that tag is pushed.
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
  # Installers are built by GitHub (.github/workflows/desktop-release.yml) when the tag v$VER is pushed:
  #   git tag -a v$VER -m "lil.mate Desk $VER" && git push origin v$VER     (takes ~10 minutes)
  echo "== lil.mate Desk $VER installers from the GitHub Release v$VER"
  ASSETS=$(curl -s "https://api.github.com/repos/$REPO/releases/tags/v$VER" | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>{const r=JSON.parse(s);console.log((r.assets||[]).map(a=>a.browser_download_url).join("\n"))})')
  if [ -z "$ASSETS" ]; then echo "   no Release v$VER yet: push the tag above, wait for the build, then run this again (or use --fw-only)"; exit 1; fi
  for u in $ASSETS; do echo "   $(basename "$u")"; curl -sL -o "$OUT/$(basename "$u")" "$u"; done
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
  # keep the previous firmware too: apps that read the older lilmate.json a moment ago can still download it
  ls -t "$U"/lilmate-os-*.bin 2>/dev/null | tail -n +2 | xargs -r rm -f
  cp "$OUT/lilmate.json" "$OUT"/lilmate-os-*.bin "$U/"
  printf '# lil.mate updates\nRead by the lil.mate Desk app. Made by scripts/release.sh, do not edit by hand.\n' > "$U/README.md"
  git -C "$U" add -A
  git -C "$U" commit -q -m "release: app $VER, firmware $FW_VER" || true
  git -C "$U" push -q origin updates
  echo "== published: customers' apps will see it within a few minutes"
else
  echo "== ready in $OUT. Upload the installers to a Release v$VER on https://github.com/$REPO/releases/new, then run again with --publish"
fi
