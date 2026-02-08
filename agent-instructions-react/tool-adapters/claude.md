# Claude Code / Claude Adapter

## Auto-Setup (via install.sh)

The installer creates `CLAUDE.md` in your project root. Claude Code reads this file automatically as project instructions.

## Manual Setup

If using Claude Code CLI or Claude on the web:

1. Claude Code reads `CLAUDE.md` from your project root automatically -- no extra configuration needed.
2. Claude Code also reads `agent/master-instructions.md` and all referenced files when instructed.

## Recommended Workflow

```
# Step 1: Plan
"plan frontend for TICKET-ID"

# Step 2: Review docs/TICKET-ID-plan.md

# Step 3: Execute phase by phase
"execute plan 1 for TICKET-ID"

# Step 4: Verify and continue
npm test && npm run lint && npm run build
"execute plan 2 for TICKET-ID"
```

## Notes

- Claude Code can run shell commands directly, so verification steps can be executed automatically.
- The `CLAUDE.md` file supports nested instructions -- you can have additional `CLAUDE.md` files in subdirectories.
- For Claude on the web (no CLI), paste `agent/master-instructions.md` as the first message in a new conversation.
