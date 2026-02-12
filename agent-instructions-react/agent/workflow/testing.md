# Testing
> Tags: test, verify, rtl, eslint, typescript, build
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
> **Note:** Commands below are defaults. Check `infrastructure/tooling.md` for project-specific test/lint commands.

```bash
npm test -- ComponentName              # tests for touched components
npm run lint                           # ESLint
tsc --noEmit                           # TypeScript type checking
```

## Full Checks (when required)
```bash
npm test -- --coverage                 # full test suite with coverage
npm run lint                           # full lint
tsc --noEmit                           # full type check
npm run build                          # verify production build succeeds
```

## Visual / Manual Checks (for UI changes)
```
- [ ] Dev server: npm run dev → open in browser
- [ ] Mobile viewport (375px) — layout, touch targets, text size
- [ ] Tablet viewport (768px) — layout adapts properly
- [ ] Desktop viewport (1280px) — full layout renders
- [ ] No console errors or warnings
- [ ] Loading states display correctly
- [ ] Error states display correctly
- [ ] Empty states display correctly
```

## Accessibility Checks
```bash
npm run lint                           # eslint-plugin-jsx-a11y catches common issues
```
```
Manual:
- [ ] Tab through — all interactive elements reachable
- [ ] Focus visible on all elements
- [ ] Screen reader test (or browser a11y inspector)
- [ ] Color contrast check (browser DevTools)
```

## Bundle Checks (when dependencies or build changed)
```bash
npm run build                          # check build output
# Review bundle size in build output
npm audit                              # security audit
```

## Reporting Format
```
Commands run:
- `npm test -- ComponentName` → PASS/FAIL
- `npm run lint` → PASS/FAIL (N issues)
- `tsc --noEmit` → PASS/FAIL (N errors)
Visual checks:
- Mobile: [PASS/FAIL]
- Tablet: [PASS/FAIL]
- Desktop: [PASS/FAIL]
- Accessibility: [PASS/FAIL]
If FAIL → STOP and ask before continuing
```
