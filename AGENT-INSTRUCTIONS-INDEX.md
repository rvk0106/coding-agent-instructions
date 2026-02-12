# Agent Instructions — Framework Collection

Drop-in, tool-agnostic instruction systems for using coding agents safely across different frameworks and languages.

## 📦 Available Frameworks

### Backend Frameworks
- **[agent-instructions-rails-api](agent-instructions-rails-api/)** - Ruby on Rails API development
- **[agent-instructions-springboot](agent-instructions-springboot/)** - Spring Boot Java applications
- **[agent-instructions-django](agent-instructions-django/)** - Django Python web framework
- **[agent-instructions-express](agent-instructions-express/)** - Express.js Node.js applications

### Frontend Frameworks
- **[agent-instructions-react](agent-instructions-react/)** - React applications

### Libraries/Packages
- **[agent-instructions-python-lib](agent-instructions-python-lib/)** - Python library/package development
- **[agent-instructions-node-lib](agent-instructions-node-lib/)** - Node.js library/package development
- **[agent-instructions-ruby-gem](agent-instructions-ruby-gem/)** - Ruby gem development
- **[agent-instructions-java-lib](agent-instructions-java-lib/)** - Java library development

## 🎯 What This Is

A collection of reusable instruction files that enforce:
- **Plan-first execution** - Planning and code generation are separate
- **Phase isolation** - Execute one small phase at a time
- **Human review** - Hard stop after each phase for approval
- **Verification** - Tests/lint/build checks are mandatory

Works with all major AI coding agents: **Claude Code, GitHub Copilot, Cursor, Windsurf, Cline, OpenAI Codex CLI, and ChatGPT**. See [MULTI-AGENT-SUPPORT.md](MULTI-AGENT-SUPPORT.md) for the full compatibility matrix.

## 🚫 What This Is NOT

- Not an agent framework or library
- Not a replacement for engineering judgment
- Not autonomous - humans remain accountable

## 🚀 Quick Start

### 1. Choose Your Framework
Pick the repository matching your project type from the list above.

### 2. Install
From your project root:
```bash
# Rails API example
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-rails-api/main/quick-install.sh | bash

# Spring Boot example
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-springboot/main/quick-install.sh | bash

# React example
curl -fsSL https://raw.githubusercontent.com/rvk0106/agent-instructions-react/main/quick-install.sh | bash
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

### Advanced Structure (all 9 frameworks)

All frameworks use the advanced 4-category subfolder structure:

#### Backend API Frameworks (rails-api, springboot, django, express)
```
agent-instructions-{framework}/
├── README.md, LICENSE, install.sh
├── agent/
│   ├── master-instructions.md         # Compact index + context flow
│   ├── architecture/                  # system-design, database, api-design, patterns,
│   │                                  #   error-handling, data-flow, glossary
│   ├── infrastructure/                # environment, dependencies, tooling,
│   │                                  #   deployment, security
│   ├── workflow/                      # context-router, planning, execution,
│   │                                  #   implementation, testing, maintenance, reviewer,
│   │                                  #   ticket-access, ticketing-systems, prompts,
│   │                                  #   initialise, context-retrieval
│   ├── features/                      # _TEMPLATE, _CONVENTIONS, per-feature docs
│   └── examples/sample-ticket-plan.md # Example plan
└── tool-adapters/ (same 7 files)
```

#### Frontend Framework (react — UI-oriented)
```
agent-instructions-react/
├── README.md, LICENSE, install.sh
├── agent/
│   ├── master-instructions.md         # Compact index + context flow (UI-oriented)
│   ├── architecture/                  # system-design, component-design,
│   │                                  #   state-management, styling, patterns,
│   │                                  #   error-handling, data-flow, accessibility, glossary
│   ├── infrastructure/                # environment, dependencies, tooling,
│   │                                  #   deployment, security
│   ├── workflow/                      # (same as backend)
│   ├── features/                      # _TEMPLATE, _CONVENTIONS (UI-specific)
│   └── examples/sample-ticket-plan.md
└── tool-adapters/ (same 7 files)
```

#### Library Frameworks (ruby-gem, python-lib, node-lib, java-lib)
```
agent-instructions-{framework}/
├── README.md, LICENSE, install.sh
├── agent/
│   ├── master-instructions.md         # Compact index + context flow
│   ├── architecture/                  # system-design, public-api, patterns,
│   │                                  #   error-handling, data-flow, glossary
│   ├── infrastructure/                # environment, dependencies, tooling,
│   │                                  #   publishing, security
│   ├── workflow/                      # (same as backend)
│   ├── features/                      # _TEMPLATE, _CONVENTIONS
│   └── examples/sample-ticket-plan.md
└── tool-adapters/ (same 7 files)
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

### Python/Node/Ruby/Java Libraries
- Semantic versioning
- Public API documentation
- High test coverage
- Backward compatibility

## 📄 License

All repositories are licensed under the **GNU General Public License v3.0**.

This means you are free to:
- Use for any purpose
- Modify to suit your needs
- Share with others
- Share your changes

Under the condition that:
- Derivative works must also be GPL-3.0
- Source code must be available when distributing

## 🤝 Contributing

Contributions are welcome! For each repository:
1. Fork the specific framework repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 💬 Support

- General issues: This repository
- Framework-specific issues: Individual framework repositories
- Feature requests: Open an issue in the relevant repository

## 🔗 Links

- [Rails API](https://github.com/rvk0106/agent-instructions-rails-api)
- [Spring Boot](https://github.com/rvk0106/agent-instructions-springboot)
- [Django](https://github.com/rvk0106/agent-instructions-django)
- [Express.js](https://github.com/rvk0106/agent-instructions-express)
- [React](https://github.com/rvk0106/agent-instructions-react)
- [Python Library](https://github.com/rvk0106/agent-instructions-python-lib)
- [Node.js Library](https://github.com/rvk0106/agent-instructions-node-lib)
- [Ruby Gem](https://github.com/rvk0106/agent-instructions-ruby-gem)
- [Java Library](https://github.com/rvk0106/agent-instructions-java-lib)

---

**Replace `rvk0106` with your GitHub organization/username when publishing.**
