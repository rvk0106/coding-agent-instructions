# Data Flow & Call Lifecycle
> Tags: flow, pipeline, middleware, lifecycle, call-chain
> Scope: How data flows through the package from consumer input to output
> Last updated: [TICKET-ID or date]

## Primary Call Flow
```
Consumer Code
  → packageName.publicMethod(args)
    → Validate input (arguments, configuration)
    → Core logic
      → [Plugin / middleware chain] (if applicable)
      → [External service calls] (if applicable)
      → [Data transformation]
    → Return result
  → Consumer receives result / error
```

## Configuration / Options Merging
```
createClient({ userOption: value })
  → Validate required options
  → Merge with DEFAULT_OPTIONS (spread / Object.assign)
  → Freeze configuration (prevent mutation)
  → Return configured client instance

// Pattern:
const config = Object.freeze({ ...DEFAULT_OPTIONS, ...userOptions });
```

## Plugin / Middleware Chain
<!-- DELETE this section if the package has no plugin/middleware system -->
```
Request → [Plugin 1] → [Plugin 2] → Core → [Plugin 2] → [Plugin 1] → Response
```
- Plugins run in registration order for requests, reverse order for responses
- Each plugin can modify input/output or short-circuit
```typescript
interface Plugin {
  name: string;
  onRequest?(request: Request): Request | Promise<Request>;
  onResponse?(response: Response): Response | Promise<Response>;
  onError?(error: LibNameError): void;
}
```

## Event Emitter Patterns
<!-- DELETE this section if the package does not emit events -->
```typescript
// If the package extends EventEmitter or provides event hooks:
client.on('request', (req) => { /* before request */ });
client.on('response', (res) => { /* after response */ });
client.on('error', (err) => { /* on error */ });
client.on('retry', (attempt, err) => { /* on retry */ });
```

## Stream Handling
<!-- DELETE this section if the package does not handle streams -->
```
Input Stream → Transform → [Backpressure handling] → Output Stream
  ├── 'data' event → process chunk → push to output
  ├── 'error' event → wrap in LibNameError → emit 'error' on output
  └── 'end' event → flush remaining → emit 'end' on output
```

## External Service Flow
<!-- DELETE this section if the package makes no external calls -->
```
Core logic → build request → [retry logic] → HTTP call → parse response → return result
  ├── Success → transform to typed result
  ├── Timeout → throw TimeoutError (with retry if configured)
  ├── Auth failure → throw ConfigError
  └── Other error → throw ConnectionError
```

## Thread Safety / Concurrency
- Node.js is single-threaded (event loop) — no mutex/lock needed for most cases
- Client instances: [safe to share? / create per-context]
- Mutable state: [list any mutable shared state and protection mechanism]
- If using Worker threads: [document shared state isolation]

## Changelog
<!-- [PROJ-123] Added plugin pipeline for request/response processing -->
