# Design Patterns & Standards
> Tags: patterns, conventions, standards, quality
> Scope: Coding patterns and quality standards for this package
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first → execute in small phases → verify → human review
- No scope creep, no unrelated refactors

## Node.js Library Patterns

### Named Exports
- ALL public API uses named exports for tree-shaking
- No default exports from the main entry point
```typescript
// CORRECT — named exports
export function createClient(options: ClientOptions): Client { /* ... */ }
export class ValidationError extends LibError { /* ... */ }
export type { ClientOptions, Result };

// WRONG — default export
export default class Client { /* ... */ }
```

### Factory Functions for Configuration
- Use factory functions instead of `new` for primary API
- Keeps constructor details private, easier to evolve
```typescript
// CORRECT — factory function
export function createClient(options: ClientOptions): Client {
  validateOptions(options);
  return new ClientImpl({ ...DEFAULT_OPTIONS, ...options });
}

// WRONG — expose constructor directly
export class Client {
  constructor(options: ClientOptions) { /* ... */ }
}
```

### Async/Await Over Callbacks
- Always use async/await for asynchronous operations
- Never use callback-style APIs in public interface
- Return Promises, not void with callbacks
```typescript
// CORRECT
export async function fetchData(id: string): Promise<Data> {
  const response = await httpClient.get(`/data/${id}`);
  return transformResponse(response);
}

// WRONG — callback style
export function fetchData(id: string, callback: (err: Error | null, data?: Data) => void): void {
  // ...
}
```

### Error Classes for Library Errors
- Custom error hierarchy under a base error class
- See `architecture/error-handling.md` for full details
```typescript
export class LibNameError extends Error {
  constructor(message: string, public readonly code: string) {
    super(message);
    this.name = 'LibNameError';
  }
}
```

### Builder Pattern for Complex APIs
- Use for objects with many optional parameters
- Return `this` from each setter for chaining
```typescript
const query = new QueryBuilder()
  .select('name', 'email')
  .where('active', true)
  .limit(10)
  .build();
```

### Pure Functions Where Possible
- Prefer stateless, side-effect-free functions
- Easier to test, compose, and tree-shake
```typescript
// CORRECT — pure function
export function transformData(input: RawData): ProcessedData {
  return { ...input, processed: true, timestamp: Date.now() };
}

// AVOID — side effects in utility functions
export function transformData(input: RawData): ProcessedData {
  globalCache.set(input.id, input); // side effect
  return { ...input, processed: true };
}
```

### TypeScript or JSDoc Types
- TypeScript preferred for new libraries
- JSDoc types acceptable for JavaScript-only libraries
- Always ship `.d.ts` type definitions

## Naming Conventions
- Classes: `PascalCase` (e.g. `HttpClient`, `ValidationError`)
- Functions/variables: `camelCase` (e.g. `createClient`, `maxRetries`)
- Constants: `UPPER_CASE` (e.g. `DEFAULT_TIMEOUT`, `MAX_RETRIES`)
- Types/Interfaces: `PascalCase` (e.g. `ClientOptions`, `Result`)
- File names: `kebab-case.ts` or `camelCase.ts` (match project convention)
- Private members: `#privateField` (ES private) or `_prefixed` (convention)

## Module Format
- **ESM preferred**: Use `import`/`export` syntax
- **CJS compatibility**: Build tool outputs `.cjs` for older consumers
- **No mixing**: Do not mix `require()` and `import` in source

## Quality Checklist
- [ ] All exported functions/classes have JSDoc/TSDoc docs
- [ ] Tests for all new code (Jest/Vitest)
- [ ] ESLint + Prettier pass
- [ ] TypeScript compiles with `--strict` (or JSDoc types verified)
- [ ] No unnecessary runtime dependencies
- [ ] Backward compatible (or version bumped appropriately)
- [ ] CHANGELOG.md updated
- [ ] Bundle size checked (no unexpected growth)
- [ ] ESM and CJS both work

## Changelog
<!-- [PROJ-123] Adopted factory function pattern for all public constructors -->
