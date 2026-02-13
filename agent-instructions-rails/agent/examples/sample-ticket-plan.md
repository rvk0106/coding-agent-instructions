# Sample Ticket Plan

**Location**: `docs/PROJ-101-plan.md`

## Ticket metadata
- Ticket ID: PROJ-101
- Title: Project CRUD with category filtering
- Owner: Unassigned
- Priority: High

## Requirements & constraints
- Users can create, edit, and delete their own projects.
- Projects belong to categories (each project has one category).
- Index page shows projects with category filter (Turbo Frame for filter).
- Non-goals: admin panel, API endpoints, public access.

## Current state analysis
- Reviewed `db/schema.rb`: projects table exists with basic fields, no category_id
- Checked `app/models/project.rb`: basic validations present
- Reviewed `app/controllers/`: no projects controller exists
- Analyzed `config/routes.rb`: no projects routes defined
- Reviewed `app/views/`: no project views exist
- Reviewed `spec/`: no projects specs exist
- Checked `.rubocop.yml`: standard Rails cops enabled

## Context Loaded
- `workflow/context-router.md` -> task type: New Page / View + New Form
- `architecture/views.md` -> layout, partial, Turbo Frame patterns
- `architecture/routing.md` -> URL design, resource conventions
- `architecture/error-handling.md` -> flash messages, form errors, Turbo status codes
- `architecture/patterns.md` -> controller/model/service conventions
- `architecture/database.md` -> schema, migration conventions
- `architecture/glossary.md` -> domain terms
- `features/_CONVENTIONS.md` -> form, Turbo, test patterns
- `infrastructure/security.md` -> query scoping, CSRF, strong params

## Architecture decisions
- Add category association and validation in model layer.
- Use standard resourceful controller (not a service — CRUD is simple enough).
- Category filter via Turbo Frame on index page for seamless UX.
- Follow project's standard layout and partial conventions.
- Use `form_with(model: ...)` for all forms.

## Phase 1
**Goal**: Add category model and project-category association via migration.
**Context needed**: `architecture/database.md` (migration rules), `architecture/patterns.md` (model conventions)
**Tasks**:
- Create categories migration and model.
- Add category_id to projects table.
- Add association and validation to Project model.
- Add model specs and factories.
**Allowed files**:
- db/migrate/[timestamp]_create_categories.rb
- db/migrate/[timestamp]_add_category_to_projects.rb
- app/models/category.rb
- app/models/project.rb
- spec/models/category_spec.rb
- spec/models/project_spec.rb
- spec/factories/categories.rb
- spec/factories/projects.rb
**Forbidden changes**:
- No controller, route, or view changes.
**Verification**:
- `rails db:migrate && rails db:rollback STEP=2 && rails db:migrate`
- `bundle exec rspec spec/models/`
**Acceptance criteria**:
- Category model exists with name validation.
- Project belongs_to category.
- Migrations are reversible.

## Phase 2
**Goal**: Add projects controller, routes, and basic views (index, show, new, edit).
**Context needed**: `architecture/views.md` (partial/layout patterns), `architecture/routing.md` (RESTful routes), `architecture/error-handling.md` (flash, form errors), `workflow/implementation.md` (coding conventions)
**Tasks**:
- Add resourceful route for projects.
- Create ProjectsController with all CRUD actions.
- Create view templates: index, show, new, edit, _form partial.
- Add flash messages and error display.
- Add request specs and system specs.
**Allowed files**:
- config/routes.rb
- app/controllers/projects_controller.rb
- app/views/projects/index.html.erb
- app/views/projects/show.html.erb
- app/views/projects/new.html.erb
- app/views/projects/edit.html.erb
- app/views/projects/_form.html.erb
- app/views/projects/_project.html.erb
- spec/requests/projects_spec.rb
- spec/system/projects_spec.rb
**Forbidden changes**:
- No Turbo Frame changes (that's Phase 3).
- No category filter UI.
**Verification**:
- `bundle exec rspec spec/requests/projects_spec.rb spec/system/projects_spec.rb`
- `bundle exec rubocop`
**Acceptance criteria**:
- User can create, view, edit, and delete projects.
- Validation errors display on form.
- Flash messages confirm actions.
- Projects scoped to current_user.

## Phase 3
**Goal**: Add category filter with Turbo Frame on projects index.
**Context needed**: `architecture/views.md` (Turbo Frame patterns), `architecture/data-flow.md` (Turbo request flow), `features/_CONVENTIONS.md` (Turbo test patterns)
**Tasks**:
- Add category filter form on index page.
- Wrap project list in Turbo Frame for seamless filtering.
- Update controller index action to filter by category.
- Add system spec for filter interaction.
**Allowed files**:
- app/views/projects/index.html.erb
- app/controllers/projects_controller.rb (index action only)
- spec/system/projects_spec.rb
**Forbidden changes**:
- No model changes.
- No new routes.
**Verification**:
- `bundle exec rspec spec/system/projects_spec.rb`
- `bundle exec rubocop`
**Acceptance criteria**:
- Selecting a category filters projects without full page reload.
- "All" option shows all projects.
- Filter works with Turbo Frame (no full page refresh).

## Next step
execute plan 1 for PROJ-101
