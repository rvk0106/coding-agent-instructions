# Agent Instructions — Rails

A drop-in, tool-agnostic instruction system for using coding agents safely with Rails.

## What this is
- A set of reusable instruction files that enforce plan-first execution, phase isolation, and human review.
- Works with Claude Code, GitHub Copilot, Cursor, Windsurf, Cline, Codex CLI, and ChatGPT.

## What this is not
- Not an agent framework or library.
- Not a replacement for engineering judgment.

## Installation

### Method 1: Quick install (recommended)
From your Rails project root:
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-rails/main/quick-install.sh | bash
```

### Method 2: Specify custom directory
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-rails/main/quick-install.sh | bash -s /path/to/your/rails/project
```

### Method 3: Clone and install
```bash
# Clone the repository
git clone https://github.com/rvk0106/agent-instructions-rails.git /tmp/agent-instructions-rails

# Run installer from your Rails project root
cd /path/to/your/rails/project
/tmp/agent-instructions-rails/install.sh .

# Clean up
rm -rf /tmp/agent-instructions-rails
```

### Method 4: Download as archive
```bash
wget https://github.com/rvk0106/agent-instructions-rails/archive/refs/heads/main.tar.gz
tar -xzf main.tar.gz
cd agent-instructions-rails-main
./install.sh /path/to/your/rails/project
```

## Quick start
1) Install (see above methods)
2) Set up your workflow:
   - Create `agent-config.md` in your project root
   - Choose your ticket source:
     - **Option A**: Configure ticketing integration (Linear, Jira, GitHub Issues)
     - **Option B**: Create `tickets/` folder and add `TICKET-ID.md` files manually
3) Start planning:
   - Command: `plan architecture for TICKET-ID`
   - Output: `docs/TICKET-ID-plan.md`
4) Execute one phase at a time:
   - Command: `execute plan 1 for TICKET-ID`
   - Agent reads from `docs/TICKET-ID-plan.md`
5) Verify, review, and approve before continuing.

## Configuration

### agent-config.md Template
Create this file in your project root:

```markdown
# Agent Configuration

## Ticketing System
System: [Linear|Jira|GitHub Issues|Manual]
API Token Location: [ENV variable or leave empty for manual]
Project/Team ID: [your-project-id or N/A]

## Connection Method
Preferred: [MCP|Direct API|Manual]
Fallback: Manual

## Ticket Source
- If using API/MCP: Agent will fetch tickets automatically
- If using Manual: Create tickets/ folder and add TICKET-ID.md files
```

### Manual Ticket Management
If you prefer not to integrate with a ticketing system:

1. Create a `tickets/` folder in your project root
2. For each ticket, create `tickets/TICKET-ID.md` with this format:

```markdown
# [TICKET-ID] Ticket Title

## Description
[Detailed description]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Constraints
- Constraint 1

## Technical Notes
[Any technical details]
```

## Repository layout
```
agent-instructions-rails/
├── README.md
├── install.sh, quick-install.sh
├── LICENSE
├── agent/
│   ├── master-instructions.md          # Entry point — routes via context-router
│   ├── architecture/                   # Technical design (pre-indexed)
│   │   ├── system-design.md           # Components, data flows, tenancy
│   │   ├── database.md               # Schema, tables, relationships
│   │   ├── api-design.md             # Endpoints, response shapes, versioning
│   │   ├── patterns.md               # Design patterns, conventions, standards
│   │   ├── error-handling.md          # HTTP codes, error shapes, exception mapping
│   │   ├── data-flow.md              # Request lifecycle, middleware, auth pipeline
│   │   ├── caching.md                # Cache layers, invalidation, patterns
│   │   └── glossary.md               # Domain terms, roles, statuses
│   ├── infrastructure/                 # Environment & setup knowledge
│   │   ├── environment.md             # Runtime, versions, DB, env vars
│   │   ├── dependencies.md            # Gems, external services, APIs
│   │   ├── tooling.md                 # Linters, test commands, CI/CD
│   │   ├── deployment.md              # Hosting, deploy process
│   │   ├── security.md                # Auth, tenant scoping, OWASP, headers
│   │   └── logging.md                 # Structured logging, error tracking
│   ├── workflow/                       # How we work
│   │   ├── context-router.md          # READ FIRST: task type → required files
│   │   ├── planning.md               # How to create phased plans
│   │   ├── execution.md              # How to execute a single phase
│   │   ├── implementation.md         # Coding conventions, file locations
│   │   ├── testing.md                # Verification commands
│   │   ├── ticket-access.md          # How to fetch tickets
│   │   ├── ticketing-systems.md      # curl/jq helpers for Linear/Jira/GitHub
│   │   ├── maintenance.md            # What to update after tickets
│   │   └── prompts.md                # Pre-built prompts for common tasks
│   ├── features/                       # How features work
│   │   ├── _TEMPLATE.md              # Copy for new features
│   │   ├── _CONVENTIONS.md           # Serialization, query, test patterns
│   │   └── (one file per feature)
│   └── examples/
│       └── sample-ticket-plan.md
└── tool-adapters/
    ├── claude.md, copilot.md, cursor.md
    ├── windsurf.md, cline.md, codex.md
    └── chatgpt.md
```

## Instruction Categories

| Category | Purpose | Update Trigger |
|----------|---------|----------------|
| **infrastructure/** | Environment, deps, tooling, deploy | Infra changes (tag with ticket ID) |
| **workflow/** | Planning, execution, testing process | Process changes |
| **architecture/** | System design, DB, API, patterns | Design changes (tag with ticket ID) |
| **features/** | How each feature works now | Feature behavior changes (no ticket IDs) |

## Recommended loop
1) **Connect** → to ticketing system (Linear/Jira via MCP or API token)
2) **Plan** → fetch ticket and create phase-based plan in `docs/TICKET-ID-plan.md`
3) **Execute Phase N** → read from `docs/TICKET-ID-plan.md` and implement only that phase
4) **Verify** → run tests/lint/contract checks specified in the phase
5) **Stop** → wait for human review and approval
6) **Repeat** → continue to Phase N+1 after approval

## Uninstall
To remove agent instructions from your project:
```bash
# Remove the agent directory
rm -rf agent/

# Remove markers from tool config files
# Manually edit these files and remove blocks between:
# >>> agent-instructions-rails
# <<< agent-instructions-rails
# Files: .github/copilot-instructions.md, .cursorrules, CLAUDE.md,
# .windsurfrules, .clinerules, AGENTS.md
```

## Contributing
Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

This means you are free to:
- Use this software for any purpose
- Change the software to suit your needs
- Share the software with others
- Share the changes you make

Under the condition that:
- Any modifications or derivative works must also be licensed under GPL-3.0
- Source code must be made available when distributing the software

## Notes
- Human review and approval are non-negotiable.
- If any referenced instruction files are unavailable, the agent must request them from the user.
- Plans are saved to `docs/` folder - commit them to version control for team visibility.

## Support
Issues and feature requests: [GitHub Issues](https://github.com/rvk0106/agent-instructions-rails/issues)
