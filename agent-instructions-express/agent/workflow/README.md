# Workflow

Standard process for ticket lifecycle: plan --> implement --> test --> update docs.

| File | When to Use |
|------|-------------|
| [context-retrieval.md](context-retrieval.md) | **READ FIRST when retrieval configured:** token-efficient context via vector DB or reduced index --> retrieve only relevant chunks |
| [context-router.md](context-router.md) | **Otherwise READ FIRST:** maps task type --> required files |
| [ticket-access.md](ticket-access.md) | Fetching/reading ticket data (order: config --> fetch-ticket.sh --> manual) |
| [ticketing-systems.md](ticketing-systems.md) | **When MCP not configured:** curl/jq shell snippets for Linear, Jira, GitHub Issues |
| [initialise.md](initialise.md) | **Run first or when knowledge empty:** scan project, fill architecture/infrastructure/features, optional re-index |
| [planning.md](planning.md) | `plan architecture for TICKET-ID` |
| [execution.md](execution.md) | `execute plan N for TICKET-ID` |
| [reviewer.md](reviewer.md) | **Post-implementation:** review code against plan and conventions; output Approve or Request changes with checklist |
| [implementation.md](implementation.md) | Writing code during a phase |
| [testing.md](testing.md) | Verifying a phase |
| [maintenance.md](maintenance.md) | After completing a ticket |
| [prompts.md](prompts.md) | Pre-built prompts for common tasks |
