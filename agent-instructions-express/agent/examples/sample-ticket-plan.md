# Sample Ticket Plan

**Location**: `docs/PROJ-201-plan.md`

## Ticket metadata
- Ticket ID: PROJ-201
- Title: Add order management API with CRUD and payment integration
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Authenticated users can create, view, update, and cancel orders.
- Orders have items (line items) with quantity and price.
- Payment is processed via an external payment service on order confirmation.
- Admin users can view all orders; regular users see only their own.
- Non-goals: frontend UI, email notifications, shipping integration.

## Current state analysis
- Reviewed `package.json`: express, sequelize, pg, jsonwebtoken, joi installed
- Checked `src/routes/`: auth routes exist, no order routes
- Reviewed `src/controllers/`: auth controller exists, no order controller
- Analyzed `src/services/`: auth service exists, no order service
- Reviewed `src/models/`: User model exists, no Order or OrderItem model
- Checked `src/middleware/`: auth middleware exists (JWT verify), role-checking middleware exists
- Reviewed `src/__tests__/`: auth API tests exist, test helpers with generateTestToken

## Context Loaded
- `workflow/context-router.md` --> task type: New API Endpoint
- `architecture/api-design.md` --> endpoint naming, response shape
- `architecture/error-handling.md` --> validation error shape, error classes
- `architecture/data-flow.md` --> request lifecycle, middleware chain, transaction patterns
- `architecture/patterns.md` --> route/controller/service conventions
- `architecture/database.md` --> migration conventions (Sequelize)
- `architecture/glossary.md` --> domain terms
- `features/_CONVENTIONS.md` --> Supertest patterns, validation patterns
- `infrastructure/security.md` --> query scoping rules, JWT auth

## Architecture decisions
- Add Order and OrderItem models with Sequelize migrations.
- Use service layer for order business logic (create, confirm with payment, cancel).
- Payment integration in a separate service (src/services/paymentService.js) -- isolate external calls.
- Admin routes under `/api/v1/admin/orders`; user routes under `/api/v1/orders`.
- Follow the project's standard API response shape.
- Wrap multi-model writes (order + items) in Sequelize transaction.

## Phase 1
**Goal**: Add Order and OrderItem models with migration.
**Context needed**: `architecture/database.md` (migration conventions), `architecture/patterns.md` (model conventions)
**Tasks**:
- Create migration for `orders` table (userId, status, totalAmount, paymentId, timestamps).
- Create migration for `order_items` table (orderId, productName, quantity, unitPrice, timestamps).
- Define Order and OrderItem models with associations.
- Add model tests.
**Allowed files**:
- src/models/Order.js
- src/models/OrderItem.js
- migrations/YYYYMMDD-create-orders.js
- migrations/YYYYMMDD-create-order-items.js
- src/__tests__/models/Order.test.js
**Forbidden changes**:
- No controller or route changes.
- No service layer yet.
**Verification**:
- `npx sequelize-cli db:migrate`
- `npx sequelize-cli db:migrate:undo:all && npx sequelize-cli db:migrate`
- `npm test -- --testPathPattern=models/Order`
**Acceptance criteria**:
- Orders table created with correct columns and foreign key to users.
- OrderItems table created with foreign key to orders.
- Rollback works cleanly.

## Phase 2
**Goal**: Add order CRUD service and user-facing routes.
**Context needed**: `architecture/api-design.md` (response shape), `architecture/error-handling.md` (error classes), `infrastructure/security.md` (query scoping), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Create orderService with createOrder, getOrders, getOrderById, cancelOrder.
- Create orderController handling req/res.
- Create order routes with auth middleware and joi validation.
- Add Supertest API tests.
**Allowed files**:
- src/services/orderService.js
- src/controllers/orderController.js
- src/routes/orderRoutes.js
- src/middleware/validators/orderValidator.js
- src/__tests__/routes/orders.test.js
- src/__tests__/services/orderService.test.js
**Forbidden changes**:
- No admin routes yet.
- No payment integration yet.
**Verification**:
- `npm test -- --testPathPattern=orders`
- `npm run lint`
**Acceptance criteria**:
- Users can create, list, view, and cancel their own orders.
- Orders are scoped to authenticated user (no cross-user access).
- Validation errors return consistent 422 response shape.

## Phase 3
**Goal**: Add payment integration and admin order view.
**Context needed**: `architecture/data-flow.md` (transaction patterns, external service calls), `infrastructure/dependencies.md` (payment service), `workflow/implementation.md`
**Tasks**:
- Create paymentService wrapping external payment API.
- Add confirmOrder method to orderService (calls payment, updates status in transaction).
- Add admin routes for listing all orders.
- Add Supertest tests for payment flow and admin access.
**Allowed files**:
- src/services/paymentService.js
- src/services/orderService.js (update)
- src/routes/adminOrderRoutes.js
- src/controllers/adminOrderController.js
- src/__tests__/routes/adminOrders.test.js
- src/__tests__/services/paymentService.test.js
**Forbidden changes**:
- No email notifications.
- No shipping integration.
**Verification**:
- `npm test -- --testPathPattern=orders`
- `npm test -- --testPathPattern=payment`
- `npm run lint`
**Acceptance criteria**:
- Order confirmation triggers payment and updates status atomically.
- External payment failure does not leave order in inconsistent state.
- Admin can view all orders; regular user cannot access admin routes (403).

## Next step
execute plan 1 for PROJ-201
