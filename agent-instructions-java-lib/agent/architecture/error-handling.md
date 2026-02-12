# Error Handling
> Tags: errors, exceptions, hierarchy, catch
> Scope: How exceptions are defined, thrown, and caught in the library
> Last updated: [TICKET-ID or date]

## Exception Hierarchy
```java
// Base exception — all library errors inherit from this (unchecked)
public class LibNameException extends RuntimeException {
    public LibNameException(String message) { super(message); }
    public LibNameException(String message, Throwable cause) { super(message, cause); }
}

// Configuration errors
public class ConfigurationException extends LibNameException { ... }

// Input/argument errors
public class ValidationException extends LibNameException { ... }

// External service errors (if library talks to external services)
public class ConnectionException extends LibNameException { ... }
public class TimeoutException extends LibNameException { ... }
public class AuthenticationException extends LibNameException { ... }
public class RateLimitException extends LibNameException { ... }

// Resource errors
public class NotFoundException extends LibNameException { ... }

// State errors
public class IllegalStateException extends LibNameException { ... }

// [Add project-specific exceptions here]
```

## Checked vs Unchecked
- **Unchecked (RuntimeException)**: Default for library exceptions. Consumers can catch if they want but are not forced to.
- **Checked exceptions**: Use ONLY for truly recoverable errors where the caller is expected to handle them (rare for libraries).
- Base `LibNameException` extends `RuntimeException` (unchecked).

## Exception Throwing Rules
- ALWAYS throw library-specific exceptions (never raw `RuntimeException` or `IllegalArgumentException` from public API)
- ALWAYS include a meaningful message
- ALWAYS wrap the original cause when wrapping external exceptions
- Include context data when helpful
```java
// CORRECT
throw new ConfigurationException(
    "API key is required — set via LibConfig.builder().apiKey(\"...\").build()");

// CORRECT — wrapping external exception
throw new ConnectionException("Failed to connect to " + url, originalException);

// WRONG — generic exception, no context
throw new RuntimeException("error");
```

## Exception Catching Patterns
```java
// Consumer-facing: catch the base exception
try {
    client.execute(input);
} catch (LibNameException e) {
    // handles all library errors
}

// Consumer-facing: catch specific exceptions
try {
    client.execute(input);
} catch (TimeoutException e) {
    retryWithBackoff();
} catch (AuthenticationException e) {
    refreshCredentials();
} catch (LibNameException e) {
    logAndRethrow(e);
}
```

## Internal Exception Handling
- Wrap external library exceptions at the boundary
- Never let third-party exceptions leak to consumers
```java
// CORRECT — wrap external errors
public Result fetchData(String url) {
    try {
        return httpClient.get(url);
    } catch (java.net.SocketTimeoutException e) {
        throw new TimeoutException("Request timed out after " + timeout + "ms: " + e.getMessage(), e);
    } catch (java.io.IOException e) {
        throw new ConnectionException("Failed to connect: " + e.getMessage(), e);
    }
}

// WRONG — leaks java.net exceptions to consumers
public Result fetchData(String url) throws IOException {
    return httpClient.get(url);
}
```

## Exception Message Guidelines
- Start with WHAT went wrong
- Include HOW to fix when possible
- Include relevant context (values, limits, etc.)
```java
// Good
"Rate limit exceeded (429): retry after " + retryAfter + "s"
"API key is invalid — regenerate at https://example.com/settings"
"Connection pool exhausted: " + active + "/" + maxSize + " connections in use"

// Bad
"error"
"something went wrong"
```

## Rules for Agents
- NEVER remove existing exception classes (breaking change)
- ALWAYS add new exception classes under `LibNameException`
- ALWAYS wrap external exceptions at boundaries
- ALWAYS include meaningful exception messages with cause chains
- Check existing hierarchy before creating new exception classes
- Place exception classes in the `exception/` package

## Changelog
<!-- [PROJ-123] Added RateLimitException for API throttling -->
