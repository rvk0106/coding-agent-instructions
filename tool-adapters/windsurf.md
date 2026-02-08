# Windsurf adapter

## Setup (automatic)

Running `install.sh` appends a short block to **`.windsurfrules`** in the project root. Windsurf has a ~6,000 character limit for this file, so the block is a brief pointer to `agent/master-instructions.md` and the phase-based workflow.

## Manual setup

If you didn’t use the installer:

1. Create or edit **`.windsurfrules`** in the project root.
2. Add: “Follow agent/master-instructions.md. Plan first, one phase at a time, verify, stop for review.”

Keep the rest of `.windsurfrules` under the 6k limit; you can reference other docs (e.g. in `/docs/` or `agent/`) from within the instructions.

## Workflow

- Plan first; then execute one phase at a time.
- Verify each phase (tests/lint/build) and stop for review before continuing.
