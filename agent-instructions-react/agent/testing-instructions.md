# Testing Instructions — React

## Source: `docs/TICKET-ID-plan.md`

## Fast checks
- Component tests: `npm test -- ComponentName`
- Lint: `npm run lint`
- Type check: `tsc --noEmit`

## Full checks
- All tests: `npm test -- --coverage`
- Build: `npm run build`
- Bundle size: Check build output

## React-specific
- Run dev server: `npm run dev`
- Test UI at breakpoints (mobile, tablet, desktop)
- Check accessibility with browser tools
- Verify no console errors/warnings
