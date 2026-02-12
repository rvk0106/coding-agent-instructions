# Error Handling
> Tags: errors, exceptions, hierarchy, try-except
> Scope: How errors are defined, raised, and caught in the package
> Last updated: [TICKET-ID or date]

## Exception Hierarchy
```python
# src/package_name/exceptions.py

class PackageNameError(Exception):
    """Base error -- all package errors inherit from this."""
    pass

# Configuration errors
class ConfigurationError(PackageNameError):
    """Raised when configuration is invalid or missing."""
    pass

# Input / argument errors
class ValidationError(PackageNameError):
    """Raised when input fails validation."""
    pass

# External service errors (if package talks to external services)
class ConnectionError(PackageNameError):
    """Raised when a connection to an external service fails."""
    pass

class TimeoutError(PackageNameError):
    """Raised when an operation exceeds the timeout."""
    pass

class AuthenticationError(PackageNameError):
    """Raised when authentication fails."""
    pass

class RateLimitError(PackageNameError):
    """Raised when a rate limit is exceeded."""
    pass

# Resource errors
class NotFoundError(PackageNameError):
    """Raised when a requested resource is not found."""
    pass

# [Add project-specific errors here]
```

## Error Raising Rules
- ALWAYS raise package-specific errors (never raw `Exception` or `RuntimeError`)
- ALWAYS include a meaningful message
- Include context data when helpful
```python
# CORRECT
raise ConfigurationError(
    "API key is required -- set via package_name.configure(api_key='...')"
)

# WRONG -- generic error, no context
raise Exception("missing key")
```

## Error Catching Patterns
```python
# Consumer-facing: catch the base error
try:
    package_name.process(data)
except package_name.PackageNameError as e:
    # handles all package errors
    log.error(f"Package error: {e}")

# Consumer-facing: catch specific errors
try:
    package_name.process(data)
except package_name.TimeoutError:
    retry_with_backoff()
except package_name.AuthenticationError:
    refresh_credentials()
except package_name.PackageNameError as e:
    log_and_reraise(e)
```

## Internal Error Handling
- Wrap external library exceptions at the boundary
- Never let third-party exceptions leak to consumers
```python
# CORRECT -- wrap external errors
import httpx

def _fetch_data(url: str) -> dict:
    try:
        response = httpx.get(url, timeout=self._timeout)
        response.raise_for_status()
        return response.json()
    except httpx.TimeoutException as e:
        raise TimeoutError(
            f"Request timed out after {self._timeout}s: {e}"
        ) from e
    except httpx.ConnectError as e:
        raise ConnectionError(f"Failed to connect to {url}: {e}") from e
    except httpx.HTTPStatusError as e:
        raise PackageNameError(
            f"HTTP {e.response.status_code}: {e}"
        ) from e

# WRONG -- leaks httpx errors to consumers
def _fetch_data(url: str) -> dict:
    return httpx.get(url).json()
```

## Error Message Guidelines
- Start with WHAT went wrong
- Include HOW to fix when possible
- Include relevant context (values, limits, etc.)
```python
# Good
"Rate limit exceeded (429): retry after {retry_after}s"
"API key is invalid -- regenerate at https://example.com/settings"
"Timeout after 30s connecting to api.example.com -- increase timeout or check network"

# Bad
"error"
"something went wrong"
```

## Exception Chaining
- Always use `raise ... from e` when wrapping exceptions
- This preserves the original traceback for debugging
```python
try:
    external_call()
except SomeExternalError as e:
    raise PackageNameError(f"External call failed: {e}") from e
```

## Rules for Agents
- NEVER remove existing error classes (breaking change)
- ALWAYS add new error classes under `PackageNameError`
- ALWAYS wrap external exceptions at boundaries using `from e`
- ALWAYS include meaningful error messages
- Check existing hierarchy before creating new error classes

## Changelog
<!-- [PROJ-123] Added RateLimitError for API throttling -->
