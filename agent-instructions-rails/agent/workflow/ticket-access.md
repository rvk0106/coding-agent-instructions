# Ticket Access
> Tags: ticket, fetch, linear, jira, github, manual
> Scope: How to get ticket data before planning

## Fetch Order
1. Check `agent-config.md` for configured system
2. If API configured → use `agent/fetch-ticket.sh`
3. If manual → read `tickets/TICKET-ID.md`
4. If neither → ask user to paste ticket

## Supported Systems
- Linear: `LINEAR_API_TOKEN` env var
- Jira: `JIRA_API_TOKEN` + `JIRA_URL` env vars
- GitHub Issues: `GITHUB_TOKEN` + `GITHUB_REPO` env vars
- Manual: `tickets/TICKET-ID.md` files

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
## Description → what needs doing
## Acceptance Criteria → checklist
## Constraints → limits
## Non-goals → out of scope
## Technical Notes → implementation hints
## Links → references
```
