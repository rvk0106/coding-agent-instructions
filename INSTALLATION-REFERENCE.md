# Installation Reference

## What Gets Created

When you run the installation, the following structure is automatically created:

```
your-project/
├── agent/
│   ├── master-instructions.md
│   ├── principles-and-standards.md
│   ├── ticket-access.md
│   ├── planner-instructions.md
│   ├── execution-contract.md
│   ├── implementer-instructions.md
│   ├── testing-instructions.md
│   └── fetch-ticket.sh ✨ NEW - Ticketing API utility
├── docs/
│   └── (plans will be saved here)
├── tickets/ ✨ NEW
│   └── _TEMPLATE.md ✨ NEW - Copy this for new tickets
├── agent-config.md ✨ NEW - Configuration file
│
│ # Agent-specific config files (all auto-created):
├── CLAUDE.md                           # Claude Code
├── AGENTS.md                           # OpenAI Codex CLI
├── .cursorrules                        # Cursor
├── .windsurfrules                      # Windsurf (Codeium)
├── .clinerules                         # Cline
└── .github/
    └── copilot-instructions.md         # GitHub Copilot
```

## New Post-Installation Message

```
Installation complete! ✅

Directory structure:
- agent/ - instruction files
- agent/fetch-ticket.sh - ticket fetching utility
- docs/ - plans saved here (docs/TICKET-ID-plan.md)
- tickets/ - manual ticket files (tickets/TICKET-ID.md)
- agent-config.md - configuration file

Next steps:

1) Choose your workflow:
   
   📁 Option A: Manual Tickets (No setup needed!)
   - Create ticket files: tickets/TICKET-ID.md
   - Use template: tickets/_TEMPLATE.md
   - Start planning: "plan [architecture|frontend|library|gem] for TICKET-ID"
   
   🔌 Option B: Ticketing Integration
   - Edit agent-config.md
   - Uncomment and configure your system (Linear/Jira/GitHub)
   - Test: source agent/fetch-ticket.sh && fetch_ticket TICKET-ID
   - Start planning: "plan [architecture|frontend|library|gem] for TICKET-ID"

2) Planning workflow:
   - Command: "plan [type] for TICKET-ID"
   - Output: docs/TICKET-ID-plan.md
   - Review the plan before executing

3) Execution workflow:
   - Command: "execute plan 1 for TICKET-ID"
   - Runs Phase 1 from docs/TICKET-ID-plan.md
   - Verify: [framework-specific test command]
   - Stop and review before Phase 2

See WORKFLOW-GUIDE.md for detailed examples.
```

## agent-config.md Template

The installation creates an `agent-config.md` with:

- **Default**: Manual mode (no external dependencies)
- **Linear API**: Configuration template with environment variables
- **Jira API**: Configuration template with URL and token
- **GitHub Issues**: Configuration template with token and repo

Simply uncomment and configure the section for your ticketing system.

## fetch-ticket.sh Utility

Bash script with functions to fetch tickets from:
- **Linear** using GraphQL API
- **Jira** using REST API v3
- **GitHub Issues** using REST API v3

### Usage

```bash
# Source the utility
source agent/fetch-ticket.sh

# Fetch a ticket (auto-detects system from agent-config.md)
fetch_ticket PROJ-123

# Save to tickets folder
fetch_ticket PROJ-123 > tickets/PROJ-123.md
```

The utility:
1. Reads `agent-config.md` for API tokens
2. Determines which ticketing system to use
3. Fetches ticket via API
4. Outputs formatted markdown

## tickets/_TEMPLATE.md

Ready-to-use template for manual tickets:

```markdown
# [TICKET-ID] Feature or Bug Title

## Description
...

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Constraints
...

## Non-goals
...

## Technical Notes
...

## Links
...
```

## Framework-Specific Verification Commands

| Framework | Verify Command |
|-----------|---------------|
| Rails | `bundle exec rspec && bundle exec rubocop` |
| Spring Boot | `./mvnw test && ./mvnw checkstyle:check` |
| Django | `python manage.py test && flake8` |
| Express | `npm test && npm run lint` |
| React | `npm test && npm run lint && npm run build` |
| Python Library | `pytest && flake8 && mypy` |
| Node Library | `npm test && npm run lint && npm run build` |
| Ruby Gem | `bundle exec rspec && bundle exec rubocop` |

## Quick Test

Test the new installation on any framework:

```bash
# Ruby gem example
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-ruby-gem/install.sh | bash -s .

# Check what was created
ls -la agent/ docs/ tickets/
cat agent-config.md
cat tickets/_TEMPLATE.md
```

You should see:
- ✅ agent-config.md created
- ✅ tickets/ folder with _TEMPLATE.md
- ✅ agent/fetch-ticket.sh executable
- ✅ CLAUDE.md created (Claude Code)
- ✅ AGENTS.md created (OpenAI Codex CLI)
- ✅ .cursorrules created (Cursor)
- ✅ .windsurfrules created (Windsurf)
- ✅ .clinerules created (Cline)
- ✅ .github/copilot-instructions.md created (GitHub Copilot)

## No More Required Steps

Previously, users had to:
- ❌ `export LINEAR_API_TOKEN="..."`
- ❌ Configure MCP manually
- ❌ Create folders themselves

Now:
- ✅ Everything created automatically
- ✅ Works offline by default (manual mode)
- ✅ Optional API integration via agent-config.md
- ✅ One curl command = ready to use
