#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
TARGET_DIR="${1:-}"
MARKER_START="# >>> agent-instructions-rails"
MARKER_END="# <<< agent-instructions-rails"

if [[ -z "$TARGET_DIR" ]]; then
  echo "Usage: ./install.sh /path/to/your-project"
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

mkdir -p "$TARGET_DIR/tickets"
echo "Created tickets/ directory for manual ticket files"

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
  echo "Created agent-config.md template"
else
  echo "Skip existing: agent-config.md"
fi

# Create ticket fetching utility script
FETCH_SCRIPT="$TARGET_DIR/agent/fetch-ticket.sh"
mkdir -p "$(dirname "$FETCH_SCRIPT")"
cat > "$FETCH_SCRIPT" <<'FETCHSCRIPT'
#!/usr/bin/env bash
# Ticket Fetching Utility
# Sources configuration from agent-config.md and fetches tickets from various systems

# Load configuration from agent-config.md
load_config() {
  if [[ -f "agent-config.md" ]]; then
    # Extract uncommented environment variables
    eval "$(grep -E '^[A-Z_]+=' agent-config.md)"
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
echo "Created agent/fetch-ticket.sh utility"

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
  echo "Created tickets/_TEMPLATE.md"
else
  echo "Skip existing: tickets/_TEMPLATE.md"
fi

AGENT_INSTRUCTIONS="Read and follow agent/master-instructions.md as the primary instruction set for Rails API development.

## Workflow
- Plan first: 'plan architecture for TICKET-ID'
- Execute one phase at a time: 'execute plan N for TICKET-ID'
- Verify after each phase, then stop for human review
- Never auto-continue to the next phase without explicit approval

## Rules
- Planning and execution are separate phases - never write code during planning
- Read agent/principles-and-standards.md for coding conventions
- Read agent/testing-instructions.md for verification commands
- Save plans to docs/TICKET-ID-plan.md
- Read tickets from tickets/TICKET-ID.md or fetch via agent/fetch-ticket.sh

## Key Files
- agent/master-instructions.md - Main instructions and workflow
- agent/principles-and-standards.md - Rails coding standards
- agent/planner-instructions.md - Planning rules
- agent/execution-contract.md - Execution discipline
- agent/implementer-instructions.md - Implementation patterns
- agent/testing-instructions.md - Verification commands"

append_block_if_missing "$TARGET_DIR/.github/copilot-instructions.md" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/.cursorrules" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/CLAUDE.md" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/.windsurfrules" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/.clinerules" "$AGENT_INSTRUCTIONS"
append_block_if_missing "$TARGET_DIR/AGENTS.md" "$AGENT_INSTRUCTIONS"

cat <<EOF

Installation complete! ✅

Directory structure:
- agent/ - instruction files
- agent/fetch-ticket.sh - ticket fetching utility
- docs/ - plans saved here (docs/TICKET-ID-plan.md)
- tickets/ - manual ticket files (tickets/TICKET-ID.md)
- agent-config.md - configuration file

Next steps:

1) Choose your workflow:
   
   📁 Option A: Manual Tickets (No setup needed!)
   - Create ticket files: tickets/TICKET-ID.md
   - Use template: tickets/_TEMPLATE.md
   - Start planning: "plan architecture for TICKET-ID"
   
   🔌 Option B: Ticketing Integration
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
   - Verify: bundle exec rspec && bundle exec rubocop
   - Stop and review before Phase 2

See WORKFLOW-GUIDE.md for detailed examples.

EOF
