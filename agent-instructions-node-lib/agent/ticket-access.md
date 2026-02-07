# Ticket Access — Source of Truth

## Purpose
Standardize how ticket data is fetched and normalized for planning.

## Configuration
All ticket system configuration (API tokens, project IDs, team IDs, etc.) should be defined in your project's `agent-config.md` file.

## Supported systems
- Linear (via API token or MCP)
- Jira (via API token or MCP)
- GitHub Issues (via API or MCP)
- Manual paste

## Setup
1. Create `agent-config.md` in your project root
2. Add your ticketing system configuration (see template below)
3. Agent will read configuration from that file when fetching tickets

## agent-config.md Template
```markdown
# Agent Configuration

## Ticketing System
System: [Linear|Jira|GitHub Issues]
API Token Location: [ENV variable or config file location]
Project/Team ID: [your-project-id]
Additional Context: [any project-specific details]

## Connection Method
Preferred: MCP (if available)
Fallback: Direct API
```

## Connection methods
The agent will automatically detect and use the best available method based on your `agent-config.md`:
1. **MCP (Model Context Protocol)**: Preferred when configured
2. **Direct API**: Using tokens from environment variables or config files
3. **Manual paste**: When neither MCP nor API is configured

## Required fields
- Ticket ID / Identifier
- Summary / title
- Description
- Acceptance criteria
- Constraints
- Non‑goals
- Links and attachments
- Owner and priority (if available)
- Framework-specific scope notes

## Workflow
1) **Connect**: Check `agent-config.md` for connection method
2) **Fetch**: Retrieve ticket data using the configured method
3) **Normalize**: Convert raw data into a structured digest:
   - Ticket ID / Identifier
   - Title
   - Description summary
   - Acceptance criteria (bullets)
   - Constraints / non‑goals
   - Links / attachments
   - Expected scope (components, files, tests)
   - Expected API changes (if applicable)
   - Data model impact (if applicable)
4) **Save**: This normalized ticket will be the input for the planner.
