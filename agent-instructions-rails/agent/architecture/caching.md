# Caching
> Tags: cache, redis, performance, invalidation, ttl
> Scope: Cache layers, patterns, and invalidation strategies
> Last updated: [TICKET-ID or date]

## Cache Layers
| Layer | Store | TTL | Use Case |
|-------|-------|-----|----------|
| HTTP caching | Browser / CDN | Varies | Static assets, public API responses |
| Application cache | [e.g. Redis / Memcached] | [e.g. 15m] | Computed values, serialized objects |
| Query cache | Rails built-in | Per-request | Duplicate queries within same request |
| Fragment cache | Rails cache | [e.g. 1h] | Expensive JSON fragments |

## Cache Store
- Engine: [e.g. Redis 7.x / Memcached / file store]
- Config: `config/environments/production.rb`
  ```ruby
  config.cache_store = :redis_cache_store, { url: ENV["REDIS_URL"] }
  ```

## Caching Patterns
```ruby
# Low-level caching -- key-value with TTL
Rails.cache.fetch("user_#{user.id}_dashboard", expires_in: 15.minutes) do
  DashboardService.call(user)
end

# Conditional caching -- skip cache when condition met
Rails.cache.fetch(key, expires_in: 1.hour, skip_nil: true) do
  expensive_query
end

# Collection caching
Rails.cache.fetch_multi(*users) do |user|
  UserSerializer.new(user).as_json
end
```

## Cache Key Conventions
- Pattern: `model_name/id/updated_at` or `model_name/query_fingerprint`
- Use `cache_key_with_version` for ActiveRecord objects
- Namespace: [e.g. `app_name:env:key`]

## Invalidation Strategy
| Trigger | Action |
|---------|--------|
| Record updated | Auto-invalidate via `updated_at` in cache key |
| Manual purge | `Rails.cache.delete("key")` |
| Bulk change | `Rails.cache.delete_matched("pattern*")` |
| Deploy | [e.g. clear cache / rely on key versioning] |

## Rules for Agents
- NEVER cache user-specific data without scoping key to user/tenant
- ALWAYS set TTL -- no indefinite caches
- ALWAYS handle cache miss gracefully (fetch block must work without cache)
- Check for N+1 queries inside cache blocks (they still run on cache miss)

## HTTP Caching (API responses)
```ruby
# In controller -- ETag-based
def show
  @resource = Resource.find(params[:id])
  if stale?(@resource)
    render json: @resource
  end
end

# Cache-Control header
expires_in 5.minutes, public: true
```

## Changelog
<!-- [PROJ-123] Added Redis caching for dashboard endpoint -->
