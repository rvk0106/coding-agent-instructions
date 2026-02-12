# Data Flow & Call Lifecycle
> Tags: flow, pipeline, middleware, lifecycle, call-chain
> Scope: How data flows through the gem from consumer input to output
> Last updated: [TICKET-ID or date]

## Primary Call Flow
```
Consumer Code
  → GemName.public_method(args)
    → Validate input (arguments, configuration)
    → Core logic
      → [Middleware / hooks] (if applicable)
      → [External service calls] (if applicable)
      → [Data transformation]
    → Return result
  → Consumer receives result / error
```

## Configuration Flow
```
GemName.configure { |c| c.key = "..." }
  → Configuration object stores values
  → Lazy validation on first use
  → Client/core reads config as needed
```

## Middleware / Plugin Flow
<!-- DELETE this section if the gem has no middleware/plugin system -->
```
Request → [Middleware 1] → [Middleware 2] → Core → [Middleware 2] → [Middleware 1] → Response
```
- Middleware runs in order for requests, reverse order for responses
- Each middleware can modify input/output or short-circuit

## Callback / Hook Flow
<!-- DELETE this section if the gem has no callbacks -->
```
Operation → before_hook → execute → after_hook → return
  ├── Success → after_success hook
  └── Failure → after_failure hook
```

## External Service Flow
<!-- DELETE this section if the gem makes no external calls -->
```
Core logic → build request → [retry logic] → HTTP call → parse response → return result
  ├── Success → transform to domain object
  ├── Timeout → raise GemName::TimeoutError (with retry if configured)
  ├── Auth failure → raise GemName::AuthenticationError
  └── Other error → raise GemName::ConnectionError
```

## Thread Safety
- Configuration: [thread-safe? / not thread-safe — document]
- Client instances: [thread-safe? / create per-thread]
- Mutable state: [list any mutable shared state and protection mechanism]

## Changelog
<!-- [PROJ-123] Added middleware pipeline for request/response processing -->
