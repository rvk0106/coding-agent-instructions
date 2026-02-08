# GitHub Copilot Adapter

## Auto-Setup (via install.sh)

The installer creates `.github/copilot-instructions.md` in your project. GitHub Copilot reads this file automatically for repository-level instructions.

## Manual Setup

1. Create `.github/copilot-instructions.md` in your repository root.
2. Paste the contents of `agent/master-instructions.md` or add a reference to it.
3. Copilot Chat will use these instructions for all interactions in this repository.

## Recommended Workflow

```
# In Copilot Chat (VS Code, JetBrains, or GitHub.com):

# Step 1: Plan
"plan frontend for TICKET-ID"

# Step 2: Review docs/TICKET-ID-plan.md

# Step 3: Execute one phase
"execute plan 1 for TICKET-ID"

# Step 4: Run verification in terminal
npm test && npm run lint && npm run build

# Step 5: Continue after approval
"execute plan 2 for TICKET-ID"
```

## Notes

- `.github/copilot-instructions.md` is loaded automatically by Copilot Chat.
- Copilot does not execute commands -- run verification steps manually.
- Keep the `agent/` directory in your repo so Copilot can read referenced files when using `@workspace`.
- Works in VS Code, JetBrains IDEs, and GitHub.com Copilot Chat.
