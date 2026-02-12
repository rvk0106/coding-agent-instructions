# Windsurf (Codeium) Adapter

## Auto-Setup (via install.sh)

The installer creates `.windsurfrules` in your project root. Windsurf reads this file automatically.

## Manual Setup

1. Create `.windsurfrules` in your project root.
2. Paste the contents of `agent/master-instructions.md` or add a reference to it.

## Recommended Workflow

```
# In Windsurf Cascade or Chat:

# Step 1: Plan
"plan library for TICKET-ID"

# Step 2: Review docs/TICKET-ID-plan.md

# Step 3: Execute one phase
"execute plan 1 for TICKET-ID"

# Step 4: Run verification in terminal
mvn clean verify

# Step 5: Continue after approval
"execute plan 2 for TICKET-ID"
```

## Notes

- Windsurf reads `.windsurfrules` from the project root automatically.
- Cascade mode can make multi-file changes -- use it for execution phases.
- Keep `agent/` directory in your repo for Windsurf to reference instruction modules.
- Verification commands should be run in the Windsurf terminal.
