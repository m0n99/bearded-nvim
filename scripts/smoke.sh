#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v nvim >/dev/null 2>&1; then
  echo "nvim not found in PATH" >&2
  exit 1
fi

# Basic sanity: ensure a flavor loads without errors.
nvim --headless -u NONE --cmd 'set rtp+=. shadafile=NONE noswapfile' -c 'lua require("bearded").load("arc")' -c 'qa'
