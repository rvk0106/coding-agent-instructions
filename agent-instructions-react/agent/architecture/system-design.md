# System Design
> Tags: architecture, pages, routes, layout, high-level
> Scope: How the application is structured at a high level
> Last updated: [TICKET-ID or date]

## Overview
<!-- 2-3 sentence summary of what this app does and who it serves -->
[Describe what this application does and its target users.]

## Tech Stack
- Framework: [React 18+ / Next.js / Remix / Vite + React]
- Language: [TypeScript / JavaScript]
- State management: [Context / Redux / Zustand / Jotai / none]
- Styling: [CSS Modules / Tailwind / styled-components / Emotion / vanilla CSS]
- Router: [React Router / Next.js routing / TanStack Router]
- Data fetching: [TanStack Query / SWR / RTK Query / fetch / axios]
- Form handling: [React Hook Form / Formik / native / none]
- Testing: [Vitest / Jest + React Testing Library]

## Route / Page Structure
<!-- Map out the pages/routes -->
```
/                     → Home / Landing
/login                → Authentication
/dashboard            → Main dashboard
/dashboard/:section   → Dashboard subsection
/settings             → User settings
/[feature]            → [Feature-specific pages]
```

## Component Hierarchy
<!-- High-level component tree -->
```
<App>
  <AuthProvider>
    <ThemeProvider>
      <Layout>
        <Header />
        <Sidebar />       (if applicable)
        <Main>
          <Routes>         (page components rendered here)
        </Main>
        <Footer />
      </Layout>
    </ThemeProvider>
  </AuthProvider>
</App>
```

## Project Structure
<!-- Map out the src/ directory layout -->
```
src/
├── components/         → Reusable UI components
│   ├── common/         → Buttons, inputs, modals, cards
│   ├── layout/         → Header, Footer, Sidebar, Layout
│   └── [feature]/      → Feature-specific components
├── pages/              → Page/route components (or views/)
├── hooks/              → Custom hooks
├── context/            → React context providers (or store/)
├── services/           → API clients, external service wrappers
├── utils/              → Pure utility functions
├── types/              → TypeScript type definitions
├── styles/             → Global styles, design tokens, themes
├── assets/             → Images, icons, fonts
└── __tests__/          → Test files (or co-located with components)
```

## Key Data Flows
<!-- Describe 2-3 critical flows through the app -->
1. **Authentication**: Login form → API call → token stored → redirect to dashboard
2. **[Flow Name]**: [user action] → [component] → [state/API] → [UI update]
3. **[Flow Name]**: [user action] → [component] → [state/API] → [UI update]

## Changelog
<!-- [PROJ-123] Added settings page route -->
