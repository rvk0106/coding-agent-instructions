# Accessibility (a11y)
> Tags: accessibility, wcag, aria, keyboard, screen-reader
> Scope: Accessibility requirements and patterns for the application
> Last updated: [TICKET-ID or date]

## Standard
- Target: **WCAG 2.1 AA** compliance
- Testing: automated (axe-core, eslint-plugin-jsx-a11y) + manual (keyboard, screen reader)

## Semantic HTML First
```tsx
// CORRECT — semantic elements
<header>...</header>
<nav aria-label="Main navigation">...</nav>
<main>...</main>
<section aria-labelledby="section-title">...</section>
<footer>...</footer>
<button onClick={handleClick}>Save</button>

// WRONG — divs with roles
<div role="banner">...</div>
<div role="navigation">...</div>
<div role="main">...</div>
<div onClick={handleClick}>Save</div>  // not keyboard accessible
```

## ARIA Rules
- Use native HTML elements FIRST — ARIA is a last resort
- Every interactive element must be keyboard accessible
- Every image must have `alt` text (or `alt=""` for decorative)
- Every form input must have a visible `<label>` or `aria-label`
- Every icon-only button must have `aria-label`
- Live regions for dynamic content: `aria-live="polite"` or `aria-live="assertive"`

```tsx
// CORRECT
<button aria-label="Close dialog" onClick={onClose}>
  <CloseIcon aria-hidden="true" />
</button>

<img src={avatar} alt={`${user.name}'s profile photo`} />
<img src={decorative} alt="" />  {/* decorative — empty alt */}

// WRONG — no accessible name
<button onClick={onClose}><CloseIcon /></button>
<img src={avatar} />
```

## Keyboard Navigation
- All interactive elements reachable via Tab
- Logical tab order (matches visual order)
- Focus visible on all elements (never `outline: none` without replacement)
- Escape closes modals/dropdowns
- Arrow keys for lists, menus, tabs
- Enter/Space activates buttons and links

### Focus Management
```tsx
// After opening a modal: focus the first focusable element or the modal title
// After closing a modal: return focus to the trigger element
const triggerRef = useRef<HTMLButtonElement>(null);

const handleClose = () => {
  setIsOpen(false);
  triggerRef.current?.focus(); // return focus
};
```

### Focus Trapping
- Modals and dialogs MUST trap focus
- Use a focus trap library or the native `<dialog>` element
- Tab from last element cycles to first, Shift+Tab from first cycles to last

## Color & Contrast
- Text contrast: minimum **4.5:1** (normal text), **3:1** (large text)
- Never use color alone to convey meaning — add icons, text, or patterns
- Test with grayscale filter to verify

## Forms
```tsx
// CORRECT
<label htmlFor="email">Email address</label>
<input
  id="email"
  type="email"
  aria-describedby="email-error"
  aria-invalid={!!errors.email}
/>
{errors.email && (
  <span id="email-error" role="alert">
    {errors.email.message}
  </span>
)}

// WRONG — no label, no error association
<input type="email" placeholder="Email" />
{errors.email && <span className="error">{errors.email.message}</span>}
```

## Component Checklist
When creating or reviewing any component:
- [ ] Semantic HTML elements used where possible
- [ ] All interactive elements keyboard accessible
- [ ] Focus visible on all focusable elements
- [ ] Images have appropriate `alt` text
- [ ] Form inputs have associated labels
- [ ] Color contrast meets WCAG AA (4.5:1 / 3:1)
- [ ] Dynamic content uses `aria-live` regions
- [ ] Modals trap focus and return focus on close
- [ ] No content conveyed by color alone

## Testing
```bash
# Automated
npm run lint                # eslint-plugin-jsx-a11y catches common issues
npx axe-core               # or run axe in browser DevTools

# Manual
# Tab through the page — all interactive elements reachable?
# Screen reader test (VoiceOver, NVDA, or browser built-in)
# Zoom to 200% — layout still usable?
# High-contrast mode — all content visible?
```

## Changelog
<!-- [PROJ-123] Added focus management to modal component -->
