# Sample Ticket Plan

**Location**: `docs/PROJ-201-plan.md`

## Ticket metadata
- Ticket ID: PROJ-201
- Title: Add streaming support with backpressure handling
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Add streaming API for processing large datasets
- Support Node.js Readable/Writable/Transform streams
- Handle backpressure correctly (pause upstream when downstream is slow)
- Emit progress events during streaming
- Must not break existing non-streaming API
- Non-goals: WebSocket support, browser ReadableStream API

## Current state analysis
- Reviewed `src/core/processor.ts`: batch processing only, loads everything into memory
- Checked `src/types/index.ts`: has `ProcessResult` type, no stream types
- Reviewed `src/errors/index.ts`: has `ValidationError`, `TimeoutError`
- Analyzed `tests/core/processor.test.ts`: tests for batch processing
- Checked `package.json`: no stream-related dependencies, exports field has single entry point
- Reviewed `CHANGELOG.md`: last release was v2.1.0

## Context Loaded
- `workflow/context-router.md` → task type: New Public Method / Function
- `architecture/public-api.md` → exports, backward compatibility, type definitions
- `architecture/error-handling.md` → error classes, error codes
- `architecture/patterns.md` → coding conventions, async patterns
- `architecture/data-flow.md` → call flow, stream handling patterns
- `features/_CONVENTIONS.md` → test patterns
- `infrastructure/security.md` → safe coding rules

## Architecture decisions
- Create a new `createStream()` factory function (not modify existing `process()`)
- Use Node.js native Transform stream (no external deps)
- Add `StreamOptions` type extending base options
- Add `StreamError` class for stream-specific errors
- Emit typed events: `data`, `progress`, `error`, `end`
- Export from main entry point alongside existing API

## Phase 1
**Goal**: Add stream types and error class.
**Context needed**: `architecture/patterns.md` (naming conventions), `architecture/error-handling.md` (error hierarchy), `architecture/public-api.md` (type export rules)
**Tasks**:
- Add `StreamOptions` and `StreamResult` types to `src/types/index.ts`
- Add `StreamError` class extending `LibNameError` with code `ERR_STREAM`
- Export new types and error from `src/index.ts`
- Add unit tests for `StreamError`
**Allowed files**:
- src/types/index.ts
- src/errors/index.ts
- src/index.ts
- tests/errors/stream-error.test.ts
**Forbidden changes**:
- No processor changes
- No new modules yet
**Verification**:
- `npm test -- --testPathPattern=errors/stream-error`
- `npm run lint`
- `tsc --noEmit`
**Acceptance criteria**:
- `StreamOptions` type exported and usable
- `StreamError` extends `LibNameError` with code `ERR_STREAM`
- Existing types and errors unchanged

## Phase 2
**Goal**: Implement streaming processor with backpressure handling.
**Context needed**: `architecture/data-flow.md` (stream patterns), `architecture/patterns.md` (module structure), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Create `src/core/stream-processor.ts` with Transform stream implementation
- Handle backpressure via `highWaterMark` and `_transform` flow control
- Emit `progress` events with processed count and total (if known)
- Wrap internal errors in `StreamError`
- Add comprehensive unit tests
**Allowed files**:
- src/core/stream-processor.ts
- tests/core/stream-processor.test.ts
- src/core/index.ts (add re-export)
**Forbidden changes**:
- No changes to existing processor
- No type changes (done in Phase 1)
**Verification**:
- `npm test -- --testPathPattern=core/stream-processor`
- `npm run lint`
- `tsc --noEmit`
**Acceptance criteria**:
- Transform stream processes chunks correctly
- Backpressure pauses upstream when downstream is slow
- Progress events emitted during processing
- Internal errors wrapped in `StreamError`

## Phase 3
**Goal**: Add `createStream()` factory function and update public API.
**Context needed**: `architecture/public-api.md` (export conventions), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Create `createStream(options: StreamOptions)` factory function
- Export from `src/index.ts`
- Update package.json if subpath export needed
- Add integration-style tests verifying full pipeline
- Update CHANGELOG.md
**Allowed files**:
- src/index.ts
- src/core/index.ts
- tests/integration/streaming.test.ts
- CHANGELOG.md
- package.json (only if exports field needs update)
**Forbidden changes**:
- No version bump (separate phase/ticket)
- No changes to batch processor behavior
**Verification**:
- `npm test -- --coverage`
- `npm run lint`
- `tsc --noEmit`
- `npm run build`
- `npm publish --dry-run`
**Acceptance criteria**:
- `createStream()` exported and documented
- ESM and CJS imports both work
- TypeScript types complete (.d.ts)
- Existing tests still pass
- CHANGELOG updated

## Next step
execute plan 1 for PROJ-201
