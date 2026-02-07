# Principles & Standards

## Core principles
- **Agents are collaborators, not autonomous engineers**
- **Plan first**: Planning and execution are separate phases
- **Small, verifiable steps**: Each phase is atomic and independently testable
- **Hard stop after each phase**: No auto-continue without human approval
- **Verification required**: Tests/lint/contract checks are mandatory
- **Humans remain accountable**: Humans approve plans, phase transitions, review code, and merge

## Rails-specific standards
- Use existing standards (RuboCop, RSpec, Swagger)
- Follow established patterns from the codebase
- Generate only what's needed
- Reference existing code for consistency

## Design patterns
- Service objects for multi-step business logic
- Thin controllers (< 100 lines)
- Fat models with concerns for shared behavior
- Repository pattern for complex queries
- Policy objects for authorization
- Consistent API response shapes

## Quality checklist
- Strong parameters in all controller actions
- RSpec tests for all new code
- RuboCop compliance
- Swagger documentation for API changes
- No N+1 queries
- Proper error handling with consistent payloads
