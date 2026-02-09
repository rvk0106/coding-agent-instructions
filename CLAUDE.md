# Agent Instructions — Meta-Repo Shorthand

## What This Repo Is
Template collection: 8 framework-specific agent instruction sets that get installed into target projects via `install.sh`. NOT an application — no runtime, no tests, no build.

## Repo Map
```
Root docs:
  README.md                    — public-facing overview + install commands
  AGENT-INSTRUCTIONS-INDEX.md  — full file index across all frameworks
  MULTI-AGENT-SUPPORT.md       — agent compatibility matrix + config files
  WORKFLOW-GUIDE.md            — ticketing integration vs manual tickets
  INSTALLATION-REFERENCE.md    — what install.sh creates, verify commands
  MIGRATION-TEMPLATE.md        — guide to replicate Rails structure to other frameworks
  docs/AGENT-COMPATIBILITY.md  — per-agent setup details + uninstall steps
  tool-adapters/               — root-level generic adapter docs (5 files)

8 Framework dirs (identical structure except Rails):
  agent-instructions-rails/       ← ADVANCED: 4-category subfolder structure
  agent-instructions-springboot/  ← STANDARD: flat agent/ files
  agent-instructions-django/      ← STANDARD
  agent-instructions-express/     ← STANDARD
  agent-instructions-react/       ← STANDARD
  agent-instructions-python-lib/  ← STANDARD
  agent-instructions-node-lib/    ← STANDARD
  agent-instructions-ruby-gem/    ← STANDARD
```

## Framework Directory Structures

### STANDARD (7 frameworks — springboot, django, express, react, python-lib, node-lib, ruby-gem)
```
agent-instructions-{fw}/
├── README.md, LICENSE, install.sh
├── agent/
│   ├── master-instructions.md         — main entry point
│   ├── principles-and-standards.md    — coding conventions
│   ├── planner-instructions.md        — planning rules
│   ├── execution-contract.md          — execution discipline
│   ├── implementer-instructions.md    — implementation patterns
│   ├── testing-instructions.md        — verification commands
│   ├── ticket-access.md              — ticket fetching
│   └── examples/sample-ticket-plan.md
└── tool-adapters/
    ├── claude.md, copilot.md, cursor.md, windsurf.md
    ├── cline.md, codex.md, chatgpt.md
```

### ADVANCED (Rails only — target structure for all frameworks)
```
agent-instructions-rails/
├── README.md, LICENSE, install.sh, quick-install.sh
├── agent/
│   ├── master-instructions.md         — compact index + context flow
│   ├── architecture/                  — system-design, database, api-design,
│   │                                    patterns, error-handling, data-flow, glossary
│   ├── infrastructure/                — environment, dependencies, tooling,
│   │                                    deployment, security
│   ├── workflow/                      — context-router, planning, execution,
│   │                                    implementation, testing, maintenance,
│   │                                    ticket-access, ticketing-systems, prompts
│   ├── features/                      — _TEMPLATE, _CONVENTIONS, per-feature docs
│   └── examples/sample-ticket-plan.md
└── tool-adapters/ (same 7 files)
```

## Supported Agents (7)
| Agent | Config File | Notes |
|-------|-------------|-------|
| Claude Code | `CLAUDE.md` | Auto-read from root |
| GitHub Copilot | `.github/copilot-instructions.md` + `.vscode/settings.json` | Auto-read; install enables Use Instruction Files |
| Cursor | `.cursorrules` | Auto-read |
| Windsurf | `.windsurfrules` | Auto-read |
| Cline | `.clinerules` | Auto-read |
| Codex CLI | `AGENTS.md` | Auto-read |
| ChatGPT | manual paste | No config file |

## install.sh Pattern (all 8 frameworks)
Each install.sh:
1. Copies `agent/` files to target project
2. Creates `docs/`, `tickets/`, `agent-config.md`
3. Writes unified AGENT_INSTRUCTIONS block to all 6 config files
4. Uses `append_block_if_missing()` to avoid duplicates
5. Runs `ensure_vscode_copilot_settings()` → creates `.vscode/settings.json`
6. Shows post-install message with next steps

Key variable: `AGENT_INSTRUCTIONS` — single block written to all config files.

## Content Format Conventions
- **Tags/Scope/Last-updated** headers on every file
- Bullet-point dense, self-contained per file
- Code examples inline (CORRECT/WRONG pattern)
- Tables for mappings (status codes, task→files, etc.)
- Changelog section at bottom of architecture/infrastructure files

## Task Routing — What to Read for Each Task Type

### Modify a single framework's instructions
```
READ: agent-instructions-{fw}/agent/master-instructions.md
READ: The specific file being changed
SKIP: Other frameworks, root docs
```

### Add a new framework
```
READ: Any STANDARD framework dir as template (e.g. agent-instructions-express/)
READ: MULTI-AGENT-SUPPORT.md — agent config patterns
READ: INSTALLATION-REFERENCE.md — what install.sh must create
COPY: Entire STANDARD structure, adapt content
UPDATE: README.md — add to framework list
UPDATE: AGENT-INSTRUCTIONS-INDEX.md — add file index
```

### Update install.sh across all frameworks
```
READ: Any one install.sh fully (e.g. agent-instructions-rails/install.sh)
PATTERN: All 8 install.sh follow identical structure
CHANGE: Apply same edit to all 8 files
VERIFY: Check AGENT_INSTRUCTIONS var, append_block_if_missing calls
```

### Add support for a new AI agent
```
READ: MULTI-AGENT-SUPPORT.md — current matrix
READ: Any one install.sh — see AGENT_INSTRUCTIONS + config file writes
CHANGE: Add new config file write to all 8 install.sh
CHANGE: Add tool-adapters/{agent}.md to all 8 frameworks
UPDATE: MULTI-AGENT-SUPPORT.md — add to matrix
```

### Replicate Rails advanced structure to another framework
```
READ: agent-instructions-rails/agent/ — full 4-category structure
READ: agent-instructions-{target}/agent/ — current flat structure
MAP: flat files → category folders:
  principles-and-standards.md  → architecture/patterns.md
  planner-instructions.md      → workflow/planning.md
  execution-contract.md        → workflow/execution.md
  implementer-instructions.md  → workflow/implementation.md
  testing-instructions.md      → workflow/testing.md
  ticket-access.md             → workflow/ticket-access.md
CREATE: New category files (system-design, database, api-design, etc.)
DELETE: Old flat files after migration
```

### Update root documentation
```
READ: The specific root .md being changed
CROSS-CHECK: Other root docs for consistency
  README.md ↔ AGENT-INSTRUCTIONS-INDEX.md ↔ INSTALLATION-REFERENCE.md
```

## Quality Checklist
- [ ] All 8 frameworks stay in sync for structural changes
- [ ] install.sh uses correct framework name (not copy-paste "ruby-gem")
- [ ] AGENT_INSTRUCTIONS block is framework-specific
- [ ] tool-adapters/ has all 7 agent files per framework
- [ ] Root docs reflect current state of all frameworks
