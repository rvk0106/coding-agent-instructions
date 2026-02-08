# Agent compatibility guide

This repo is designed to work with **any** AI coding agent (Cursor, GitHub Copilot, Claude Code, Windsurf, ChatGPT, etc.). The same instruction set is written into each tool’s expected file(s) so one install works across agents.

## Where each agent reads instructions

| Agent | Primary file(s) | Notes |
|-------|-----------------|--------|
| **Cursor** | `.cursorrules` or `.cursor/rules/*.mdc` | Legacy: single `.cursorrules`. New: `.cursor/rules/` with `.mdc` files. Install writes to both when possible. |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Repo-wide instructions. Copilot also supports `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` for agent mode. |
| **Claude Code (Claude.dev)** | `CLAUDE.md` | Loaded automatically from repo root (or nearest parent). |
| **Windsurf (Codeium)** | `.windsurfrules` | Project root, ~6,000 character limit. Install adds a short pointer to `agent/master-instructions.md`. |
| **ChatGPT / other** | No standard file | Use **Manual**: paste `agent/master-instructions.md` into the system prompt, or use `AGENTS.md` and tell the agent to follow it. |

## What the install script creates

When you run `install.sh` for a framework, it:

1. Copies the `agent/` folder (instruction modules) into your project.
2. Creates or updates **agent-specific entry points** so your agent picks up the same workflow:

| File | Used by |
|------|--------|
| `.github/copilot-instructions.md` | GitHub Copilot |
| `.cursorrules` | Cursor (legacy) |
| `.cursor/rules/agent-instructions.mdc` | Cursor (modern rules) |
| `CLAUDE.md` | Claude Code |
| `AGENTS.md` | Copilot agents, generic “agent” tools that look for AGENTS.md |
| `.windsurfrules` | Windsurf |

Each of these contains a short pointer (or inline summary) so the agent follows `agent/master-instructions.md` and the plan-first, phase-by-phase workflow.

## Using a specific agent

### Cursor

- **Legacy:** Instructions are appended to `.cursorrules`.
- **Modern:** If the install supports it, a rule is added under `.cursor/rules/` (e.g. `agent-instructions.mdc`) that references or embeds the same workflow. Cursor will load rules from both locations.

### GitHub Copilot

- Repo-wide: Ensure `.github/copilot-instructions.md` exists and includes the install block (install script does this).
- Agent mode on GitHub: Copilot can also use `AGENTS.md` or `CLAUDE.md` in the repo root; install adds a block to `AGENTS.md` when creating it.

### Claude Code

- `CLAUDE.md` in the project root is updated by the install script. Claude Code loads it automatically. No extra steps.

### Windsurf

- Install appends a short directive to `.windsurfrules` (within the 6k character limit) that tells Windsurf to follow `agent/master-instructions.md` and the phase-based workflow.

### ChatGPT or other agents (no standard file)

1. **Option A:** Open `agent/master-instructions.md` and paste it into the system or initial message.
2. **Option B:** Create or use `AGENTS.md` in the repo root (install can add a block). Tell the agent: “Follow the instructions in AGENTS.md and in the agent/ folder.”

## Keeping instructions in sync

- **Single source of truth:** `agent/master-instructions.md` (and the other files in `agent/`).
- **Entry-point files** (`.cursorrules`, `CLAUDE.md`, `.github/copilot-instructions.md`, `AGENTS.md`, `.windsurfrules`) should only point to or briefly summarize that workflow.
- When you update instructions, edit the `agent/` files. Re-run the install script only if you need to re-apply the short blocks to the agent-specific files (e.g. after changing how the pointer is phrased).

## Tool-adapters reference

Some framework packages (e.g. `agent-instructions-rails`) include a `tool-adapters/` folder with one-page notes per agent:

- `cursor.md` – Cursor setup and workflow
- `copilot.md` – Copilot setup and workflow
- `claude.md` – Claude Code setup and workflow
- `chatgpt.md` – ChatGPT / manual paste workflow

The repo root may also provide a shared `tool-adapters/` for generic, framework-agnostic adapter text. Use these as references; the install script is what actually wires your project to each agent.

## Uninstall (all agents)

To remove agent instructions from your project:

1. Delete the `agent/` directory.
2. In each of the files below, remove the block between the markers:
   - `# >>> agent-instructions-<framework>`
   - `# <<< agent-instructions-<framework>`
3. Files to edit:
   - `.github/copilot-instructions.md`
   - `.cursorrules`
   - `.cursor/rules/agent-instructions.mdc` (if present)
   - `CLAUDE.md`
   - `AGENTS.md`
   - `.windsurfrules`

After that, no agent will pick up this workflow from repo files unless you reinstall or re-add the blocks manually.
