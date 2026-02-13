# Routing & URL Design
> Tags: routes, urls, paths, constraints, namespaces
> Scope: How URLs are structured, route conventions, named paths
> Last updated: [TICKET-ID or date]

## Route File
- Location: `config/routes.rb`
- Draw files: [e.g. `config/routes/admin.rb` if using `draw :admin` / none]

## URL Structure
<!-- Define your project's URL patterns -->
| Area | Pattern | Example |
|------|---------|---------|
| Public pages | `/[page]` | `/about`, `/pricing` |
| Auth | `/users/sign_in` etc. | Devise defaults or custom |
| User-facing | `/[resources]` | `/projects`, `/projects/1` |
| Admin | `/admin/[resources]` | `/admin/users`, `/admin/settings` |
| API (if any) | `/api/v1/[resources]` | `/api/v1/projects` |

## Namespace / Scope Conventions
```ruby
# Admin namespace — separate controllers under Admin::
namespace :admin do
  resources :users
  resources :settings, only: [:index, :update]
end

# Authenticated scope (shared controllers, URL prefix only)
# scope :dashboard do
#   resources :projects
# end
```

## Resource Conventions
- Resources: plural (`/users`, `/projects`)
- Actions: RESTful (index, show, new, create, edit, update, destroy)
- Custom member actions: `get :archive, on: :member`
- Custom collection actions: `get :search, on: :collection`
- Nested max depth: 2 levels (`/projects/:project_id/tasks`)
```ruby
# Standard RESTful resources
resources :projects do
  resources :tasks, only: [:index, :create, :destroy]
end

# Shallow nesting for deep resources
resources :projects, shallow: true do
  resources :tasks
end
```

## Named Routes
<!-- Document important named routes agents should know -->
| Helper | Path | Controller#Action |
|--------|------|-------------------|
| `root_path` | `/` | `pages#home` or `dashboard#index` |
| [helper] | [path] | [controller#action] |

## Authentication Routes
- Library: [e.g. Devise / custom]
- Routes: [e.g. `devise_for :users` / custom session routes]
- Sign in: [e.g. `/users/sign_in`]
- Sign up: [e.g. `/users/sign_up`]
- Sign out: [e.g. `DELETE /users/sign_out`]

## Route Constraints
<!-- DELETE this section if not using constraints -->
```ruby
# Subdomain constraint (multi-tenant)
constraints subdomain: "admin" do
  namespace :admin do
    resources :users
  end
end

# Custom constraint
constraints lambda { |req| req.session[:user_id].present? } do
  # authenticated routes
end
```

## API Routes (if applicable)
<!-- DELETE this section if no API routes -->
```ruby
namespace :api do
  namespace :v1 do
    resources :projects, only: [:index, :show]
  end
end
```

## Changelog
<!-- [PROJ-123] Added admin namespace routes -->
