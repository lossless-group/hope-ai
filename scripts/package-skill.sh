#!/usr/bin/env bash
# Package the personal-strategic-plan skill as a zip that the Claude apps can
# upload (Customize → Skills → + → Create skill → Upload a skill).
#
#   scripts/package-skill.sh [out-dir]     # default: dist/
#
# Claude looks for <skill-name>/SKILL.md inside the archive, so the zip's top
# level is the skill folder. The templates, references, and scripts the skill
# points at are bundled inside it, at the same relative paths they have from
# the repo root, so the skill reads the same way in both places.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$(mkdir -p "${1:-$ROOT/dist}" && cd "${1:-$ROOT/dist}" && pwd)"
NAME=personal-strategic-plan
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$STAGE/$NAME"
cp "$ROOT/context-v/agent-skills/$NAME/SKILL.md" "$STAGE/$NAME/"
cp -R "$ROOT/templates" "$ROOT/references" "$ROOT/scripts" "$STAGE/$NAME/"
rm -f "$STAGE/$NAME/scripts/package-skill.sh"

rm -f "$OUT/$NAME.zip"
(cd "$STAGE" && zip -qrX "$OUT/$NAME.zip" "$NAME" -x '*.DS_Store')
echo "packaged $OUT/$NAME.zip"
