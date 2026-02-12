# Environment
> Tags: node, browser, runtime, versions
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Node.js: [e.g. >= 18 LTS]
- Package manager: [npm / yarn / pnpm]
- Bundler: [Vite / webpack / Next.js / CRA]

## Browser Support
| Browser | Minimum Version |
|---------|----------------|
| Chrome | [e.g. last 2 versions] |
| Firefox | [e.g. last 2 versions] |
| Safari | [e.g. last 2 versions] |
| Edge | [e.g. last 2 versions] |
| iOS Safari | [e.g. last 2 versions] |
| Android Chrome | [e.g. last 2 versions] |

## Framework
- React: [e.g. 18.x]
- TypeScript: [e.g. 5.x]
- Router: [React Router 6 / Next.js / etc.]

## Local Setup
```bash
# Minimum commands to get running
git clone [repo]
cd project-name
npm install        # or yarn / pnpm install
npm run dev        # start dev server
```

## Environment Variables
<!-- List env vars the app uses -->
| Variable | Purpose | Required | Example |
|----------|---------|----------|---------|
| `VITE_API_URL` | Backend API base URL | Yes | `https://api.example.com` |
| `VITE_APP_ENV` | App environment | No | `development` |
| [Add more] | | | |

**Rules:**
- `.env.local` is gitignored — never commit secrets
- Prefix with `VITE_` (Vite) or `NEXT_PUBLIC_` (Next.js) or `REACT_APP_` (CRA) to expose to client
- NEVER put server-side secrets in client env vars — they ship in the bundle

## Changelog
<!-- [PROJ-123] Updated to Node 20 LTS -->
