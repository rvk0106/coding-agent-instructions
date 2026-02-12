# Feature: [Feature Name]
> Tags: [relevant, keywords]
> Scope: [what this feature covers]
> Status: [active / deprecated / planned]

## Summary
<!-- 1-2 sentences: what this feature does -->

## How It Works
<!-- Step-by-step flow, keep it concise -->
1. [Step]
2. [Step]
3. [Step]

## Key Components
| Component | Location | Purpose |
|-----------|----------|---------|
| Module | `src/core/...` | [what it does] |
| Types | `src/types/...` | [what it does] |
| Config | `src/config.ts` | [what it does] |

## Public API
| Export | Type | Params | Returns | Description |
|--------|------|--------|---------|-------------|
| `functionName` | function | `(arg: Type)` | `Promise<Result>` | [description] |

## Configuration Options (if applicable)
| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `option` | `string` | `undefined` | [description] |

## Types
```typescript
interface FeatureOptions {
  // [document the types used by this feature]
}
```

## Usage Examples
```typescript
import { featureFunction } from 'package-name';

const result = await featureFunction({ option: 'value' });
```

## Business Rules
- [Rule 1]
- [Rule 2]

## Edge Cases / Gotchas
- [Thing to watch out for]
- [Known limitation]

## Tests
- Unit tests: `tests/[module].test.ts`
- Integration tests: `tests/integration/[module].test.ts`
