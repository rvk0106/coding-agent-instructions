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
3. **Read project knowledge** → check `architecture/` and `features/` for context
4. **Implement** → follow tasks, see `workflow/implementation.md`
5. **Verify** → run commands, see `workflow/testing.md`
6. **Report** → output format below
7. **STOP** → wait for human approval

## Output Format
```
1. Phase goal (1-2 lines)
2. Files changed (list)
3. Diff summary (what changed, why)
4. Verification commands + results
5. Assumptions / risks
6. STOP -- awaiting approval
```

## Post-Phase (after approval)
- Run `workflow/maintenance.md` checklist
- Update `architecture/` if schema/API/patterns changed
- Update `features/` if feature behavior changed
- Update `infrastructure/` if env/deps/tooling changed
