# Error Handling
> Tags: errors, exceptions, hierarchy, error-codes
> Scope: How errors are defined, thrown, and caught in the package
> Last updated: [TICKET-ID or date]

## Error Class Hierarchy
```typescript
// Base error — all package errors inherit from this
export class LibNameError extends Error {
  public readonly code: string;

  constructor(message: string, code: string) {
    super(message);
    this.name = 'LibNameError';
    this.code = code;
  }
}

// Configuration errors
export class ConfigError extends LibNameError {
  constructor(message: string) {
    super(message, 'ERR_CONFIG');
    this.name = 'ConfigError';
  }
}

// Input/argument validation errors
export class ValidationError extends LibNameError {
  constructor(message: string) {
    super(message, 'ERR_VALIDATION');
    this.name = 'ValidationError';
  }
}

// External service errors (if package talks to external services)
export class ConnectionError extends LibNameError {
  constructor(message: string) {
    super(message, 'ERR_CONNECTION');
    this.name = 'ConnectionError';
  }
}

export class TimeoutError extends LibNameError {
  constructor(message: string) {
    super(message, 'ERR_TIMEOUT');
    this.name = 'TimeoutError';
  }
}

// Resource errors
export class NotFoundError extends LibNameError {
  constructor(message: string) {
    super(message, 'ERR_NOT_FOUND');
    this.name = 'NotFoundError';
  }
}

// [Add project-specific errors here]
```

## Error Raising Rules
- ALWAYS throw package-specific errors (never raw `Error` or `TypeError`)
- ALWAYS include a meaningful message
- ALWAYS provide `error.code` for programmatic handling
- Include context data when helpful
```typescript
// CORRECT
throw new ConfigError('API key is required — pass it via createClient({ apiKey: "..." })');

// WRONG — generic error, no context
throw new Error('missing key');
```

## Error Catching Patterns
```typescript
// Consumer-facing: catch the base error
try {
  const result = await client.doSomething();
} catch (error) {
  if (error instanceof LibNameError) {
    // handles all package errors
    console.error(`[${error.code}] ${error.message}`);
  }
}

// Consumer-facing: catch specific errors
try {
  const result = await client.doSomething();
} catch (error) {
  if (error instanceof TimeoutError) {
    await retryWithBackoff();
  } else if (error instanceof ConfigError) {
    console.error('Check your configuration:', error.message);
  } else if (error instanceof LibNameError) {
    logAndRethrow(error);
  }
}

// Consumer-facing: use error.code for programmatic handling
try {
  const result = await client.doSomething();
} catch (error) {
  if (error instanceof LibNameError) {
    switch (error.code) {
      case 'ERR_TIMEOUT': return retry();
      case 'ERR_CONFIG': return reconfigure();
      default: throw error;
    }
  }
}
```

## Internal Error Handling
- Wrap external library exceptions at the boundary
- Never let third-party errors leak to consumers
```typescript
// CORRECT — wrap external errors
async function fetchData(url: string): Promise<Data> {
  try {
    return await httpClient.get(url);
  } catch (error) {
    if (error instanceof Error && error.message.includes('ETIMEDOUT')) {
      throw new TimeoutError(`Request timed out after ${timeout}ms: ${error.message}`);
    }
    throw new ConnectionError(`Failed to connect: ${(error as Error).message}`);
  }
}

// WRONG — leaks axios/fetch errors to consumers
async function fetchData(url: string): Promise<Data> {
  return await httpClient.get(url); // axios AxiosError leaks out
}
```

## Error Message Guidelines
- Start with WHAT went wrong
- Include HOW to fix when possible
- Include relevant context (values, limits, etc.)
```typescript
// Good
'Request timed out after 30000ms — increase timeout via createClient({ timeout: 60000 })'
'API key is invalid — regenerate at https://example.com/settings'
'Input must be a non-empty string, received: ""'

// Bad
'error'
'something went wrong'
'invalid input'
```

## Library-Specific Rules
- NEVER use `process.exit()` in library code
- NEVER use `console.log()` for error reporting (use `throw`)
- NEVER swallow errors silently
- ALWAYS let consumers decide how to handle errors
- ALWAYS provide `error.code` for programmatic handling without message parsing

## Rules for Agents
- NEVER remove existing error classes (breaking change)
- ALWAYS add new error classes under `LibNameError`
- ALWAYS wrap external exceptions at boundaries
- ALWAYS include meaningful error messages with error codes
- Check existing hierarchy before creating new error classes

## Changelog
<!-- [PROJ-123] Added TimeoutError for network request failures -->
