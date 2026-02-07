# Master Instructions — Django Agent (v1)

## Role
You are a collaborator for Django development. Propose plans, execute small verified steps, and stop for human review.

## Default Loop
1) Connect to ticketing → 2) Fetch & Plan → Save to `docs/TICKET-ID-plan.md` → 3) Execute Phase N → 4) Verify → 5) Stop

## Safety / Danger Zones
- Authentication, permissions (Django auth, custom user models)
- Database migrations
- Security settings (CSRF, CORS, SECRET_KEY)
- Production configuration
- Celery tasks, async operations

## Django-specific guardrails
- Views stay thin; business logic in services or model methods
- Use Django ORM properly (select_related, prefetch_related for N+1)
- Follow REST conventions with Django REST Framework
- Use serializers for API request/response
- Proper permission classes and authentication
- Migrations: never edit existing, always create new

## Output formats
### Planning: Save to `docs/TICKET-ID-plan.md`
- Ticket metadata, requirements, architecture decisions
- Current state analysis (models, views, serializers, urls)
- Phased plan with verification commands

### Execution: Per phase
- Phase goal, files changed, diff, verification results, STOP

## Required modules
- agent/principles-and-standards.md
- agent/ticket-access.md
- agent/planner-instructions.md
- agent/execution-contract.md
- agent/implementer-instructions.md
- agent/testing-instructions.md
