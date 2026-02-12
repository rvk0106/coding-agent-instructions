# Design Patterns & Standards
> Tags: patterns, conventions, typescript, quality, hooks
> Scope: Coding patterns and quality standards for this React project
> Last updated: [TICKET-ID or date]

## Core Principles
- Agents are collaborators, not autonomous engineers
- Plan first → execute in small phases → verify → human review
- No scope creep, no unrelated refactors

## TypeScript Standards
- Strict mode enabled (`"strict": true` in tsconfig)
- Explicit return types on exported functions
- `interface` for object shapes, `type` for unions/intersections
- No `any` — use `unknown` and narrow, or proper generics
- No `@ts-ignore` — fix the type instead

```tsx
// CORRECT
interface UserListProps {
  users: User[];
  onSelect: (user: User) => void;
}

const UserList: React.FC<UserListProps> = ({ users, onSelect }) => { ... };

// WRONG
const UserList = ({ users, onSelect }: any) => { ... };
```

## Hooks Rules
- Only call hooks at the top level (never inside conditions/loops)
- Always include all dependencies in useEffect/useMemo/useCallback
- Clean up side effects (return cleanup function from useEffect)
- Extract complex logic into custom hooks

```tsx
// CORRECT — clean dependency array and cleanup
useEffect(() => {
  const controller = new AbortController();
  fetchData(id, { signal: controller.signal });
  return () => controller.abort();
}, [id]);

// WRONG — missing dependency, no cleanup
useEffect(() => {
  fetchData(id);
}, []);
```

## Custom Hooks
- Prefix with `use` (e.g. `useAuth`, `useDebounce`, `useMediaQuery`)
- Location: `src/hooks/` (shared) or co-located with feature component
- Return clear interface (not raw state)
- Handle loading, error, and success states

```tsx
// CORRECT — clear return interface
function useUser(userId: string) {
  const { data, isLoading, error } = useQuery({
    queryKey: ['user', userId],
    queryFn: () => fetchUser(userId),
  });
  return { user: data, isLoading, error };
}
```

## Event Handlers
- Prefix with `handle` in the component: `handleClick`, `handleSubmit`
- Prefix with `on` in props: `onClick`, `onSubmit`
```tsx
interface ButtonProps {
  onClick: () => void;  // prop: on-prefix
}

const Parent = () => {
  const handleSave = () => { ... };  // handler: handle-prefix
  return <Button onClick={handleSave} />;
};
```

## File Naming
- Components: `PascalCase.tsx` (e.g. `UserCard.tsx`)
- Hooks: `camelCase.ts` (e.g. `useAuth.ts`)
- Utils: `camelCase.ts` (e.g. `formatDate.ts`)
- Types: `camelCase.ts` or `PascalCase.ts` (e.g. `user.ts` or `User.ts`)
- Tests: `*.test.tsx` or `*.spec.tsx` (co-located or in `__tests__/`)
- Styles: `ComponentName.module.css` (if CSS Modules)
- Constants: `SCREAMING_SNAKE_CASE` for values, `camelCase` for files

## Import Order
```tsx
// 1. React / framework
import React, { useState, useEffect } from 'react';
// 2. Third-party libraries
import { useQuery } from '@tanstack/react-query';
// 3. Internal shared (hooks, utils, types, context)
import { useAuth } from '@/hooks/useAuth';
import { formatDate } from '@/utils/formatDate';
import type { User } from '@/types/user';
// 4. Relative (siblings, children)
import { UserAvatar } from './UserAvatar';
import styles from './UserCard.module.css';
```

## Performance Patterns
- `React.memo` — only for components that re-render with same props
- `useMemo` — only for expensive computations
- `useCallback` — only when passing callbacks to memoized children
- Don't optimize prematurely — profile first, optimize second
- Code splitting with `React.lazy` for route-level components

## Quality Checklist
- [ ] TypeScript types for all props and API responses
- [ ] Tests with React Testing Library for new components
- [ ] Accessibility attributes (see `architecture/accessibility.md`)
- [ ] Responsive at all breakpoints (see `architecture/styling.md`)
- [ ] Loading + error states for async operations
- [ ] No console errors or warnings
- [ ] ESLint + Prettier pass
- [ ] Build succeeds

## Changelog
<!-- [PROJ-123] Added custom hooks naming convention -->
