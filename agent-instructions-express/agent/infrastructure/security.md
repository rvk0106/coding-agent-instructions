# Security Rules
> Tags: security, auth, owasp, injection, xss, cors, helmet
> Scope: Security constraints agents must follow -- prevents vulnerabilities
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never trust client-side data for authorization
- Never use string concatenation/interpolation in SQL queries -- use parameterized queries
- Never expose internal error stacks or DB details in production responses
- Never log passwords, tokens, or PII
- Never hardcode secrets in code -- use environment variables
- Never disable security middleware (helmet, cors) in production
- Never store JWTs in localStorage (use httpOnly cookies or in-memory)
- Never skip input validation on any endpoint

## Always Do These
- Always use `helmet()` for security headers
- Always configure CORS explicitly (never use `cors({ origin: '*' })` in production)
- Always validate and sanitize all user input
- Always use parameterized queries (ORM methods or `$1` placeholders)
- Always hash passwords with bcrypt (cost factor >= 10)
- Always rate-limit authentication endpoints
- Always scope DB queries to the authenticated user (or tenant)
- Always use HTTPS in production

## Helmet (Security Headers)
```javascript
const helmet = require('helmet');
app.use(helmet());
// Sets: X-Content-Type-Options, X-Frame-Options, HSTS, CSP, Referrer-Policy, etc.
```

## CORS Configuration
```javascript
const cors = require('cors');

// CORRECT: explicit origin whitelist
app.use(cors({
  origin: ['https://app.example.com', 'https://admin.example.com'],
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
  credentials: true,  // if using cookies
}));

// WRONG: open to all origins
app.use(cors());  // Do NOT use in production
```

## Rate Limiting
```javascript
const rateLimit = require('express-rate-limit');

// Global limiter
app.use(rateLimit({
  windowMs: 15 * 60 * 1000,  // 15 minutes
  max: 100,                    // per IP
  standardHeaders: true,
  legacyHeaders: false,
}));

// Stricter for auth endpoints
app.use('/api/v1/auth', rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 10,
}));
```

## JWT Best Practices
- Short expiry for access tokens (15m-1h)
- Longer expiry for refresh tokens (7d-30d), stored securely
- Include only essential claims (userId, role) -- not sensitive data
- Use strong secrets (256+ bit random string)
- Validate token on every protected request
- Implement token revocation (blacklist or DB check) for logout

```javascript
// CORRECT: verify and decode
const decoded = jwt.verify(token, process.env.JWT_SECRET);
req.user = { id: decoded.userId, role: decoded.role };

// WRONG: decode without verify (anyone can forge tokens)
const decoded = jwt.decode(token);
```

## Input Validation
```javascript
// CORRECT: validate before processing
const schema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).max(128).required(),
});
const { error, value } = schema.validate(req.body);
if (error) throw new ValidationError(error.details);

// WRONG: use req.body directly
const user = await User.create(req.body);  // mass assignment vulnerability
```

## SQL Injection Prevention
```javascript
// CORRECT: parameterized (Sequelize)
const user = await User.findOne({ where: { email: req.body.email } });

// CORRECT: parameterized (raw query)
const [users] = await sequelize.query('SELECT * FROM users WHERE email = $1', {
  bind: [req.body.email],
});

// WRONG: string interpolation
const [users] = await sequelize.query(`SELECT * FROM users WHERE email = '${req.body.email}'`);
```

## XSS Prevention
- Use `helmet()` for Content-Security-Policy headers
- Never render user input as HTML (API-only apps are lower risk)
- Sanitize any user-provided data stored in DB if it may be rendered by a frontend
- Use `express-validator` `escape()` or dedicated sanitization libraries

## CSRF Protection
- **API-only (Bearer token auth)**: CSRF not needed (tokens are not auto-sent by browsers)
- **Cookie-based session auth**: Use `csurf` middleware or `SameSite=Strict` cookies

## Query Scoping
```javascript
// CORRECT: scoped to authenticated user
const order = await Order.findOne({
  where: { id: req.params.id, userId: req.user.id }
});

// WRONG: unscoped -- may leak other users' data
const order = await Order.findByPk(req.params.id);
```

## Dependency Audit
```bash
npm audit                 # check for known vulnerabilities
npm audit fix             # auto-fix where possible
npm audit fix --force     # force major version bumps (review changes!)
```
- Run `npm audit` in CI pipeline
- Keep dependencies updated (use Dependabot or Renovate)

## Secrets Management
- Location: environment variables loaded via `dotenv`
- Never commit `.env` files with real secrets
- Use `.env.example` with placeholder values (committed)
- Production: use platform secrets (AWS Secrets Manager, Vault, Railway secrets)
- Rotate: [process for rotating JWT_SECRET and other secrets]

## Changelog
<!-- [PROJ-123] Added rate limiting to auth endpoints -->
