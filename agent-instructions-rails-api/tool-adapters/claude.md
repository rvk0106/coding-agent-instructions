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
"plan architecture for TICKET-ID"
→ Agent reads ticket, analyzes codebase, creates docs/TICKET-ID-plan.md
→ Agent STOPS for your review

# Step 2: Review the plan
Open docs/TICKET-ID-plan.md and approve or request changes

# Step 3: Execute phase by phase
"execute plan 1 for TICKET-ID"
→ Agent implements Phase 1 only
→ Agent runs verification commands
→ Agent STOPS for your review

# Step 4: Verify and continue
bundle exec rspec && bundle exec rubocop
"execute plan 2 for TICKET-ID"
```

## Notes

- Claude Code can run shell commands directly, so verification steps can be executed automatically.
- The `CLAUDE.md` file supports nested instructions -- you can have additional `CLAUDE.md` files in subdirectories.
- For Claude on the web (no CLI), paste `agent/master-instructions.md` as the first message in a new conversation.
