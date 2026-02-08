# Claude adapter

## Setup (automatic)

Running `install.sh` creates or updates **`CLAUDE.md`** in the project root. Claude Code loads this file automatically at the start of a session.

## Manual setup

If you didn’t use the installer:

1. Create **`CLAUDE.md`** in the project root.
2. Add a line such as: “Use agent/master-instructions.md as your system prompt or initial context. Plan first, execute one phase at a time, verify, stop for review.”

## Workflow

1. Provide ticket data or let the agent fetch it (e.g. from `tickets/` or API).
2. Ask for a plan: “plan ticket &lt;ID&gt;” or “plan architecture for &lt;ID&gt;”.
3. Approve the plan, then ask: “execute plan 1 for &lt;ID&gt;”.
4. Review output, run tests, then approve the next phase.

**Note:** Claude may not run shell commands itself. Verification steps often need to be run by you.
