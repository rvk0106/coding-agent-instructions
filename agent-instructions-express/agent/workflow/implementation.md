# Implementation
> Tags: code, conventions, express, patterns
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain --> STOP and ask

## Express Conventions
- **Routes**: thin -- define endpoints, apply middleware, delegate to controllers (`src/routes/`)
- **Controllers**: handle req/res only -- extract params, call service, send response (`src/controllers/`)
- **Services**: all business logic lives here -- no req/res awareness (`src/services/`)
- **Middleware**: reusable cross-cutting logic -- auth, validation, logging, error handling (`src/middleware/`)
- **Models**: data definitions and schema -- no business logic (`src/models/`)
- **Migrations**: only with explicit approval

## File Locations
```
src/routes/              --> route definitions (thin)
src/controllers/         --> request/response handling
src/services/            --> business logic
src/models/              --> data models (Sequelize/Prisma/Mongoose/TypeORM)
src/middleware/           --> reusable middleware
  middleware/validators/  --> validation schemas (joi/zod/express-validator)
src/utils/               --> helper functions
src/config/              --> app config, DB config, env loading
src/types/               --> TypeScript interfaces (if using TS)
src/__tests__/           --> test files (or test/ at project root)
  __tests__/routes/      --> API/integration tests (Supertest)
  __tests__/services/    --> service unit tests
  __tests__/middleware/  --> middleware tests
```

## API Response Shape
See `architecture/api-design.md` for the project's standard response shapes. All endpoints must use them consistently.

## TypeScript Rules (if using TS)
- Define interfaces for request bodies, query params, route params
- Use `express.Request<Params, ResBody, ReqBody, Query>` generics
- Export types from `src/types/`
- No `any` -- use `unknown` when type is truly unknown

## Error Handling
- Always use `async/await` with try-catch or `express-async-errors`
- Always pass errors to `next(error)` (never `res.status().json()` in catch blocks)
- Use AppError subclasses for operational errors
- See `architecture/error-handling.md` for error classes and patterns

## Danger Zones
- Auth middleware changes --> ask first
- Direct SQL / raw queries --> justify
- Data scoping bypass (accessing other users' data) --> ask first
- Skipping validation --> never
- Modifying global middleware order --> ask first
