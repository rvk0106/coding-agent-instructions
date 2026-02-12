# Tooling
> Tags: linter, test, ci, formatter, build, quality
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Build
- TypeScript: `npm run build` (runs `tsc`)
- Bundler (if used): [e.g. esbuild / swc / tsup / none]
- Output: [e.g. `dist/` directory]

## Linting
- ESLint: `npm run lint`
- Config: `.eslintrc.js` or `eslint.config.mjs` (flat config)
- Auto-fix: `npm run lint -- --fix`
- Prettier: `npm run format` or integrated via eslint-config-prettier
- Config: `.prettierrc`

## Testing
- Framework: [e.g. Jest / Vitest]
- API testing: Supertest
- Run all: `npm test`
- Run specific: `npm test -- --testPathPattern=path/to/test`
- Run single file: `npx jest path/to/test.js`
- Coverage: `npm test -- --coverage` or `npm run test:coverage`
- Watch mode: `npm test -- --watch`
- Config: `jest.config.js` or `vitest.config.ts`

## API Documentation
- Tool: [e.g. swagger-jsdoc + swagger-ui-express / none]
- Generate: auto-generated from JSDoc annotations in route files
- View: `http://localhost:3000/api-docs`

## Type Checking (TypeScript)
- Check: `npx tsc --noEmit`
- Build: `npm run build`

## CI/CD
- Platform: [e.g. GitHub Actions / CircleCI / GitLab CI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Pipeline steps:
  1. Install dependencies (`npm ci`)
  2. Lint (`npm run lint`)
  3. Type check (`npx tsc --noEmit`) -- if TypeScript
  4. Test (`npm test -- --coverage`)
  5. Build (`npm run build`)
  6. Deploy (if merge to main)
- Required checks before merge: [list them]

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches --> main]
- Commit convention: [e.g. conventional commits / free-form]

## Useful Scripts (package.json)
```json
{
  "scripts": {
    "dev": "ts-node-dev --respawn src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "test": "jest",
    "test:coverage": "jest --coverage",
    "lint": "eslint src/",
    "lint:fix": "eslint src/ --fix",
    "format": "prettier --write src/",
    "typecheck": "tsc --noEmit"
  }
}
```

## Changelog
<!-- [PROJ-123] Switched from Jest to Vitest -->
