# Testing Instructions — Express.js

## Source: `docs/TICKET-ID-plan.md`

## Fast checks
- Unit tests: `npm test -- path/to/test`
- Lint: `npm run lint`
- Type check: `tsc --noEmit`

## Full checks
- All tests: `npm test`
- Coverage: `npm run test:coverage`
- Build (TypeScript): `npm run build`

## Express-specific
- Run server: `npm run dev`
- Test endpoints with curl/Postman
- Check for memory leaks in long-running processes
