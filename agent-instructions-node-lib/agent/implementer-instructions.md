# Implementer Instructions — Node.js Library

## Read `docs/TICKET-ID-plan.md` first

## Node.js library conventions
- **Exports**: Define in package.json `exports` field
- **TypeScript**: Provide `.d.ts` files
- **ESM/CJS**: Support both module systems
- **Tree-shaking**: Use named exports
- **Entry points**: index.js/ts as main export
- **Side effects**: Declare in package.json

## File structure
- Source: `src/`
- Build output: `dist/` or `lib/`
- Types: `types/` or alongside source
- Tests: `tests/` or `__tests__/`
- Docs: `docs/` or README.md

## Quality rules
- TypeScript or JSDoc for types
- Comprehensive tests (Jest, Vitest)
- JSDoc comments for public API
- No breaking changes in minor/patch
- Deprecation warnings with console.warn
- Examples in README

## Post-implementation
1) Run tests: `npm test`
2) Lint: `npm run lint`
3) Type check: `tsc --noEmit`
4) Build: `npm run build`
5) Test package: `npm pack && npm install <tarball>`
6) Update CHANGELOG.md
