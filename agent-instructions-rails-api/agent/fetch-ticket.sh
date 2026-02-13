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
