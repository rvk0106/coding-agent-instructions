# Dependencies
> Tags: npm, packages, runtime, devDependencies, external
> Scope: All dependencies the project relies on
> Last updated: [TICKET-ID or date]

## Dependency Philosophy
- Prefer small, focused packages over monolithic ones
- Evaluate bundle size impact before adding (use bundlephobia.com)
- Keep dependencies up to date — audit regularly
- Every dependency must be justified

## Core Dependencies (package.json)
<!-- List key runtime dependencies -->
| Package | Version | Purpose | Bundle Impact |
|---------|---------|---------|---------------|
| `react` | ^18 | UI library | Core |
| `react-dom` | ^18 | DOM renderer | Core |
| `react-router-dom` | ^6 | Routing | [size] |
| `@tanstack/react-query` | ^5 | Server state | [size] |
| `typescript` | ^5 | Type safety | Dev only |
| [Add more] | | | |

## Dev Dependencies
| Package | Purpose |
|---------|---------|
| `vite` or `webpack` | Bundler |
| `eslint` | Linter |
| `prettier` | Formatter |
| `vitest` or `jest` | Test runner |
| `@testing-library/react` | Component testing |
| `@testing-library/jest-dom` | DOM matchers |
| [Add more] | |

## External Services / APIs
<!-- Services the app talks to -->
- Backend API: [URL / description]
- Auth provider: [Auth0 / Firebase Auth / custom / none]
- Analytics: [GA4 / Mixpanel / none]
- Error tracking: [Sentry / Bugsnag / none]
- CDN: [CloudFront / Cloudflare / none]

## Adding Dependencies
Before adding a new package:
1. Check if the feature can be done with vanilla JS/React
2. Check bundle size at bundlephobia.com
3. Check maintenance status (last release, open issues, downloads)
4. Check for tree-shaking support
5. Prefer packages with TypeScript types included
6. Document the justification in this file

## Changelog
<!-- [PROJ-123] Added @tanstack/react-query for server state -->
