# Agent Instructions — Meta-Repo Shorthand

## What This Repo Is
Template collection: 9 framework-specific agent instruction sets that get installed into target projects via `install.sh`. NOT an application — no runtime, no tests, no build.

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

9 Framework dirs (all ADVANCED 4-category subfolder structure):
  agent-instructions-rails-api/    ← ADVANCED: backend API (Ruby/Rails)
  agent-instructions-springboot/   ← ADVANCED: backend API (Java/Spring)
  agent-instructions-django/       ← ADVANCED: backend API (Python/Django)
  agent-instructions-express/      ← ADVANCED: backend API (Node.js/Express)
  agent-instructions-react/        ← ADVANCED: frontend (React, UI-oriented)
  agent-instructions-ruby-gem/     ← ADVANCED: library (Ruby/RubyGems)
  agent-instructions-python-lib/   ← ADVANCED: library (Python/PyPI)
  agent-instructions-node-lib/     ← ADVANCED: library (Node.js/npm)
  agent-instructions-java-lib/     ← ADVANCED: library (Java/Maven Central)
```

## Framework Directory Structures

All 9 frameworks use the ADVANCED 4-category subfolder structure:

### Backend API Frameworks (Rails, Spring Boot, Django, Express)
```
agent-instructions-{fw}/
├── README.md, LICENSE, install.sh
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

### Frontend Framework (React — UI-oriented)
```
agent-instructions-react/
├── README.md, LICENSE, install.sh
├── agent/
│   ├── master-instructions.md         — compact index + context flow (UI-oriented)
│   ├── architecture/                  — system-design, component-design,
│   │                                    state-management, styling, patterns,
│   │                                    error-handling, data-flow, accessibility, glossary
│   ├── infrastructure/                — environment, dependencies, tooling,
│   │                                    deployment, security
│   ├── workflow/                      — context-router, planning, execution,
│   │                                    implementation, testing, maintenance,
│   │                                    ticket-access, ticketing-systems, prompts
│   ├── features/                      — _TEMPLATE, _CONVENTIONS, per-feature docs
│   └── examples/sample-ticket-plan.md
└── tool-adapters/ (same 7 files)
```

### Library Frameworks (Ruby Gem, Python Lib, Node Lib, Java Lib)
```
agent-instructions-{fw}/
├── README.md, LICENSE, install.sh
├── agent/
│   ├── master-instructions.md         — compact index + context flow
│   ├── architecture/                  — system-design, public-api, patterns,
│   │                                    error-handling, data-flow, glossary
│   ├── infrastructure/                — environment, dependencies, tooling,
│   │                                    publishing, security
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

## install.sh Pattern (all 9 frameworks)
Each install.sh:
1. Copies `agent/` files to target project (architecture/, infrastructure/, workflow/, features/, examples/)
2. Creates `docs/`, `tickets/`, `agent-config.md`
3. Creates `agent/fetch-ticket.sh` utility (safe config parsing, no eval)
4. Creates `tickets/_TEMPLATE.md`
5. Writes unified AGENT_INSTRUCTIONS block to all 6 config files
6. Uses `append_block_if_missing()` to avoid duplicates
7. Runs `ensure_vscode_copilot_settings()` → creates `.vscode/settings.json`
8. Verifies installation (checks subdirectories exist)

Key variable: `AGENT_INSTRUCTIONS` — single block written to all config files, references `workflow/` paths.

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
READ: Any ADVANCED framework dir as template (e.g. agent-instructions-express/)
READ: MULTI-AGENT-SUPPORT.md — agent config patterns
READ: INSTALLATION-REFERENCE.md — what install.sh must create
COPY: Entire ADVANCED structure, adapt content
UPDATE: README.md — add to framework list
UPDATE: AGENT-INSTRUCTIONS-INDEX.md — add file index
UPDATE: CLAUDE.md — add to framework list
```

### Update install.sh across all frameworks
```
READ: Any one install.sh fully (e.g. agent-instructions-rails-api/install.sh)
PATTERN: All 9 install.sh follow identical structure
CHANGE: Apply same edit to all 9 files
VERIFY: Check AGENT_INSTRUCTIONS var, append_block_if_missing calls
```

### Add support for a new AI agent
```
READ: MULTI-AGENT-SUPPORT.md — current matrix
READ: Any one install.sh — see AGENT_INSTRUCTIONS + config file writes
CHANGE: Add new config file write to all 9 install.sh
CHANGE: Add tool-adapters/{agent}.md to all 9 frameworks
UPDATE: MULTI-AGENT-SUPPORT.md — add to matrix
```

### Update root documentation
```
READ: The specific root .md being changed
CROSS-CHECK: Other root docs for consistency
  README.md ↔ AGENT-INSTRUCTIONS-INDEX.md ↔ INSTALLATION-REFERENCE.md
```

## Quality Checklist
- [ ] All 9 frameworks stay in sync for structural changes
- [ ] install.sh uses correct framework name (not copy-paste errors)
- [ ] AGENT_INSTRUCTIONS block is framework-specific
- [ ] tool-adapters/ has all 7 agent files per framework
- [ ] Root docs reflect current state of all frameworks
