# Implementer Instructions — Rails

> When implementing a phase, always read `docs/TICKET-ID-plan.md` first.

## General rules
- Read the plan from `docs/TICKET-ID-plan.md` before starting.
- Follow the approved plan and the execution contract.
- Touch only files listed for the phase (ask if new files are needed).
- No unrelated refactors.
- Reuse existing patterns and helpers from the codebase.
- If uncertain, stop and ask.

## Rails conventions
- Controllers stay thin; business logic belongs in services or models.
- Prefer service objects for multi‑step operations.
- Keep model/controller/service sizes reasonable; refactor if they grow too large.
- Add or modify migrations only with explicit approval.
- Treat multi‑tenant boundaries and authorization as danger zones.

## File location conventions
- Controllers: `app/controllers/`
- Models: `app/models/`
- Services: `app/services/`
- Policies: `app/policies/`
- Jobs: `app/jobs/`
- Request specs: `spec/requests/`
- Model specs: `spec/models/`

## API response shape (Rails)
- Success: `{ success: true, message: string, data: object, meta: object }`
- Error: `{ success: false, message: string, errors: array, meta: object }`

## Multi‑tenant notes
- Use the correct base controller for tenant/admin/public contexts.
- Never cross tenant boundaries without explicit approval.

## Quality rules
- Strong parameters only.
- Consistent API response shapes.
- Add tests for each behavior change in the phase.
