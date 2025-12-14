#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 not found" >&2
  exit 1
fi

if [ -z "${BEARDED_THEME_PATH:-}" ]; then
  echo "BEARDED_THEME_PATH is not set. Point it to your clone of https://github.com/BeardedBear/bearded-theme" >&2
  exit 1
fi

if [ ! -f "$BEARDED_THEME_PATH/bridge.json" ]; then
  echo "bridge.json not found at $BEARDED_THEME_PATH. Is BEARDED_THEME_PATH pointing to the upstream clone?" >&2
  exit 1
fi

export BEARDED_THEME_PATH

echo "Using BEARDED_THEME_PATH=$BEARDED_THEME_PATH"
python3 scripts/export-palettes.py
python3 scripts/generate-colorfiles.py
echo "Done."
