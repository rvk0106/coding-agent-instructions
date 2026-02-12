# Feature Implementation Conventions
> Tags: conventions, testing, patterns, junit
> Scope: Patterns to follow when implementing any feature in the library
> Last updated: [TICKET-ID or date]

## Class Structure
```java
// src/main/java/com/example/lib/api/FeatureName.java
package com.example.lib.api;

import com.example.lib.config.FeatureConfig;
import com.example.lib.exception.LibNameException;

/**
 * Brief description.
 *
 * @since 1.0.0
 */
public interface FeatureName {
    // Public interface methods
}
```

## Configuration Pattern
```java
// If the feature adds config options, use the builder pattern:
public final class FeatureConfig {
    private final String option;
    private final Duration timeout;

    private FeatureConfig(Builder builder) {
        this.option = builder.option;
        this.timeout = builder.timeout != null ? builder.timeout : Duration.ofSeconds(30);
    }

    public String getOption() { return option; }
    public Duration getTimeout() { return timeout; }

    public static Builder builder() { return new Builder(); }

    public static final class Builder {
        private String option;
        private Duration timeout;

        public Builder option(String option) { this.option = option; return this; }
        public Builder timeout(Duration timeout) { this.timeout = timeout; return this; }
        public FeatureConfig build() { return new FeatureConfig(this); }
    }
}
```

## Javadoc Standards
```java
// Every public class/method must have:
// @param, @return, @throws, @since

/**
 * Processes the given input and returns a result.
 *
 * <p>This method validates the input, applies the configured transformations,
 * and returns the processed result.</p>
 *
 * @param input the input to process, must not be {@code null}
 * @param options optional configuration overrides, may be {@code null}
 * @return the processed result, never {@code null}
 * @throws ValidationException if input fails validation
 * @throws ConfigurationException if the client is not properly configured
 * @since 1.2.0
 */
public Result process(@NonNull String input, @Nullable Options options) {
    Objects.requireNonNull(input, "input must not be null");
    // ...
}
```

## Test Data
```java
// Use @BeforeEach for test setup
// Prefer builder patterns for test objects

class FeatureTest {
    private FeatureConfig config;
    private LibClient client;

    @BeforeEach
    void setUp() {
        config = FeatureConfig.builder()
            .option("test-value")
            .timeout(Duration.ofSeconds(5))
            .build();
        client = LibClient.create(config);
    }
}
```

## Unit Test Pattern (JUnit 5)
```java
// src/test/java/com/example/lib/api/FeatureNameTest.java
package com.example.lib.api;

import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import static org.assertj.core.api.Assertions.*;

class FeatureNameTest {

    private FeatureName feature;

    @BeforeEach
    void setUp() {
        feature = new DefaultFeatureName(config);
    }

    @Nested
    @DisplayName("process()")
    class ProcessTests {

        @Test
        @DisplayName("returns result for valid input")
        void returnsResultForValidInput() {
            Result result = feature.process("valid-input");

            assertThat(result).isNotNull();
            assertThat(result.isSuccess()).isTrue();
            assertThat(result.getData()).isEqualTo("expected");
        }

        @Test
        @DisplayName("throws ValidationException for null input")
        void throwsForNullInput() {
            assertThatThrownBy(() -> feature.process(null))
                .isInstanceOf(ValidationException.class)
                .hasMessageContaining("must not be null");
        }

        @Test
        @DisplayName("throws ValidationException for blank input")
        void throwsForBlankInput() {
            assertThatThrownBy(() -> feature.process(""))
                .isInstanceOf(ValidationException.class)
                .hasMessageContaining("must not be blank");
        }

        @ParameterizedTest
        @ValueSource(strings = {"input1", "input2", "input3"})
        @DisplayName("processes various valid inputs")
        void processesVariousInputs(String input) {
            Result result = feature.process(input);
            assertThat(result.isSuccess()).isTrue();
        }
    }
}
```

## Integration Test Pattern
```java
// src/test/java/com/example/lib/integration/FeatureIntegrationTest.java
package com.example.lib.integration;

import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.EnabledIfEnvironmentVariable;

@Tag("integration")
class FeatureIntegrationTest {

    private LibClient client;

    @BeforeEach
    void setUp() {
        FeatureConfig config = FeatureConfig.builder()
            .option(System.getenv("TEST_OPTION"))
            .build();
        client = LibClient.create(config);
    }

    @Test
    @EnabledIfEnvironmentVariable(named = "TEST_OPTION", matches = ".+")
    @DisplayName("processes end-to-end with real service")
    void processesEndToEnd() {
        Result result = client.execute("real input");
        assertThat(result.isSuccess()).isTrue();
    }
}
```

## Mocking with Mockito
```java
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ServiceTest {

    @Mock
    private ExternalClient externalClient;

    @InjectMocks
    private DefaultService service;

    @Test
    void delegatesToExternalClient() {
        when(externalClient.call(anyString())).thenReturn("response");

        Result result = service.process("input");

        assertThat(result.getData()).isEqualTo("response");
        verify(externalClient).call("input");
    }

    @Test
    void wrapsExternalExceptionAsLibException() {
        when(externalClient.call(anyString()))
            .thenThrow(new java.io.IOException("network error"));

        assertThatThrownBy(() -> service.process("input"))
            .isInstanceOf(ConnectionException.class)
            .hasMessageContaining("network error")
            .hasCauseInstanceOf(java.io.IOException.class);
    }
}
```

## Changelog
<!-- Update when conventions change -->
