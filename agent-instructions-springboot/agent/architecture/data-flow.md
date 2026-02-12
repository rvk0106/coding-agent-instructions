# Data Flow & Request Lifecycle
> Tags: request, filter, pipeline, controller, service, response
> Scope: How a request flows through the app from entry to response
> Last updated: [TICKET-ID or date]

## Request Pipeline
```
Client Request
  --> Servlet Container (Tomcat/Jetty)
    --> Filter Chain (Spring Security, CORS, logging, etc.)
      --> DispatcherServlet
        --> HandlerMapping (find controller method)
          --> HandlerInterceptor.preHandle() (if configured)
            --> Controller method:
              --> @Valid (request body validation via Bean Validation)
              --> Service (business logic)
                --> Repository (DB read/write via JPA/Hibernate)
                --> External service calls (if any)
              --> Map to response DTO
            --> HandlerInterceptor.postHandle()
          --> HttpMessageConverter (serialize to JSON via Jackson)
        --> @ControllerAdvice (if exception thrown)
      --> Filter Chain (response processing)
    --> Servlet Container (send response)
Client Response
```

## Filter Chain (Spring Security)
<!-- Adapt to your SecurityFilterChain configuration -->
```
Request
  --> CorsFilter (CORS headers)
    --> SecurityFilterChain:
      1. UsernamePasswordAuthenticationFilter / JwtAuthenticationFilter (custom)
      2. AuthorizationFilter (URL-pattern or method-level checks)
    --> DispatcherServlet (if authenticated/authorized)
    --> OR --> 401/403 error response (if denied)
```

## Authentication Flow
<!-- Adapt to your auth method (JWT, OAuth2, session) -->
```
Request --> extract token (Authorization header) --> validate JWT --> set SecurityContext
  |-- Valid --> proceed to DispatcherServlet
  |-- Expired/Invalid --> 401 Unauthorized
  |-- Missing (and endpoint requires auth) --> 401 Unauthorized
```

## Authorization Flow
<!-- Adapt to your authz approach -->
```
Controller/Service --> check permissions (@PreAuthorize / SecurityFilterChain rules) --> allow or deny
  |-- Authorized --> proceed
  |-- Denied --> 403 Forbidden (via AccessDeniedException)
```

## Multi-Tenant Flow
<!-- DELETE this section if your app is single-tenant -->
```
Request --> resolve tenant (from header/subdomain/param) --> set tenant context (ThreadLocal / Hibernate filter)
  |-- All JPA queries auto-scoped to tenant
  |-- Admin routes may cross tenant boundaries
  |-- Danger: native SQL bypasses tenant filter
```

## Transaction Management
- Use `@Transactional` on service methods (not on controllers or repositories)
- Spring creates a proxy that wraps the method in a DB transaction
- Default: `REQUIRED` propagation (join existing or create new)
- Read-only optimization: `@Transactional(readOnly = true)` for query-only methods

### Transaction Rules
- ALWAYS wrap multi-entity writes in `@Transactional`
- NEVER call external HTTP services inside a `@Transactional` method (holds DB connection on network failure)
- Pattern: DB writes in transaction --> external calls after transaction commits
- Use `@TransactionalEventListener(phase = AFTER_COMMIT)` for post-commit side effects
```java
// CORRECT: external call after transaction
@Transactional
public Order createOrder(CreateOrderRequest request) {
    Order order = orderRepository.save(mapToOrder(request));
    eventPublisher.publishEvent(new OrderCreatedEvent(order.getId())); // listener calls external API after commit
    return order;
}

// WRONG: HTTP call inside transaction
@Transactional
public Order createOrder(CreateOrderRequest request) {
    Order order = orderRepository.save(mapToOrder(request));
    paymentClient.charge(order); // holds DB connection during HTTP call
    return order;
}
```

## Async Flows
<!-- DELETE or adapt if not using async processing -->
- `@Async` methods: annotate with `@Async`, configure `TaskExecutor` bean
- Message queues: [e.g. RabbitMQ via spring-boot-starter-amqp / Kafka via spring-kafka]
- Scheduled tasks: `@Scheduled` methods with `@EnableScheduling`
```
Controller --> publish event/message --> return 200/202 to client
  --> @Async method or message listener picks up --> execute --> update DB
  --> If failure --> retry (configure max retries) --> dead letter queue
```

## Caching Strategy
<!-- DELETE if not using caching -->
- Library: [e.g. Spring Cache with Caffeine / Redis / EhCache]
- Annotations: `@Cacheable`, `@CacheEvict`, `@CachePut`
- Eviction: [strategy -- TTL-based, event-driven, manual]
- Cacheable data: [e.g. reference data, user profiles, configuration]
- Never cache: [e.g. transactional data, user-specific mutable state]

## Serialization
- Library: Jackson (Spring Boot default)
- JSON naming: camelCase (default `PropertyNamingStrategies.LOWER_CAMEL_CASE`)
- Timestamps: ISO-8601 (`spring.jackson.serialization.write-dates-as-timestamps=false`)
- Nulls: [e.g. include as null / omit via `@JsonInclude(NON_NULL)`]
- Custom serializers: register in `JacksonConfiguration` or use `@JsonSerialize`

## Changelog
<!-- [PROJ-123] Added caching for user profile lookups -->
