#!/bin/sh
set -eu

PKG_LIST="/tools/scripts/package-db.txt"

if ! command -v tlmgr >/dev/null 2>&1; then
    echo "Error: tlmgr not found in PATH"
    exit 1
fi

if [ ! -f "$PKG_LIST" ]; then
    echo "Error: package list '$PKG_LIST' not found"
    exit 1
fi

echo "== Installing / updating TeX Live packages =="

while IFS= read -r pkg || [ -n "$pkg" ]; do
    # Strip comments and whitespace
    pkg="$(printf '%s' "$pkg" | sed 's/#.*//; s/^[[:space:]]*//; s/[[:space:]]*$//')"

    [ -z "$pkg" ] && continue

    echo " -> $pkg"
    tlmgr install "$pkg"
done < "$PKG_LIST"


echo "== TeX Live package update complete =="