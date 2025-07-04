---
description: Perform comprehensive security and best practices audit
---

Perform a security and best practices audit:

1. Security scanning:
   - Search for hardcoded credentials:
     - API keys, tokens, passwords
     - AWS/Cloudflare/Vercel credentials
     - Database connection strings
   - Check for exposed secrets in:
     - Environment files (.env, .properties)
     - Configuration files (application.yml, config.toml)
     - Docker/container images
     - Git history

2. Code-level security:
   **Typescript:**
   - SQL injection (parameterized queries)
   - Cross-site scripting (XSS) prevention
   - Prototype pollution vulnerabilities
   - Regular expression denial of service (ReDoS)
   - Input validation and sanitisation
   - Authentication and authorisation flaws
   - Improper error handling exposing internals
   - Insecure direct object references
   - Command injection in child_process/exec

   **Go:**
   - SQL injection (parameterized queries)
   - Command injection in os/exec
   - Path traversal vulnerabilities
   - Improper error handling exposing internals

   **Shell scripts:**
   - Proper quoting and escaping
   - Command injection vulnerabilities
   - Input validation

3. File permissions audit:
   - Check executable scripts have proper permissions
   - Verify no world-writable files
   - Ensure backup directories have restricted access
   - Validate .ssh and sensitive config permissions

4. Portability checks:
   - Verify no hard-coded paths (should use ~ or variables)
   - Check for platform-specific commands
   - Validate shell compatibility (bash vs zsh)

5. Backup safety:
   - Verify backups don't include sensitive data
   - Check backup paths are secure
   - Validate restore process doesn't expose secrets
   - Ensure atomic operations for critical files

6. Best practices review:
   - Check for proper error handling
   - Verify cleanup on script failure
   - Validate logging doesn't expose sensitive data
   - Ensure idempotent operations

7. Language/Framework specific:
   **Typescript:**
   - NPM vulnerability scanning (npm audit, Snyk, audit-ci)
   - Prototype pollution prevention (--disable-proto)
   - Client-side security headers (CSP, CSRF tokens)
   - Server-side security middleware (helmet.js, rate limiting)
   - Dependency management (lockfile integrity, outdated packages)
   - Type safety validation (strict mode, no any usage)
   - Build process security (sourcemap exposure, minification)
   - Environment variable validation
   - Package integrity verification
   - Bundle analysis for sensitive data exposure

   **Go:**
   - Module vulnerabilities (nancy, gosec)
   - Goroutine leaks
   - Race conditions
   - Proper context cancellation

8. Infrastructure security:
   - Kubernetes manifest validation
   - Helm chart security
   - Infrastructure as Code scanning (Terraform, SST)
   - CI/CD pipeline security

9. Generate audit report:

   ```markdown
   # Security Audit Report

   Generated: [timestamp]
   Project Type: [Typescript/Go/Mixed]

   ## Critical Issues (Immediate Action Required)

   - [CVE-2023-XXXXX] Vulnerable dependency: package@version
   - [SEC001] Hardcoded database password in config.properties:45

   ## High Priority (Fix Soon)

   - [SEC002] SQL injection risk in UserRepository.java:78
   - [SEC003] Missing RBAC for admin endpoints

   ## Medium Priority (Plan to Fix)

   - [SEC004] Outdated TLS version in use
   - [SEC005] Missing rate limiting on API

   ## Low Priority (Best Practice)

   - [BP001] Consider using structured logging
   - [BP002] Add security headers

   ## Compliance Status

   - OWASP Top 10: [Status]
   - CIS Benchmarks: [Status]
   - PCI DSS: [Status if applicable]

   ## Summary

   - Total issues found: X
   - Critical: X, High: X, Medium: X, Low: X
   - Estimated remediation time: X hours
   - Recommended actions: [prioritized list]
   ```

Save report to: `/tmp/security-audit-[timestamp].md`

Include specific remediation commands and code examples for each finding.
