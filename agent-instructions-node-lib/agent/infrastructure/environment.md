# Environment
> Tags: node, runtime, versions, package-manager
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Node.js: [e.g. >= 18]
- Package manager: [npm / yarn / pnpm]
- TypeScript: [e.g. >= 5.0 / not used]

## Supported Node.js Versions
<!-- List all versions the package supports and tests against -->
| Version | Status |
|---------|--------|
| 22 | Primary |
| 20 | Supported (LTS) |
| 18 | Minimum (LTS) |

## package.json `type` Field
- `"type": "module"` → ESM-first (`.js` = ESM, `.cjs` = CJS)
- Omitted or `"type": "commonjs"` → CJS-first (`.js` = CJS, `.mjs` = ESM)
- Current: [e.g. `"module"` / omitted]

## TypeScript Configuration
<!-- Key tsconfig.json settings -->
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "declaration": true,
    "declarationDir": "./dist",
    "strict": true,
    "esModuleInterop": true,
    "outDir": "./dist"
  },
  "include": ["src/**/*"]
}
```

## ESM vs CJS Configuration
- Source: ESM (TypeScript with `import`/`export`)
- Output: Both ESM and CJS via build tool
- package.json `exports` map: points to correct format per condition

## Local Setup
```bash
# Minimum commands to get running
git clone [repo]
cd package-name
npm install
npm test
npm run build
```

## Environment Variables
<!-- List any env vars the package uses (for testing or optional features) -->
- [e.g. `PACKAGE_NAME_API_KEY` — optional, for integration tests]
- [e.g. `PACKAGE_NAME_DEBUG` — enables verbose logging]

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Dropped Node.js 16 support -->
