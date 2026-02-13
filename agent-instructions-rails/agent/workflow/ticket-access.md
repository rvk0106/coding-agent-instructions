# Ticket Access
> Tags: ticket, fetch, linear, jira, github, manual
> Scope: How to get ticket data before planning

## Fetch Order
1. **MCP** -- If an MCP server for Linear/Jira/GitHub is configured, use it to fetch the ticket.
2. **API (no MCP)** -- Check `agent-config.md`; if a ticketing system is configured, use **`agent/fetch-ticket.sh`** or the shell helpers in **[ticketing-systems.md](ticketing-systems.md)** (curl + jq).
3. **Manual** -- Read `tickets/TICKET-ID.md` if the file exists.
4. **Fallback** -- Ask the user to paste the ticket or provide a link.

For curl-based fetching when MCP is not configured (token sources, Linear/Jira/GitHub examples, markdown output), see **[ticketing-systems.md](ticketing-systems.md)**.

## Supported Systems
- **Linear:** `LINEAR_API_TOKEN` (env or `agent-config.md`) -- see [ticketing-systems.md](ticketing-systems.md#linear)
- **Jira:** `JIRA_API_TOKEN` + `JIRA_URL` -- see [ticketing-systems.md](ticketing-systems.md#jira)
- **GitHub Issues:** `GITHUB_TOKEN` + `GITHUB_REPO` -- see [ticketing-systems.md](ticketing-systems.md#github-issues)
- **Manual:** `tickets/TICKET-ID.md` files

## Required Fields to Extract
- Ticket ID
- Title
- Description
- Acceptance criteria (as checklist)
- Constraints / non-goals
- Technical notes
- Links / attachments

## Manual Ticket Format
```
tickets/PROJ-123.md:
# [PROJ-123] Title
## Description -> what needs doing
## Acceptance Criteria -> checklist
## Constraints -> limits
## Non-goals -> out of scope
## Technical Notes -> implementation hints
## Links -> references
```
