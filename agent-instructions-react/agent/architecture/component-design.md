# Component Design
> Tags: components, props, composition, reusability, ui
> Scope: How components are structured, composed, and reused
> Last updated: [TICKET-ID or date]

## Component Types

### Page Components
- Located in `src/pages/` (or `src/views/`)
- Correspond to routes
- Compose feature components and layout
- Handle page-level data fetching
- Minimal logic — delegate to child components

### Feature Components
- Located in `src/components/[feature]/`
- Implement business/feature-specific UI
- Can manage local state for the feature
- May use custom hooks for feature logic

### Common / Shared Components
- Located in `src/components/common/`
- Reusable across the app (Button, Input, Modal, Card, etc.)
- Purely presentational — no business logic
- Fully configurable via props
- Must include accessibility attributes

### Layout Components
- Located in `src/components/layout/`
- Structural: Header, Footer, Sidebar, Layout wrapper
- Handle navigation, responsive layout

## Component Rules

### Functional Components Only
```tsx
// CORRECT
const UserCard: React.FC<UserCardProps> = ({ name, avatar }) => {
  return (
    <div className={styles.card}>
      <img src={avatar} alt={`${name}'s avatar`} />
      <h3>{name}</h3>
    </div>
  );
};

// WRONG — no class components
class UserCard extends React.Component { ... }
```

### Props Interface
- ALWAYS define a TypeScript interface for props
- Use descriptive names, not abbreviations
- Default props via destructuring defaults
```tsx
interface UserCardProps {
  name: string;
  avatar: string;
  role?: string;
  onSelect?: (userId: string) => void;
}

const UserCard: React.FC<UserCardProps> = ({
  name,
  avatar,
  role = "member",
  onSelect,
}) => { ... };
```

### Composition Over Configuration
```tsx
// CORRECT — composable
<Card>
  <Card.Header>Title</Card.Header>
  <Card.Body>{content}</Card.Body>
  <Card.Footer><Button>Save</Button></Card.Footer>
</Card>

// WRONG — prop overload
<Card
  title="Title"
  body={content}
  footer={<Button>Save</Button>}
  headerStyle={{ ... }}
  bodyStyle={{ ... }}
/>
```

### Children Pattern
- Use `children` for flexible composition
- Use render props or slots for complex cases
- Prefer composition over deeply nested props

### Single Responsibility
- Each component does ONE thing
- If a component file exceeds ~200 lines, consider splitting
- Extract hooks for complex logic
- Extract sub-components for complex rendering

## Component File Structure
```
src/components/[feature]/
├── FeatureComponent.tsx           → main component
├── FeatureComponent.test.tsx      → tests
├── FeatureComponent.module.css    → styles (if CSS Modules)
├── FeatureComponent.stories.tsx   → Storybook stories (if used)
├── useFeatureLogic.ts             → custom hook (if complex logic)
└── index.ts                       → re-export
```

## Changelog
<!-- [PROJ-123] Added compound component pattern for Card -->
