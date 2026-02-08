# Cline Adapter

## Auto-Setup (via install.sh)

The installer creates `.clinerules` in your project root. Cline reads this file automatically.

## Manual Setup

1. Create `.clinerules` in your project root.
2. Paste the contents of `agent/master-instructions.md` or add a reference to it.

## Recommended Workflow

```
# In Cline (VS Code extension):

# Step 1: Plan
"plan architecture for TICKET-ID"

# Step 2: Review docs/TICKET-ID-plan.md

# Step 3: Execute one phase
"execute plan 1 for TICKET-ID"

# Step 4: Cline can run verification commands with approval
./mvnw test && ./mvnw checkstyle:check

# Step 5: Continue after approval
"execute plan 2 for TICKET-ID"
```

## Notes

- Cline reads `.clinerules` from the project root automatically.
- Cline can execute terminal commands with your approval -- useful for verification steps.
- Keep `agent/` directory in your repo for Cline to reference instruction modules.
- Cline supports auto-approve mode, but the agent instructions enforce manual review between phases.
