# Feature Implementation Conventions
> Tags: conventions, testing, patterns, components
> Scope: Patterns to follow when implementing any feature
> Last updated: [TICKET-ID or date]

## Component Pattern
```tsx
// src/components/feature/FeatureName.tsx
import React from 'react';
import styles from './FeatureName.module.css';
import type { FeatureNameProps } from './types';

export const FeatureName: React.FC<FeatureNameProps> = ({
  title,
  onAction,
  children,
}) => {
  return (
    <section className={styles.container} aria-labelledby="feature-title">
      <h2 id="feature-title">{title}</h2>
      {children}
      <button onClick={onAction}>Action</button>
    </section>
  );
};
```

## Test Pattern
```tsx
// src/components/feature/FeatureName.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import { FeatureName } from './FeatureName';

describe('FeatureName', () => {
  const defaultProps = {
    title: 'Test Feature',
    onAction: vi.fn(),
  };

  it('renders the title', () => {
    render(<FeatureName {...defaultProps} />);
    expect(screen.getByText('Test Feature')).toBeInTheDocument();
  });

  it('calls onAction when button is clicked', () => {
    render(<FeatureName {...defaultProps} />);
    fireEvent.click(screen.getByRole('button', { name: /action/i }));
    expect(defaultProps.onAction).toHaveBeenCalledTimes(1);
  });

  it('renders children', () => {
    render(
      <FeatureName {...defaultProps}>
        <p>Child content</p>
      </FeatureName>
    );
    expect(screen.getByText('Child content')).toBeInTheDocument();
  });
});
```

## Testing Rules
- Use `screen` queries, not container queries
- Prefer `getByRole`, `getByLabelText`, `getByText` (accessible queries)
- Avoid `getByTestId` unless no accessible alternative
- Test user behavior, not implementation details
- Test loading, error, and empty states
- Test accessibility: keyboard navigation, ARIA attributes

## Query Priority (React Testing Library)
1. `getByRole` — buttons, links, headings, etc.
2. `getByLabelText` — form inputs
3. `getByPlaceholderText` — if no label (avoid this)
4. `getByText` — non-interactive elements
5. `getByDisplayValue` — filled form fields
6. `getByAltText` — images
7. `getByTitle` — tooltip-like elements
8. `getByTestId` — last resort

## Custom Hook Test Pattern
```tsx
import { renderHook, act } from '@testing-library/react';
import { useCounter } from './useCounter';

describe('useCounter', () => {
  it('increments the count', () => {
    const { result } = renderHook(() => useCounter());
    act(() => result.current.increment());
    expect(result.current.count).toBe(1);
  });
});
```

## API Hook Test Pattern (with mocked server)
```tsx
import { renderHook, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { useUsers } from './useUsers';

const wrapper = ({ children }) => (
  <QueryClientProvider client={new QueryClient()}>
    {children}
  </QueryClientProvider>
);

describe('useUsers', () => {
  it('fetches users', async () => {
    // Mock the API response (MSW, vi.mock, etc.)
    const { result } = renderHook(() => useUsers(), { wrapper });
    await waitFor(() => expect(result.current.isSuccess).toBe(true));
    expect(result.current.data).toHaveLength(3);
  });
});
```

## Changelog
<!-- Update when conventions change -->
