#!/usr/bin/env bash
# Render the hope-ai share-image set from scripts/og-template.html with
# headless Chrome (Technique B in the generate-consistent-og-images skill:
# rasterize the hero instead of illustrating it).
#
#   scripts/render-og.sh            # all formats
#   scripts/render-og.sh BannerTall # one format
#
# Run from splash/. Writes public/ogimage__Hope-Ai--<Format>.jpg. An existing
# file is moved to .ogimage-archive/ with today's date before it's replaced.
# Needs Google Chrome (macOS path below, or set CHROME) and ImageMagick.
set -euo pipefail
ONLY="${1:-}"
cd "$(dirname "$0")/.."

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
TEMPLATE="$PWD/scripts/og-template.html"
ARCHIVE=.ogimage-archive
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# format  width  height   (aspect)
FORMATS=(
  "Banner 1200 630"          # 1.91:1 OG / X / Slack / LinkedIn
  "BannerTall 1200 1600"     # 3:4  WhatsApp / iMessage (Lossless priority)
  "BannerTallMax 1200 1800"  # 2:3
  "Portrait 1080 1350"       # 4:5  LinkedIn portrait / IG feed
  "PortraitTall 1080 1920"   # 9:16 Stories / Reels
  "Square 1200 1200"         # 1:1  avatars, Discord, square fallbacks
)

render() {
  local name=$1 w=$2 h=$3 out="public/ogimage__Hope-Ai--$1.jpg"
  # Headless Chrome won't size a window below ~500px wide, so these sizes are safe.
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars \
    --user-data-dir="$TMP/profile-$name" --virtual-time-budget=6000 \
    --window-size="$w,$h" --screenshot="$TMP/$name.png" \
    "file://$TEMPLATE?w=$w&h=$h" >/dev/null 2>&1 &
  local pid=$!
  # Chrome sometimes lingers after writing the screenshot; don't wait on it forever.
  for _ in $(seq 1 60); do [ -s "$TMP/$name.png" ] && break; sleep 0.5; done
  sleep 1; kill "$pid" 2>/dev/null || true
  [ -s "$TMP/$name.png" ] || { echo "failed: $name" >&2; return 1; }
  if [ -f "$out" ]; then
    mkdir -p "$ARCHIVE"
    # Date-stamped; a second render the same day gets a time suffix instead of
    # overwriting the first archive.
    local dest="$ARCHIVE/ogimage__Hope-Ai--$name--$(date +%Y-%m-%d).jpg"
    [ -e "$dest" ] && dest="$ARCHIVE/ogimage__Hope-Ai--$name--$(date +%Y-%m-%d-%H%M%S).jpg"
    mv "$out" "$dest"
  fi
  magick "$TMP/$name.png" -strip -quality 88 "$out"
  echo "rendered $out (${w}x${h})"
}

for f in "${FORMATS[@]}"; do
  set -- $f
  if [ -z "$ONLY" ] || [ "$ONLY" = "$1" ]; then render "$@"; fi
done

# Default aliases Banner, per the naming convention.
cp public/ogimage__Hope-Ai--Banner.jpg public/ogimage__Hope-Ai--Default.jpg
echo "aliased Default -> Banner"
