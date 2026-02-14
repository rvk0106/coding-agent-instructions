# VIDEO DEMO SCRIPT — Coding Agent Instructions Framework

**Total Duration:** ~14 minutes
**Repository:** https://github.com/rvk0106/coding-agent-instructions
**License:** GPL-3.0 (Open Source)

---

## [0:00-1:00] Introduction

This video is a demonstration of the framework I built.

It's called **Coding Agent Instructions — Framework Collection**.

**Repository:** github.com/rvk0106/coding-agent-instructions
**License:** GPL-3.0 — Open source, contributions welcome

### What it is NOT

It is **not** an AI framework.
It is **not** an automation tool.
It is **not** an autonomous coding system.

### What it IS

It is a collection of **structured instruction systems** that enforce discipline when using AI coding agents.

### Who should watch this

This video is useful for you if:

* ✅ You already use AI for coding but want more control
* ✅ You feel AI output becomes messy in real projects
* ✅ You want structured, reviewable, production-safe workflows
* ✅ You work in teams and need predictable agent behavior

If you're looking for instant automation without review, this is not for you.

---

## [1:00-2:30] Problem Statement

### The current state of AI coding

Today, most developers use AI by writing random prompts.

The result is often:

* ❌ Inconsistent structure
* ❌ Uncontrolled scope
* ❌ No planning
* ❌ Weak testing
* ❌ No review discipline

The output may be fast, but **unstable**.

### What this framework fixes

This framework enforces:

* ✅ **Plan-first execution** — Planning and code generation are separate
* ✅ **Phase isolation** — Execute one small phase at a time
* ✅ **Human review** — Hard stop after each phase for approval
* ✅ **Mandatory verification** — Tests/lint/build checks are required

It forces agents to behave like **disciplined collaborators**.

---

## [2:30-4:00] What It Supports

### Tool-agnostic design

This framework is **tool-agnostic**.

It works with **all 7 major AI coding agents**:

| Agent | Config File | Auto-Read |
|-------|-------------|:---------:|
| **Claude Code** | `CLAUDE.md` | Yes |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Yes |
| **Cursor** | `.cursorrules` | Yes |
| **Windsurf** | `.windsurfrules` | Yes |
| **Cline** | `.clinerules` | Yes |
| **OpenAI Codex CLI** | `AGENTS.md` | Yes |
| **ChatGPT** | _(manual paste)_ | No |

**One install command** creates configuration files for all supported agents.

Different team members can use different agents.
**The workflow stays the same.**

### Framework coverage

It supports **10 framework-specific instruction sets**:

**Full-stack:**
* Rails (views, Turbo, Stimulus)

**Backend APIs:**
* Rails API
* Spring Boot
* Django
* Express.js

**Frontend:**
* React

**Libraries:**
* Ruby Gem
* Python Library
* Node.js Library
* Java Library

Each framework has its own structured instruction set.

---

## [4:00-5:00] Workflow Overview

After installation, the workflow is always:

```
Connect → Plan → Execute → Verify → Stop → Review → Continue
```

Everything starts with a **ticket**.

### The agent:

1. Fetches or reads the ticket
2. Normalizes it into structured format
3. Creates a phased plan
4. **Waits for approval** ⏸️
5. Executes **only one phase**
6. Runs verification
7. **Stops** ⏸️

There is **no auto-continue**.
There is **no scope creep**.

**Humans remain accountable.**

---

## [5:00-12:00] Live Demo

### Demo scenario

We'll demonstrate this using a **shopping cart application**.

**Tech stack:**
* Backend: Rails API
* Frontend: React

**Feature we'll add:**

**Ratings and Reviews for products**

Requirements:
* One review per user per product
* Star rating (1-5)
* Users can update their review
* Display average rating

> **Note:** The feature itself is simple. **The focus is the workflow.**

---

### Step 1 — Install agent instructions

**[SCREEN: Terminal showing project root directory]**

From the project root, install the appropriate instruction sets.

For our Rails API backend:

```bash
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-rails-api/quick-install.sh | bash
```

For our React frontend (in a separate directory):

```bash
cd frontend
curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-react/quick-install.sh | bash
```

**[SCREEN: Split view — before/after directory structure]**

### What gets created

After installation, your project contains:

```
your-project/
├── agent/
│   ├── master-instructions.md          # Main entry point
│   ├── architecture/                   # Framework design patterns
│   │   ├── system-design.md
│   │   ├── database.md
│   │   ├── api-design.md
│   │   ├── patterns.md
│   │   └── ...
│   ├── infrastructure/                 # Environment, tooling, deployment
│   │   ├── environment.md
│   │   ├── dependencies.md
│   │   ├── tooling.md
│   │   └── ...
│   ├── workflow/                       # Planning, execution rules
│   │   ├── context-router.md
│   │   ├── planning.md
│   │   ├── execution.md
│   │   ├── ticket-access.md
│   │   └── ...
│   ├── features/                       # Per-feature documentation
│   │   ├── _TEMPLATE.md
│   │   └── _CONVENTIONS.md
│   └── fetch-ticket.sh                 # Ticket fetching utility
├── docs/                               # Plans saved here
├── tickets/                            # Manual ticket files
│   └── _TEMPLATE.md
├── agent-config.md                     # Ticketing configuration
│
│ # Agent-specific config files (all auto-created):
├── CLAUDE.md                           # Claude Code
├── AGENTS.md                           # OpenAI Codex CLI
├── .cursorrules                        # Cursor
├── .windsurfrules                      # Windsurf
├── .clinerules                         # Cline
├── .vscode/
│   └── settings.json                   # Copilot instruction files enabled
└── .github/
    └── copilot-instructions.md         # GitHub Copilot
```

**[SCREEN: Highlight key directories]**

* `agent/` — Core instruction modules
* `docs/` — Plans will be saved here
* `tickets/` — Manual ticket files (optional)
* Config files for 6 agents (CLAUDE.md, .cursorrules, etc.)

This is **not automation**.
This is **installing rules**.

---

### Step 2 — Review architecture files

**[SCREEN: Opening agent/architecture/ directory]**

The installation creates **template architecture files**.

You should review and customize them for your project:

* `system-design.md` — Overall architecture patterns
* `database.md` — Database conventions
* `api-design.md` — API endpoint patterns
* `error-handling.md` — Error response formats

**[SCREEN: Show example of agent/architecture/database.md with project-specific conventions]**

These files provide context to the agent about:
* Your naming conventions
* Your patterns
* Your constraints
* Your testing approach

---

### Step 3 — Create or connect to a ticket

**[SCREEN: Two-column layout showing both options]**

You have **two options** for tickets:

#### Option A: Manual tickets (no setup required)

Create `tickets/REVIEWS-001.md`:

```markdown
# REVIEWS-001: Add Ratings and Reviews for Products

## Description
Users should be able to rate and review products they have purchased.

## Acceptance Criteria
- [ ] Users can submit a rating (1-5 stars) and review text for a product
- [ ] One review per user per product
- [ ] Users can update their existing review
- [ ] Display average rating on product pages
- [ ] API endpoints for create, update, and fetch reviews

## Constraints
- Must maintain backward compatibility with existing Product API
- Reviews require authenticated user
- Rating must be between 1 and 5

## Non-goals
- Review moderation or flagging (future feature)
- Review images or media (future feature)
```

#### Option B: Ticketing integration (Linear/Jira/GitHub)

**[SCREEN: agent-config.md file]**

Edit `agent-config.md` and configure your system:

```bash
# For Linear
export LINEAR_API_TOKEN="lin_api_..."
export LINEAR_TEAM_KEY="SHOP"

# For Jira
export JIRA_URL="https://yourcompany.atlassian.net"
export JIRA_API_TOKEN="your-token"

# For GitHub Issues
export GITHUB_TOKEN="ghp_..."
export GITHUB_REPO="owner/repo"
```

Then fetch the ticket:

```bash
source agent/fetch-ticket.sh
fetch_ticket REVIEWS-001 > tickets/REVIEWS-001.md
```

**For this demo, we'll use Option A (manual ticket).**

---

### Step 4 — Planning phase

**[SCREEN: Terminal with agent prompt]**

Run the planning command:

```
plan architecture for REVIEWS-001
```

**[SCREEN: Agent reading ticket — no code being written yet]**

The agent:
* Reads `tickets/REVIEWS-001.md`
* Reads `agent/architecture/` files for context
* Creates a phased plan
* **Does NOT write code**

**[SCREEN: Show docs/REVIEWS-001-plan.md being created]**

The agent produces: `docs/REVIEWS-001-plan.md`

**[SCREEN: Open the plan file and scroll through]**

The plan includes:

```markdown
# Implementation Plan: REVIEWS-001

## Phase 1: Database Schema and Model
**Scope:**
- Create `reviews` table migration
- Add Review model with validations
- Ensure one review per user per product (unique constraint)
- Model tests

**Files to modify:**
- db/migrate/XXX_create_reviews.rb (new)
- app/models/review.rb (new)
- spec/models/review_spec.rb (new)

**Verification:**
bundle exec rspec spec/models/review_spec.rb
bundle exec rubocop app/models/review.rb

**Stop after this phase for review.**

---

## Phase 2: API Endpoints
**Scope:**
- POST /api/v1/products/:product_id/reviews
- PATCH /api/v1/reviews/:id
- GET /api/v1/products/:product_id/reviews
- Controller logic (thin)
- Service layer for business logic
- Request specs

**Files to modify:**
- app/controllers/api/v1/reviews_controller.rb (new)
- app/services/reviews/create_service.rb (new)
- app/services/reviews/update_service.rb (new)
- config/routes.rb
- spec/requests/api/v1/reviews_spec.rb (new)

**Verification:**
bundle exec rspec spec/requests/api/v1/reviews_spec.rb
bundle exec rubocop app/controllers/ app/services/

**Stop after this phase for review.**

---

## Phase 3: Frontend Integration
**Scope:**
- ReviewForm component
- ReviewsList component
- ProductRating display component
- API client methods
- Component tests

**Files to modify:**
- src/components/ReviewForm.tsx (new)
- src/components/ReviewsList.tsx (new)
- src/components/ProductRating.tsx (new)
- src/api/reviews.ts (new)
- src/components/__tests__/ReviewForm.test.tsx (new)

**Verification:**
npm test -- ReviewForm ReviewsList ProductRating
npm run lint
npm run build

**Stop after this phase for review.**
```

**[IMPORTANT: Planning ≠ Coding. That separation is enforced.]**

---

### Step 5 — Review and approve the plan

**[SCREEN: Human reviewing docs/REVIEWS-001-plan.md in an editor]**

You review:
* ✅ Are the phases small enough?
* ✅ Are acceptance criteria covered?
* ✅ Are verification commands correct?
* ✅ Is anything out of scope?

**Approve or request changes.**

**No code has been written yet.**

If you spot issues:
* Edit the plan
* Or ask the agent to revise

Once approved, move to execution.

---

### Step 6 — Execute Phase 1 only

**[SCREEN: Terminal with agent prompt]**

Run:

```
execute plan 1 for REVIEWS-001
```

**[SCREEN: Agent implementing Phase 1 — show file creation]**

Phase 1 implements:
* Migration: `db/migrate/20250214_create_reviews.rb`
* Model: `app/models/review.rb` with validations
* Uniqueness constraint: `user_id + product_id`
* Tests: `spec/models/review_spec.rb`

**[SCREEN: Show created files side by side]**

Migration:
```ruby
class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :comment
      t.timestamps
    end

    add_index :reviews, [:user_id, :product_id], unique: true
  end
end
```

Model:
```ruby
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, presence: true,
                     numericality: { only_integer: true,
                                   greater_than_or_equal_to: 1,
                                   less_than_or_equal_to: 5 }
  validates :user_id, uniqueness: { scope: :product_id,
                                   message: "can only review a product once" }
end
```

**[SCREEN: Agent running verification]**

Verification commands from the plan:

```bash
bundle exec rspec spec/models/review_spec.rb
bundle exec rubocop app/models/review.rb
```

**[SCREEN: Test output showing all green]**

```
Review
  validations
    ✓ validates presence of rating
    ✓ validates rating range 1-5
    ✓ ensures one review per user per product
    ✓ allows user to have reviews for different products

Finished in 0.5 seconds
4 examples, 0 failures
```

Status: ✅ **All tests pass**

**[SCREEN: Agent stops — clear "Phase 1 complete" message]**

```
Phase 1 complete. ⏸️

Files created:
- db/migrate/20250214_create_reviews.rb
- app/models/review.rb
- spec/models/review_spec.rb

Verification: ✅ All tests pass

Waiting for approval before Phase 2.
```

**The agent does NOT continue to Phase 2.**

---

### Step 7 — Review and continue

**[SCREEN: Human reviewing code in GitHub or IDE]**

You review the code:
* ✅ Check the migration
* ✅ Check the validations
* ✅ Check the tests
* ✅ Verify the unique constraint

**[SCREEN: Running git diff to see changes]**

You can:
* Run the migration locally
* Test edge cases manually
* Request modifications
* Approve the phase

**[SCREEN: Terminal showing approval]**

Once approved:

```
execute plan 2 for REVIEWS-001
```

**[SCREEN: Fast-forward montage showing Phase 2 execution]**

Phase 2 implements:
* API endpoints
* Controller (thin)
* Service layer (business logic)
* Request specs
* Verification ✅
* **Stop** ⏸️

**[SCREEN: Fast-forward montage showing Phase 3 execution]**

Phase 3 implements:
* React components
* API client
* Component tests
* Verification ✅
* **Stop** ⏸️

---

### Step 8 — Final verification

**[SCREEN: Terminal showing full test suite]**

After all phases:

```bash
# Backend
bundle exec rspec
bundle exec rubocop

# Frontend
npm test
npm run lint
npm run build
```

All verification passes ✅

---

## [12:00-13:30] Before/After Comparison

### WITHOUT this framework

**[SCREEN: Show chaotic prompt example]**

Prompt: *"Add ratings and reviews to my app"*

The agent might:

* ❌ Mix backend and frontend changes in one go
* ❌ Skip tests or write minimal tests
* ❌ Refactor unrelated files
* ❌ Continue beyond safe boundaries
* ❌ Create one giant PR with 40+ file changes
* ❌ No review points until the end

**Result:** Fast but risky. Hard to review. High chance of bugs.

---

### WITH this framework

**[SCREEN: Show structured workflow diagram]**

```
Ticket → Plan → Review Plan → Execute Phase 1 → Review Code
                                        ↓
                                 Phase 2 → Review Code
                                        ↓
                                 Phase 3 → Review Code → Done
```

The agent:

* ✅ Plans first (separate from coding)
* ✅ Executes one phase at a time
* ✅ Includes comprehensive tests
* ✅ Follows your architecture patterns
* ✅ Stops for review after each phase
* ✅ Creates 3 reviewable PRs (or commits)
* ✅ Incremental, safe delivery

**Result:** Controlled, auditable, production-safe.

---

### The key difference

**[SCREEN: Side-by-side comparison table]**

| Aspect | Without Framework | With Framework |
|--------|------------------|----------------|
| **Planning** | Ad-hoc, implicit | Explicit, reviewable |
| **Scope** | Unpredictable | Controlled, phased |
| **Testing** | Skipped or minimal | Mandatory, verified |
| **Review points** | End only | After each phase |
| **Control** | Agent decides | Human decides |
| **Accountability** | Ambiguous | Human accountable |

---

## [13:30-14:00] Closing & Call to Action

### The ratings feature is not important

The **workflow** is.

The same workflow works for:

* Backend APIs
* Frontend apps
* Full-stack systems
* Libraries and packages
* Scripts and tools

**Agents execute. Humans define intent and approve work.**

That is the system.

---

### This framework is open source

**Repository:** https://github.com/rvk0106/coding-agent-instructions
**License:** GPL-3.0

You are free to:
* ✅ Use it for any purpose
* ✅ Modify it to suit your needs
* ✅ Share it with others
* ✅ Contribute improvements

---

### How to contribute

Contributions welcome:

* 🔧 Add support for new frameworks (Go, Rust, PHP, etc.)
* 📝 Improve existing instruction sets
* 🐛 Report issues or edge cases
* 💡 Share your workflow improvements
* 📖 Improve documentation

**Your improvements benefit everyone using AI for coding.**

---

### Get started today

1. Visit: **github.com/rvk0106/coding-agent-instructions**
2. Choose your framework
3. Run the install command
4. Start working with disciplined AI collaboration

**Made with ❤️ for better human-agent collaboration**

---

## Production Notes

### Visual elements to prepare

- [ ] Terminal recordings (asciinema or similar)
- [ ] Split-screen file tree comparisons
- [ ] Code diff highlights
- [ ] Test output with green checkmarks
- [ ] Before/After comparison graphics
- [ ] Workflow diagram animation

### Audio notes

- Pace: Moderate, clear enunciation
- Emphasize key phrases: "plan first", "stop after each phase", "humans remain accountable"
- Add pauses at "⏸️" markers in script

### Screen recording tips

- Use large, readable fonts (minimum 14pt)
- Clear terminal color scheme (dark background recommended)
- Highlight cursor position
- Use screen annotations for emphasis
- Keep each code view on screen for 3-5 seconds minimum

### Example repository

Consider creating a demo repository:
- `coding-agent-demo-shopping-cart`
- Include before/after branches
- Include the completed plan file
- Include example PRs for each phase

This allows viewers to explore the real artifacts.
