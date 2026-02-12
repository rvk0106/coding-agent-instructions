# Security Rules
> Tags: security, validation, audit, safe-coding
> Scope: Security constraints agents must follow when developing the gem
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never use `eval`, `instance_eval`, or `class_eval` with user-provided strings
- Never use `send` or `public_send` with user-controlled method names
- Never use `system`, `exec`, `%x{}`, or backticks with unsanitized input
- Never hardcode secrets, API keys, or credentials in code
- Never log sensitive data (keys, tokens, passwords, PII)
- Never use `Marshal.load` on untrusted data
- Never use `YAML.load` on untrusted data (use `YAML.safe_load`)
- Never monkey-patch core classes without explicit opt-in from the consumer

## Always Do These
- Always validate and sanitize input at the gem's public API boundary
- Always use `Shellwords.escape` if shelling out is unavoidable
- Always freeze string literals (`# frozen_string_literal: true`) in every file
- Always keep dependencies up to date (audit with `bundle audit`)
- Always handle sensitive data in memory carefully (clear after use if possible)

## Input Validation
```ruby
# CORRECT: validate at the public API boundary
def process(input)
  raise GemName::ArgumentError, "input must be a String" unless input.is_a?(String)
  raise GemName::ArgumentError, "input must not be empty" if input.empty?
  # proceed with validated input
end

# WRONG: trust user input
def process(input)
  eval(input)  # NEVER
end
```

## Dependency Auditing
```bash
# Check for known vulnerabilities in dependencies
bundle audit check --update

# Keep gems up to date
bundle outdated
bundle update --conservative
```

## Safe Metaprogramming
```ruby
# CORRECT: define methods from a known list
ALLOWED_METHODS = %i[get post put delete].freeze

ALLOWED_METHODS.each do |method|
  define_method(method) do |*args|
    request(method, *args)
  end
end

# WRONG: dynamic method names from user input
def method_missing(name, *args)
  send(name, *args)  # dangerous if name comes from user
end
```

## File Operations
- Never write to arbitrary paths — validate and restrict
- Use `File.expand_path` and check against allowed directories
- Prefer `Tempfile` for temporary files (auto-cleanup)

## HTTP/Network
- Always use HTTPS, not HTTP
- Always set timeouts on HTTP connections
- Always validate SSL certificates (don't disable verification)
- Never interpolate user input into URLs without encoding

## Changelog
<!-- [PROJ-123] Added input validation for all public methods -->
