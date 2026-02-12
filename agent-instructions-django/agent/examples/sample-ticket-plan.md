# Sample Ticket Plan

**Location**: `docs/PROJ-101-plan.md`

## Ticket metadata
- Ticket ID: PROJ-101
- Title: Add product catalog API with CRUD and filtering
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Admins can create, update, and delete products.
- Products belong to categories (each product has one category).
- Expose read endpoints for non-admin users with filtering by category and status.
- Pagination on list endpoints.
- Non-goals: UI changes, image uploads, search functionality.

## Current state analysis
- Reviewed `apps/catalog/models.py`: Category model exists, no Product model yet
- Checked `apps/catalog/views.py`: CategoryViewSet exists (read-only)
- Reviewed `apps/catalog/serializers.py`: CategorySerializer exists
- Analyzed `project/urls.py` and `apps/catalog/urls.py`: category routes defined
- Reviewed `apps/catalog/tests/`: category tests exist, no product tests
- Checked `requirements.txt`: django-filter already installed

## Context Loaded
- `workflow/context-router.md` -> task type: New API Endpoint
- `architecture/api-design.md` -> endpoint naming, response shape, pagination
- `architecture/error-handling.md` -> validation error shape
- `architecture/data-flow.md` -> DRF request lifecycle, permission pipeline
- `architecture/patterns.md` -> viewset/serializer/model conventions
- `architecture/glossary.md` -> domain terms
- `features/_CONVENTIONS.md` -> serialization, query, test patterns
- `infrastructure/security.md` -> query scoping rules

## Architecture decisions
- Add Product model with ForeignKey to Category.
- Use ModelSerializer with field-level validation.
- Use ModelViewSet for CRUD with django-filter for category/status filtering.
- Separate admin and public viewsets (admin has write, public has read-only).
- Follow the project's standard API response shape and pagination.

## Phase 1
**Goal**: Add Product model with category relationship and factory.
**Context needed**: `architecture/patterns.md` (model conventions), `architecture/database.md` (migration rules), `features/_CONVENTIONS.md` (factory patterns)
**Tasks**:
- Add Product model with fields: name, description, price, status, category (FK).
- Add indexes on status and category.
- Generate migration.
- Add ProductFactory.
- Add model tests.
**Allowed files**:
- apps/catalog/models.py
- apps/catalog/tests/factories.py
- apps/catalog/tests/test_models.py
- apps/catalog/migrations/ (new migration)
**Forbidden changes**:
- No view, serializer, or URL changes.
- No existing migration edits.
**Verification**:
- `python manage.py makemigrations --check --dry-run`
- `python manage.py migrate`
- `pytest apps/catalog/tests/test_models.py`
- `flake8 apps/catalog/`
**Acceptance criteria**:
- Product model created with all fields.
- Category ForeignKey relationship works.
- Migration applies and rolls back cleanly.

## Phase 2
**Goal**: Add admin write endpoints (create, update, delete) with serializer validation.
**Context needed**: `architecture/api-design.md` (response shape), `architecture/error-handling.md` (validation errors), `infrastructure/security.md` (admin auth), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Add ProductSerializer with field validation.
- Add IsAdminUser permission class usage.
- Add AdminProductViewSet with create/update/destroy.
- Register admin routes.
- Add API tests for admin CRUD.
**Allowed files**:
- apps/catalog/serializers.py
- apps/catalog/views.py
- apps/catalog/urls.py
- apps/catalog/tests/test_views.py
**Forbidden changes**:
- No public read endpoints yet.
- No model changes.
**Verification**:
- `pytest apps/catalog/tests/test_views.py`
- `flake8 apps/catalog/`
**Acceptance criteria**:
- Admin can create, update, and delete products.
- Validation errors return consistent API format.
- Non-admin users get 403 on write endpoints.

## Phase 3
**Goal**: Add public read-only endpoints with filtering and pagination.
**Context needed**: `architecture/api-design.md` (public endpoint conventions, pagination), `architecture/data-flow.md` (read request pipeline), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Add PublicProductViewSet (list, retrieve only).
- Add django-filter FilterSet for category and status.
- Register public routes.
- Add API tests for filtering and pagination.
**Allowed files**:
- apps/catalog/views.py
- apps/catalog/filters.py (new)
- apps/catalog/urls.py
- apps/catalog/tests/test_views.py
**Forbidden changes**:
- No admin write endpoint changes.
- No model changes.
**Verification**:
- `pytest apps/catalog/tests/test_views.py`
- `flake8 apps/catalog/`
**Acceptance criteria**:
- Non-admin users can list and retrieve products.
- Filtering by category and status works.
- Pagination returns correct meta fields.

## Next step
execute plan 1 for PROJ-101
