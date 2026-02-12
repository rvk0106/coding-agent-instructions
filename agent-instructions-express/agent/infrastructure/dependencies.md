# Dependencies
> Tags: packages, npm, services, apis, external
> Scope: All external dependencies the app relies on
> Last updated: [TICKET-ID or date]

## Core Dependencies
<!-- List packages the agent needs to know about when planning/implementing -->
- **Framework**: `express`
- **Security**: `helmet`, `cors`
- **Compression**: `compression`
- **Environment**: `dotenv`
- **Auth**: [e.g. `jsonwebtoken` + `bcrypt` / `passport` + `passport-jwt` / `express-session`]
- **Validation**: [e.g. `joi` / `zod` / `express-validator`]
- **Database**: [e.g. `sequelize` + `pg` / `prisma` / `mongoose` / `typeorm`]
- **Cache**: [e.g. `ioredis` / `redis` / none]
- **Queue**: [e.g. `bullmq` / `amqplib` / none]
- **Logging**: [e.g. `winston` / `pino` / `morgan`]
- **Rate limiting**: `express-rate-limit`
- **API docs**: [e.g. `swagger-jsdoc` + `swagger-ui-express` / none]
- **HTTP client**: [e.g. `axios` / `node-fetch` / none]
- [Add project-specific packages]

## Dev Dependencies
- **TypeScript**: `typescript`, `ts-node-dev` or `tsx`
- **Testing**: `jest` or `vitest`, `supertest`, `@types/jest` (if TS)
- **Linting**: `eslint`, `@eslint/js`, eslint plugins
- **Formatting**: `prettier`, `eslint-config-prettier`
- **Dev server**: `nodemon` or `ts-node-dev`
- **Types**: `@types/express`, `@types/node`, `@types/cors`, etc.
- [Add project-specific dev deps]

## External Services
<!-- Services the app talks to -->
- Payment: [e.g. Stripe / none]
- Email: [e.g. SendGrid / Nodemailer / AWS SES / none]
- Storage: [e.g. S3 (aws-sdk) / Cloudinary / none]
- Monitoring: [e.g. Sentry / Datadog / none]
- [Add project-specific services]

## Internal APIs / Microservices
<!-- Other services this app depends on or is consumed by -->
- [e.g. Auth service at auth.internal:3001]
- [e.g. Consumed by React frontend at app.example.com]

## Adding Dependencies
```bash
# Production dependency
npm install package-name

# Dev dependency
npm install --save-dev package-name

# Always review: does this duplicate existing functionality?
# Always check: is it actively maintained? Any known vulnerabilities?
npm audit
```

## Changelog
<!-- [PROJ-123] Added bullmq for job queue -->
