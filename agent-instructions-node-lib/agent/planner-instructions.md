# Planner Instructions — Node.js Library

## Analyze patterns
- Review `package.json` for exports, dependencies, scripts
- Check `src/` for source structure
- Examine `dist/` or `lib/` for build output
- Review `types/` or `*.d.ts` for TypeScript definitions
- Check `tests/` or `__tests__/` for test structure
- Review `.github/workflows/` for CI/CD
- Check bundler config (rollup, webpack, tsup)

## Danger zones
- Public API exports changes
- Dependency/peerDependency changes
- Node version support
- ESM/CommonJS compatibility
- Build configuration

## Verification commands
- Tests: `npm test` or `jest`
- Lint: `npm run lint` or `eslint src/`
- Type check: `tsc --noEmit`
- Build: `npm run build`
- Publish dry-run: `npm publish --dry-run`

## Save to: `docs/TICKET-ID-plan.md`
