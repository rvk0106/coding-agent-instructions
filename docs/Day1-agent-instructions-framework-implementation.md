# Day 1: Agent Instructions Framework Implementation

**Date:** February 7, 2026  
**Repository:** github.com/rvk0106/coding-agent-instructions

## Overview

Implemented a complete framework-agnostic instruction system for using coding agents safely across 8 different frameworks. The system enforces plan-first execution, phase isolation, and human review.

## Frameworks Implemented

Created complete instruction sets for:

1. **Backend Frameworks**
   - Rails (Ruby on Rails)
   - Spring Boot (Java)
   - Django (Python)
   - Express (Node.js)

2. **Frontend Framework**
   - React

3. **Library Development**
   - Python Library
   - Node.js Library
   - Ruby Gem

## Core Features Implemented

### 1. Agent Instruction Files

Each framework includes:

- `agent/master-instructions.md` - Core agent role, loop, safety zones
- `agent/principles-and-standards.md` - Framework-specific conventions
- `agent/ticket-access.md` - Ticket fetching and normalization
- `agent/planner-instructions.md` - 7-step planning workflow
- `agent/execution-contract.md` - Phase discipline rules
- `agent/implementer-instructions.md` - Coding standards
- `agent/testing-instructions.md` - Verification commands

### 2. Configuration System: agent-config.md

**Problem Solved:** Originally required manual environment variable exports (`export LINEAR_API_TOKEN=...`)

**Solution:** Auto-created configuration file with:
- Default: Manual mode (no external dependencies)
- Templates for Linear API, Jira API, GitHub Issues
- Clear documentation of all options
- Comment-based activation (uncomment to enable)

### 3. Manual Ticket Management: tickets/ Folder

**Problem Solved:** Not all teams use external ticketing systems

**Solution:** Local ticket file system:
- `tickets/` folder auto-created during installation
- `tickets/_TEMPLATE.md` - Copy-paste template
- Structured format: Description, Acceptance Criteria, Constraints, Technical Notes
- Works completely offline
- Version controlled with project

### 4. Ticket Fetching Utility: fetch-ticket.sh

**Problem Solved:** Different ticketing systems have different APIs

**Solution:** Unified bash utility:
```bash
source agent/fetch-ticket.sh
fetch_ticket TICKET-ID > tickets/TICKET-ID.md
```

**Supports:**
- Linear (GraphQL API)
- Jira (REST API v3)
- GitHub Issues (REST API v3)

**Features:**
- Auto-reads configuration from `agent-config.md`
- Auto-detects which system to use
- Outputs formatted markdown
- Error handling for missing tokens

### 5. Automated Installation

**Old Workflow:**
```bash
curl ... | bash
export LINEAR_API_TOKEN="..."
# Configure MCP manually
# Create folders manually
```

**New Workflow:**
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-{framework}/install.sh | bash -s .
# Everything ready to use!
```

**What Gets Created:**
- ✅ `agent/` folder with all instruction files
- ✅ `agent/fetch-ticket.sh` executable utility
- ✅ `docs/` folder for plan storage
- ✅ `tickets/` folder for manual tickets
- ✅ `tickets/_TEMPLATE.md` template
- ✅ `agent-config.md` configuration file
- ✅ `.github/copilot-instructions.md` (updated)
- ✅ `.cursorrules` (updated)
- ✅ `CLAUDE.md` (updated)

## Installation Commands

### Backend Frameworks

```bash
# Rails
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-rails/install.sh | bash -s .

# Spring Boot
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-springboot/install.sh | bash -s .

# Django
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-django/install.sh | bash -s .

# Express
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-express/install.sh | bash -s .
```

### Frontend Framework

```bash
# React
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-react/install.sh | bash -s .
```

### Library Development

```bash
# Python Library
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-python-lib/install.sh | bash -s .

# Node.js Library
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-node-lib/install.sh | bash -s .

# Ruby Gem
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-ruby-gem/install.sh | bash -s .
```

## Workflow Design

### Two Workflow Options

#### Option A: Manual Tickets (Default)
1. Install framework instructions
2. Create `tickets/TICKET-ID.md` from template
3. Plan: `"plan [type] for TICKET-ID"`
4. Execute: `"execute plan 1 for TICKET-ID"`
5. Verify with framework-specific commands
6. Repeat for each phase

**Advantages:**
- No external dependencies
- Works completely offline
- Version controlled tickets
- No API rate limits

#### Option B: Ticketing Integration
1. Install framework instructions
2. Edit `agent-config.md` (uncomment API config)
3. Test: `source agent/fetch-ticket.sh && fetch_ticket TICKET-ID`
4. Plan: `"plan [type] for TICKET-ID"`
5. Execute phases as above

**Advantages:**
- Auto-sync with ticketing system
- Fetch latest ticket data
- Centralized ticket management
- Team collaboration

### Execution Loop

```
┌─────────────────┐
│  Fetch Ticket   │  (API or Local File)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Plan Phase    │  → docs/TICKET-ID-plan.md
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Human Review    │  (Approve or Request Changes)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Execute Phase N │  (One phase at a time)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│     Verify      │  (Run tests, linters)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│      STOP       │  (Wait for approval)
└────────┬────────┘
         │
         └──────────► Repeat for Phase N+1
```

## Framework-Specific Verification Commands

| Framework | Verification Command |
|-----------|---------------------|
| Rails | `bundle exec rspec && bundle exec rubocop` |
| Spring Boot | `./mvnw test && ./mvnw checkstyle:check` |
| Django | `python manage.py test && flake8` |
| Express | `npm test && npm run lint` |
| React | `npm test && npm run lint && npm run build` |
| Python Library | `pytest && flake8 && mypy` |
| Node Library | `npm test && npm run lint && npm run build` |
| Ruby Gem | `bundle exec rspec && bundle exec rubocop` |

## Repository Structure

```
coding-agent-instructions/
├── README.md                          # Main repository documentation
├── WORKFLOW-GUIDE.md                  # Detailed workflow examples
├── INSTALLATION-REFERENCE.md          # Installation details
├── AGENT-INSTRUCTIONS-INDEX.md        # Master catalog
├── LICENSE                            # GNU GPL v3.0
│
├── agent-instructions-rails/
│   ├── README.md
│   ├── install.sh
│   ├── LICENSE
│   └── agent/
│       ├── master-instructions.md
│       ├── principles-and-standards.md
│       ├── ticket-access.md
│       ├── planner-instructions.md
│       ├── execution-contract.md
│       ├── implementer-instructions.md
│       └── testing-instructions.md
│
├── agent-instructions-springboot/
├── agent-instructions-django/
├── agent-instructions-express/
├── agent-instructions-react/
├── agent-instructions-python-lib/
├── agent-instructions-node-lib/
└── agent-instructions-ruby-gem/
    (same structure as rails)
```

## Git Commit History

Key commits made today:

1. **Initial commit** - Created 8 framework repositories (84 files, 3637 insertions)
2. **Updated README** - Added all 8 installation commands
3. **Added install.sh scripts** - For all frameworks with curl installation
4. **Fixed BASH_SOURCE** - Handle piped bash execution
5. **Refactored ticket-access.md** - Reference agent-config.md for configuration
6. **Improved workflow** - Added agent-config.md + tickets/ folder support
7. **Updated READMEs** - Clear setup instructions for both workflows
8. **Added workflow guide** - Comprehensive WORKFLOW-GUIDE.md
9. **Major installation update** - Auto-create agent-config.md, tickets/, fetch-ticket.sh
10. **Added installation reference** - INSTALLATION-REFERENCE.md documentation

## Technical Implementation Details

### Install Script Features

- **Idempotent**: Can be run multiple times safely
- **Non-destructive**: Uses markers to avoid overwriting existing content
- **Executable**: Automatically chmods fetch-ticket.sh
- **Skip existing**: Won't overwrite user-created files
- **Framework-agnostic**: Same structure across all frameworks

### Bash Source Fix

**Issue:** When piping to bash, `BASH_SOURCE[0]` is unbound
```bash
bash: line 4: BASH_SOURCE[0]: unbound variable
```

**Solution:** Use fallback pattern
```bash
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
```

### Marker System

Install scripts use markers to avoid duplicates:
```bash
MARKER_START="# >>> agent-instructions-{framework}"
MARKER_END="# <<< agent-instructions-{framework}"
```

Files checked for markers:
- `.github/copilot-instructions.md`
- `.cursorrules`
- `CLAUDE.md`

## Documentation Created

1. **README.md** - Each framework's main documentation
2. **WORKFLOW-GUIDE.md** - Two workflow approaches with examples
3. **INSTALLATION-REFERENCE.md** - Complete installation details
4. **AGENT-INSTRUCTIONS-INDEX.md** - Master catalog
5. **This file** - Day 1 implementation summary

## Testing & Validation

**Tested:**
- ✅ Ruby gem installation (bash warning fixed)
- ✅ All 8 frameworks pushed to GitHub
- ✅ Install scripts executable
- ✅ Curl one-liners work
- ✅ Post-install messages accurate

**Installation Flow Verified:**
```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-ruby-gem/install.sh | bash -s .

# Output:
Created docs/ directory for plans
Created tickets/ directory for manual ticket files
Created agent-config.md template
Created agent/fetch-ticket.sh utility
Created tickets/_TEMPLATE.md
Markers already present: ./.github/copilot-instructions.md
Markers already present: ./.cursorrules
Markers already present: ./CLAUDE.md

Installation complete! ✅
...
```

## Key Design Decisions

### 1. Manual Mode as Default
**Rationale:** Most users want to try the system without external dependencies. Manual mode works offline and requires zero configuration.

### 2. agent-config.md Instead of Environment Variables
**Rationale:** 
- Version controlled (can be in .gitignore if needed)
- Self-documenting with templates
- Easy to switch between systems
- No shell-specific syntax

### 3. tickets/ Folder for Local Files
**Rationale:**
- Version control ticket history
- Work offline
- No API dependencies
- Fast iteration

### 4. fetch-ticket.sh as Optional Utility
**Rationale:**
- Not everyone uses ticketing systems
- Keep it simple for those who do
- Bash (works everywhere)
- Single responsibility

### 5. Framework-Specific Repositories
**Rationale:**
- Users only install what they need
- Framework-specific patterns and commands
- Independent versioning
- Clear separation of concerns

## Challenges Solved

### 1. Terminal Heredoc Issues
**Problem:** Bash heredocs getting garbled when creating complex scripts in terminal

**Solution:** Used Python script to generate install.sh files from template

### 2. Cross-Platform Compatibility
**Problem:** Different systems have different bash versions

**Solution:** Used `${BASH_SOURCE[0]:-$0}` fallback pattern

### 3. Configuration Complexity
**Problem:** Too many setup steps discourage adoption

**Solution:** Auto-create everything with sensible defaults (manual mode)

### 4. API Diversity
**Problem:** Linear, Jira, GitHub all have different APIs

**Solution:** Unified interface in fetch-ticket.sh with auto-detection

## Future Enhancements (Not Implemented Today)

- [ ] Quick-install.sh for remaining frameworks
- [ ] Example ticket plans for each framework
- [ ] CI/CD workflows for validation
- [ ] CONTRIBUTING.md guide
- [ ] Video tutorials
- [ ] Ticket format validation
- [ ] Plan template customization
- [ ] Integration with more ticketing systems (Asana, Trello, etc.)

## Impact

**Before:**
- Manual setup required
- Environment variables needed
- No offline mode
- Unclear next steps

**After:**
- One curl command = ready to use
- Works offline by default
- Clear choice: Manual or API
- Step-by-step guidance
- Complete automation

## Repository Stats

- **Total Files:** 84+
- **Total Lines:** 3,637+ insertions
- **Frameworks:** 8
- **Installation Commands:** 8 (one per framework)
- **License:** GNU GPL v3.0
- **Public:** Yes (GitHub)

## Links

- Repository: https://github.com/rvk0106/coding-agent-instructions
- Main README: https://github.com/rvk0106/coding-agent-instructions/blob/main/README.md
- Workflow Guide: https://github.com/rvk0106/coding-agent-instructions/blob/main/WORKFLOW-GUIDE.md

## Conclusion

Successfully implemented a production-ready, framework-agnostic agent instruction system with:
- Zero external dependencies (works offline)
- Optional ticketing integration (Linear/Jira/GitHub)
- Automated setup (one curl command)
- Comprehensive documentation
- 8 framework implementations

The system is ready for immediate use and public distribution.
