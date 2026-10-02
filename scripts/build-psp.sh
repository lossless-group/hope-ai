#!/usr/bin/env bash
# Build a PSP for pasting into the program's shared Google Doc.
# HTML is the paste format: Google Docs honors inline styles and drops <style> blocks.
#
#   scripts/build-psp.sh path/to/My_PSP.md [out-dir]
#
# Writes <stem>_<date>.html and <stem>_<date>.docx next to the source (or to out-dir).
# Needs pandoc and python3.
set -euo pipefail

SRC="${1:?usage: build-psp.sh <plan.md> [out-dir]}"
OUT="${2:-$(dirname "$SRC")}"
STEM="$(basename "$SRC" .md)"
STAMP=$(date +%Y-%m-%d)
HERE="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -t psp-raw).html"

pandoc "$SRC" --from=gfm --to=html5 -o "$TMP"
python3 "$HERE/build-psp.py" "$TMP" "$OUT/${STEM}_${STAMP}.html"
pandoc "$SRC" --from=gfm --to=docx -o "$OUT/${STEM}_${STAMP}.docx"
rm -f "$TMP"
echo "built $OUT/${STEM}_${STAMP}.{html,docx}"
