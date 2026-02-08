# OpenAI Codex CLI Adapter

## Auto-Setup (via install.sh)

The installer creates `AGENTS.md` in your project root. Codex CLI reads this file automatically as agent instructions.

## Manual Setup

1. Create `AGENTS.md` in your project root.
2. Paste the contents of `agent/master-instructions.md` or add a reference to it.

## Recommended Workflow

```
# In Codex CLI:

# Step 1: Plan
"plan gem for TICKET-ID"

# Step 2: Review docs/TICKET-ID-plan.md

# Step 3: Execute one phase
"execute plan 1 for TICKET-ID"

# Step 4: Run verification
bundle exec rspec && bundle exec rubocop

# Step 5: Continue after approval
"execute plan 2 for TICKET-ID"
```

## Notes

- Codex CLI reads `AGENTS.md` from the project root automatically.
- Codex can execute shell commands directly -- verification steps can run automatically.
- Keep `agent/` directory in your repo for Codex to reference instruction modules.
