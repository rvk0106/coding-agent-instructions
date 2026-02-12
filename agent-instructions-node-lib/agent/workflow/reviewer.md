# Reviewer
> Tags: review, code review, post-implementation, checklist, approve
> Scope: Structured code review after implementation (phase or ticket)
> Trigger: `review implementation for TICKET-ID` or `review phase N for TICKET-ID`

## Purpose
Assess changed code against the plan and conventions. Output a clear **Approve** or **Request changes** with a checklist and, if needed, suggested fixes. The reviewer does not modify code; it only evaluates and suggests.

## When to Run
- After `execute plan N for TICKET-ID` (before or alongside human approval)
- After all phases of a ticket are done (full ticket review)
- When a human asks for a structured review of recent changes

## Rules
- Do not edit code; only read and assess
- Base assessment on the plan, `workflow/implementation.md`, and `workflow/testing.md`
- If verification commands fail, result must be **Request changes**
- Be concrete: cite file, line or area, and what to change

## Steps

### 1. Load the plan
- Open `docs/TICKET-ID-plan.md`
- If phase-specific review: identify Phase N — goal, tasks, allowed files, forbidden changes, verification commands, acceptance criteria, context needed
- If full-ticket review: consider all phases and the overall ticket requirements

### 2. Identify changed files
- Use the list of files changed (from the agent's execution output or from the diff)
- Confirm which files were in scope for the phase (or ticket)

### 3. Load review criteria
- **Conventions:** `workflow/implementation.md` — file locations, Node.js library conventions, TSDoc, danger zones
- **Verification:** `workflow/testing.md` — test and lint commands that must pass

### 4. Run verification
- Execute the phase's (or ticket's) verification commands (e.g. `npm test ...`, `npm run lint`)
- Record pass/fail and any failure output

### 5. Checklist
Evaluate each item; mark Pass or Fail and note briefly if Fail:

| Check | Pass/Fail | Notes |
|-------|-----------|--------|
| Scope limited to phase (or ticket) | | No extra files or scope creep |
| Only allowed files touched | | Per plan's allowed files |
| No forbidden changes | | Per plan's forbidden list |
| TypeScript types correct and complete | | .d.ts generated, exports typed |
| Public functions have TSDoc/JSDoc | | @param, @returns, @throws, @example |
| Tests added/updated as required | | Tests for new/changed behavior |
| Backward compatible (or version bumped) | | No breaking changes in minor/patch |
| ESM + CJS both work | | Both import paths verified |
| Bundle size acceptable | | No unexpected growth |
| Danger zones avoided or explicitly called out | | Exports, deps, package.json, publishing |
| Verification commands pass | | test, lint, typecheck, build |

### 6. Output format
Produce the review in this structure:

```
## Review result
[Approve | Request changes]

## Checklist
- Scope limited to phase: [Pass/Fail] — [one-line note]
- Only allowed files touched: [Pass/Fail] — [note]
- No forbidden changes: [Pass/Fail] — [note]
- TypeScript types: [Pass/Fail] — [note]
- TSDoc/JSDoc: [Pass/Fail] — [note]
- Tests added/updated: [Pass/Fail] — [note]
- Backward compatible: [Pass/Fail] — [note]
- ESM + CJS: [Pass/Fail] — [note]
- Bundle size: [Pass/Fail] — [note]
- Danger zones: [Pass/Fail] — [note]
- Verification commands: [Pass/Fail] — [note]

## Verification
Commands run:
- [command] → [pass/fail] [optional output snippet]

## Risks or follow-ups
[Any assumptions, edge cases, or follow-up work]

## Suggested changes (if Request changes)
- [File/area]: [concrete change to make]
- ...
```

## Integration with default loop
- **Optional** after execute → verify: run this workflow to get a structured review, then human approves or requests changes.
- Human can use the checklist and suggested changes to decide approval or to prompt the agent to fix and re-run.
