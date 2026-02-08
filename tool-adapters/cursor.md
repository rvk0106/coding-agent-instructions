# Cursor adapter

## Setup (automatic)

Running `install.sh` for your framework will:

- Append a short block to **`.cursorrules`** (legacy, single-file rules).
- Create **`.cursor/rules/agent-instructions.mdc`** (modern Cursor rules with `alwaysApply: true`).

Both point to `agent/master-instructions.md`. No manual step required.

## Manual setup

If you didn’t use the installer:

1. Copy the framework’s `agent/` folder into your project.
2. Either:
   - Add to **`.cursorrules`**: “Follow agent/master-instructions.md. Planning and execution are separate; no phase auto-continue.”
   - Or create **`.cursor/rules/agent-instructions.mdc`** with the same instruction and `alwaysApply: true` in the frontmatter.

## Workflow

- Ask for a plan first (e.g. “plan architecture for TICKET-ID”).
- Approve and execute one phase at a time.
- Require tests/verification for each phase before continuing.
