# Coding Agent Instructions — Framework Collection

Drop-in, tool-agnostic instruction systems for using coding agents safely across different frameworks and languages.

## 📦 Available Frameworks

### Backend Frameworks
- **[agent-instructions-rails](agent-instructions-rails/)** - Ruby on Rails API development
- **[agent-instructions-springboot](agent-instructions-springboot/)** - Spring Boot Java applications
- **[agent-instructions-django](agent-instructions-django/)** - Django Python web framework
- **[agent-instructions-express](agent-instructions-express/)** - Express.js Node.js applications

### Frontend Frameworks
- **[agent-instructions-react](agent-instructions-react/)** - React applications

### Libraries/Packages
- **[agent-instructions-python-lib](agent-instructions-python-lib/)** - Python library/package development
- **[agent-instructions-node-lib](agent-instructions-node-lib/)** - Node.js library/package development
- **[agent-instructions-ruby-gem](agent-instructions-ruby-gem/)** - Ruby gem development

## 🎯 What This Is

A collection of reusable instruction files that enforce:
- **Plan-first execution** - Planning and code generation are separate
- **Phase isolation** - Execute one small phase at a time
- **Human review** - Hard stop after each phase for approval
- **Verification** - Tests/lint/build checks are mandatory

Works with **all 7 major AI coding agents** — one install command creates config files for all of them:

| Agent | Config File | Auto-Read |
|-------|-------------|:---------:|
| Claude Code | `CLAUDE.md` | Yes |
| GitHub Copilot | `.github/copilot-instructions.md` | Yes |
| Cursor | `.cursorrules` | Yes |
| Windsurf | `.windsurfrules` | Yes |
| Cline | `.clinerules` | Yes |
| OpenAI Codex CLI | `AGENTS.md` | Yes |
| ChatGPT | _(manual paste)_ | No |

See [MULTI-AGENT-SUPPORT.md](MULTI-AGENT-SUPPORT.md) for the full compatibility and capability matrix.

## 🚫 What This Is NOT

- Not an agent framework or library
- Not a replacement for engineering judgment
- Not autonomous - humans remain accountable

## 🚀 Quick Start

### 1. Choose Your Framework
Pick the directory matching your project type from the list above.

### 2. Install

**One command** from your project root — creates `agent/` instructions + config files for all 7 supported agents:

```bash
# Rails
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-rails/install.sh | bash -s .

# Spring Boot
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-springboot/install.sh | bash -s .

# Django
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-django/install.sh | bash -s .

# Express.js
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-express/install.sh | bash -s .

# React
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-react/install.sh | bash -s .

# Python Library
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-python-lib/install.sh | bash -s .

# Node.js Library
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-node-lib/install.sh | bash -s .

# Ruby Gem
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-ruby-gem/install.sh | bash -s .
```

Or clone and run locally:
```bash
git clone https://github.com/rvk0106/coding-agent-instructions.git
cd coding-agent-instructions/agent-instructions-rails  # or your framework
./install.sh /path/to/your/project
```

### 3. Enable Your Agent

The install script auto-creates config files for all 7 agents. Most need **zero extra setup**:

| Agent | Config file (created by install) | What you do |
|-------|----------------------------------|-------------|
| **Claude Code** | `CLAUDE.md` | Nothing. Run `claude` in your project — it reads `CLAUDE.md` automatically. |
| **GitHub Copilot** | `.github/copilot-instructions.md` + `.vscode/settings.json` | **Nothing.** The installer enables **Use Instruction Files** for this workspace via `.vscode/settings.json`. On GitHub.com, repo instructions are used by default. |
| **Cursor** | `.cursorrules` | Nothing. Open the project in Cursor — it reads `.cursorrules` automatically. |
| **Windsurf** | `.windsurfrules` | Nothing. Open the project in Windsurf — it reads `.windsurfrules` automatically. |
| **Cline** | `.clinerules` | Nothing. Open the project with the Cline extension — it reads `.clinerules` automatically. |
| **Codex CLI** | `AGENTS.md` | Nothing. Run `codex` in your project — it reads `AGENTS.md` automatically. |
| **ChatGPT** | _(no file)_ | **Manual:** Paste `agent/master-instructions.md` into your conversation or Custom Instructions. |

**Verify it works:** Ask your agent *"What are your instructions for planning and executing work?"* — it should describe plan-first, phase-by-phase execution.

> **Multiple agents, same project**: All config files are created together, so different team members can use different agents on the same codebase. Everyone gets the same instructions.

For the full capability matrix and uninstall steps, see [MULTI-AGENT-SUPPORT.md](MULTI-AGENT-SUPPORT.md) and [docs/AGENT-COMPATIBILITY.md](docs/AGENT-COMPATIBILITY.md).

### 4. Connect to Ticketing (optional)

```bash
# Option A: Ticketing integration (Linear, Jira, GitHub Issues)
# Edit agent-config.md and configure your system

# Option B: Manual tickets (works offline, no setup)
# Create ticket files in tickets/TICKET-ID.md
# Use the template: tickets/_TEMPLATE.md
```

See [WORKFLOW-GUIDE.md](WORKFLOW-GUIDE.md) for detailed setup of both options.

### 5. Start Working
```bash
# Plan
"plan architecture for TICKET-ID"
# Output: docs/TICKET-ID-plan.md → review and approve

# Execute one phase at a time
"execute plan 1 for TICKET-ID"

# Verify
Run the verification commands specified in the plan

# Review and approve, then continue
"execute plan 2 for TICKET-ID"
```

## 📋 Workflow

All frameworks follow the same workflow:
1. **Connect** → Ticketing system (Linear/Jira via MCP or API token)
2. **Plan** → Fetch ticket and create phase-based plan in `docs/TICKET-ID-plan.md`
3. **Execute Phase N** → Read from `docs/TICKET-ID-plan.md` and implement only that phase
4. **Verify** → Run tests/lint/build checks specified in the phase
5. **Stop** → Wait for human review and approval
6. **Repeat** → Continue to Phase N+1 after approval

## 🧩 Repository Structure

### Standard Structure (7 frameworks)
Used by: Spring Boot, Django, Express, React, Python-Lib, Node-Lib, Ruby-Gem
```
agent-instructions-{framework}/
├── README.md, install.sh, LICENSE
├── agent/
│   ├── master-instructions.md        # Main entry point
│   ├── principles-and-standards.md   # Coding conventions
│   ├── planner-instructions.md       # Planning rules
│   ├── execution-contract.md         # Execution discipline
│   ├── implementer-instructions.md   # Implementation patterns
│   ├── testing-instructions.md       # Verification commands
│   ├── ticket-access.md              # Ticket fetching
│   └── examples/sample-ticket-plan.md
└── tool-adapters/                    # Per-agent setup guides
    ├── claude.md, copilot.md, cursor.md, windsurf.md
    ├── cline.md, codex.md, chatgpt.md
```

### Advanced Structure (Rails — target for all frameworks)
Organized into 4 knowledge categories for minimal token usage:
```
agent-instructions-rails/
├── README.md, install.sh, LICENSE
├── agent/
│   ├── master-instructions.md        # Compact index + context router
│   ├── architecture/                 # System design, DB, API, patterns,
│   │                                   error handling, data flow, glossary
│   ├── infrastructure/               # Environment, dependencies, tooling,
│   │                                   deployment, security
│   ├── workflow/                     # Context router, planning, execution,
│   │                                   implementation, testing, maintenance,
│   │                                   ticket access, pre-built prompts
│   ├── features/                     # Template, conventions, per-feature docs
│   └── examples/sample-ticket-plan.md
└── tool-adapters/                    # Per-agent setup guides (same 7 files)
```

> See [MIGRATION-TEMPLATE.md](MIGRATION-TEMPLATE.md) for how to migrate any framework from Standard to Advanced structure.

## 🌟 Key Principles

- **Agents are collaborators**, not autonomous engineers
- **Plan first** - Planning and execution are separate phases
- **Small, verifiable steps** - Each phase is atomic and independently testable
- **Hard stop after each phase** - No auto-continue without human approval
- **Verification required** - Tests/lint/build checks are mandatory
- **Humans remain accountable** - Humans approve plans, review code, and merge

## 🛠️ Framework-Specific Features

### Rails
- Controllers thin, business logic in services
- Strong parameters, consistent API responses
- RSpec tests, RuboCop compliance
- Swagger/OpenAPI documentation

### Spring Boot
- Controller → Service → Repository layering
- DTOs for requests/responses
- JUnit + Mockito testing
- OpenAPI/Swagger support

### Django
- MVT pattern with DRF
- Serializer validation
- Django ORM best practices
- pytest or Django TestCase

### Express.js
- Route → Controller → Service layering
- Middleware for cross-cutting concerns
- Jest/Mocha + Supertest testing
- Input validation (joi, express-validator)

### React
- Functional components with hooks
- TypeScript for type safety
- React Testing Library
- Accessibility and responsive design

### Python/Node/Ruby Libraries
- Semantic versioning
- Public API documentation
- High test coverage
- Backward compatibility

## 📄 License

All frameworks are licensed under the **GNU General Public License v3.0**.

This means you are free to:
- Use for any purpose
- Modify to suit your needs
- Share with others
- Share your changes

Under the condition that:
- Derivative works must also be GPL-3.0
- Source code must be available when distributing

## 🤝 Contributing

Contributions are welcome!
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 💬 Support

- Issues: [GitHub Issues](https://github.com/rvk0106/coding-agent-instructions/issues)
- Discussions: [GitHub Discussions](https://github.com/rvk0106/coding-agent-instructions/discussions)

## 🔗 Direct Links to Frameworks

- [Rails](./agent-instructions-rails/)
- [Spring Boot](./agent-instructions-springboot/)
- [Django](./agent-instructions-django/)
- [Express.js](./agent-instructions-express/)
- [React](./agent-instructions-react/)
- [Python Library](./agent-instructions-python-lib/)
- [Node.js Library](./agent-instructions-node-lib/)
- [Ruby Gem](./agent-instructions-ruby-gem/)

---

**Made with ❤️ for better human-agent collaboration**
