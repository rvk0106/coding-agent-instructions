# Cursor Adapter

## Auto-Setup (via install.sh)

The installer creates `.cursorrules` in your project root. Cursor reads this file automatically.

## Manual Setup

1. Open Cursor Settings > Rules for AI.
2. Add a project rule that points to `agent/master-instructions.md`.
3. Alternatively, paste the contents of `agent/master-instructions.md` into your `.cursorrules` file.

## Recommended Workflow

```
# In Cursor chat or Composer:

# Step 1: Plan
"plan architecture for TICKET-ID"

# Step 2: Review docs/TICKET-ID-plan.md

# Step 3: Execute one phase
"execute plan 1 for TICKET-ID"

# Step 4: Run verification in terminal
bundle exec rspec && bundle exec rubocop

# Step 5: Continue after approval
"execute plan 2 for TICKET-ID"
```

## Notes

- Cursor reads `.cursorrules` from the project root on every interaction.
- Keep `agent/` directory in your repo so Cursor can reference the instruction modules.
- Use Cursor's Composer mode for multi-file changes within a single phase.
- Verification commands should be run manually in the Cursor terminal.
