# Principles & Standards — Express.js

## Core: Plan first, small phases, verify, human review

## Express standards
- Follow Node.js best practices
- Use ESLint and Prettier
- TypeScript recommended
- Async/await over callbacks

## Patterns
- **Layered architecture**: Routes → Controllers → Services → Data
- **Middleware** for cross-cutting concerns
- **Error handling** with Express error middleware
- **Validation** at route/controller level
- **Dependency injection** for testability

## Quality
- Tests with Jest/Mocha + Supertest
- Input validation
- Proper error responses
- Security headers (helmet)
- Rate limiting where needed
