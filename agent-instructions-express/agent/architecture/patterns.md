# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality
> Scope: Coding patterns and quality standards for this project
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first --> execute in small phases --> verify --> human review
- No scope creep, no unrelated refactors

## Express Patterns Used

### Routes (thin -- define endpoints only)
- Location: `src/routes/`
- One file per resource (e.g. `userRoutes.js`, `orderRoutes.js`)
- No business logic -- delegate to controllers
- Apply validation and auth middleware at route level

```javascript
// CORRECT: thin route
const router = require('express').Router();
const { authenticate } = require('../middleware/auth');
const { validateCreateUser } = require('../middleware/validators/userValidator');
const userController = require('../controllers/userController');

router.get('/', authenticate, userController.list);
router.post('/', authenticate, validateCreateUser, userController.create);

module.exports = router;
```

### Controllers (handle req/res only)
- Location: `src/controllers/`
- Extract params from request, call service, send response
- No direct DB queries -- delegate to services
- Handle HTTP concerns (status codes, response shape)

```javascript
// CORRECT: thin controller
const userService = require('../services/userService');

exports.create = async (req, res, next) => {
  try {
    const user = await userService.createUser(req.body);
    res.status(201).json({ success: true, data: user });
  } catch (error) {
    next(error);
  }
};
```

### Services (business logic)
- Location: `src/services/`
- All business logic lives here
- Services call models/ORM, never call req/res
- Used for: multi-step operations, cross-model logic, external API calls
- Naming: `verbNoun` functions or class methods (e.g. `createUser`, `processOrder`)

### Middleware (cross-cutting concerns)
- Location: `src/middleware/`
- Auth: `authenticate.js` -- verify JWT/session, attach `req.user`
- Authorization: `authorize.js` -- check roles/permissions
- Validation: `validators/` -- joi/zod/express-validator schemas
- Error handling: `errorHandler.js` -- global error middleware (must be last)
- Logging: `requestLogger.js` -- log incoming requests
- Rate limiting: `rateLimiter.js` -- per-endpoint or global limits

### Models (data definitions)
- Location: `src/models/`
- Validations and schema definitions only
- No business logic -- delegate to services
- Scopes/named queries for common lookups

## Package Structure
```
src/
  routes/            --> route definitions
  controllers/       --> request/response handling
  services/          --> business logic
  models/            --> data models (Sequelize/Prisma/Mongoose/TypeORM)
  middleware/         --> reusable middleware
    validators/      --> validation schemas
  utils/             --> helper functions
  config/            --> app config, DB config
  types/             --> TypeScript interfaces (if using TS)
  __tests__/         --> test files (or test/ at project root)
```

## Naming Conventions
- **Files**: camelCase (`userController.js`, `authMiddleware.js`)
- **Classes**: PascalCase (`AppError`, `UserService`)
- **Functions/variables**: camelCase (`createUser`, `isAuthenticated`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRIES`, `JWT_SECRET`)
- **Route files**: camelCase with Resource suffix (`userRoutes.js`)
- **Test files**: match source (`userController.test.js` or `userController.spec.js`)

## TypeScript (recommended)
- Use strict mode: `"strict": true` in tsconfig.json
- Define interfaces for request bodies, response shapes, service params
- Use `express.Request` / `express.Response` / `express.NextFunction` types
- Avoid `any` -- use `unknown` when type is truly unknown

## Async/Await Rules
- Always use `async/await` over callbacks or raw promises
- Always wrap async route handlers with try-catch or use `express-async-errors`
- Never leave a promise unhandled (no floating promises)
- Always pass errors to `next(error)` in catch blocks

## Dependency Injection
- Pass dependencies to services via constructor or factory function
- Enables unit testing with mocked dependencies
- Example: `const userService = new UserService(userRepository, emailService)`

## Quality Checklist
- [ ] Input validation on all endpoints (joi/zod/express-validator)
- [ ] Tests for all new code (Jest/Vitest + Supertest)
- [ ] ESLint + Prettier pass
- [ ] API docs updated (if API changed)
- [ ] No N+1 queries (use eager loading / includes)
- [ ] Error handling with consistent payloads via error middleware
- [ ] Rollback plan for migrations
- [ ] TypeScript types defined for new interfaces

## Changelog
<!-- [PROJ-123] Adopted service layer pattern for all business logic -->
