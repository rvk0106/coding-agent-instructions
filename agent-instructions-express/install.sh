#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
TARGET_DIR="${1:-}"
MARKER_START="# >>> agent-instructions-express"
MARKER_END="# <<< agent-instructions-express"

if [[ -z "$TARGET_DIR" ]]; then
  echo "Usage: ./install.sh /path/to/your-project"
  exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Target directory does not exist: $TARGET_DIR"
  exit 1
fi

# Convert TARGET_DIR to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

copy_if_missing() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" ]]; then
    # Compare files and only copy if different
    if cmp -s "$src" "$dest"; then
      echo "  ⊘ Skip (unchanged): $dest"
      return 0
    else
      cp -p "$src" "$dest"
      echo "  ↻ Updated: $dest"
    fi
  else
    cp -p "$src" "$dest"
    echo "  ✓ Copied: $dest"
  fi
}

copy_agent_dir() {
  local src_root="$SOURCE_DIR/agent"
  local dest_root="$TARGET_DIR/agent"

  if [[ ! -d "$src_root" ]]; then
    echo "ERROR: Source agent directory not found: $src_root"
    echo "Make sure you're running the script from the correct location."
    exit 1
  fi

  mkdir -p "$dest_root"

  echo "Copying agent directory structure from $src_root to $dest_root..."

  local file_count=0
  while IFS= read -r -d '' file; do
    local rel="${file#$src_root/}"
    copy_if_missing "$file" "$dest_root/$rel"
    ((file_count++))
  done < <(find "$src_root" -type f -print0)

  if [[ $file_count -eq 0 ]]; then
    echo "WARNING: No files found in $src_root"
  else
    echo "Processed $file_count files from agent directory"
  fi
}

append_block_if_missing() {
  local file_path="$1"
  local block_content="$2"

  mkdir -p "$(dirname "$file_path")"
  if [[ -f "$file_path" ]] && grep -q "$MARKER_START" "$file_path"; then
    echo "  ⊘ Markers already present: $file_path"
    return 0
  fi

  {
    echo "$MARKER_START"
    echo "$block_content"
    echo "$MARKER_END"
  } >> "$file_path"

  echo "  ✓ Appended markers to: $file_path"
}

echo "=== Step 1: Copying agent instruction files ==="
copy_agent_dir

echo ""
echo "=== Step 2: Creating project directories ==="
mkdir -p "$TARGET_DIR/docs"
echo "✓ Created docs/ directory for plans"

mkdir -p "$TARGET_DIR/tickets"
echo "✓ Created tickets/ directory for manual ticket files"

echo ""
echo "=== Step 3: Creating configuration files ==="
# Create agent-config.md template if it doesn't exist
AGENT_CONFIG="$TARGET_DIR/agent-config.md"
if [[ ! -f "$AGENT_CONFIG" ]]; then
  cat > "$AGENT_CONFIG" <<'AGENTCONFIG'
# Agent Configuration

## Ticketing System
System: Manual
API Token Location: N/A
Project/Team ID: N/A

## Connection Method
Preferred: Manual
Fallback: Manual

## Ticket Source
Choose one of the following:

### Option 1: Manual (Default)
- Create ticket files in tickets/ folder
- Format: tickets/TICKET-ID.md
- Agent reads directly from local files

### Option 2: Linear API
- System: Linear
- API Token: Set LINEAR_API_TOKEN environment variable
- Configure below and use: source agent/fetch-ticket.sh

### Option 3: Jira API
- System: Jira
- API Token: Set JIRA_API_TOKEN environment variable
- Jira URL: Set JIRA_URL environment variable
- Configure below and use: source agent/fetch-ticket.sh

### Option 4: GitHub Issues
- System: GitHub
- API Token: Set GITHUB_TOKEN environment variable
- Repository: Set GITHUB_REPO (format: owner/repo)
- Configure below and use: source agent/fetch-ticket.sh

## Active Configuration
# Uncomment and configure the ticketing system you're using:

# LINEAR_API_TOKEN=your_token_here
# LINEAR_TEAM_ID=your_team_id

# JIRA_API_TOKEN=your_token_here
# JIRA_URL=https://your-domain.atlassian.net
# JIRA_PROJECT=PROJ

# GITHUB_TOKEN=your_token_here
# GITHUB_REPO=owner/repo
AGENTCONFIG
  echo "✓ Created agent-config.md template"
else
  echo "⊘ Skip existing: agent-config.md"
fi

echo ""
echo "=== Step 4: Creating utility scripts ==="
# Create ticket fetching utility script (skip if user has customized it)
FETCH_SCRIPT="$TARGET_DIR/agent/fetch-ticket.sh"
mkdir -p "$(dirname "$FETCH_SCRIPT")"
if [[ -f "$FETCH_SCRIPT" ]]; then
  echo "⊘ Skip existing: agent/fetch-ticket.sh (remove it first to regenerate)"
else
cat > "$FETCH_SCRIPT" <<'FETCHSCRIPT'
#!/usr/bin/env bash
# Ticket Fetching Utility
# Sources configuration from agent-config.md and fetches tickets from various systems

# Load configuration from agent-config.md (safe parsing, no eval)
load_config() {
  if [[ -f "agent-config.md" ]]; then
    while IFS='=' read -r key value; do
      # Only export valid uppercase env var names with safe values
      if [[ "$key" =~ ^[A-Z_]+$ ]] && [[ -n "$value" ]]; then
        # Strip surrounding quotes if present
        value="${value%\"}"
        value="${value#\"}"
        value="${value%\'}"
        value="${value#\'}"
        export "$key=$value"
      fi
    done < <(grep -E '^[A-Z_]+=.+' agent-config.md)
  fi
}

# Fetch from Linear
fetch_linear() {
  local issue_id="$1"
  local token="${LINEAR_API_TOKEN:-}"

  if [[ -z "$token" ]]; then
    echo "Error: LINEAR_API_TOKEN not configured in agent-config.md"
    return 1
  fi

  curl -s https://api.linear.app/graphql \
    -H "Content-Type: application/json" \
    -H "Authorization: $token" \
    -d @- <<EOF | jq -r '.data.issue | "# [\(.identifier)] \(.title)\n\n## Description\n\(.description)\n\n## State\n\(.state.name)\n\n## Assignee\n\(.assignee.name // "Unassigned")"'
{
  "query": "query { issue(id: \"$issue_id\") { id identifier title description state { name } assignee { name } createdAt updatedAt } }"
}
EOF
}

# Fetch from Jira
fetch_jira() {
  local issue_key="$1"
  local token="${JIRA_API_TOKEN:-}"
  local url="${JIRA_URL:-}"

  if [[ -z "$token" ]] || [[ -z "$url" ]]; then
    echo "Error: JIRA_API_TOKEN and JIRA_URL must be configured in agent-config.md"
    return 1
  fi

  curl -s "$url/rest/api/3/issue/$issue_key" \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" | \
    jq -r '"# [\(.key)] \(.fields.summary)\n\n## Description\n\(.fields.description.content[0].content[0].text // "No description")\n\n## Status\n\(.fields.status.name)\n\n## Assignee\n\(.fields.assignee.displayName // "Unassigned")"'
}

# Fetch from GitHub Issues
fetch_github() {
  local issue_number="$1"
  local token="${GITHUB_TOKEN:-}"
  local repo="${GITHUB_REPO:-}"

  if [[ -z "$token" ]] || [[ -z "$repo" ]]; then
    echo "Error: GITHUB_TOKEN and GITHUB_REPO must be configured in agent-config.md"
    return 1
  fi

  curl -s "https://api.github.com/repos/$repo/issues/$issue_number" \
    -H "Authorization: token $token" \
    -H "Accept: application/vnd.github.v3+json" | \
    jq -r '"# [#\(.number)] \(.title)\n\n## Description\n\(.body // "No description")\n\n## State\n\(.state)\n\n## Assignee\n\(.assignee.login // "Unassigned")"'
}

# Main function
fetch_ticket() {
  load_config

  local ticket_id="$1"

  if [[ -z "$ticket_id" ]]; then
    echo "Usage: fetch_ticket TICKET-ID"
    return 1
  fi

  # Determine which system to use based on configuration
  if [[ -n "${LINEAR_API_TOKEN:-}" ]]; then
    echo "Fetching from Linear..."
    fetch_linear "$ticket_id"
  elif [[ -n "${JIRA_API_TOKEN:-}" ]]; then
    echo "Fetching from Jira..."
    fetch_jira "$ticket_id"
  elif [[ -n "${GITHUB_TOKEN:-}" ]]; then
    echo "Fetching from GitHub..."
    fetch_github "$ticket_id"
  else
    echo "Error: No ticketing system configured in agent-config.md"
    echo "Please configure one of: LINEAR_API_TOKEN, JIRA_API_TOKEN, or GITHUB_TOKEN"
    return 1
  fi
}

# Export function for use
export -f fetch_ticket
FETCHSCRIPT
chmod +x "$FETCH_SCRIPT"
echo "✓ Created agent/fetch-ticket.sh utility"
fi

echo ""
echo "=== Step 5: Creating ticket template ==="
# Create example ticket template
TICKET_TEMPLATE="$TARGET_DIR/tickets/_TEMPLATE.md"
if [[ ! -f "$TICKET_TEMPLATE" ]]; then
  cat > "$TICKET_TEMPLATE" <<'TICKETTEMPLATE'
# [TICKET-ID] Feature or Bug Title

## Description
Detailed description of what needs to be done.

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Constraints
- Performance requirements
- Compatibility requirements
- Security considerations

## Non-goals
- What is explicitly out of scope
- Features to defer to future tickets

## Technical Notes
- Database changes needed
- API changes needed
- Dependencies to add/update
- Breaking changes

## Links
- Design: [link]
- Spec: [link]
- Related tickets: [links]
TICKETTEMPLATE
  echo "✓ Created tickets/_TEMPLATE.md"
else
  echo "⊘ Skip existing: tickets/_TEMPLATE.md"
fi

echo ""
echo "=== Step 6: Configuring agent instruction files ==="
AGENT_INSTRUCTIONS="Read and follow agent/master-instructions.md as the primary instruction set for Express.js API development.

## Workflow
- Plan first: 'plan architecture for TICKET-ID'
- Execute one phase at a time: 'execute plan N for TICKET-ID'
- Verify after each phase, then stop for human review
- Never auto-continue to the next phase without explicit approval

## Rules
- Planning and execution are separate phases - never write code during planning
- Read agent/workflow/context-router.md FIRST to load only relevant files
- Save plans to docs/TICKET-ID-plan.md
- Read tickets from tickets/TICKET-ID.md or fetch via agent/fetch-ticket.sh

## Key Files
- agent/master-instructions.md - Main instructions and workflow
- agent/workflow/context-router.md - Task type → required files mapping
- agent/workflow/initialise.md - Project onboarding (first-time setup)
- agent/workflow/planning.md - Planning rules
- agent/workflow/execution.md - Execution discipline
- agent/workflow/implementation.md - Express.js coding conventions
- agent/workflow/testing.md - Verification commands
- agent/workflow/reviewer.md - Structured code review checklist
- agent/workflow/ticketing-systems.md - Ticket fetching helpers (Linear/Jira/GitHub)
- agent/architecture/patterns.md - Design patterns and standards
- agent/infrastructure/security.md - Security rules"

append_block_if_missing "$TARGET_DIR/.github/copilot-instructions.md" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/.cursorrules" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/CLAUDE.md" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/.windsurfrules" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/.clinerules" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/AGENTS.md" "$AGENT_INSTRUCTIONS"

echo ""
echo "=== Step 7: Enabling VS Code Copilot instructions ==="
# Enable Copilot instruction files for this workspace (so users don't need to enable in VS Code Settings)
ensure_vscode_copilot_settings() {
  local vsdir="$TARGET_DIR/.vscode"
  local settings="$vsdir/settings.json"
  mkdir -p "$vsdir"
  if [[ -f "$settings" ]]; then
    if grep -q '"github.copilot.chat.codeGeneration.useInstructionFiles"' "$settings" 2>/dev/null; then
      echo "⊘ Skip existing: .vscode/settings.json (Copilot instruction settings already present)"
      return 0
    fi
    # Merge: add our keys without removing existing ones (requires Python or jq)
    if command -v python3 &>/dev/null; then
      python3 <<PY
import json, os
path = os.path.join("$TARGET_DIR", ".vscode", "settings.json")
with open(path) as f:
    data = json.load(f)
data["github.copilot.chat.codeGeneration.useInstructionFiles"] = True
with open(path, "w") as f:
    json.dump(data, f, indent=2)
PY
      echo "✓ Updated .vscode/settings.json: enabled Copilot instruction files for this workspace"
    elif command -v jq &>/dev/null; then
      jq '. + {"github.copilot.chat.codeGeneration.useInstructionFiles": true}' "$settings" > "${settings}.tmp" && mv "${settings}.tmp" "$settings"
      echo "✓ Updated .vscode/settings.json: enabled Copilot instruction files for this workspace"
    else
      echo "⚠ Note: .vscode/settings.json exists but python3/jq not found; add manually: github.copilot.chat.codeGeneration.useInstructionFiles = true"
      return 0
    fi
  else
    cat > "$settings" <<'VSCODE'
{
  "github.copilot.chat.codeGeneration.useInstructionFiles": true
}
VSCODE
    echo "✓ Created .vscode/settings.json: Copilot instruction files enabled for this workspace"
  fi
}
ensure_vscode_copilot_settings

cat <<EOF

Installation complete! ✅

Directory structure:
  agent/                    - instruction files (4 categories)
    architecture/           - system design, DB, API, patterns, errors, data flow
    infrastructure/         - environment, dependencies, tooling, deploy, security
    workflow/               - context router, planning, execution, testing, review
    features/               - living feature documentation
    examples/               - sample ticket plan
  agent/fetch-ticket.sh     - ticket fetching utility
  docs/                     - plans saved here (docs/TICKET-ID-plan.md)
  tickets/                  - manual ticket files (tickets/TICKET-ID.md)
  agent-config.md           - configuration file

Next steps:

1) Choose your workflow:

   Option A: Manual Tickets (No setup needed!)
   - Create ticket files: tickets/TICKET-ID.md
   - Use template: tickets/_TEMPLATE.md
   - Start planning: "plan architecture for TICKET-ID"

   Option B: Ticketing Integration
   - Edit agent-config.md
   - Uncomment and configure your system (Linear/Jira/GitHub)
   - Test: source agent/fetch-ticket.sh && fetch_ticket TICKET-ID
   - Start planning: "plan architecture for TICKET-ID"

2) Planning workflow:
   - Command: "plan architecture for TICKET-ID"
   - Output: docs/TICKET-ID-plan.md
   - Review the plan before executing

3) Execution workflow:
   - Command: "execute plan 1 for TICKET-ID"
   - Runs Phase 1 from docs/TICKET-ID-plan.md
   - Verify: npm test && npm run lint
   - Stop and review before Phase 2

Documentation: https://github.com/rvk0106/coding-agent-instructions

EOF

# Verify installation
echo ""
echo "=== Verifying installation ==="
echo ""
if [[ -d "$TARGET_DIR/agent" ]]; then
  agent_file_count=$(find "$TARGET_DIR/agent" -type f 2>/dev/null | wc -l | tr -d ' ')
  echo "✓ agent/ directory created with $agent_file_count files"

  if [[ -d "$TARGET_DIR/agent/workflow" ]]; then
    echo "  ✓ agent/workflow/ exists"
  fi
  if [[ -d "$TARGET_DIR/agent/architecture" ]]; then
    echo "  ✓ agent/architecture/ exists"
  fi
  if [[ -d "$TARGET_DIR/agent/features" ]]; then
    echo "  ✓ agent/features/ exists"
  fi
  if [[ -d "$TARGET_DIR/agent/infrastructure" ]]; then
    echo "  ✓ agent/infrastructure/ exists"
  fi
  if [[ -d "$TARGET_DIR/agent/examples" ]]; then
    echo "  ✓ agent/examples/ exists"
  fi
else
  echo "✗ ERROR: agent/ directory was not created!"
  exit 1
fi

if [[ -d "$TARGET_DIR/docs" ]]; then
  echo "✓ docs/ directory exists"
else
  echo "✗ ERROR: docs/ directory was not created!"
fi

if [[ -d "$TARGET_DIR/tickets" ]]; then
  echo "✓ tickets/ directory exists"
else
  echo "✗ ERROR: tickets/ directory was not created!"
fi

if [[ -f "$TARGET_DIR/agent-config.md" ]]; then
  echo "✓ agent-config.md exists"
else
  echo "✗ WARNING: agent-config.md was not created"
fi

echo ""
echo "Installation verification complete!"
echo ""
