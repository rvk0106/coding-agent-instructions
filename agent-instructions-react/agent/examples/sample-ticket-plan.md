# Sample Ticket Plan

**Location**: `docs/PROJ-201-plan.md`

## Ticket metadata
- Ticket ID: PROJ-201
- Title: Add user settings page with profile editing
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Add a /settings route with profile editing form
- Fields: display name, email, avatar upload
- Must validate inputs client-side
- Must be fully responsive and accessible
- Non-goals: password change (separate ticket), notification preferences

## Design references
- Figma: [link to settings page mockup]

## Current state analysis
- Reviewed `src/pages/` — no settings page exists
- Checked router config — /settings route not defined
- Reviewed `src/components/common/` — Input, Button, Avatar components exist
- Checked `src/hooks/useAuth.ts` — returns current user data
- Reviewed `src/services/api.ts` — no updateProfile endpoint
- Analyzed `src/types/user.ts` — User type exists, needs UpdateProfilePayload

## Context Loaded
- `workflow/context-router.md` → task type: New Page / Route
- `architecture/system-design.md` → route structure, page layout
- `architecture/component-design.md` → page vs feature component patterns
- `architecture/patterns.md` → TypeScript, naming, hooks rules
- `architecture/styling.md` → responsive breakpoints, form styling
- `architecture/accessibility.md` → form a11y requirements
- `architecture/data-flow.md` → API client, mutation patterns
- `architecture/error-handling.md` → form validation, API errors
- `features/_CONVENTIONS.md` → test patterns

## Architecture decisions
- Create SettingsPage as a page component in src/pages/
- Create ProfileForm as a feature component in src/components/settings/
- Use React Hook Form for form management
- Use existing useAuth hook for current user data
- Create useUpdateProfile mutation hook
- Mobile-first responsive layout

## Phase 1
**Goal**: Add types, API service, and data hook.
**Context needed**: `architecture/data-flow.md`, `architecture/patterns.md`
**Tasks**:
- Add `UpdateProfilePayload` type to `src/types/user.ts`
- Add `updateProfile` API function to `src/services/api.ts`
- Create `useUpdateProfile` mutation hook in `src/hooks/useUpdateProfile.ts`
- Add tests for the hook
**Allowed files**:
- src/types/user.ts
- src/services/api.ts
- src/hooks/useUpdateProfile.ts
- src/hooks/useUpdateProfile.test.ts
**Forbidden changes**:
- No component or page files yet
- No route changes
**Verification**:
- `npm test -- useUpdateProfile`
- `tsc --noEmit`
- `npm run lint`
**Acceptance criteria**:
- TypeScript types defined for request/response
- Mutation hook invalidates user query on success
- Hook tests pass with mocked API

## Phase 2
**Goal**: Create ProfileForm component with validation and accessibility.
**Context needed**: `architecture/component-design.md`, `architecture/accessibility.md`, `architecture/styling.md`
**Tasks**:
- Create ProfileForm component with display name, email, avatar fields
- Add client-side validation (required, email format)
- Add accessible labels, error messages, and ARIA attributes
- Add responsive styles (mobile-first)
- Add component tests
**Allowed files**:
- src/components/settings/ProfileForm.tsx
- src/components/settings/ProfileForm.module.css
- src/components/settings/ProfileForm.test.tsx
- src/components/settings/index.ts
**Forbidden changes**:
- No page or route changes yet
**Verification**:
- `npm test -- ProfileForm`
- `npm run lint`
- `tsc --noEmit`
- Visual: check at 375px, 768px, 1280px
**Acceptance criteria**:
- Form renders with all fields
- Validation shows inline errors
- All inputs have associated labels
- Keyboard navigable (Tab, Enter to submit)

## Phase 3
**Goal**: Create SettingsPage, add route, and wire everything together.
**Context needed**: `architecture/system-design.md`, `architecture/data-flow.md`
**Tasks**:
- Create SettingsPage component
- Add /settings route to router config
- Wire ProfileForm with useAuth (current data) and useUpdateProfile (mutation)
- Handle loading, error, and success states
- Add page-level tests
**Allowed files**:
- src/pages/SettingsPage.tsx
- src/pages/SettingsPage.test.tsx
- Router config file
**Forbidden changes**:
- No changes to existing pages
**Verification**:
- `npm test -- --coverage`
- `npm run lint`
- `tsc --noEmit`
- `npm run build`
- Visual: all breakpoints, all UI states
**Acceptance criteria**:
- /settings route renders SettingsPage
- Form pre-fills with current user data
- Submit calls API and shows success/error feedback
- All verification commands pass

## Next step
execute plan 1 for PROJ-201
