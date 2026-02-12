# Public API Design
> Tags: api, public, exports, interface, semver, types
> Scope: Public API surface, package.json exports, TypeScript types, versioning
> Last updated: [TICKET-ID or date]

## API Surface Rules
- Every exported function/class MUST have JSDoc/TSDoc documentation
- Every exported function/class MUST have test coverage
- Breaking changes require a MAJOR version bump (semver)
- New exports require a MINOR version bump
- Bug fixes use PATCH version bump

## Entry Points

### package.json `exports` field
```json
{
  "exports": {
    ".": {
      "import": "./dist/index.mjs",
      "require": "./dist/index.cjs",
      "types": "./dist/index.d.ts"
    },
    "./submodule": {
      "import": "./dist/submodule.mjs",
      "require": "./dist/submodule.cjs",
      "types": "./dist/submodule.d.ts"
    }
  },
  "main": "./dist/index.cjs",
  "module": "./dist/index.mjs",
  "types": "./dist/index.d.ts"
}
```

### Named Exports (tree-shaking)
```typescript
// CORRECT — named exports, tree-shakeable
export { createClient } from './core/client';
export { ConfigError, ValidationError } from './errors';
export type { ClientOptions, Result } from './types';

// WRONG — default export, not tree-shakeable
export default { createClient, ConfigError };
```

## TypeScript Type Definitions
- Ship `.d.ts` files alongside JavaScript output
- Use `@types` packages only for dev dependencies
- Export all public types from the main entry point
- Use `@public`, `@internal`, `@deprecated` TSDoc tags

### For TypeScript Libraries
```typescript
// src/types/index.ts — define and export all public types
export interface ClientOptions {
  apiKey: string;
  timeout?: number;
  retries?: number;
}

export interface Result<T> {
  success: boolean;
  data: T;
  error?: string;
}
```

### For JavaScript-Only Libraries (JSDoc)
```javascript
/**
 * @typedef {Object} ClientOptions
 * @property {string} apiKey - API key for authentication
 * @property {number} [timeout=30000] - Request timeout in ms
 * @property {number} [retries=3] - Number of retries
 */

/**
 * Creates a new client instance.
 * @param {ClientOptions} options - Client configuration
 * @returns {Client} Configured client instance
 */
export function createClient(options) { /* ... */ }
```

## Configuration API
<!-- Document the configuration pattern -->
```typescript
import { createClient } from 'package-name';

const client = createClient({
  apiKey: 'your-key',
  timeout: 5000,
  // [Add project-specific options]
});
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| [apiKey] | `string` | required | [description] |
| [timeout] | `number` | `30000` | [description] |

## Core Public Exports
<!-- Document the primary public API -->
| Export | Type | Params | Returns | Description |
|--------|------|--------|---------|-------------|
| `createClient` | function | `(options: ClientOptions)` | `Client` | [description] |
| `ClientOptions` | type | - | - | [description] |

## Deprecation Policy
- Deprecation warnings for at least ONE minor version before removal
- Use `console.warn('[package-name] DEPRECATION: functionName is deprecated, use newFunction instead')`
- Add `@deprecated` TSDoc tag to deprecated exports
- Document deprecations in CHANGELOG.md

## Backward Compatibility Rules
- Exported functions: never remove in minor/patch
- Function signatures: never change required params in minor/patch
- Return types: never change in minor/patch
- Configuration options: never remove in minor/patch (deprecate first)
- TypeScript types: narrowing is OK in minor, widening is breaking

## Semantic Versioning
| Change Type | Version Bump | Examples |
|------------|:------------:|---------|
| Breaking API change | MAJOR (X) | Remove export, change return type, remove config option, narrow accepted types |
| New feature (backward compatible) | MINOR (Y) | Add export, add config option, add error class, widen accepted types |
| Bug fix (backward compatible) | PATCH (Z) | Fix behavior, improve error message, performance fix |

## Changelog
<!-- [PROJ-123] Added new createClient factory function -->
