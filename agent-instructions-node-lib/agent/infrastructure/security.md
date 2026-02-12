# Security Rules
> Tags: security, validation, audit, safe-coding
> Scope: Security constraints agents must follow when developing the package
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never use `eval()` or `new Function()` with user-provided input
- Never use `child_process.exec()` with unsanitized input (use `execFile` with args array)
- Never use `require()` or dynamic `import()` with user-controlled paths
- Never hardcode secrets, API keys, or credentials in code
- Never log sensitive data (keys, tokens, passwords, PII)
- Never deserialize untrusted data (`JSON.parse` is OK; avoid custom deserialization)
- Never use `vm.runInNewContext()` with untrusted code
- Never disable TLS certificate verification

## ALWAYS Do These
- Always validate and sanitize input at the package's public API boundary
- Always use parameterized queries if the package interacts with databases
- Always keep dependencies updated (`npm audit`)
- Always set timeouts on network calls (never hang indefinitely)
- Always use HTTPS, never HTTP
- Always validate SSL certificates

## Input Validation
```typescript
// CORRECT: validate at the public API boundary
export function process(input: string): Result {
  if (typeof input !== 'string') {
    throw new ValidationError('input must be a string');
  }
  if (input.length === 0) {
    throw new ValidationError('input must not be empty');
  }
  if (input.length > MAX_INPUT_LENGTH) {
    throw new ValidationError(`input must not exceed ${MAX_INPUT_LENGTH} characters`);
  }
  // proceed with validated input
}

// WRONG: trust user input
export function process(input: string): Result {
  eval(input); // NEVER
}
```

## Shell Command Safety
```typescript
// CORRECT: use execFile with args array
import { execFile } from 'node:child_process';
execFile('git', ['log', '--oneline', '-10'], callback);

// WRONG: use exec with string interpolation
import { exec } from 'node:child_process';
exec(`git log ${userInput}`, callback); // command injection risk
```

## Path Traversal Prevention
```typescript
import { resolve, relative } from 'node:path';

// CORRECT: validate paths stay within allowed directory
function readFile(userPath: string, baseDir: string): string {
  const resolved = resolve(baseDir, userPath);
  const rel = relative(baseDir, resolved);
  if (rel.startsWith('..') || resolve(resolved) !== resolved) {
    throw new ValidationError('path traversal detected');
  }
  return fs.readFileSync(resolved, 'utf-8');
}

// WRONG: use user input directly as path
function readFile(userPath: string): string {
  return fs.readFileSync(userPath, 'utf-8'); // path traversal risk
}
```

## Content Security (if DOM involved)
- Never use `innerHTML` with user input
- Use `textContent` or DOM APIs instead
- If HTML is necessary, sanitize with a trusted library

## Dependency Auditing
```bash
# Check for known vulnerabilities in dependencies
npm audit

# Fix automatically where possible
npm audit fix

# Check for outdated packages
npm outdated

# Update dependencies conservatively
npm update
```

## HTTP / Network
- Always use HTTPS, not HTTP
- Always set timeouts on connections and requests
- Always validate SSL certificates (don't set `rejectUnauthorized: false`)
- Never interpolate user input into URLs without encoding (`encodeURIComponent`)

## Changelog
<!-- [PROJ-123] Added input validation for all public methods -->
