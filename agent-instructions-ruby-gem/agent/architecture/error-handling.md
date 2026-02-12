# Error Handling
> Tags: errors, exceptions, rescue, hierarchy
> Scope: How errors are defined, raised, and rescued in the gem
> Last updated: [TICKET-ID or date]

## Exception Hierarchy
```ruby
module GemName
  # Base error — all gem errors inherit from this
  class Error < StandardError; end

  # Configuration errors
  class ConfigurationError < Error; end

  # Input/argument errors
  class ArgumentError < Error; end
  class ValidationError < Error; end

  # External service errors (if gem talks to external services)
  class ConnectionError < Error; end
  class TimeoutError < Error; end
  class AuthenticationError < Error; end
  class RateLimitError < Error; end

  # Resource errors
  class NotFoundError < Error; end

  # [Add project-specific errors here]
end
```

## Error Raising Rules
- ALWAYS raise gem-specific errors (never raw `StandardError` or `RuntimeError`)
- ALWAYS include a meaningful message
- Include context data when helpful
```ruby
# CORRECT
raise GemName::ConfigurationError, "API key is required — set via GemName.configure { |c| c.api_key = '...' }"

# WRONG — generic error, no context
raise "missing key"
```

## Error Rescue Patterns
```ruby
# Consumer-facing: catch the base error
begin
  GemName.do_something
rescue GemName::Error => e
  # handles all gem errors
end

# Consumer-facing: catch specific errors
begin
  GemName.do_something
rescue GemName::TimeoutError => e
  retry_with_backoff
rescue GemName::AuthenticationError => e
  refresh_credentials
rescue GemName::Error => e
  log_and_reraise(e)
end
```

## Internal Error Handling
- Wrap external library exceptions at the boundary
- Never let third-party exceptions leak to consumers
```ruby
# CORRECT — wrap external errors
def fetch_data
  http_client.get(url)
rescue Faraday::TimeoutError => e
  raise GemName::TimeoutError, "Request timed out after #{timeout}s: #{e.message}"
rescue Faraday::ConnectionFailed => e
  raise GemName::ConnectionError, "Failed to connect: #{e.message}"
end

# WRONG — leaks Faraday errors to consumers
def fetch_data
  http_client.get(url)
end
```

## Error Message Guidelines
- Start with WHAT went wrong
- Include HOW to fix when possible
- Include relevant context (values, limits, etc.)
```ruby
# Good
"Rate limit exceeded (429): retry after #{retry_after}s"
"API key is invalid — regenerate at https://example.com/settings"

# Bad
"error"
"something went wrong"
```

## Rules for Agents
- NEVER remove existing error classes (breaking change)
- ALWAYS add new error classes under `GemName::Error`
- ALWAYS wrap external exceptions at boundaries
- ALWAYS include meaningful error messages
- Check existing hierarchy before creating new error classes

## Changelog
<!-- [PROJ-123] Added RateLimitError for API throttling -->
