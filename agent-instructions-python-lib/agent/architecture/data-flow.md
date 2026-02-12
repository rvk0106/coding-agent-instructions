# Data Flow & Call Lifecycle
> Tags: flow, pipeline, lifecycle, call-chain
> Scope: How data flows through the package from consumer input to output
> Last updated: [TICKET-ID or date]

## Primary Call Flow
```
Consumer Code
  -> package_name.public_func(args)
    -> Validate input (type checks, value checks)
    -> Core logic
      -> [Hooks / callbacks] (if applicable)
      -> [External service calls] (if applicable)
      -> [Data transformation]
    -> Return result
  -> Consumer receives result / exception
```

## Configuration Flow
```
package_name.configure(api_key="...", timeout=30)
  -> Config dataclass/object stores values
  -> Validation on construction (fail-fast)
  -> Core modules read config as needed
```

## Plugin / Hook Flow
<!-- DELETE this section if the package has no plugin/hook system -->
```
Request -> [Plugin 1] -> [Plugin 2] -> Core -> [Plugin 2] -> [Plugin 1] -> Response
```
- Plugins run in registration order for input, reverse for output
- Each plugin can modify input/output or short-circuit

## Callback / Event Flow
<!-- DELETE this section if the package has no callbacks -->
```
Operation -> before_hook() -> execute() -> after_hook() -> return
  |-- Success -> on_success callback
  |-- Failure -> on_error callback
```

## External Service Flow
<!-- DELETE this section if the package makes no external calls -->
```
Core logic -> build request -> [retry logic] -> HTTP call -> parse response -> return result
  |-- Success -> transform to domain object
  |-- Timeout -> raise TimeoutError (with retry if configured)
  |-- Auth failure -> raise AuthenticationError
  |-- Other error -> raise ConnectionError
```

## Thread Safety
- Configuration: [thread-safe? / not thread-safe -- document]
- Client instances: [thread-safe? / create per-thread]
- Mutable state: [list any mutable shared state and protection mechanism]
- Consider `threading.Lock` for shared mutable state
- Consider `contextvars` for per-context state

## Async Support
<!-- DELETE this section if no async support -->
- Async variants: [e.g. `async_process()` / `AsyncClient` / none]
- Event loop: [asyncio / trio / none]
- Sync wrappers: [if sync API wraps async internals, document how]

## Changelog
<!-- [PROJ-123] Added retry logic to external service flow -->
