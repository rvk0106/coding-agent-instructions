# Data Flow & API Integration
> Tags: api, fetch, data, caching, mutations, server-state
> Scope: How data moves between the server and the UI
> Last updated: [TICKET-ID or date]

## API Client
<!-- Document the HTTP client setup -->
- Library: [fetch / axios / ky]
- Base URL: [e.g. `import.meta.env.VITE_API_URL` or `/api`]
- Auth: [Bearer token in header / cookie / none]
- Location: `src/services/api.ts` or `src/services/apiClient.ts`

```tsx
// Example API client (adjust to your project)
const apiClient = {
  get: <T>(url: string) => fetch(`${BASE_URL}${url}`, { headers }).then(handleResponse<T>),
  post: <T>(url: string, body: unknown) => fetch(`${BASE_URL}${url}`, { method: 'POST', headers, body: JSON.stringify(body) }).then(handleResponse<T>),
  // ... put, patch, delete
};
```

## Data Fetching Pattern
<!-- Document how data is fetched -->
- Library: [TanStack Query / SWR / RTK Query / custom hooks]
- Pattern: hooks per resource or per feature

```tsx
// src/hooks/useUsers.ts
export function useUsers(filters?: UserFilters) {
  return useQuery({
    queryKey: ['users', filters],
    queryFn: () => apiClient.get<User[]>(`/users?${toParams(filters)}`),
  });
}
```

## Mutation Pattern
```tsx
// src/hooks/useCreateUser.ts
export function useCreateUser() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (data: CreateUserPayload) => apiClient.post<User>('/users', data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });
}
```

## Data Flow Diagram
```
User Action (click, submit, navigate)
  → Component event handler
    → Custom hook (useCreateUser, useUsers, etc.)
      → API client (fetch / axios)
        → Backend API
        ← Response (JSON)
      ← Data-fetching library handles cache + state
    ← Hook returns { data, isLoading, error }
  ← Component renders based on state
User sees updated UI
```

## Caching Strategy
- **Query key convention**: `[resource, ...params]` e.g. `['users', userId]`, `['posts', { page: 1 }]`
- **Stale time**: [e.g. 5 minutes for lists, 1 minute for detail views]
- **Cache invalidation**: invalidate on mutation success
- **Optimistic updates**: [used for X / not used]
- **Prefetching**: [prefetch on hover / on route change / not used]

## Real-Time Data (if applicable)
<!-- DELETE this section if the app doesn't use real-time -->
- Method: [WebSocket / SSE / polling / none]
- Library: [Socket.io / native WebSocket / none]
- Pattern: [hook-based subscription / global listener]

## Authentication Flow
```
Login form → POST /auth/login → receive token
  → Store token (localStorage / cookie / memory)
  → Set Authorization header on API client
  → Redirect to authenticated route

Token expired → 401 response → clear token → redirect to login
```

## Environment Variables
- API URL: `[VITE_API_URL / NEXT_PUBLIC_API_URL / REACT_APP_API_URL]`
- Other: [list any other env vars]
- NEVER commit secrets — use `.env.local` (gitignored)

## Changelog
<!-- [PROJ-123] Added TanStack Query for server state management -->
