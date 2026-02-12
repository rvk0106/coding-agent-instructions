# Security Rules
> Tags: security, validation, audit, safe-coding
> Scope: Security constraints agents must follow when developing the library
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never use `Runtime.exec()` or `ProcessBuilder` with user-provided input
- Never use `ObjectInputStream.readObject()` on untrusted data (deserialization attacks)
- Never parse XML without disabling external entities (XXE attacks)
- Never concatenate user input into SQL strings (use `PreparedStatement`)
- Never use reflection on user-controlled class names (`Class.forName(userInput)`)
- Never hardcode secrets, API keys, or credentials in code
- Never log sensitive data (keys, tokens, passwords, PII)
- Never use `sun.*` or `com.sun.*` internal APIs
- Never disable SSL/TLS certificate verification
- Never use weak cryptographic algorithms (MD5, SHA-1 for security, DES)

## Always Do These
- Always validate and sanitize input at the library's public API boundary
- Always use `Objects.requireNonNull()` for non-null parameters
- Always use `PreparedStatement` if the library interacts with databases
- Always keep dependencies up to date
- Always use HTTPS for network connections
- Always set timeouts on HTTP/network connections
- Always validate SSL certificates (never disable verification)
- Always use `try-with-resources` for `AutoCloseable` resources

## Input Validation
```java
// CORRECT: validate at the public API boundary
public Result process(@NonNull String input) {
    Objects.requireNonNull(input, "input must not be null");
    if (input.isBlank()) {
        throw new ValidationException("input must not be blank");
    }
    // proceed with validated input
}

// WRONG: trust user input
public Result process(String input) {
    Runtime.getRuntime().exec(input);  // NEVER
}
```

## XML Parsing (prevent XXE)
```java
// CORRECT: disable external entities
DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);

// WRONG: default XML parsing allows XXE
DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
DocumentBuilder builder = factory.newDocumentBuilder();
Document doc = builder.parse(untrustedInput);  // VULNERABLE
```

## Deserialization
```java
// NEVER deserialize untrusted data
ObjectInputStream ois = new ObjectInputStream(untrustedStream);
Object obj = ois.readObject();  // DANGEROUS

// CORRECT: use safe serialization formats (JSON, Protocol Buffers, etc.)
```

## Dependency Auditing
```bash
# Maven: check for known vulnerabilities
mvn versions:display-dependency-updates
mvn dependency:tree
# Use OWASP dependency-check plugin
mvn org.owasp:dependency-check-maven:check

# Gradle
./gradlew dependencyUpdates
# Use OWASP dependency-check plugin
./gradlew dependencyCheckAnalyze
```

## Resource Management
```java
// CORRECT: try-with-resources
try (InputStream is = new FileInputStream(file);
     BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {
    // use reader
}

// WRONG: manual resource management (easy to leak)
InputStream is = new FileInputStream(file);
// ... if exception thrown here, resource leaks
is.close();
```

## HTTP/Network
- Always use `java.net.http.HttpClient` (Java 11+) or well-maintained HTTP libraries
- Always set connect and read timeouts
- Always validate SSL certificates
- Never interpolate user input into URLs without encoding
```java
// CORRECT: set timeouts
HttpClient client = HttpClient.newBuilder()
    .connectTimeout(Duration.ofSeconds(10))
    .build();

HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create(url))
    .timeout(Duration.ofSeconds(30))
    .build();
```

## File Operations
- Never write to arbitrary paths — validate and restrict
- Use `Path.normalize()` and check against allowed directories (path traversal)
- Prefer `Files.createTempFile()` for temporary files

## Changelog
<!-- [PROJ-123] Added input validation for all public methods -->
