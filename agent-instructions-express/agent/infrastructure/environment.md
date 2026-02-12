# Environment
> Tags: node, express, runtime, versions, typescript
> Scope: Dev/runtime environment details
> Last updated: [TICKET-ID or date]

## Runtime
- Node.js: [e.g. 18.x / 20.x / 22.x]
- Express: [e.g. 4.x / 5.x]
- Package manager: [e.g. npm / yarn / pnpm]
- TypeScript: [e.g. 5.x / not used]

## Database & Services
- Primary DB: [e.g. PostgreSQL / MySQL / MongoDB]
- ORM/ODM: [e.g. Sequelize / Prisma / TypeORM / Mongoose]
- Cache: [e.g. Redis (ioredis) / none]
- Search: [e.g. Elasticsearch / Meilisearch / none]
- Queue: [e.g. BullMQ (Redis) / RabbitMQ / SQS / none]

## OS / Container
- Dev: [e.g. macOS / Docker / devcontainer]
- CI: [e.g. GitHub Actions ubuntu-latest]
- Prod: [e.g. AWS ECS / Railway / Render / Fly.io / Heroku]

## Local Setup
```bash
# Minimum commands to get running
npm install                    # install dependencies
cp .env.example .env           # configure environment
npx prisma migrate dev         # or: npx sequelize-cli db:migrate
npm run dev                    # start dev server (ts-node-dev / nodemon)
```

## TypeScript Configuration
<!-- DELETE this section if not using TypeScript -->
- Config: `tsconfig.json`
- Strict mode: [yes/no]
- Build: `npm run build` (tsc)
- Dev: `npm run dev` (ts-node-dev / tsx / nodemon + ts-node)

## Environment Variables
Required env vars (loaded via `dotenv` from `.env`):
- `PORT` -- server port (default: 3000)
- `NODE_ENV` -- development / test / production
- `DATABASE_URL` -- primary DB connection string
- `JWT_SECRET` -- secret for signing JWTs
- `JWT_EXPIRES_IN` -- token expiry (e.g. "15m", "1h")
- `REDIS_URL` -- cache/queue broker (if using Redis)
- [Add project-specific vars here]

## .env Files
- `.env` -- local dev (gitignored)
- `.env.example` -- committed template with placeholder values
- `.env.test` -- test environment overrides (if needed)

## Changelog
<!-- Tag with ticket ID when infra changes -->
<!-- [PROJ-123] Upgraded Node.js 18 --> 20 -->
