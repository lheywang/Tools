#!/bin/sh
set -eu

TEMPLATE_DB="/tools/scripts/template-db.txt"
DEST="${TEMPLATE_DIR:-/tools/templates}"

if ! command -v git >/dev/null 2>&1; then
    echo "Error: git not found"
    exit 1
fi

if [ ! -f "$TEMPLATE_DB" ]; then
    echo "Error: template DB '$TEMPLATE_DB' not found"
    exit 1
fi

mkdir -p "$DEST"

echo "== Updating templates in $DEST =="

while IFS= read -r repo || [ -n "$repo" ]; do
    # Strip comments and whitespace
    repo="$(printf '%s' "$repo" | sed 's/#.*//; s/^[[:space:]]*//; s/[[:space:]]*$//')"

    [ -z "$repo" ] && continue

    name="$(basename "$repo" .git)"
    target="$DEST/$name"

    if [ -d "$target/.git" ]; then
        echo " -> Updating $name"
        git -C "$target" pull --ff-only
    else
        echo " -> Cloning $name"
        git clone --depth=1 "$repo" "$target"
    fi
done < "$TEMPLATE_DB"

echo "== Template update complete =="