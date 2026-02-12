# Testing
> Tags: test, verify, jest, vitest, supertest, eslint
> Scope: Verification commands for every phase

## Rule
Every phase MUST be verified. No exceptions.

## Fast Checks (every phase)
> **Note:** Commands below are defaults. Check `infrastructure/tooling.md` for project-specific test/lint commands.

```bash
npm test -- --testPathPattern=path/to/test   # tests for touched files
npm run lint                                  # ESLint
npx tsc --noEmit                             # type check (if TypeScript)
```

## Full Checks (when required)
```bash
npm test                                     # full test suite
npm test -- --coverage                       # with coverage report
npm run build                                # TypeScript build (if TS)
```

## Express-Specific Testing

### API Tests (Supertest)
```javascript
const request = require('supertest');
const app = require('../../app');

describe('GET /api/v1/users', () => {
  it('returns 200 with user list', async () => {
    const res = await request(app)
      .get('/api/v1/users')
      .set('Authorization', `Bearer ${token}`)
      .expect(200);

    expect(res.body.success).toBe(true);
    expect(res.body.data).toBeInstanceOf(Array);
  });

  it('returns 401 without auth', async () => {
    await request(app)
      .get('/api/v1/users')
      .expect(401);
  });
});
```

### Test Setup
```javascript
// jest.setup.js or test/setup.js
// DB setup for integration tests

beforeAll(async () => {
  // Initialize test database
  // e.g. await sequelize.sync({ force: true });
  // e.g. await prisma.$connect();
});

afterAll(async () => {
  // Clean up
  // e.g. await sequelize.close();
  // e.g. await prisma.$disconnect();
});

beforeEach(async () => {
  // Clean tables between tests (optional)
  // e.g. await truncateTables();
});
```

### Test Helpers
```javascript
// test/helpers/auth.js
const jwt = require('jsonwebtoken');

const generateTestToken = (user) => {
  return jwt.sign(
    { userId: user.id, role: user.role },
    process.env.JWT_SECRET || 'test-secret',
    { expiresIn: '1h' }
  );
};

// test/helpers/db.js
const createTestUser = async (overrides = {}) => {
  return User.create({
    email: `test-${Date.now()}@example.com`,
    password: 'hashedpassword',
    role: 'member',
    ...overrides,
  });
};
```

## DB Changes (if migrations added)
```bash
# Sequelize
npx sequelize-cli db:migrate              # apply
npx sequelize-cli db:migrate:undo         # rollback last
npx sequelize-cli db:migrate              # re-apply

# Prisma
npx prisma migrate dev                    # apply in dev
npx prisma migrate reset                  # reset + re-apply all

# TypeORM
npx typeorm migration:run -d src/data-source.ts
npx typeorm migration:revert -d src/data-source.ts
npx typeorm migration:run -d src/data-source.ts
```

## CI Commands
```bash
npm ci                                    # clean install
npm run lint                              # lint
npx tsc --noEmit                          # type check (if TS)
npm test -- --coverage                    # tests with coverage
npm run build                             # build (if TS)
npm audit                                 # security audit
```

## Reporting Format
```
Commands run:
- `npm test -- --testPathPattern=...` --> PASS/FAIL
- `npm run lint` --> PASS/FAIL (N issues)
- `npx tsc --noEmit` --> PASS/FAIL (if TS)
If FAIL --> STOP and ask before continuing
```
