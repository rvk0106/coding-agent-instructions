# Execution Contract — Phase Discipline

> When user says: "implement api for TICKET-ID phase N" or "execute plan N for TICKET-ID" follow these mandated steps:

## Definition
"Execute plan N" means you will:
1) Read the approved plan from `docs/TICKET-ID-plan.md`
2) Implement only Phase N from that plan
3) Stop and wait for approval

## Non‑negotiables
- Execute only Phase N.
- Do not edit the plan.
- Do not advance to Phase N+1.
- Do not broaden scope.

## Execution workflow
1) **Read plan**: Open and read `docs/TICKET-ID-plan.md`
2) **Extract Phase N**: Identify the exact phase to execute
3) **Implement**: Follow the phase tasks exactly
4) **Verify**: Run the verification commands specified in the phase
5) **Report**: Provide the executor output (below)
6) **STOP**: Do not continue to Phase N+1

## Required executor output
1) Restate the phase goal (1–2 lines)
2) List files changed
3) Diff summary
4) Verification commands + results
5) Assumptions/risks
6) STOP and wait for approval

## Rails-specific phase checks
- If touching controllers: confirm strong params and consistent response payloads.
- If touching models: confirm validations and associations updated with specs.
- If adding endpoints: confirm routes and request specs updated.
- If API changes: include swagger generation and verification commands.
