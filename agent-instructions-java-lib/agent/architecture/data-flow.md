# Data Flow & Call Lifecycle
> Tags: flow, pipeline, lifecycle, call-chain, thread-safety
> Scope: How data flows through the library from consumer input to output
> Last updated: [TICKET-ID or date]

## Primary Call Flow
```
Consumer Code
  → LibName.publicMethod(args)
    → Validate input (Objects.requireNonNull, constraint checks)
    → Core logic
      → [Interceptors / hooks] (if applicable)
      → [External service calls] (if applicable)
      → [Data transformation]
    → Return result
  → Consumer receives result / exception
```

## Configuration Flow
```
LibConfig.builder()
    .apiKey("...")
    .timeout(Duration.ofSeconds(30))
    .build()
  → Builder validates and creates immutable Config
  → Config passed to LibName.create(config)
  → Stored as final field, used by internal components
```

## SPI / Plugin Flow
<!-- DELETE this section if the library has no plugin system -->
```
ServiceLoader.load(PluginInterface.class)
  → Discovers implementations via META-INF/services
  → Each plugin registered in order
  → Plugin lifecycle: init → configure → execute → cleanup
```
- SPI interfaces live in the `spi/` package
- Implementations discovered via `java.util.ServiceLoader`
- Consumers can provide custom implementations

## Interceptor / Hook Flow
<!-- DELETE this section if the library has no interceptors -->
```
Request → [Interceptor 1] → [Interceptor 2] → Core → [Interceptor 2] → [Interceptor 1] → Response
```
- Interceptors run in order for requests, reverse order for responses
- Each interceptor can modify input/output or short-circuit

## External Service Flow
<!-- DELETE this section if the library makes no external calls -->
```
Core logic → build request → [retry logic] → HTTP/network call → parse response → return result
  ├── Success → transform to domain object
  ├── Timeout → throw TimeoutException (with retry if configured)
  ├── Auth failure → throw AuthenticationException
  └── Other error → throw ConnectionException
```

## Thread Safety
- **Configuration**: Immutable after build → thread-safe
- **Client instances**: [thread-safe? / create per-thread — document]
- **Mutable state**: [list any mutable shared state and protection mechanism]
  - Use `synchronized`, `ReentrantLock`, or `java.util.concurrent` collections
  - Prefer `ConcurrentHashMap` over `Collections.synchronizedMap`
  - Use `AtomicReference`, `AtomicInteger` for simple shared state
  - Document thread-safety guarantees in Javadoc

## Stream API Usage
- Use `Stream` for collection transformations internally
- Never return `Stream` from public API (prefer `List`, `Set`, or `Collection`)
- Avoid parallel streams unless the operation is CPU-bound and measured

## CompletableFuture
<!-- DELETE this section if the library is synchronous-only -->
```java
// If the library provides async API:
public CompletableFuture<Result> executeAsync(Input input) {
    return CompletableFuture.supplyAsync(() -> execute(input), executor);
}
```
- Provide both sync and async variants if async is supported
- Use a configurable `Executor` — never default to `ForkJoinPool.commonPool()`
- Propagate exceptions as `CompletionException` wrapping library exceptions

## Changelog
<!-- [PROJ-123] Added interceptor pipeline for request/response processing -->
