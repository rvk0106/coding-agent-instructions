# Tooling
> Tags: bundler, linter, test, ci, formatter, quality
> Scope: Dev tools, CI/CD pipeline, quality checks
> Last updated: [TICKET-ID or date]

## Bundler
- Tool: [Vite / webpack / Next.js / CRA]
- Config: [e.g. `vite.config.ts` / `webpack.config.js`]
- Dev server: `npm run dev`
- Build: `npm run build`
- Preview: `npm run preview` (Vite) or `npx serve dist`

## Linting
- ESLint: `npm run lint`
- Config: `.eslintrc.js` or `eslint.config.js`
- Plugins: [e.g. react, react-hooks, jsx-a11y, import, typescript-eslint]
- Auto-fix: `npm run lint -- --fix`

## Formatting
- Prettier: `npm run format` (if configured)
- Config: `.prettierrc`
- Ignored: `.prettierignore`

## Type Checking
- TypeScript: `tsc --noEmit`
- Config: `tsconfig.json`
- Strict mode: [enabled / disabled]

## Testing
- Framework: [Vitest / Jest]
- Library: React Testing Library
- Run all: `npm test`
- Run specific: `npm test -- ComponentName`
- Coverage: `npm test -- --coverage`
- Watch mode: `npm test -- --watch`
- Config: [e.g. `vitest.config.ts` / `jest.config.js`]

## Storybook (if used)
<!-- DELETE this section if no Storybook -->
- Start: `npm run storybook`
- Build: `npm run build-storybook`
- Config: `.storybook/`

## CI/CD
- Platform: [GitHub Actions / Vercel / Netlify / CircleCI]
- Config: [e.g. `.github/workflows/ci.yml`]
- Pipeline steps: lint → type-check → test → build
- Deploy: [auto on merge to main / manual / preview per PR]
- Required checks before merge: [list them]

## Code Quality
- PR review required: [yes/no, how many]
- Branch strategy: [feature branches → main]
- Commit convention: [conventional commits / free-form]

## Changelog
<!-- [PROJ-123] Migrated from CRA to Vite -->
