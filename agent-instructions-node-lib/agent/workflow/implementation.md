# Implementation
> Tags: code, conventions, node, npm, patterns
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing patterns -- check `architecture/patterns.md`
- If uncertain → STOP and ask

## Node.js Library Conventions
- **Exports**: Define in package.json `exports` field
- **TypeScript**: Provide `.d.ts` files for all public API
- **ESM/CJS**: Support both module systems via build tool
- **Tree-shaking**: Use named exports, set `"sideEffects": false`
- **Entry points**: `src/index.ts` as main source entry
- **JSDoc/TSDoc**: All public functions/classes documented
- **Private members**: Use `#privateField` (ES private) or `_prefix` (convention)

## File Locations
```
src/index.ts                  → entry point, re-exports public API
src/types/index.ts            → shared TypeScript types
src/errors/index.ts           → error class hierarchy
src/core/[module].ts          → feature modules
src/utils/[helper].ts         → internal helpers (not exported)
tests/[module].test.ts        → tests matching source structure
  or __tests__/[module].test.ts
dist/                         → build output (ESM + CJS + .d.ts)
package.json                  → package configuration
tsconfig.json                 → TypeScript configuration
```

## TSDoc Documentation
```typescript
/**
 * Creates a new client instance with the given options.
 *
 * @param options - Client configuration options
 * @param options.apiKey - API key for authentication
 * @param options.timeout - Request timeout in milliseconds (default: 30000)
 * @returns A configured client instance
 * @throws {ConfigError} If apiKey is missing or invalid
 *
 * @example
 * ```typescript
 * const client = createClient({ apiKey: 'your-key' });
 * const result = await client.fetchData('id-123');
 * ```
 */
export function createClient(options: ClientOptions): Client {
  // ...
}
```

## Import Conventions
```typescript
// Node.js built-ins: use node: prefix
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';

// Internal imports: use relative paths
import { ConfigError } from '../errors/index.js';
import type { ClientOptions } from '../types/index.js';

// External imports: bare specifiers
import { someLib } from 'some-lib';
```

## Danger Zones
- Public API / exports changes → flag for review
- Adding runtime dependencies → justify in `infrastructure/dependencies.md`
- Changing package.json `exports` → ask first
- Removing/renaming exports → major version bump required
- `eval` / dynamic `import()` with user input → never
