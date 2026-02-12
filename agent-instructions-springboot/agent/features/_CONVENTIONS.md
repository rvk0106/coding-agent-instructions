# Feature Implementation Conventions
> Tags: conventions, testing, patterns, spring-boot, mockmvc
> Scope: Patterns to follow when implementing any feature
> Last updated: [TICKET-ID or date]

## DTO Patterns

### Request DTOs
```java
// Use records (Java 16+) or classes with validation annotations
public record CreateUserRequest(
    @NotBlank @Email String email,
    @NotBlank @Size(min = 8, max = 100) String password,
    @NotBlank @Size(max = 50) String name
) {}

// For updates (partial), use nullable fields
public record UpdateUserRequest(
    @Email String email,
    @Size(max = 50) String name
) {}
```

### Response DTOs
```java
// Use records for immutable responses
public record UserResponse(
    Long id,
    String email,
    String name,
    LocalDateTime createdAt
) {
    // Static factory from entity
    public static UserResponse from(User user) {
        return new UserResponse(user.getId(), user.getEmail(), user.getName(), user.getCreatedAt());
    }
}
```

## Controller Test Pattern (@WebMvcTest)
```java
@WebMvcTest(UserController.class)
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void shouldCreateUser() throws Exception {
        CreateUserRequest request = new CreateUserRequest("user@example.com", "password123", "Test User");
        UserResponse response = new UserResponse(1L, "user@example.com", "Test User", LocalDateTime.now());

        when(userService.create(any(CreateUserRequest.class))).thenReturn(response);

        mockMvc.perform(post("/api/v1/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.email").value("user@example.com"))
            .andExpect(jsonPath("$.name").value("Test User"));
    }

    @Test
    void shouldReturn400ForInvalidRequest() throws Exception {
        CreateUserRequest request = new CreateUserRequest("", "", ""); // invalid

        mockMvc.perform(post("/api/v1/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
            .andExpect(status().isBadRequest());
    }

    @Test
    void shouldReturnUserById() throws Exception {
        UserResponse response = new UserResponse(1L, "user@example.com", "Test User", LocalDateTime.now());
        when(userService.findById(1L)).thenReturn(response);

        mockMvc.perform(get("/api/v1/users/1"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.id").value(1))
            .andExpect(jsonPath("$.email").value("user@example.com"));
    }

    @Test
    void shouldReturn404WhenUserNotFound() throws Exception {
        when(userService.findById(999L)).thenThrow(new ResourceNotFoundException("User", 999L));

        mockMvc.perform(get("/api/v1/users/999"))
            .andExpect(status().isNotFound());
    }
}
```

## Repository Test Pattern (@DataJpaTest)
```java
@DataJpaTest
class UserRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TestEntityManager entityManager;

    @BeforeEach
    void setUp() {
        User user = new User();
        user.setEmail("test@example.com");
        user.setName("Test User");
        user.setPasswordHash("hashed");
        entityManager.persistAndFlush(user);
    }

    @Test
    void shouldFindByEmail() {
        Optional<User> found = userRepository.findByEmail("test@example.com");

        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("Test User");
    }

    @Test
    void shouldReturnEmptyForNonExistentEmail() {
        Optional<User> found = userRepository.findByEmail("nonexistent@example.com");

        assertThat(found).isEmpty();
    }
}
```

## Service Unit Test Pattern (Mockito)
```java
@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private UserService userService;

    @Test
    void shouldCreateUser() {
        CreateUserRequest request = new CreateUserRequest("user@example.com", "password123", "Test User");

        when(userRepository.existsByEmail("user@example.com")).thenReturn(false);
        when(passwordEncoder.encode("password123")).thenReturn("hashed");
        when(userRepository.save(any(User.class))).thenAnswer(invocation -> {
            User user = invocation.getArgument(0);
            user.setId(1L);
            return user;
        });

        UserResponse response = userService.create(request);

        assertThat(response.email()).isEqualTo("user@example.com");
        verify(userRepository).save(any(User.class));
    }

    @Test
    void shouldThrowConflictWhenEmailExists() {
        CreateUserRequest request = new CreateUserRequest("taken@example.com", "password123", "User");
        when(userRepository.existsByEmail("taken@example.com")).thenReturn(true);

        assertThatThrownBy(() -> userService.create(request))
            .isInstanceOf(ConflictException.class)
            .hasMessageContaining("Email already registered");
    }
}
```

## Integration Test Pattern (@SpringBootTest)
```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
class UserIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    void setUp() {
        userRepository.deleteAll();
    }

    @Test
    void shouldCreateAndRetrieveUser() throws Exception {
        // Create
        CreateUserRequest request = new CreateUserRequest("user@example.com", "password123", "Test User");

        String createResult = mockMvc.perform(post("/api/v1/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(request)))
            .andExpect(status().isCreated())
            .andReturn().getResponse().getContentAsString();

        Long userId = objectMapper.readTree(createResult).get("id").asLong();

        // Retrieve
        mockMvc.perform(get("/api/v1/users/" + userId))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.email").value("user@example.com"));
    }
}
```

## Test Data Setup
```java
// @BeforeEach for test data setup
@BeforeEach
void setUp() {
    // Clean state
    userRepository.deleteAll();

    // Create test data
    User admin = new User();
    admin.setEmail("admin@example.com");
    admin.setRole(Role.ADMIN);
    userRepository.save(admin);
}

// Test fixtures as helper methods
private User createTestUser(String email, Role role) {
    User user = new User();
    user.setEmail(email);
    user.setName("Test User");
    user.setRole(role);
    user.setPasswordHash("hashed");
    return userRepository.save(user);
}
```

## Query Patterns
```java
// Eager loading -- prevent N+1 with @EntityGraph
@EntityGraph(attributePaths = {"roles", "profile"})
Optional<User> findWithRolesAndProfileById(Long id);

// Custom JPQL with JOIN FETCH
@Query("SELECT u FROM User u JOIN FETCH u.roles WHERE u.id = :id")
Optional<User> findWithRolesById(@Param("id") Long id);

// Pagination (Spring Data default)
Page<User> findByRole(Role role, Pageable pageable);
// Usage: userRepository.findByRole(Role.USER, PageRequest.of(0, 25, Sort.by("createdAt").descending()));

// Specification for dynamic queries (optional)
public static Specification<User> hasRole(Role role) {
    return (root, query, cb) -> cb.equal(root.get("role"), role);
}
```

## Changelog
<!-- Update when conventions change -->
