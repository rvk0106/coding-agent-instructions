# System Design
> Tags: architecture, components, modules, high-level
> Scope: How the gem is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this gem does -->
[Describe what this gem does and who it serves.]

## Key Components
<!-- Replace placeholders with your actual structure -->
```
[Consumer Code] → [GemName.configure / GemName.method]
                    → [Core Module] → [Adapters / Backends] (if used)
                    → [Middleware / Hooks] (if used)
                    → [External Services] (if used)
```
- Core: [e.g. main processing logic / DSL / client]
- Adapters: [e.g. HTTP backends / storage backends / none]
- Middleware: [e.g. request/response pipeline / none]

## Module Structure
<!-- Map out the namespace hierarchy -->
```ruby
module GemName
  module Configuration    # config DSL
  module Core             # main logic
  module Errors           # exception classes
  class Client            # primary entry point (if applicable)
end
```

## Dependencies
- Runtime: [list runtime gems, prefer minimal]
- Development: [list dev-only gems]

## Ruby Version Support
- Minimum: [e.g. Ruby 3.0+]
- Tested: [e.g. 3.0, 3.1, 3.2, 3.3]

## Key Data Flows
<!-- Describe 2-3 critical flows through the gem -->
1. **Configuration**: `GemName.configure { |c| ... }` → stores in `Configuration` → used by `Client`
2. **[Flow Name]**: [step] → [step] → [step]
3. **[Flow Name]**: [step] → [step] → [step]

## Changelog
<!-- [PROJ-123] Added adapter pattern for pluggable backends -->
