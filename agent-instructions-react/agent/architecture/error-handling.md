# Error Handling
> Tags: errors, boundaries, api-errors, user-feedback, fallback
> Scope: How errors are caught, displayed, and recovered from
> Last updated: [TICKET-ID or date]

## Error Categories

| Category | Source | Handling |
|----------|--------|----------|
| **Render errors** | Component throws during render | Error Boundary → fallback UI |
| **API errors** | Network, 4xx, 5xx | Data-fetching library error state → user message |
| **Form validation** | Invalid user input | Inline field errors, form-level summary |
| **Auth errors** | 401, expired token | Redirect to login, clear session |
| **Not found** | 404, missing resource | 404 page or empty state |
| **Unexpected** | Uncaught exceptions | Global error boundary → generic fallback |

## Error Boundaries
```tsx
// src/components/common/ErrorBoundary.tsx
import { Component, ErrorInfo, ReactNode } from 'react';

interface Props {
  fallback: ReactNode;
  children: ReactNode;
  onError?: (error: Error, errorInfo: ErrorInfo) => void;
}

class ErrorBoundary extends Component<Props, { hasError: boolean }> {
  state = { hasError: false };

  static getDerivedStateFromError() {
    return { hasError: true };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    this.props.onError?.(error, errorInfo);
    // Log to error reporting service (Sentry, etc.)
  }

  render() {
    if (this.state.hasError) return this.props.fallback;
    return this.props.children;
  }
}
```

### Placement
- **Root**: Global boundary wrapping `<App>` → generic fallback
- **Route**: Per-route boundary → "Something went wrong on this page"
- **Feature**: Around risky components → feature-specific fallback

## API Error Handling
```tsx
// With TanStack Query
const { data, error, isError } = useQuery({
  queryKey: ['users'],
  queryFn: fetchUsers,
});

if (isError) {
  if (error instanceof ApiError && error.status === 404) {
    return <EmptyState message="No users found" />;
  }
  return <ErrorMessage error={error} />;
}
```

### API Error Class
```tsx
// src/services/apiError.ts
export class ApiError extends Error {
  constructor(
    message: string,
    public status: number,
    public code?: string,
  ) {
    super(message);
    this.name = 'ApiError';
  }
}
```

### Status Code Handling
| Status | User sees | Action |
|--------|-----------|--------|
| 400 | Validation errors | Show field-level errors |
| 401 | "Session expired" | Redirect to login |
| 403 | "You don't have permission" | Show forbidden page |
| 404 | Empty state / 404 page | Show appropriate message |
| 429 | "Too many requests" | Show retry message with countdown |
| 500+ | "Something went wrong" | Show generic error + retry button |

## User-Facing Error UI Rules
- ALWAYS show a meaningful message — never a blank screen or raw error
- Include a retry action where appropriate (button or link)
- For form validation: show errors inline next to the field
- For transient errors: use a toast/notification that auto-dismisses
- For fatal errors: show a full-page fallback with a "Go Home" action
- NEVER expose stack traces, error codes, or technical details to users

## Loading States
- Always pair error handling with loading states
- Show skeleton / spinner while loading
- Show error UI if request fails
- Show empty state if data is empty
```tsx
if (isLoading) return <Skeleton />;
if (isError) return <ErrorMessage error={error} onRetry={refetch} />;
if (!data?.length) return <EmptyState />;
return <UserList users={data} />;
```

## Changelog
<!-- [PROJ-123] Added per-route error boundaries -->
