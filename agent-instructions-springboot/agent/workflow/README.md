# Workflow

How we work: planning, execution, testing, maintenance, and ticket management. These files define the process agents follow for every task.

## Files

| File | Purpose | When to Read |
|------|---------|--------------|
| `context-router.md` | Maps task type to required files (READ FIRST) | Start of every planning session |
| `context-retrieval.md` | Vector DB / reduced index for token-efficient context | When retrieval is set up |
| `planning.md` | How to create phased plans from tickets | When planning a ticket |
| `execution.md` | How to execute a single phase | When implementing a phase |
| `implementation.md` | Spring Boot coding conventions and file locations | During every implementation |
| `testing.md` | Verification commands (Maven/Gradle, JUnit, Checkstyle) | After every phase |
| `maintenance.md` | What to update after completing a ticket | After ticket completion |
| `ticket-access.md` | How to fetch ticket data (MCP, API, manual) | Before planning |
| `ticketing-systems.md` | curl/jq helpers for Linear, Jira, GitHub | When MCP not available |
| `initialise.md` | First-time project scan and knowledge file population | First planning or empty knowledge files |
| `reviewer.md` | Structured code review (Approve/Request changes) | After implementation, before human review |
| `prompts.md` | Pre-built prompts for common task types | Quick-start for common tasks |

## Default Loop
1. Fetch ticket --> `ticket-access.md`
2. If first time --> `initialise.md`
3. Plan --> `planning.md` --> save to `docs/TICKET-ID-plan.md` --> STOP
4. Execute Phase N --> `execution.md` --> STOP
5. Verify --> `testing.md`
6. Optional: `reviewer.md` for structured review
7. Wait for human approval --> repeat for Phase N+1
8. After ticket complete --> `maintenance.md`
