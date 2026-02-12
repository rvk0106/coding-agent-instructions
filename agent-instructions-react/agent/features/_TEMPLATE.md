# Feature: [Feature Name]
> Tags: [relevant, keywords]
> Scope: [what this feature covers]
> Status: [active / deprecated / planned]

## Summary
<!-- 1-2 sentences: what this feature does from the user's perspective -->

## User Flow
<!-- Step-by-step from the user's perspective -->
1. User [action]
2. App [response]
3. User [sees/can do]

## Key Components
| Component | Location | Purpose |
|-----------|----------|---------|
| PageComponent | `src/pages/...` | Page-level layout |
| FeatureComponent | `src/components/feature/...` | Main feature UI |
| useFeatureHook | `src/hooks/...` | Data/logic |

## State
- Local state: [what's in useState/useReducer]
- Shared state: [what's in context/store]
- Server state: [what's fetched from API]

## API Endpoints (if applicable)
| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/api/...` | Fetch data |
| POST | `/api/...` | Create data |

## Routes (if applicable)
| Path | Component | Description |
|------|-----------|-------------|
| `/feature` | FeaturePage | Main page |
| `/feature/:id` | FeatureDetail | Detail view |

## UI States
- **Loading**: [skeleton / spinner / placeholder]
- **Error**: [error message / retry button / fallback]
- **Empty**: [empty state message / call to action]
- **Success**: [what the user sees on success]

## Design
- Figma: [link]
- Mockups: [link or description]
- Breakpoints: [any responsive behavior notes]

## Edge Cases / Gotchas
- [Thing to watch out for]
- [Known limitation]

## Tests
- Component tests: `src/components/feature/__tests__/`
- Integration: [if applicable]
