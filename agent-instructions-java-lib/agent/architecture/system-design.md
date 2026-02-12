# System Design
> Tags: architecture, components, modules, packages, high-level
> Scope: How the library is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this library does -->
[Describe what this library does and who it serves.]

## Key Components
<!-- Replace placeholders with your actual structure -->
```
[Consumer Code] → [LibName.create() / LibName.builder()]
                    → [Core Module] → [Adapters / Backends] (if used)
                    → [Interceptors / Hooks] (if used)
                    → [External Services] (if used)
```
- Core: [e.g. main processing logic / client / engine]
- Adapters: [e.g. HTTP backends / storage backends / none]
- Interceptors: [e.g. request/response pipeline / none]

## Module/Package Structure
<!-- Map out the package hierarchy -->
```java
com.example.lib
├── api/              // Public interfaces, entry points
├── core/             // Core logic, internal implementation
├── impl/             // Interface implementations (not exported if JPMS)
├── config/           // Configuration classes, builders
├── exception/        // Exception hierarchy
├── util/             // Internal utilities
├── spi/              // Service Provider Interface (if pluggable)
└── model/            // Value objects, DTOs
```

### Java Module System (JPMS) — if used
```java
module com.example.lib {
    exports com.example.lib.api;
    exports com.example.lib.config;
    exports com.example.lib.exception;
    exports com.example.lib.model;
    // impl/ and core/ are NOT exported
    requires java.base;
    // [Add required modules]
}
```

## Dependencies
- Runtime: [list runtime dependencies, prefer minimal]
- Development: [list dev-only dependencies]

## Java Version Support
- Minimum: [e.g. Java 17]
- Tested: [e.g. 17, 21]
- Baseline: [e.g. compile with 17, test on 17 and 21]

## Key Data Flows
<!-- Describe 2-3 critical flows through the library -->
1. **Configuration**: `LibName.builder().option(value).build()` → stores in `Config` → used by `Core`
2. **[Flow Name]**: [step] → [step] → [step]
3. **[Flow Name]**: [step] → [step] → [step]

## Changelog
<!-- [PROJ-123] Added SPI pattern for pluggable backends -->
