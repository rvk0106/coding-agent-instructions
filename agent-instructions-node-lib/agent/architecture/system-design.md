# System Design
> Tags: architecture, components, modules, high-level
> Scope: How the package is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this package does -->
[Describe what this npm package does and who it serves.]

## Key Components
<!-- Replace placeholders with your actual structure -->
```
[Consumer Code] → [packageName.configure / packageName.method]
                    → [Core Module] → [Adapters / Backends] (if used)
                    → [Middleware / Plugins] (if used)
                    → [External Services] (if used)
```
- Core: [e.g. main processing logic / client / DSL]
- Adapters: [e.g. HTTP backends / storage backends / none]
- Plugins: [e.g. request/response pipeline / none]

## Module Structure
<!-- Map out the package layout -->
```
src/
├── index.ts              # main entry point, re-exports public API
├── config.ts             # configuration types and defaults
├── core/                 # main logic
│   ├── index.ts
│   └── [module].ts
├── errors/               # error class hierarchy
│   └── index.ts
├── types/                # shared TypeScript types
│   └── index.ts
└── utils/                # internal helpers (not exported)
    └── index.ts
```

## Dual Package Strategy (ESM + CJS)
- **ESM**: Primary target, tree-shakeable named exports
- **CJS**: Compatibility target for older Node.js consumers
- **Build tool**: [e.g. tsup / rollup / esbuild] produces both formats
- **package.json `exports`**: Maps entry points to ESM (`.mjs`/`.js`) and CJS (`.cjs`) outputs
- **package.json `type`**: [e.g. `"module"` for ESM-first, or omitted for CJS-first]

## Dependency Graph
<!-- Describe internal module dependencies -->
- `index.ts` → re-exports from `core/`, `errors/`, `types/`
- `core/` → imports from `errors/`, `types/`, `utils/`
- `utils/` → no imports from `core/` (no circular deps)

## Node.js Version Support
- Minimum: [e.g. Node.js 18+]
- Tested: [e.g. 18, 20, 22]
- CI matrix: [e.g. GitHub Actions with node-version: [18, 20, 22]]

## Key Data Flows
<!-- Describe 2-3 critical flows through the package -->
1. **Configuration**: `createClient({ option })` → merges with defaults → returns configured instance
2. **[Flow Name]**: [step] → [step] → [step]
3. **[Flow Name]**: [step] → [step] → [step]

## Changelog
<!-- [PROJ-123] Added plugin architecture for extensibility -->
