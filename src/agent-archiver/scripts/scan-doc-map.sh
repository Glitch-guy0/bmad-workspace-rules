#!/usr/bin/env bash
# scan-doc-map.sh
# Checks every folder has _index.md and files match index entries.
# Usage: ./scan-doc-map.sh [project-root]
# Defaults to current directory if no argument given.

set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"
EXIT_CODE=0

echo "=== Doc Map Scan ==="
echo "Scanning from: $(pwd)"
echo ""

# Directories to check for _index.md
INDEXED_DIRS=("docs" "ideas" "milestones" "planning" "reports")

for dir in "${INDEXED_DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "[SKIP] $dir/ — directory not found"
    continue
  fi

  echo "[CHECK] $dir/"

  if [ ! -f "$dir/_index.md" ]; then
    echo "  [MISSING] $dir/_index.md — no index file"
    EXIT_CODE=1
    continue
  fi

  # List files in directory (excluding _index.md)
  while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    if [ "$filename" = "_index.md" ]; then
      continue
    fi
    # Check if filename appears in _index.md
    if ! grep -q "$filename" "$dir/_index.md" 2>/dev/null; then
      echo "  [UNINDEXED] $dir/$filename — not listed in _index.md"
      EXIT_CODE=1
    fi
  done < <(find "$dir" -maxdepth 1 -type f -name "*.md" -print0)

  # Check index entries point to existing files
  while IFS= read -r line; do
    # Match markdown links: [name](path)
    case "$line" in
      *'['*']('*')'*)
        linked_file="${line#*](}"
        linked_file="${linked_file%)*}"
        if [ ! -f "$dir/$linked_file" ] && [ ! -f "$linked_file" ]; then
          echo "  [BROKEN] $dir/_index.md links to '$linked_file' — file not found"
          EXIT_CODE=1
        fi
        ;;
    esac
  done < "$dir/_index.md"
done

# Check cross-repo doc map in docs/_index.md
if [ -f "docs/_index.md" ]; then
  echo "[CHECK] docs/_index.md (cross-repo doc map)"
  while IFS= read -r line; do
    case "$line" in
      *'['*']('*')'*)
        linked_file="${line#*](}"
        linked_file="${linked_file%)*}"
        if [ ! -f "$linked_file" ]; then
          echo "  [BROKEN] docs/_index.md links to '$linked_file' — file not found"
          EXIT_CODE=1
        fi
        ;;
    esac
  done < "docs/_index.md"
fi

echo ""
if [ "$EXIT_CODE" -eq 0 ]; then
  echo "Doc map is healthy."
else
  echo "Issues found. Review and fix before next session."
fi

exit "$EXIT_CODE"
