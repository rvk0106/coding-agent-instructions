# Implementer Instructions — Express.js

## Read `docs/TICKET-ID-plan.md` first

## Conventions
- **Routes**: Define endpoints, delegate to controllers
- **Controllers**: Handle requests, call services
- **Services**: Business logic
- **Middleware**: Reusable logic (auth, validation, logging)
- **Models**: Data definitions (Mongoose/Sequelize)

## File structure
- Routes: `src/routes/`
- Controllers: `src/controllers/`
- Services: `src/services/`
- Middleware: `src/middleware/`
- Models: `src/models/`
- Utils: `src/utils/`
- Tests: `src/__tests__/` or `test/`

## Quality rules
- Use async/await with try-catch
- Input validation with joi or express-validator
- Proper error handling middleware
- HTTP status codes (200, 201, 400, 404, 500)
- Add tests (Jest, Mocha, Supertest)

## Post-implementation
1) Run tests: `npm test`
2) Lint: `npm run lint`
3) Type check: `tsc --noEmit` (if TypeScript)
4) Document endpoints in `docs/frontend-integration.md`
