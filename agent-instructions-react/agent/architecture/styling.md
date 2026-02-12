# Styling & Design System
> Tags: css, styling, theme, responsive, design-tokens, breakpoints
> Scope: How the application is styled, themed, and made responsive
> Last updated: [TICKET-ID or date]

## Styling Approach
- Method: [CSS Modules / Tailwind CSS / styled-components / Emotion / vanilla CSS]
- Location: [e.g. co-located with components / `src/styles/`]

## Design Tokens
<!-- Define the core design tokens / variables -->
```css
/* Example — adjust to your project */
:root {
  /* Colors */
  --color-primary: #3b82f6;
  --color-secondary: #6366f1;
  --color-success: #22c55e;
  --color-warning: #f59e0b;
  --color-error: #ef4444;
  --color-text: #1f2937;
  --color-text-muted: #6b7280;
  --color-bg: #ffffff;
  --color-bg-secondary: #f9fafb;
  --color-border: #e5e7eb;

  /* Typography */
  --font-sans: 'Inter', system-ui, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
  --text-xs: 0.75rem;
  --text-sm: 0.875rem;
  --text-base: 1rem;
  --text-lg: 1.125rem;
  --text-xl: 1.25rem;
  --text-2xl: 1.5rem;

  /* Spacing */
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 0.75rem;
  --space-4: 1rem;
  --space-6: 1.5rem;
  --space-8: 2rem;

  /* Border radius */
  --radius-sm: 0.25rem;
  --radius-md: 0.375rem;
  --radius-lg: 0.5rem;
  --radius-full: 9999px;

  /* Shadows */
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
  --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
  --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
}
```

## Responsive Breakpoints
| Name | Min width | Target |
|------|-----------|--------|
| `sm` | 640px | Large phones |
| `md` | 768px | Tablets |
| `lg` | 1024px | Laptops |
| `xl` | 1280px | Desktops |
| `2xl` | 1536px | Large screens |

### Mobile-First Rule
```css
/* CORRECT: mobile-first (min-width) */
.container { padding: var(--space-4); }
@media (min-width: 768px) { .container { padding: var(--space-8); } }

/* WRONG: desktop-first (max-width) */
.container { padding: var(--space-8); }
@media (max-width: 767px) { .container { padding: var(--space-4); } }
```

## Theming (if applicable)
<!-- Document dark mode / theme switching -->
- Strategy: [CSS variables + class toggle / styled-components ThemeProvider / Tailwind dark mode]
- Dark mode: [supported / not supported / planned]
```tsx
// Example theme toggle
<button onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}>
  Toggle theme
</button>
```

## Component Styling Rules
- Co-locate styles with components (same directory)
- Use semantic class names, not utility-only (unless Tailwind)
- Never use inline styles except for dynamic values (e.g. `style={{ width: `${percent}%` }}`)
- Use CSS custom properties (design tokens) for all colors, spacing, etc.
- Animation: prefer CSS transitions/animations over JS animations
- Z-index: use named layers, not magic numbers

## Z-Index Scale
| Layer | Value | Usage |
|-------|-------|-------|
| Base | 0 | Normal flow |
| Dropdown | 10 | Menus, selects |
| Sticky | 20 | Sticky headers |
| Overlay | 30 | Backdrop |
| Modal | 40 | Modals, dialogs |
| Toast | 50 | Notifications |
| Tooltip | 60 | Tooltips, popovers |

## Changelog
<!-- [PROJ-123] Added dark mode theme variables -->
