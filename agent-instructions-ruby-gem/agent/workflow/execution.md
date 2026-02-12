# Execution
> Tags: execute, phase, implement, contract
> Scope: How to execute a single phase from an approved plan
> Trigger: `execute plan N for TICKET-ID`

## Rules
- Execute ONLY Phase N -- nothing else
- Do NOT edit the plan
- Do NOT advance to Phase N+1
- Do NOT broaden scope
- STOP after phase is complete

## Execution Steps
1. **Read plan** → open `docs/TICKET-ID-plan.md`
2. **Extract Phase N** → identify exact tasks
3. **Load context from plan** → read ONLY the files listed in the plan's "Context Loaded" section + the phase's "Context needed" list
4. **Load implementation rules** → `workflow/implementation.md`
5. **Implement** → follow phase tasks exactly
6. **Load testing rules** → `workflow/testing.md` (only when verifying)
7. **Verify** → run phase verification commands
8. **Report** → output format below
9. **STOP** → wait for human approval

## Context Loading (execution)
DO NOT re-read all instruction files. Instead:
```
1. Read the plan's "Context Loaded" section → these were used during planning
2. Read the phase's "Context needed" list → specific to this phase
3. Read workflow/implementation.md → coding conventions
4. Read workflow/testing.md → only when running verification
5. That's it. Skip everything else.
```

## Output Format
```
Phase goal: (1-2 lines)
Context loaded: (list files read)
Files changed: (list)
Diff summary: (what changed, why)
Verification commands + results:
Assumptions / risks:
STOP -- awaiting approval
```

## Gem-Specific Phase Checks
- If touching public API: confirm YARD docs and backward compatibility
- If adding methods: confirm RSpec coverage for all public methods
- If changing errors: confirm exception hierarchy consistency
- If modifying configuration: confirm defaults and validation
- If adding dependencies: confirm gemspec updated and justified

## Post-Phase (after approval)
Use `workflow/context-router.md` MAINTENANCE section:
- Load `workflow/maintenance.md` → check what needs updating
- Load ONLY the doc files that need updating (not everything)
