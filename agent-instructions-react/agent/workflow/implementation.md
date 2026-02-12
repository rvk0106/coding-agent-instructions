# Implementation
> Tags: code, conventions, react, typescript, components
> Scope: Coding rules to follow when implementing a phase

## General
- Read the plan from `docs/TICKET-ID-plan.md` FIRST
- Touch ONLY files listed for the phase
- No unrelated refactors
- Reuse existing components/hooks -- check `architecture/component-design.md`
- If uncertain → STOP and ask

## React Conventions
- **Functional components** only (no class components except Error Boundaries)
- **TypeScript** for all new files (`.tsx` for components, `.ts` for logic)
- **Props interface** defined for every component
- **Hooks rules** — top-level only, proper dependency arrays, cleanup
- **Accessibility** — ARIA labels, semantic HTML, keyboard navigation
- **Responsive** — mobile-first, test at all breakpoints

## File Locations
```
src/components/common/       → shared reusable components (Button, Input, Modal)
src/components/layout/       → structural components (Header, Footer, Sidebar)
src/components/[feature]/    → feature-specific components
src/pages/                   → page/route components (or src/views/)
src/hooks/                   → shared custom hooks
src/context/ or src/store/   → state management
src/services/ or src/api/    → API clients, data services
src/types/                   → TypeScript type definitions
src/utils/                   → pure utility functions
src/styles/                  → global styles, design tokens
src/assets/                  → images, icons, fonts
```

## Component File Pattern
```
src/components/[feature]/
├── ComponentName.tsx              → main component
├── ComponentName.test.tsx         → tests
├── ComponentName.module.css       → styles (if CSS Modules)
├── useComponentLogic.ts           → custom hook (if complex logic)
└── index.ts                       → re-export
```

## Styling Rules
- Use the project's established CSS approach (see `architecture/styling.md`)
- Use design tokens / CSS variables for colors, spacing, etc.
- Mobile-first responsive design
- No inline styles except for truly dynamic values
- Co-locate styles with components

## Accessibility Rules
- Semantic HTML elements first (button, nav, main, section, etc.)
- Every interactive element keyboard accessible
- Every image has `alt` text
- Every form input has a label
- Color contrast meets WCAG AA (4.5:1)
- See `architecture/accessibility.md` for full rules

## Danger Zones
- `dangerouslySetInnerHTML` → must sanitize with DOMPurify
- Auth tokens / secrets → never in client code
- Build config changes → ask first
- Shared component breaking changes → ask first
- `any` type → use proper types instead
