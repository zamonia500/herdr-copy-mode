#!/bin/sh
# Shows terminal $1 (screen + history) read-only in nvim; on quit, closes this tab and goes back to tab $2.
hc=$(command -v hc || command -v herdr-core) || { echo "copy-mode: hc (herdr-core) not found"; sleep 3; exit 1; }
f=$(mktemp "${TMPDIR:-/tmp}/herdr-copy.XXXXXX")
"$hc" read "$1" > "$f"
nvim -R -S "$(dirname "$0")/copy-mode.vim" "$f"
rm -f "$f"
# Closing this tab kills this script, so the cleanup runs detached.
nohup sh -c 'herdr-app do terminal.kill --terminal "$0"; herdr-app do tab.select --id "$1"' "$HC_TERMINAL_ID" "$2" >/dev/null 2>&1 &
