#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${1:-screenshots}"
PREFIX="${2:-android}"
SERIAL="${3:-}"

if ! command -v adb >/dev/null 2>&1; then
  echo "adb not found. Install Android Platform Tools and ensure adb is in PATH." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILE="$OUT_DIR/${PREFIX}_${TIMESTAMP}.png"

if [[ -n "$SERIAL" ]]; then
  adb -s "$SERIAL" exec-out screencap -p > "$FILE"
else
  adb exec-out screencap -p > "$FILE"
fi

echo "Saved screenshot: $FILE"
