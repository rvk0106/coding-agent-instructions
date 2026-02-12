# Reviewer
> Tags: review, code review, post-implementation, checklist, approve
> Scope: Structured code review after implementation
> Trigger: `review implementation for TICKET-ID` or `review phase N for TICKET-ID`

## Purpose
Assess changed code against the plan and conventions. Output **Approve** or **Request changes** with a checklist. The reviewer does not modify code.

## Steps

### 1. Load the plan
- Open `docs/TICKET-ID-plan.md`
- Identify phase goal, tasks, allowed files, forbidden changes, verification commands

### 2. Identify changed files
- Confirm which files were in scope

### 3. Load review criteria
- `workflow/implementation.md` — coding conventions
- `workflow/testing.md` — verification commands

### 4. Run verification
- Execute verification commands
- Record pass/fail

### 5. Checklist
| Check | Pass/Fail | Notes |
|-------|-----------|--------|
| Scope limited to phase | | No extra files or scope creep |
| Only allowed files touched | | Per plan |
| TypeScript types for all props and data | | No `any` |
| Components follow project patterns | | Functional, hooks, composition |
| Accessibility attributes present | | ARIA, semantic HTML, keyboard |
| Responsive at all breakpoints | | Mobile, tablet, desktop |
| Loading + error + empty states handled | | For async operations |
| Tests added/updated | | React Testing Library |
| No console errors/warnings | | Clean output |
| Verification commands pass | | Lint, type-check, tests, build |

### 6. Output
```
## Review result
[Approve | Request changes]

## Checklist
- [item]: [Pass/Fail] — [note]

## Verification
Commands run:
- [command] → [pass/fail]

## Risks or follow-ups
[Any edge cases or follow-up work]

## Suggested changes (if Request changes)
- [File/area]: [concrete change]
```
