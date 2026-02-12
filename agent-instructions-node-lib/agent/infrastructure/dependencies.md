# Dependencies
> Tags: npm, package-json, runtime, development, peer
> Scope: All dependencies the package relies on
> Last updated: [TICKET-ID or date]

## Dependency Philosophy
- **Minimal runtime dependencies** — fewer deps = fewer conflicts, smaller bundles for consumers
- Prefer Node.js built-in modules (`node:fs`, `node:path`, `node:crypto`) over npm packages
- Use version ranges (`^` or `~`) not exact versions for runtime deps
- Every runtime dependency must be justified

## Runtime Dependencies (package.json `dependencies`)
<!-- List packages added as runtime dependencies -->
| Package | Version | Purpose | Justification |
|---------|---------|---------|---------------|
| [e.g. `undici`] | `^6.0.0` | HTTP client | [why not built-in fetch] |
| [e.g. none] | - | - | Prefer zero runtime deps |

## Development Dependencies (package.json `devDependencies`)
<!-- List packages used for development only -->
| Package | Purpose |
|---------|---------|
| `typescript` | Type checking and declaration generation |
| `tsup` / `rollup` / `esbuild` | Bundler (ESM + CJS output) |
| `vitest` / `jest` | Test framework |
| `eslint` | Linter |
| `prettier` | Code formatter |
| `@types/node` | Node.js type definitions |
| [Add project-specific dev deps] |

## Peer Dependencies (package.json `peerDependencies`)
<!-- List peer dependencies if the package is a plugin or extension -->
| Package | Version | Why Peer |
|---------|---------|----------|
| [e.g. `react`] | `^18.0.0` | [consumer must provide their own React] |
| [e.g. none] | - | - |

## Process for Adding Dependencies
Before adding a new runtime dependency:
1. **Check built-in**: Can Node.js built-in modules do the job? (`node:fs`, `node:crypto`, `node:http`, `fetch`)
2. **Check bundle size**: Use [bundlephobia.com](https://bundlephobia.com) to check package size impact
3. **Check maintenance**: Is the package actively maintained? Check last publish date, open issues
4. **Check alternatives**: Are there smaller/zero-dep alternatives?
5. **Document justification**: Add to this file with clear reason
6. **Use loosest compatible range**: `^major.minor.patch` preferred

## Changelog
<!-- [PROJ-123] Added undici ^6.0.0 for HTTP/2 support -->
