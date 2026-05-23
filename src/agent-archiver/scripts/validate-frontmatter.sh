#!/usr/bin/env bash
# validate-frontmatter.sh
# Checks all .md files have required YAML frontmatter fields.
# Usage: ./validate-frontmatter.sh [output-folder]
# Defaults to current directory if no argument given.
# All scanned paths (docs/, ideas/, milestones/, etc.) resolve from output-folder.

set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"
EXIT_CODE=0

# Directories to scan
SCAN_DIRS=("docs" "ideas" "milestones" "planning" "reports")

# Required frontmatter fields (all that apply)
# Files in docs/ need: type, status, owner, created
# Ideas need: type, status, slug, created, owner
# Milestones need: type, status, slug, created, owner
# Reports need: type, status, slug, date
# Planning docs need: type, status, slug, date

echo "=== Frontmatter Validation ==="
echo "Scanning from: $(pwd)"
echo ""

for dir in "${SCAN_DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "[SKIP] $dir/ — directory not found"
    continue
  fi

  echo "[CHECK] $dir/"

  while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    if [ "$filename" = "_index.md" ]; then
      # _index.md needs: type, path
      if ! head -20 "$file" | grep -q "^type:"; then
        echo "  [MISSING] $file — missing 'type' in frontmatter"
        EXIT_CODE=1
      fi
      continue
    fi

    # Read first 20 lines (frontmatter should be within that)
    content=$(head -20 "$file")

    # Check for YAML frontmatter delimiters
    if ! echo "$content" | head -1 | grep -q "^---"; then
      echo "  [MISSING] $file — no YAML frontmatter (missing opening ---)"
      EXIT_CODE=1
      continue
    fi

    # Check required fields
    fields=("type" "status" "slug" "created")
    for field in "${fields[@]}"; do
      if ! echo "$content" | grep -q "^${field}:"; then
        echo "  [MISSING] $file — missing '$field' in frontmatter"
        EXIT_CODE=1
      fi
    done
  done < <(find "$dir" -maxdepth 2 -type f -name "*.md" -print0)
done

echo ""
if [ "$EXIT_CODE" -eq 0 ]; then
  echo "All files have valid frontmatter."
else
  echo "Issues found. Review and fix before next session."
fi

exit "$EXIT_CODE"
