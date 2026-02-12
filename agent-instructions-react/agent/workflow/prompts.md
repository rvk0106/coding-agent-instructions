# Pre-Built Agent Prompts
> Tags: prompts, templates, commands, shortcuts
> Scope: Copy-paste prompts for common React tasks

## Quick Reference
| Task | Prompt |
|------|--------|
| New Component | Use "New Component" below |
| New Page / Route | Use "New Page" below |
| Styling / Theme | Use "Styling Change" below |
| State Management | Use "State Change" below |
| API Integration | Use "API Integration" below |
| Bug Fix | Use "Bug Fix" below |
| Accessibility | Use "Accessibility Fix" below |
| Performance | Use "Performance Optimization" below |
| Refactor | Use "Refactor" below |

---

## New Component
```
Add a new component:
- Name: [ComponentName]
- Location: [src/components/feature/ or src/components/common/]
- Props: [list with TypeScript types]
- Behavior: [what it does]
- Design: [Figma link or description]

Before implementing, read context-router.md → "New Component" for full file list.

Create: component, TypeScript interface, styles, tests.
Verify: npm test -- ComponentName && npm run lint && tsc --noEmit
Visual: test at mobile (375px), tablet (768px), desktop (1280px)
```

## New Page / Route
```
Add a new page:
- Route: [/path]
- Page component: [PageName]
- Data needed: [API endpoints or state]
- Layout: [which layout components to use]
- Design: [Figma link or description]

Before implementing, read context-router.md → "New Page / Route" for full file list.

Create: page component, route config, data hooks, tests.
Verify: npm test && npm run lint && tsc --noEmit && npm run build
Visual: check all breakpoints, loading/error/empty states
```

## Styling Change
```
Update styling:
- Target: [component/page/global]
- Change: [what to change — colors, spacing, responsive, theme]
- Design: [Figma link or description]

Before implementing, read context-router.md → "Styling / Theme Change" for full file list.

Verify: npm run lint && tsc --noEmit
Visual: all breakpoints, dark mode (if applicable), contrast check
```

## State Change
```
Modify state management:
- What: [add/change state for feature X]
- Approach: [local state / context / store]
- Consumers: [which components use this state]

Before implementing, read context-router.md → "State Management Change" for full file list.

Verify: npm test && npm run lint && tsc --noEmit
```

## API Integration
```
Add/modify API integration:
- Endpoint: [GET/POST/PUT/DELETE /path]
- Request: [body/params]
- Response: [TypeScript type]
- UI states: [loading, error, empty, success]

Before implementing, read context-router.md → "API Integration" for full file list.

Create: API service, query/mutation hook, TypeScript types, tests.
Verify: npm test && npm run lint && tsc --noEmit
```

## Bug Fix
```
Fix bug:
- Symptom: [what's happening]
- Expected: [what should happen]
- Location: [component/page if known]

Before implementing, read context-router.md → "Bug Fix" for full file list.

Steps: reproduce → identify root cause → fix → add regression test.
Verify: npm test -- [affected] && npm run lint && tsc --noEmit
```

## Accessibility Fix
```
Fix accessibility issue:
- Issue: [what's broken — keyboard, screen reader, contrast, etc.]
- Component: [which component]
- Standard: [WCAG 2.1 AA rule]

Before implementing, read context-router.md → "Accessibility Fix" for full file list.

Verify: npm run lint && manual keyboard test && screen reader test
```

## Performance Optimization
```
Optimize performance:
- Issue: [slow render, large bundle, unnecessary re-renders, etc.]
- Target: [component/page/bundle]
- Metric: [what to improve]

Before implementing, read context-router.md → "Performance Optimization" for full file list.

Steps: profile → identify bottleneck → optimize → measure improvement.
Verify: npm test && npm run build (check bundle size)
```

## Refactor
```
Refactor:
- Target: [file/component/hook]
- Reason: [too large, duplicated, etc.]
- Constraint: NO behavior changes

Before implementing, read context-router.md → "Refactor" for full file list.

Verify: npm test && npm run lint && tsc --noEmit
```
