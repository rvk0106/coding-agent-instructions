# Copilot adapter

## Setup (automatic)

Running `install.sh` creates or updates **`.github/copilot-instructions.md`** with a short block that tells Copilot to follow `agent/master-instructions.md` and the plan-first, phase-by-phase workflow.

## Manual setup

If you didn’t use the installer:

1. Ensure **`.github/copilot-instructions.md`** exists (create `.github` if needed).
2. Add a line such as: “Follow agent/master-instructions.md as the single source of truth. Plan first, execute one phase at a time, verify, then stop for review.”

Copilot also supports **AGENTS.md** and **CLAUDE.md** in the repo root for agent mode; the installer can add a block to **AGENTS.md** as well.

## Workflow

- Plan first; no code during planning.
- Execute one phase at a time.
- Verify, stop, and wait for approval before the next phase.
