# Data Flow & Request Lifecycle
> Tags: request, middleware, pipeline, controller, service, response
> Scope: How a request flows through the Express app from entry to response
> Last updated: [TICKET-ID or date]

## Request Pipeline
```
Client Request
  --> Express app (app.js / server.js)
    --> Global middleware (in order registered):
      1. helmet()           -- security headers
      2. cors()             -- CORS handling
      3. compression()      -- gzip responses
      4. express.json()     -- parse JSON body
      5. requestLogger()    -- log incoming request
      6. rateLimiter()      -- rate limiting (if global)
    --> Router matching (src/routes/)
      --> Route-level middleware:
        1. authenticate     -- verify JWT/session --> sets req.user (401 if invalid)
        2. authorize(roles) -- check permissions (403 if denied)
        3. validate(schema) -- validate input (422 if invalid)
      --> Controller (src/controllers/)
        --> Parse req.params, req.body, req.query
        --> Call service (src/services/)
          --> Model / ORM (src/models/) --> DB read/write
          --> External service calls (if any)
        --> Format response (use standard shape)
        --> res.status(xxx).json(response)
    --> Error middleware (LAST):
      --> errorHandler(err, req, res, next) -- catches all errors
Client Response
```

## Middleware Execution Order
Express executes middleware in the order they are registered via `app.use()`. Order matters:

1. **Security first**: helmet, cors
2. **Parsing**: express.json, express.urlencoded, cookie-parser
3. **Logging**: request logger (morgan or custom)
4. **Rate limiting**: before routes
5. **Routes**: app.use('/api/v1', routes)
6. **404 handler**: after all routes (catch unmatched)
7. **Error handler**: LAST -- must have 4 params `(err, req, res, next)`

## Authentication Flow
<!-- Adapt to your auth method (JWT, session, Passport) -->
```
Request
  --> extract token from Authorization header (or cookie/session)
  --> verify token (jsonwebtoken.verify / passport.authenticate)
    |-- Valid --> decode payload --> attach req.user --> next()
    |-- Expired/Invalid --> 401 Unauthorized
    |-- Missing --> 401 Unauthorized (or skip if route is public)
```

### JWT Token Flow
```
Login: POST /api/v1/auth/login
  --> validate credentials --> generate access_token + refresh_token
  --> return tokens (body or httpOnly cookie)

Protected request:
  --> Authorization: Bearer <access_token>
  --> middleware verifies --> req.user = decoded payload

Token refresh: POST /api/v1/auth/refresh
  --> validate refresh_token --> issue new access_token
```

## Authorization Flow
```
Controller / Route middleware
  --> authorize('admin', 'manager')
  --> check req.user.role against allowed roles
    |-- Authorized --> next()
    |-- Denied --> 403 Forbidden
```

## Multi-Tenant Flow
<!-- DELETE this section if your app is single-tenant -->
```
Request
  --> resolve tenant (from subdomain / header / path param)
  --> attach tenant context to req (req.tenant)
  --> all DB queries scoped to tenant
    |-- Danger: raw queries bypass tenant scoping
    |-- Admin routes may cross tenant boundaries
```

## Background Job Flow
<!-- DELETE this section if not using background jobs -->
```
Controller / Service --> enqueue job (BullMQ / RabbitMQ / SQS)
  --> return 202 Accepted (or 200) to client immediately
  --> Worker picks up job --> execute --> update DB
  --> If failure --> retry (maxAttempts) --> dead letter queue
```

### BullMQ Example
```javascript
// Enqueue
const queue = new Queue('email');
await queue.add('welcome', { userId: user.id });

// Process (worker.js)
const worker = new Worker('email', async (job) => {
  await sendWelcomeEmail(job.data.userId);
});
```

## Transaction Patterns
```javascript
// Sequelize transactions
const t = await sequelize.transaction();
try {
  await Order.create(orderData, { transaction: t });
  await OrderItem.bulkCreate(items, { transaction: t });
  await t.commit();
} catch (error) {
  await t.rollback();
  throw error;
}

// Prisma transactions
await prisma.$transaction([
  prisma.order.create({ data: orderData }),
  prisma.orderItem.createMany({ data: items }),
]);

// Mongoose sessions
const session = await mongoose.startSession();
session.startTransaction();
try {
  await Order.create([orderData], { session });
  await session.commitTransaction();
} catch (error) {
  await session.abortTransaction();
  throw error;
}
```

## Transaction Rules
- ALWAYS wrap multi-model writes in a transaction
- NEVER call external services inside a transaction (holds DB connection on network failure)
- Pattern: DB writes in transaction --> external calls after commit
- Log transaction failures for debugging

## Caching (Redis)
<!-- DELETE this section if not using Redis -->
```javascript
// Check cache --> return if hit --> else query DB --> cache result
const cached = await redis.get(`user:${id}`);
if (cached) return JSON.parse(cached);

const user = await User.findByPk(id);
await redis.set(`user:${id}`, JSON.stringify(user), 'EX', 3600);
return user;
```

## Response Serialization
- Format: JSON
- Naming: [e.g. camelCase / snake_case]
- Timestamps: [e.g. ISO-8601]
- Nulls: [e.g. included as null / omitted]
- Use consistent shape from `architecture/api-design.md`

## Changelog
<!-- [PROJ-123] Added rate limiting middleware -->
