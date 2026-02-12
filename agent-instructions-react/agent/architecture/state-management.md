# State Management
> Tags: state, context, redux, zustand, hooks, server-state
> Scope: How application state is organized, stored, and accessed
> Last updated: [TICKET-ID or date]

## State Categories

| Category | Where | Examples |
|----------|-------|---------|
| **Local / UI state** | `useState`, `useReducer` in components | Form inputs, toggles, modals open/close, accordion state |
| **Shared / App state** | Context API or state library | Auth user, theme, locale, feature flags, shopping cart |
| **Server state** | Data fetching library (TanStack Query / SWR / RTK Query) | API data, loading/error states, cache, pagination |
| **URL state** | Router (search params, path params) | Current page, filters, sort order, active tab |
| **Form state** | Form library or local state | Field values, validation errors, dirty/touched state |

## Rules
- ALWAYS use the simplest approach that works
- Local state FIRST — lift only when needed
- Server state belongs in a data-fetching library, NOT in global store
- URL state for anything that should survive refresh or be shareable
- Do NOT duplicate server data in client state

## State Library
<!-- Fill in which library is used -->
- Library: [Context API / Redux Toolkit / Zustand / Jotai / none]
- Location: [e.g. `src/context/` or `src/store/`]

### If Context API:
```tsx
// src/context/AuthContext.tsx
interface AuthContextValue {
  user: User | null;
  login: (credentials: Credentials) => Promise<void>;
  logout: () => void;
  isAuthenticated: boolean;
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuth must be within AuthProvider");
  return context;
};
```

### If Zustand / Redux / Jotai:
<!-- Document the store structure, slices, and access patterns -->

## Server State
<!-- Document the data fetching strategy -->
- Library: [TanStack Query / SWR / RTK Query / custom hooks]
- Cache strategy: [stale-while-revalidate / cache-first / network-first]
- Key convention: [e.g. `['users', userId]`, `['posts', { page, limit }]`]

```tsx
// Example query pattern
const { data, isLoading, error } = useQuery({
  queryKey: ['users', userId],
  queryFn: () => fetchUser(userId),
});
```

## State Decision Tree
```
Need state?
├── Only this component → useState / useReducer
├── Parent + few children → lift state + props
├── Many consumers across tree → Context / state library
├── Server data → data-fetching library (TanStack Query / SWR)
├── Should survive refresh → URL params (router)
└── Form fields → form library or local state
```

## Anti-Patterns to Avoid
- Prop drilling > 3 levels deep — use context or composition
- Storing derived data — compute from source state instead
- Storing server data in global store — use a data-fetching library
- Syncing state between two sources — single source of truth
- Large monolithic context — split by domain

## Changelog
<!-- [PROJ-123] Migrated auth state from Redux to Context API -->
