# Planner Instructions — Express.js

## Analyze patterns
- Review `package.json` for dependencies and scripts
- Check `src/routes/` or `routes/` for routing patterns
- Examine `src/controllers/` for request handling
- Review `src/services/` for business logic
- Check `src/models/` for data models (Mongoose, Sequelize, etc.)
- Review `src/middleware/` for middleware patterns
- Check test structure (`__tests__/`, `test/`)

## Danger zones
- Auth middleware and JWT handling
- Database migrations (Sequelize, TypeORM)
- Environment variables and secrets
- CORS and security configurations

## Verification commands
- Tests: `npm test` or `yarn test`
- Lint: `npm run lint` or `eslint src/`
- Type check (TypeScript): `tsc --noEmit`
- Run: `npm run dev` or `npm start`

## Save to: `docs/TICKET-ID-plan.md`
