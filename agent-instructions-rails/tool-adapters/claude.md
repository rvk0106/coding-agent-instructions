# Claude Adapter

## Where to paste
- Use `agent/master-instructions.md` as the system prompt or initial context.

## Recommended flow
1) Provide ticket data or let the agent fetch it.
2) Ask for a plan: “plan ticket <ID>”.
3) Approve plan and ask: “execute plan 1 for <ID>”.
4) Review output, run tests, approve next phase.

## Notes
- Claude does not run commands unless you do. Verification steps should be run by a human.
