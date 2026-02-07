# Workflow Guide: Two Ways to Use Agent Instructions

This repository now supports **two flexible workflows** for ticket management. Choose the one that fits your team's needs.

---

## 🎯 Option 1: Ticketing System Integration

For teams using Linear, Jira, or GitHub Issues.

### Setup

**1. Create `agent-config.md` in your project root:**

```markdown
# Agent Configuration

## Ticketing System
System: Linear
API Token Location: ENV['LINEAR_API_TOKEN']
Project ID: your-project-id
Team ID: your-team-id

## Connection Method
Preferred: MCP (if available)
Fallback: Direct API
```

**2. Set environment variable (optional):**

```bash
export LINEAR_API_TOKEN="your_token_here"
```

Or add to your `.env` file.

**3. Use the workflow:**

```bash
# Agent will automatically fetch ticket from Linear/Jira/GitHub
plan architecture for PROJ-123
```

The agent reads your `agent-config.md`, fetches the ticket data via API or MCP, and generates the plan.

---

## 📁 Option 2: Manual Ticket Files

For teams without ticketing system integration or preferring file-based tickets.

### Setup

**1. Create `agent-config.md` in your project root:**

```markdown
# Agent Configuration

## Ticketing System
System: Manual
API Token Location: N/A
Project/Team ID: N/A

## Connection Method
Preferred: Manual
Fallback: Manual

## Ticket Source
Manual ticket files in tickets/ folder
```

**2. Create a `tickets/` folder:**

```bash
mkdir tickets
```

**3. Create ticket files:**

Create `tickets/PROJ-123.md`:

```markdown
# [PROJ-123] Add User Authentication

## Description
Implement JWT-based authentication for the API with refresh token support.
Users should be able to login, logout, and automatically refresh their sessions.

## Acceptance Criteria
- [ ] Users can login with email/password
- [ ] JWT tokens expire after 15 minutes
- [ ] Refresh tokens valid for 7 days
- [ ] Logout invalidates both tokens
- [ ] Protected routes check token validity

## Constraints
- Must use bcrypt for password hashing
- Tokens stored in httpOnly cookies
- Rate limiting: 5 login attempts per minute

## Non-goals
- Not implementing OAuth providers in this ticket
- Not implementing 2FA (separate ticket)

## Technical Notes
- Database migration: add users table with email, password_hash
- New middleware: authenticate_user
- New routes: POST /login, POST /logout, POST /refresh
- Redis for token blacklist

## Links
- API Design: [link to design doc]
- Security Review: [link to review]
```

**4. Use the workflow:**

```bash
# Agent will read from tickets/PROJ-123.md
plan architecture for PROJ-123
```

The agent reads the ticket from your local file and generates the plan.

---

## 🔄 The Planning & Execution Loop

Regardless of which option you choose, the execution loop is identical:

### 1. Plan Phase
```bash
> plan architecture for PROJ-123
```

**Agent actions:**
- Fetches ticket (from API or local file based on agent-config.md)
- Analyzes requirements
- Breaks work into phases
- Creates `docs/PROJ-123-plan.md`
- **STOPS** and waits for your review

### 2. Review & Approve
- Open `docs/PROJ-123-plan.md`
- Review the phases
- Approve or request changes

### 3. Execute Phase by Phase
```bash
> execute plan 1 for PROJ-123
```

**Agent actions:**
- Reads the approved plan
- Implements **only Phase 1**
- Runs verification commands
- **STOPS** and waits for review

### 4. Verify & Continue
```bash
# Run tests
npm test  # or bundle exec rspec, pytest, etc.

# Review changes
git diff

# If approved, continue
> execute plan 2 for PROJ-123
```

---

## 🎨 Workflow Comparison

| Feature | Ticketing Integration | Manual Files |
|---------|----------------------|--------------|
| **Setup** | Configure API token | Create tickets/ folder |
| **Ticket Source** | Linear/Jira/GitHub API | Local .md files |
| **Best For** | Teams with existing ticketing | Teams wanting local control |
| **Offline Work** | ❌ Needs API access | ✅ Fully offline |
| **Sync** | Auto-syncs with system | Manual file management |
| **Flexibility** | Follows ticket system format | Custom format per project |

---

## 💡 Pro Tips

### Hybrid Approach
You can use **both** methods:
- Production tickets: Use ticketing system integration
- Experimental work: Use manual ticket files
- Documentation tasks: Use manual ticket files

### Agent Config Per Branch
Create different `agent-config.md` files for different workflows:

```bash
# Feature branch with ticketing
git checkout feature/new-api
# Uses agent-config.md with Linear integration

# Experimental branch
git checkout experiment/refactor
# Uses agent-config.md with Manual mode
```

### Team Templates
Create team-specific ticket templates in `tickets/_template.md`:

```markdown
# [TICKET-ID] Title

## Description
...

## Acceptance Criteria
- [ ] ...

## Constraints
...

## Technical Notes
...
```

Team members copy this template when creating new tickets.

---

## 📚 Next Steps

1. Choose your workflow (Integration or Manual)
2. Create `agent-config.md`
3. Set up tickets (API config or tickets/ folder)
4. Start planning: `plan architecture for TICKET-ID`
5. Execute phases one at a time
6. Review and verify before continuing

For framework-specific examples and patterns, see the README in your framework's directory (rails, django, express, react, etc.).
