# Testing
> Tags: test, verify, jest, vitest, eslint, build
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
> **Note:** Commands below are defaults. Check `infrastructure/tooling.md` for project-specific test/lint commands.

```bash
npm test -- --testPathPattern=path/to/test    # tests for touched files
npm run lint                                   # lint (ESLint + Prettier)
tsc --noEmit                                   # type check (TypeScript projects)
```

## Full Checks (when required)
```bash
npm test -- --coverage                         # full suite with coverage
npm run build                                  # verify build output
npm publish --dry-run                          # verify package contents
```

## Library-Specific Checks

### Verify ESM + CJS imports
```bash
# After build, verify both module formats work:
node -e "import('./dist/index.mjs').then(m => console.log('ESM OK:', Object.keys(m)))"
node -e "console.log('CJS OK:', Object.keys(require('./dist/index.cjs')))"
```

### Verify type definitions
```bash
# Check that .d.ts files are generated and valid:
ls dist/*.d.ts
tsc --noEmit --esModuleInterop -m nodenext dist/index.d.ts
```

### Verify tree-shaking
```bash
# Check that named exports are tree-shakeable:
# Build a consumer project that imports one function → verify unused exports are removed
```

### Verify package contents
```bash
npm pack                                       # creates .tgz
tar -tzf package-name-*.tgz                   # list contents
# Verify only expected files are included (dist/, README, LICENSE)
```

## Bundle Size Check
```bash
# Check package size before/after changes:
npm pack && ls -la *.tgz
# Or use package-specific size script:
npm run size
```

## Dependency Checks (when dependencies changed)
```bash
npm audit                                      # security audit
npm outdated                                  # check for outdated deps
```

## CI Commands
```bash
npm run lint                                   # lint
tsc --noEmit                                   # type check
npm test -- --coverage                         # tests + coverage
npm run build                                  # build
npm publish --dry-run                          # package verification
```

## Reporting Format
```
Commands run:
- `npm test -- --testPathPattern=...` → PASS/FAIL
- `npm run lint` → PASS/FAIL (N issues)
- `tsc --noEmit` → PASS/FAIL (N errors)
- `npm run build` → PASS/FAIL
If FAIL → STOP and ask before continuing
```
