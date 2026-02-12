# Security Rules
> Tags: security, xss, csp, auth, tokens, sanitization
> Scope: Security constraints agents must follow in frontend development
> Last updated: [TICKET-ID or date]

## NEVER Do These
- Never use `dangerouslySetInnerHTML` without sanitizing (use DOMPurify or equivalent)
- Never store secrets, API keys, or private tokens in client-side code or env vars
- Never store auth tokens in `localStorage` if possible (prefer `httpOnly` cookies)
- Never interpolate user input into `eval()`, `new Function()`, or `innerHTML`
- Never disable HTTPS in production
- Never trust client-side validation alone — always validate on the server too
- Never expose user PII in URLs (use POST or request body)
- Never log sensitive data to the browser console in production

## Always Do These
- Always sanitize user input before rendering as HTML
- Always use React's built-in JSX escaping (don't bypass it)
- Always use `rel="noopener noreferrer"` on external links with `target="_blank"`
- Always validate and type-check API responses before using them
- Always set appropriate CORS headers on the API side
- Always use HTTPS for all API calls
- Always set `Content-Security-Policy` headers where possible

## XSS Prevention
```tsx
// SAFE — React's JSX escapes by default
<p>{userInput}</p>

// DANGER — only with sanitized content
import DOMPurify from 'dompurify';
<div dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(htmlContent) }} />

// NEVER — raw unsanitized HTML
<div dangerouslySetInnerHTML={{ __html: userInput }} />
```

## Authentication Tokens
- Prefer `httpOnly` cookies (not accessible to JS, XSS-safe)
- If using `localStorage`: acceptable for low-risk tokens, but understand the XSS risk
- If using in-memory (React state/context): safest, but lost on refresh
- Always send tokens via `Authorization: Bearer <token>` header, not URL params
- Always handle token refresh/expiry gracefully (redirect to login)

## Environment Variables
```bash
# SAFE — public config (included in bundle)
VITE_API_URL=https://api.example.com
VITE_APP_ENV=production

# NEVER in client env vars — these belong on the server
# DATABASE_URL=...
# API_SECRET_KEY=...
# STRIPE_SECRET_KEY=...
```

## Third-Party Scripts
- Audit all third-party scripts (analytics, tracking, widgets)
- Load third-party scripts async where possible
- Use Subresource Integrity (SRI) for CDN-hosted scripts
- Review permissions and data sharing for each third party

## Dependency Auditing
```bash
# Check for known vulnerabilities
npm audit

# Fix automatically (safe fixes only)
npm audit fix

# Check for outdated packages
npm outdated
```

## Form Security
- Validate inputs on client AND server
- Use appropriate `type` attributes (`email`, `url`, `number`, etc.)
- Set `autocomplete` attributes correctly
- Use CSRF tokens for state-changing requests (if cookie-based auth)

## Changelog
<!-- [PROJ-123] Added DOMPurify for user-generated HTML content -->
