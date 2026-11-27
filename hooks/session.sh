#!/bin/sh
# Prints the one-tap-open rule plus this machine's editor state into the session context.
root="${CLAUDE_PLUGIN_ROOT:-$(dirname "$0")/..}"
cfg="$HOME/.one-tap-open.json"

cat "$root/rule.md"

pick=""
[ -f "$cfg" ] && pick=$(sed -n 's/.*"editor"[[:space:]]*:[[:space:]]*"\([a-z]*\)".*/\1/p' "$cfg" | head -n 1)

found=""
for e in code cursor windsurf zed subl idea; do
  command -v "$e" >/dev/null 2>&1 && found="$found $e"
done
found="${found# }"

printf '\n## This machine\nSettings file: %s\n' "$cfg"
if [ -n "$pick" ] && command -v "$pick" >/dev/null 2>&1; then
  echo "Chosen editor: $pick"
elif [ -z "$found" ]; then
  echo "No editor found: open code files with the OS opener like any other file."
elif [ "${found#* }" = "$found" ]; then
  echo "Chosen editor: $found (the only one installed)"
else
  echo "Several editors found: $found. None saved yet: ask once (see rule)."
fi
