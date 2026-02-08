# ChatGPT / generic adapter

## Setup

There is no standard project file that ChatGPT reads automatically. Use one of these:

### Option A: Paste into the conversation

1. Open **agent/master-instructions.md** in your project (after running `install.sh` for your framework).
2. Paste its contents into the system prompt or the first message.
3. Then ask for a plan (e.g. “plan architecture for TICKET-ID”) and run the phase-by-phase workflow.

### Option B: Use AGENTS.md

1. Run `install.sh` so that **AGENTS.md** in the repo root contains a block pointing to `agent/`.
2. Tell the agent at the start: “Follow the instructions in AGENTS.md and in the agent/ folder.”
3. Proceed with plan → execute phase 1 → verify → review → next phase.

## Workflow

- Provide ticket data (paste or reference `tickets/TICKET-ID.md`).
- Ask for a phase-based plan.
- Execute one phase at a time with verification and human approval between phases.
