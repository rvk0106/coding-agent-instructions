# Security Rules
> Tags: security, auth, spring-security, jwt, cors, csrf, validation
> Scope: Security constraints agents must follow -- prevents vulnerabilities
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never expose JPA entities directly in API responses -- use DTOs
- Never use string concatenation in JPQL/SQL queries -- use parameterized queries
- Never expose internal IDs, stack traces, or implementation details in error messages
- Never log passwords, tokens, or PII
- Never hardcode secrets in source code (application.yml, Java classes, etc.)
- Never trust client-side data for authorization decisions
- Never disable Spring Security for convenience
- Never use `@Transactional` with REQUIRES_NEW to bypass tenant/user scoping

## ALWAYS Do These
- Always scope queries to the authenticated user (or tenant if multi-tenant)
- Always use `@Valid` on request DTOs with proper validation annotations
- Always validate file uploads (type, size, content)
- Always sanitize user input before storing or rendering
- Always use HTTPS in production
- Always rate-limit authentication endpoints
- Always use BCrypt (or Argon2) for password hashing

## Spring Security Configuration
```java
@Configuration
@EnableWebSecurity
@EnableMethodSecurity  // enables @PreAuthorize, @Secured
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())  // disable for stateless API
            .sessionManagement(session ->
                session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/v1/auth/**").permitAll()
                .requestMatchers("/actuator/health").permitAll()
                .requestMatchers("/swagger-ui/**", "/v3/api-docs/**").permitAll()
                .requestMatchers("/api/v1/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

## JWT Validation
- Token extraction: `Authorization: Bearer <token>` header
- Validation: verify signature, check expiration, extract claims
- Token lifetime: [e.g. 15 min access token, 7 day refresh token]
- Secret storage: environment variable or Vault -- never in code

## CORS Configuration
```java
@Bean
public CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration config = new CorsConfiguration();
    config.setAllowedOrigins(List.of("[frontend-url]"));
    config.setAllowedMethods(List.of("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
    config.setAllowedHeaders(List.of("Authorization", "Content-Type"));
    config.setAllowCredentials(true);
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/api/**", config);
    return source;
}
```

## CSRF Protection
- Stateless API (JWT/Bearer token): CSRF disabled (safe -- no cookie-based auth)
- Session-based auth: CSRF protection MUST be enabled (`csrf.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())`)

## Input Validation
```java
// CORRECT: validated DTO
@PostMapping
public ResponseEntity<UserResponse> create(@Valid @RequestBody CreateUserRequest request) {
    // request is validated via Bean Validation annotations
}

// DTO with validation annotations
public record CreateUserRequest(
    @NotBlank @Email String email,
    @NotBlank @Size(min = 8, max = 100) String password,
    @NotBlank @Size(max = 50) String name
) {}
```

## SQL Injection Prevention
```java
// CORRECT: Spring Data query methods (parameterized)
Optional<User> findByEmail(String email);

// CORRECT: JPQL with parameters
@Query("SELECT u FROM User u WHERE u.email = :email")
Optional<User> findByEmailJpql(@Param("email") String email);

// CORRECT: native query with parameters
@Query(value = "SELECT * FROM users WHERE email = :email", nativeQuery = true)
Optional<User> findByEmailNative(@Param("email") String email);

// WRONG: string concatenation
@Query("SELECT u FROM User u WHERE u.email = '" + email + "'")  // SQL injection!
```

## Query Scoping
```java
// CORRECT: scoped to current user
public Resource getResource(Long id, Long userId) {
    return resourceRepository.findByIdAndUserId(id, userId)
        .orElseThrow(() -> new ResourceNotFoundException("Resource", id));
}

// WRONG: unscoped -- may leak other users' data
public Resource getResource(Long id) {
    return resourceRepository.findById(id)  // any user's resource!
        .orElseThrow(() -> new ResourceNotFoundException("Resource", id));
}
```

## XSS Prevention
- Jackson HTML encoding: configure `ObjectMapper` with HTML escaping if rendering user content
- Never render user-supplied HTML without sanitization
- Content-Type headers: always return `application/json` for API responses

## Rate Limiting
- Library: [e.g. Bucket4j / Spring Cloud Gateway rate limiter / custom filter / none]
- Auth endpoints: limit per IP (e.g. 10 requests/minute for login)
- API endpoints: limit per user (e.g. 100 requests/minute)
- Return `429 Too Many Requests` with `Retry-After` header

## Password Hashing
```java
// Spring Security's BCryptPasswordEncoder (default recommendation)
@Bean
public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
}

// Usage in service
String hashedPassword = passwordEncoder.encode(rawPassword);
boolean matches = passwordEncoder.matches(rawPassword, hashedPassword);
```

## Secrets Management
- Location: [e.g. environment variables / Spring Cloud Config / HashiCorp Vault]
- Never commit: `.env` files with real secrets, `application-prod.yml` with credentials
- Pattern: use `${VARIABLE_NAME}` in application.yml, set via environment
- Rotation: [process for rotating secrets]

## Authentication Checks
- Every controller action must require authentication (unless explicitly public)
- Public endpoints: list them in `architecture/api-design.md` and in SecurityFilterChain
- Token expiration: [e.g. 15 min access, 7 day refresh]

## Authorization Checks
- Every mutating action must check authorization
- Use `@PreAuthorize` or SecurityFilterChain URL rules consistently
- Test authorization in integration tests:
```java
@Test
void shouldReturn403ForUnauthorizedUser() {
    mockMvc.perform(get("/api/v1/admin/users")
            .header("Authorization", "Bearer " + userToken))
        .andExpect(status().isForbidden());
}
```

## Changelog
<!-- [PROJ-123] Added rate limiting to login endpoint -->
