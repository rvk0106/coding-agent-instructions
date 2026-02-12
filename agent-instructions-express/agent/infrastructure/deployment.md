# Deployment
> Tags: deploy, hosting, environments, infra, docker
> Scope: How the app is deployed and where
> Last updated: [TICKET-ID or date]

## Environments
| Env | URL | Branch | Deploy Method |
|-----|-----|--------|---------------|
| Dev | localhost:3000 | any | manual |
| Staging | [url] | [branch] | [auto/manual] |
| Production | [url] | main | [auto/manual] |

## Deploy Process
- [e.g. Push to main --> GitHub Actions --> Docker build --> ECS deploy]
- [e.g. Push to main --> Railway auto-deploy]
- Migrations: [auto-run on deploy? manual step? e.g. `npx prisma migrate deploy`]
- Rollback: [process for rollback]

## Docker (if used)
```dockerfile
# Example multi-stage Dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --production
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

## Process Manager (if used)
- [e.g. PM2 for production: `pm2 start dist/server.js -i max`]
- [e.g. PM2 ecosystem file: `ecosystem.config.js`]

## Health Check
```javascript
// GET /health or GET /api/v1/health
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});
```

## Secrets Management
- Method: [e.g. environment variables / AWS Secrets Manager / Vault]
- Never commit `.env` files with real secrets
- Use `.env.example` as a template

## Infrastructure Notes
- [e.g. Behind nginx reverse proxy, sticky sessions disabled]
- [e.g. Background workers run as separate process/container]
- [e.g. Redis shared between cache and BullMQ queue]

## Changelog
<!-- [PROJ-123] Migrated from Heroku to Railway -->
