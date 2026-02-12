# Tooling
> Tags: build, test, lint, ci, formatter, quality, docs
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Build
- Tool: [tsup / rollup / esbuild / tsc]
- Config: [e.g. `tsup.config.ts`, `rollup.config.js`]
- Command: `npm run build`
- Output: `dist/` (ESM + CJS + `.d.ts`)
- Type checking (separate): `tsc --noEmit`

## Testing
- Framework: [Jest / Vitest]
- Config: [e.g. `vitest.config.ts`, `jest.config.js`]
- Run all: `npm test`
- Run specific: `npm test -- --testPathPattern=path/to/test`
- Run with coverage: `npm test -- --coverage`
- Coverage output: [e.g. `coverage/` directory]

## Linting
- ESLint: `npm run lint`
- Config: [e.g. `eslint.config.js`, `.eslintrc.js`]
- Auto-fix: `npm run lint -- --fix`

## Formatting
- Prettier: `npm run format` (or integrated with ESLint)
- Config: [e.g. `.prettierrc`, `prettier.config.js`]
- Check: `npx prettier --check .`

## Documentation
- Tool: [TypeDoc / JSDoc / none]
- Generate: [e.g. `npx typedoc`]
- Output: [e.g. `docs/api/`]

## Bundle Analysis
- Check package size: `npm pack && ls -la *.tgz`
- Analyze bundle: [e.g. `npx bundlesize`, `npm run size`]
- Track size in CI: [yes/no]

## CI/CD
- Platform: [e.g. GitHub Actions / CircleCI / GitLab CI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Matrix: [e.g. Node.js 18, 20, 22 on ubuntu-latest]
- Pipeline steps: install → lint → type-check → test → build
- Required checks before merge: [list them]

## Package Scripts (package.json)
```json
{
  "scripts": {
    "build": "[build command]",
    "test": "[test command]",
    "lint": "[lint command]",
    "format": "[format command]",
    "typecheck": "tsc --noEmit",
    "prepublishOnly": "npm run build"
  }
}
```

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [e.g. feature branches → main]
- Commit convention: [e.g. conventional commits / free-form]

## Changelog
<!-- [PROJ-123] Added GitHub Actions CI matrix for Node.js 18-22 -->
