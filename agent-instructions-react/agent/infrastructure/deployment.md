# Deployment
> Tags: build, hosting, cdn, deploy, preview
> Scope: How the application is built and deployed
> Last updated: [TICKET-ID or date]

## Build
```bash
npm run build
# Output: dist/ (Vite) or build/ (CRA) or .next/ (Next.js)
```

## Build Output
- Static files: [dist/ / build/ / .next/]
- Entry: `index.html` (SPA) or server routes (SSR)
- Assets: hashed filenames for cache busting

## Hosting
- Platform: [Vercel / Netlify / AWS S3+CloudFront / Firebase Hosting / custom]
- URL: [e.g. `https://app.example.com`]
- Staging: [e.g. `https://staging.example.com`]

## Deploy Process
<!-- Document how deploys happen -->
- **Production**: [auto on merge to main / manual trigger / CD pipeline]
- **Preview**: [auto per PR / Vercel/Netlify preview deployments]
- **Staging**: [auto on push to staging branch / manual]

## Environment-Specific Config
| Environment | API URL | Features |
|-------------|---------|----------|
| Development | `http://localhost:3001` | Debug tools enabled |
| Staging | `https://staging-api.example.com` | Feature flags enabled |
| Production | `https://api.example.com` | Analytics, error tracking |

## Performance Budget (if defined)
<!-- DELETE if no performance budget -->
| Metric | Budget |
|--------|--------|
| First Contentful Paint | < 1.5s |
| Largest Contentful Paint | < 2.5s |
| Total JS bundle | < 200 KB gzipped |
| Time to Interactive | < 3.5s |

## Danger Zones (hard stop, ask first)
- Changing build config (bundler, output, targets)
- Modifying deployment pipeline
- Changing environment variables in production
- Updating Node.js version in CI

## Changelog
<!-- [PROJ-123] Migrated from Netlify to Vercel -->
