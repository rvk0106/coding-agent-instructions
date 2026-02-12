# Agent Instructions — Java Library

Drop-in, tool-agnostic instruction system for Java library development.

## What This Is

A set of structured instruction files that any AI coding agent can read to understand your Java library project, follow consistent workflows, and produce high-quality code. The instructions cover architecture, infrastructure, workflow, and feature documentation — all tailored for Java library development with Maven/Gradle, JUnit 5, and Maven Central publishing.

## Quick Start

```bash
# Install into your Java library project
./install.sh /path/to/your-java-lib
```

1. Set up your workflow:
   - Create `agent-config.md` in your project root
   - Choose: Ticketing integration OR manual `tickets/TICKET-ID.md` files
2. Plan: `plan library for TICKET-ID` → `docs/TICKET-ID-plan.md`
3. Execute: `execute plan 1 for TICKET-ID`
4. Verify: `mvn clean verify`

## Supported Agents

| Agent | Config File | Auto-Read |
|-------|-------------|-----------|
| Claude Code | `CLAUDE.md` | Yes |
| GitHub Copilot | `.github/copilot-instructions.md` | Yes |
| Cursor | `.cursorrules` | Yes |
| Windsurf | `.windsurfrules` | Yes |
| Cline | `.clinerules` | Yes |
| Codex CLI | `AGENTS.md` | Yes |
| ChatGPT | manual paste | No |

## Workflow Overview

```
Plan → Execute → Verify → Review
```

1. **Plan**: Analyze the ticket, load relevant context, create a phased plan
2. **Execute**: Implement one phase at a time, following the plan exactly
3. **Verify**: Run tests (`mvn clean verify`), check Javadoc, lint with Checkstyle/SpotBugs
4. **Review**: Human reviews the implementation before proceeding to the next phase

## Directory Structure (after install)

```
your-project/
├── agent/
│   ├── master-instructions.md
│   ├── architecture/          — system design, public API, patterns, errors
│   ├── infrastructure/        — environment, dependencies, tooling, publishing
│   ├── workflow/              — planning, execution, testing, maintenance
│   ├── features/              — per-feature living documentation
│   └── examples/              — sample ticket plans
├── docs/                      — plan output (docs/TICKET-ID-plan.md)
├── tickets/                   — manual ticket files
└── agent-config.md            — configuration
```

## License

GNU GPL v3.0
