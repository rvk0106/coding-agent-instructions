# Planner Instructions — React

## Analyze patterns
- Review `package.json` for dependencies (React version, state management)
- Check `src/components/` for component patterns
- Examine `src/pages/` or `src/views/` for page structure
- Review `src/hooks/` for custom hooks
- Check `src/context/` or `src/store/` for state management
- Review `src/services/` or `src/api/` for API integration
- Check `src/types/` for TypeScript definitions
- Review test patterns (`*.test.tsx`, `*.spec.tsx`)

## Danger zones
- Auth state and token management
- API error handling and retry logic
- Environment variable changes
- Build configuration (webpack, vite)
- Third-party library integrations

## Verification commands
- Tests: `npm test` or `yarn test`
- Lint: `npm run lint`
- Type check: `tsc --noEmit`
- Build: `npm run build`
- Run: `npm run dev` or `npm start`

## Save to: `docs/TICKET-ID-plan.md`
