# Testing Instructions — Node.js Library

## Source: `docs/TICKET-ID-plan.md`

## Fast checks
- Unit tests: `npm test -- path/to/test`
- Lint: `npm run lint`
- Type check: `tsc --noEmit`

## Full checks
- All tests: `npm test -- --coverage`
- Build: `npm run build`
- Package size: `npm run size` or check build output
- Publish test: `npm publish --dry-run`

## Library-specific
- Test across Node versions (using CI)
- Verify exports work (ESM and CJS)
- Test tree-shaking capability
- Verify type definitions work
