# Feature Implementation Conventions
> Tags: conventions, testing, patterns, specs
> Scope: Patterns to follow when implementing any feature in the package
> Last updated: [TICKET-ID or date]

## Module Structure
```typescript
// src/core/feature-name.ts
import type { FeatureOptions, FeatureResult } from '../types/index.js';
import { ValidationError } from '../errors/index.js';

/**
 * Brief description of what this function does.
 *
 * @param options - Configuration for the feature
 * @returns The processed result
 * @throws {ValidationError} If options are invalid
 */
export function featureFunction(options: FeatureOptions): FeatureResult {
  validateOptions(options);
  // implementation
}

// Private helpers — not exported
function validateOptions(options: FeatureOptions): void {
  if (!options.requiredField) {
    throw new ValidationError('requiredField is required');
  }
}
```

## Configuration Pattern
```typescript
// If the feature adds config options:
interface FeatureConfig {
  featureOption: string;
  featureTimeout: number;
}

const DEFAULT_FEATURE_CONFIG: FeatureConfig = {
  featureOption: 'default_value',
  featureTimeout: 30000,
};

export function createFeature(userConfig: Partial<FeatureConfig> = {}): Feature {
  const config = { ...DEFAULT_FEATURE_CONFIG, ...userConfig };
  // ...
}
```

## TSDoc Documentation
```typescript
// Every public function must have:
// @param, @returns, @throws, @example

/**
 * Processes the input data and returns a transformed result.
 *
 * @param input - The raw input string to process
 * @param options - Optional processing configuration
 * @returns The processed result with metadata
 * @throws {ValidationError} If input is empty or null
 * @throws {TimeoutError} If processing exceeds timeout
 *
 * @example
 * ```typescript
 * const result = await process('hello', { timeout: 5000 });
 * console.log(result.data); // processed output
 * ```
 */
export async function process(
  input: string,
  options?: ProcessOptions
): Promise<ProcessResult> {
  // ...
}
```

## Test Data
```typescript
// Use descriptive test fixtures
// Prefer inline data over external fixtures for clarity

// Simple objects
const defaultOptions: ClientOptions = {
  apiKey: 'test-key-123',
  timeout: 5000,
};

// Factory helper for tests
function createTestClient(overrides: Partial<ClientOptions> = {}): Client {
  return createClient({ ...defaultOptions, ...overrides });
}
```

## Unit Test Pattern (Jest / Vitest)
```typescript
// tests/core/feature-name.test.ts
import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
// or: import { describe, it, expect, jest, beforeEach, afterEach } from '@jest/globals';
import { featureFunction } from '../../src/core/feature-name.js';
import { ValidationError } from '../../src/errors/index.js';

describe('featureFunction', () => {
  describe('with valid input', () => {
    it('returns expected result', async () => {
      const result = await featureFunction({ input: 'test' });

      expect(result).toEqual({
        success: true,
        data: expect.any(String),
      });
    });
  });

  describe('with invalid input', () => {
    it('throws ValidationError for empty input', () => {
      expect(() => featureFunction({ input: '' }))
        .toThrow(ValidationError);
    });

    it('includes helpful error message', () => {
      expect(() => featureFunction({ input: '' }))
        .toThrow(/must not be empty/);
    });
  });

  describe('edge cases', () => {
    it('handles null gracefully', () => {
      expect(() => featureFunction({ input: null as any }))
        .toThrow(ValidationError);
    });
  });
});
```

## Mocking Modules
```typescript
// Mock external dependencies
import { vi } from 'vitest';

// Mock a module
vi.mock('node:fs/promises', () => ({
  readFile: vi.fn().mockResolvedValue('file content'),
  writeFile: vi.fn().mockResolvedValue(undefined),
}));

// Mock a specific function
const mockFetch = vi.fn().mockResolvedValue({
  ok: true,
  json: () => Promise.resolve({ data: 'test' }),
});

// Spy on a method
const spy = vi.spyOn(client, 'request');
expect(spy).toHaveBeenCalledWith('GET', '/path');
```

## Test Setup / Teardown
```typescript
describe('ClientWithSideEffects', () => {
  let client: Client;

  beforeEach(() => {
    client = createClient({ apiKey: 'test-key' });
    vi.useFakeTimers();
  });

  afterEach(() => {
    vi.restoreAllMocks();
    vi.useRealTimers();
  });

  it('retries on timeout', async () => {
    // test implementation
  });
});
```

## Integration Test Pattern
```typescript
// tests/integration/feature-name.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { createClient } from '../../src/index.js';

describe('FeatureName integration', () => {
  let client: Client;

  beforeAll(() => {
    client = createClient({
      apiKey: process.env.TEST_API_KEY ?? 'test-key',
    });
  });

  afterAll(() => {
    // cleanup
  });

  it('processes end-to-end', async () => {
    const result = await client.process('real input');
    expect(result.success).toBe(true);
  });
});
```

## Async Test Patterns
```typescript
// Always await async operations
it('resolves with data', async () => {
  const result = await fetchData('id-123');
  expect(result.data).toBeDefined();
});

// Test rejected promises
it('rejects on invalid ID', async () => {
  await expect(fetchData('invalid'))
    .rejects
    .toThrow(NotFoundError);
});

// Test with timeouts
it('times out after configured duration', async () => {
  const client = createClient({ timeout: 100 });
  await expect(client.slowOperation())
    .rejects
    .toThrow(TimeoutError);
}, 5000); // test timeout
```

## Changelog
<!-- Update when conventions change -->
