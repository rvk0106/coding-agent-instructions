# Ticket Access — Source of Truth

## Purpose
Standardize how ticket data is fetched and normalized for planning.

## Supported systems
- Linear (via API token or MCP)
- Jira (via API token or MCP)
- GitHub Issues (via API or MCP)

## Connection methods

### Method 1: Linear API (Direct)
```bash
linear_issue() {
  local ISSUE_ID="$1"
  local TOKEN="${LINEAR_API_TOKEN:-$(rails runner "puts ENV['LINEAR_API_TOKEN']")}" 

  if [ -z "$TOKEN" ]; then
    echo "Error: LINEAR_API_TOKEN not found in environment variables"
    echo "Please set LINEAR_API_TOKEN in your Rails environment or .env file"
    return 1
  fi

  curl -s https://api.linear.app/graphql \
    -H "Content-Type: application/json" \
    -H "Authorization: $TOKEN" \
    -d @- <<EOF | jq
{
  "query": "query { issue(id: \"$ISSUE_ID\") { id identifier title description state { name } assignee { name } createdAt updatedAt } }"
}
EOF
}
```

### Method 2: MCP (Model Context Protocol)
- If MCP server is configured, use MCP tools to fetch ticket data.
- This is preferred when available for richer context.

### Method 3: Manual paste
- If neither API nor MCP is available, ask the user to paste ticket details.

## Required fields
- Ticket ID / Identifier
- Summary / title
- Description
- Acceptance criteria
- Constraints
- Non‑goals
- Links and attachments
- Owner and priority (if available)
- Rails-specific scope notes (models, controllers, routes, jobs, migrations)

## Workflow
1) **Connect**: Try MCP first, then API token, then ask for manual paste.
2) **Fetch**: Retrieve ticket data using the available method.
3) **Normalize**: Convert raw data into a structured digest:
   - Ticket ID / Identifier
   - Title
   - Description summary
   - Acceptance criteria (bullets)
   - Constraints / non‑goals
   - Links / attachments
   - Expected scope (models, controllers, services, routes, jobs, tests)
   - Expected API endpoints (if applicable)
   - Data model impact (if applicable)
4) **Save**: This normalized ticket will be the input for the planner.
