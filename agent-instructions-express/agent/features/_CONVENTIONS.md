# Feature Implementation Conventions
> Tags: conventions, testing, validation, patterns
> Scope: Patterns to follow when implementing any feature in Express
> Last updated: [TICKET-ID or date]

## Response Shape
Use the standard shape defined in `architecture/api-design.md`. Example:
```javascript
// Success
res.status(200).json({ success: true, data: result, meta: { total, page, limit } });

// Created
res.status(201).json({ success: true, data: newResource });

// Error (handled by error middleware)
throw new NotFoundError('User');
// --> { success: false, message: "User not found", errors: [] }
```

## Validation Patterns

### Using Joi
```javascript
// src/middleware/validators/userValidator.js
const Joi = require('joi');
const { ValidationError } = require('../../utils/errors');

const createUserSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).max(128).required(),
  name: Joi.string().max(255).required(),
  role: Joi.string().valid('admin', 'member', 'viewer').default('member'),
});

const validateCreateUser = (req, res, next) => {
  const { error, value } = createUserSchema.validate(req.body, { abortEarly: false });
  if (error) {
    const errors = error.details.map(d => ({ field: d.path.join('.'), message: d.message }));
    throw new ValidationError(errors);
  }
  req.body = value;
  next();
};

module.exports = { validateCreateUser };
```

### Using Zod
```javascript
// src/middleware/validators/userValidator.js
const { z } = require('zod');
const { ValidationError } = require('../../utils/errors');

const createUserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8).max(128),
  name: z.string().max(255),
  role: z.enum(['admin', 'member', 'viewer']).default('member'),
});

const validateCreateUser = (req, res, next) => {
  const result = createUserSchema.safeParse(req.body);
  if (!result.success) {
    const errors = result.error.issues.map(i => ({ field: i.path.join('.'), message: i.message }));
    throw new ValidationError(errors);
  }
  req.body = result.data;
  next();
};

module.exports = { validateCreateUser };
```

## Query Patterns
```javascript
// Eager loading -- prevent N+1 (Sequelize)
const users = await User.findAll({
  include: [{ model: Order, as: 'orders' }],
  where: { active: true },
});

// Pagination
const { page = 1, limit = 25 } = req.query;
const offset = (page - 1) * limit;
const { rows, count } = await User.findAndCountAll({ limit, offset });
res.json({
  success: true,
  data: rows,
  meta: { total: count, page: Number(page), limit: Number(limit), totalPages: Math.ceil(count / limit) },
});

// Scoping -- always scope to authenticated user
const order = await Order.findOne({
  where: { id: req.params.id, userId: req.user.id },
});
if (!order) throw new NotFoundError('Order');
```

## Supertest API Test Pattern
```javascript
// src/__tests__/routes/users.test.js
const request = require('supertest');
const app = require('../../app');
const { createTestUser, generateTestToken } = require('../helpers');

describe('Users API', () => {
  let user;
  let token;

  beforeAll(async () => {
    user = await createTestUser();
    token = generateTestToken(user);
  });

  describe('GET /api/v1/users', () => {
    it('returns 200 with user list', async () => {
      const res = await request(app)
        .get('/api/v1/users')
        .set('Authorization', `Bearer ${token}`)
        .expect(200);

      expect(res.body.success).toBe(true);
      expect(res.body.data).toBeInstanceOf(Array);
    });

    it('returns 401 without auth token', async () => {
      await request(app)
        .get('/api/v1/users')
        .expect(401);
    });
  });

  describe('POST /api/v1/users', () => {
    it('creates a user and returns 201', async () => {
      const res = await request(app)
        .post('/api/v1/users')
        .set('Authorization', `Bearer ${token}`)
        .send({ email: 'new@example.com', password: 'password123', name: 'New User' })
        .expect(201);

      expect(res.body.success).toBe(true);
      expect(res.body.data.email).toBe('new@example.com');
    });

    it('returns 422 for invalid params', async () => {
      const res = await request(app)
        .post('/api/v1/users')
        .set('Authorization', `Bearer ${token}`)
        .send({ email: 'invalid' })
        .expect(422);

      expect(res.body.success).toBe(false);
      expect(res.body.errors).toBeInstanceOf(Array);
    });
  });
});
```

## Service Unit Test Pattern
```javascript
// src/__tests__/services/userService.test.js
const userService = require('../../services/userService');
const User = require('../../models/User');

jest.mock('../../models/User');

describe('UserService', () => {
  afterEach(() => jest.clearAllMocks());

  describe('createUser', () => {
    it('creates a user with hashed password', async () => {
      const input = { email: 'test@example.com', password: 'password123', name: 'Test' };
      User.create.mockResolvedValue({ id: 1, ...input, password: 'hashed' });

      const result = await userService.createUser(input);

      expect(User.create).toHaveBeenCalledWith(
        expect.objectContaining({ email: 'test@example.com' })
      );
      expect(result).toHaveProperty('id');
    });

    it('throws ConflictError for duplicate email', async () => {
      User.create.mockRejectedValue({ name: 'SequelizeUniqueConstraintError' });

      await expect(userService.createUser({ email: 'dup@example.com' }))
        .rejects.toThrow();
    });
  });
});
```

## Middleware Test Pattern
```javascript
// src/__tests__/middleware/auth.test.js
const { authenticate } = require('../../middleware/auth');
const jwt = require('jsonwebtoken');

describe('authenticate middleware', () => {
  const mockReq = (token) => ({
    headers: { authorization: token ? `Bearer ${token}` : undefined },
  });
  const mockRes = () => ({ status: jest.fn().mockReturnThis(), json: jest.fn() });
  const mockNext = jest.fn();

  it('calls next() with valid token', () => {
    const token = jwt.sign({ userId: 1, role: 'member' }, process.env.JWT_SECRET || 'test-secret');
    const req = mockReq(token);

    authenticate(req, mockRes(), mockNext);

    expect(mockNext).toHaveBeenCalledWith();
    expect(req.user).toHaveProperty('userId', 1);
  });

  it('passes UnauthorizedError for missing token', () => {
    authenticate(mockReq(null), mockRes(), mockNext);

    expect(mockNext).toHaveBeenCalledWith(expect.objectContaining({ statusCode: 401 }));
  });
});
```

## Test Helpers
```javascript
// src/__tests__/helpers/index.js
const jwt = require('jsonwebtoken');
const User = require('../../models/User');

const generateTestToken = (user) => {
  return jwt.sign(
    { userId: user.id, role: user.role },
    process.env.JWT_SECRET || 'test-secret',
    { expiresIn: '1h' }
  );
};

const createTestUser = async (overrides = {}) => {
  return User.create({
    email: `test-${Date.now()}@example.com`,
    password: 'hashedpassword',
    role: 'member',
    ...overrides,
  });
};

module.exports = { generateTestToken, createTestUser };
```

## Changelog
<!-- Update when conventions change -->
