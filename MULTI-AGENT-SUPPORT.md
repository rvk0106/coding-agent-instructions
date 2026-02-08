# Multi-Agent Support

This repository supports all major AI coding agents. The `install.sh` script automatically creates the correct configuration file for each agent, so your instructions work regardless of which tool your team uses.

## Supported Agents & Configuration Files

| Agent | Config File | Auto-Created | How It Works |
|-------|-------------|:------------:|--------------|
| **Claude Code** | `CLAUDE.md` | Yes | Read automatically from project root |
| **GitHub Copilot** | `.github/copilot-instructions.md` + `.vscode/settings.json` | Yes | Install enables instruction files for this workspace in VS Code; read automatically in Copilot Chat |
| **Cursor** | `.cursorrules` | Yes | Read automatically on every interaction |
| **Windsurf (Codeium)** | `.windsurfrules` | Yes | Read automatically from project root |
| **Cline** | `.clinerules` | Yes | Read automatically from project root |
| **OpenAI Codex CLI** | `AGENTS.md` | Yes | Read automatically as agent instructions |
| **ChatGPT** | _(manual paste)_ | No | Paste `agent/master-instructions.md` into chat |

## What Gets Created

After running `install.sh`, your project will contain:

```
your-project/
├── agent/                              # Core instruction modules
│   ├── master-instructions.md          # Main entry point (all agents read this)
│   ├── principles-and-standards.md     # Framework coding standards
│   ├── ticket-access.md               # Ticket fetching instructions
│   ├── planner-instructions.md        # Planning workflow rules
│   ├── execution-contract.md          # Execution discipline
│   ├── implementer-instructions.md    # Coding conventions
│   ├── testing-instructions.md        # Verification commands
│   └── fetch-ticket.sh               # Ticket fetching utility
├── docs/                               # Plan output directory
├── tickets/                            # Manual ticket files
│   └── _TEMPLATE.md                   # Ticket template
├── agent-config.md                     # Ticketing system config
│
│ # Agent-specific config files (all auto-created):
├── CLAUDE.md                           # Claude Code
├── AGENTS.md                           # OpenAI Codex CLI
├── .cursorrules                        # Cursor
├── .windsurfrules                      # Windsurf
├── .clinerules                         # Cline
├── .vscode/
│   └── settings.json                   # Enables Copilot instruction files for this workspace (VS Code)
└── .github/
    └── copilot-instructions.md         # GitHub Copilot
```

**GitHub Copilot (VS Code):** The installer creates or updates `.vscode/settings.json` with `github.copilot.chat.codeGeneration.useInstructionFiles: true` and `chat.useAgentsMdFile: true`, so you don’t need to enable “Use Instruction Files” in Settings manually for this project.

## How It Works

All agent config files point to the same `agent/master-instructions.md` as the single source of truth. This means:

1. **One set of instructions** -- maintained in the `agent/` directory
2. **Multiple entry points** -- each agent reads its own config file format
3. **Consistent behavior** -- every agent follows the same plan-first, phase-based workflow
4. **No duplication** -- the config files are thin pointers, not copies of the instructions

## Using Multiple Agents on the Same Project

Since all config files are created simultaneously, team members can use different agents on the same codebase:

- Developer A uses **Cursor** (reads `.cursorrules`)
- Developer B uses **Claude Code** (reads `CLAUDE.md`)
- Developer C uses **GitHub Copilot** (reads `.github/copilot-instructions.md`)
- Developer D uses **Windsurf** (reads `.windsurfrules`)

All four developers get the same instructions and follow the same workflow.

## Agent Capability Matrix

| Capability | Claude Code | Copilot | Cursor | Windsurf | Cline | Codex CLI | ChatGPT |
|------------|:-----------:|:-------:|:------:|:--------:|:-----:|:---------:|:-------:|
| Reads config file automatically | Yes | Yes | Yes | Yes | Yes | Yes | No |
| Can read project files | Yes | Yes | Yes | Yes | Yes | Yes | No |
| Can run terminal commands | Yes | No | No | No | Yes | Yes | No |
| Multi-file editing | Yes | Yes | Yes | Yes | Yes | Yes | No |
| Runs verification automatically | Yes | No | No | No | Yes | Yes | No |

## Per-Agent Setup Guides

Each framework directory includes detailed adapter guides in `tool-adapters/`:

```
tool-adapters/
├── claude.md       # Claude Code / Claude setup
├── copilot.md      # GitHub Copilot setup
├── cursor.md       # Cursor setup
├── windsurf.md     # Windsurf (Codeium) setup
├── cline.md        # Cline setup
├── codex.md        # OpenAI Codex CLI setup
└── chatgpt.md      # ChatGPT setup (manual)
```

## .gitignore Considerations

All agent config files should be committed to your repository so they're available to all team members. None of these files contain secrets -- they only contain instruction pointers.

If your `.gitignore` excludes any of these files, add exceptions:

```gitignore
# Allow agent config files
!CLAUDE.md
!AGENTS.md
!.cursorrules
!.windsurfrules
!.clinerules
!.github/copilot-instructions.md
```
