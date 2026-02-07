# Implementer Instructions — React

## Read `docs/TICKET-ID-plan.md` first

## React conventions
- **Components**: Functional components with hooks
- **State**: useState, useReducer, or state management library
- **Effects**: useEffect with proper dependencies and cleanup
- **Props**: TypeScript interfaces for prop types
- **Styling**: CSS modules, styled-components, or Tailwind
- **Accessibility**: ARIA labels, semantic HTML, keyboard navigation

## File structure
- Components: `src/components/`
- Pages: `src/pages/`
- Hooks: `src/hooks/`
- Context/Store: `src/context/` or `src/store/`
- Services: `src/services/`
- Types: `src/types/`
- Utils: `src/utils/`
- Tests: `src/__tests__/` or alongside files

## Quality rules
- TypeScript for type safety
- PropTypes or TS interfaces
- Accessibility attributes
- Responsive design (mobile, tablet, desktop)
- Error boundaries for error handling
- Loading and error states for async operations
- Tests with React Testing Library

## Post-implementation
1) Run tests: `npm test`
2) Lint: `npm run lint`
3) Type check: `tsc --noEmit`
4) Build: `npm run build`
5) Test in browser at all breakpoints
