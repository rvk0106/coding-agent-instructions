#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-}"
MARKER_START="# >>> agent-instructions-express"
MARKER_END="# <<< agent-instructions-express"

if [[ -z "$TARGET_DIR" ]]; then
  echo "Usage: ./install.sh /path/to/express/project"
  exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Target directory does not exist: $TARGET_DIR"
  exit 1
fi

copy_if_missing() {
  local src="$1"
  local dest="$2"

  if [[ -e "$dest" ]]; then
    echo "Skip existing: $dest"
    return 0
  fi

  mkdir -p "$(dirname "$dest")"
  cp -p "$src" "$dest"
  echo "Copied: $dest"
}

copy_agent_dir() {
  local src_root="$SOURCE_DIR/agent"
  local dest_root="$TARGET_DIR/agent"

  mkdir -p "$dest_root"

  while IFS= read -r -d '' file; do
    local rel="${file#$src_root/}"
    copy_if_missing "$file" "$dest_root/$rel"
  done < <(find "$src_root" -type f -print0)
}

append_block_if_missing() {
  local file_path="$1"
  local block_content="$2"

  mkdir -p "$(dirname "$file_path")"
  if [[ -f "$file_path" ]] && grep -q "$MARKER_START" "$file_path"; then
    echo "Markers already present: $file_path"
    return 0
  fi

  {
    echo "$MARKER_START"
    echo "$block_content"
    echo "$MARKER_END"
  } >> "$file_path"

  echo "Appended markers to: $file_path"
}

copy_agent_dir

mkdir -p "$TARGET_DIR/docs"
echo "Created docs/ directory for plans"

COPILOT_BLOCK="Follow agent/master-instructions.md as the single source of truth for Express.js development. Plan first, execute one phase at a time, verify, then stop for review."
CURSOR_BLOCK="Follow agent/master-instructions.md. Planning and execution are separate; no phase auto-continue."
CLAUDE_BLOCK="Use agent/master-instructions.md as your system prompt or initial context for Express.js development."

append_block_if_missing "$TARGET_DIR/.github/copilot-instructions.md" "$COPILOT_BLOCK"
append_block_if_missing "$TARGET_DIR/.cursorrules" "$CURSOR_BLOCK"
append_block_if_missing "$TARGET_DIR/CLAUDE.md" "$CLAUDE_BLOCK"

cat <<EOF

Installation complete.

Directory structure:
- agent/ - instruction files
- docs/ - plans will be saved here (docs/TICKET-ID-plan.md)

Next steps:
1) Set up ticketing system connection:
   - Linear: export LINEAR_API_TOKEN="your_token"
   - Or configure MCP server
2) Plan: "plan architecture for TICKET-ID"
   - Saves to: docs/TICKET-ID-plan.md
3) Execute: "execute plan 1 for TICKET-ID"
   - Reads from: docs/TICKET-ID-plan.md
4) Verify: npm test && npm run lint
5) Stop: wait for human review before continuing to next phase

EOF
