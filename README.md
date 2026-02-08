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

Works with all major AI coding agents: **Claude Code, GitHub Copilot, Cursor, Windsurf, Cline, OpenAI Codex CLI, and ChatGPT**. See [MULTI-AGENT-SUPPORT.md](MULTI-AGENT-SUPPORT.md) for the full compatibility matrix.

## 🤖 How to Enable for Each Agent

After you run **Step 2 (Install)** above, the installer creates the right config file for each agent. Here is what each tool uses and what you need to do.

| Agent | Config file (created by install) | What you do to enable |
|-------|-----------------------------------|------------------------|
| **Cursor** | `.cursorrules` and `.cursor/rules/agent-instructions.mdc` | Nothing. Open the project in Cursor; it reads these automatically. |
| **GitHub Copilot** | `.github/copilot-instructions.md` | **VS Code:** Settings → search "instruction file" → enable **Code Generation: Use Instruction Files**. **GitHub.com:** repo instructions are used by default when the repo is attached to Copilot Chat. |
| **Claude Code** | `CLAUDE.md` | Nothing. Start Claude Code in this project; it loads `CLAUDE.md` from the repo root automatically. |
| **Windsurf (Codeium)** | `.windsurfrules` | Nothing. Open the project in Windsurf; it reads `.windsurfrules` from the project root automatically. |
| **Cline** | `.clinerules` | Nothing. Open the project in Cline; it reads `.clinerules` from the project root automatically. |
| **OpenAI Codex CLI** | `AGENTS.md` | Nothing. Run the Codex CLI in this project; it uses `AGENTS.md` as agent instructions automatically. |
| **ChatGPT** | _(no file)_ | **Manual:** Copy the contents of `agent/master-instructions.md` and paste into the system prompt or first message. Or tell the agent to follow `AGENTS.md` and the `agent/` folder if you have the project in context. |

### Quick checklist

1. **Run the install** for your framework (see [Quick Start](#-quick-start) above).
2. **Pick your agent** in the table above — for Cursor, Copilot, Claude Code, Windsurf, Cline, or Codex CLI you don’t need to do anything else; the right file is already there.
3. **Verify:** In your agent, ask: *“What are your instructions for planning and executing work?”* — it should describe plan-first, phase-by-phase execution and reading from `docs/TICKET-ID-plan.md`.
4. **ChatGPT only:** Paste `agent/master-instructions.md` (or point to `AGENTS.md` + `agent/`) at the start of the conversation.

For more detail (what gets created, capability matrix, multi-agent teams), see [MULTI-AGENT-SUPPORT.md](MULTI-AGENT-SUPPORT.md).

## 🚫 What This Is NOT

- Not an agent framework or library
- Not a replacement for engineering judgment
- Not autonomous - humans remain accountable

## 🚀 Quick Start

### 1. Choose Your Framework
Pick the directory matching your project type from the list above.

### 2. Install
From your project root:

#### Backend Frameworks
```bash
# Rails
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-rails/install.sh | bash -s .

# Spring Boot
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-springboot/install.sh | bash -s .

# Django
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-django/install.sh | bash -s .

# Express.js
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-express/install.sh | bash -s .
```

#### Frontend Frameworks
```bash
# React
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-react/install.sh | bash -s .
```

#### Libraries/Packages
```bash
# Python Library
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-python-lib/install.sh | bash -s .

# Node.js Library
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-node-lib/install.sh | bash -s .

# Ruby Gem
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-ruby-gem/install.sh | bash -s .
```

Or clone the entire repository and run install script:
```bash
git clone https://github.com/rvk0106/coding-agent-instructions.git
cd coding-agent-instructions/agent-instructions-rails  # or your framework
./install.sh /path/to/your/project
```

### 3. Connect to Ticketing
```bash
export LINEAR_API_TOKEN="your_token"
# Or configure MCP server
```

### 4. Start Working
```bash
# Plan
"plan architecture for TICKET-ID"
# Output: docs/TICKET-ID-plan.md

# Execute one phase
"execute plan 1 for TICKET-ID"

# Verify
Run the verification commands specified in the plan

# Review and approve
Wait for human review before continuing to next phase
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

Each framework directory contains:
```
agent-instructions-{framework}/
├── README.md                    # Framework-specific documentation
├── install.sh                   # Installation script
├── LICENSE                      # GNU GPL v3.0
├── agent/
│   ├── master-instructions.md        # Main entry point
│   ├── principles-and-standards.md   # Framework conventions
│   ├── ticket-access.md              # How to fetch tickets
│   ├── planner-instructions.md       # Planning workflow
│   ├── execution-contract.md         # Execution rules
│   ├── implementer-instructions.md   # Coding conventions
│   ├── testing-instructions.md       # Verification steps
│   └── examples/
│       └── sample-ticket-plan.md     # Example plan
└── tool-adapters/
    ├── claude.md                     # Claude Code setup
    ├── copilot.md                    # GitHub Copilot setup
    ├── cursor.md                     # Cursor setup
    ├── windsurf.md                   # Windsurf setup
    ├── cline.md                      # Cline setup
    ├── codex.md                      # OpenAI Codex CLI setup
    └── chatgpt.md                    # ChatGPT setup
```

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
