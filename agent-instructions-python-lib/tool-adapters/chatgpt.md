# ChatGPT Adapter

## Setup

ChatGPT does not read project files automatically. You need to provide context manually.

1. Start a new conversation.
2. Paste the contents of `agent/master-instructions.md` as the first message.
3. Optionally paste `agent/principles-and-standards.md` for framework-specific standards.

## Recommended Workflow

```
# Step 1: Paste master-instructions.md as first message

# Step 2: Provide ticket data
"Here is the ticket: [paste ticket content or tickets/TICKET-ID.md]"

# Step 3: Plan
"plan library for TICKET-ID"

# Step 4: Review the plan output

# Step 5: Execute one phase
"execute plan 1 for TICKET-ID"

# Step 6: Copy code to your project, run verification
pytest && flake8 && mypy

# Step 7: Report results back
"Tests pass. Continue to phase 2."
```

## Notes

- ChatGPT cannot read files from your repository or run commands. All context must be pasted manually.
- Copy generated code into your project and run verification steps yourself.
- If the conversation grows long, start a new conversation and re-paste the instructions.
- Works with ChatGPT Plus, Team, and Enterprise plans.
