---
allowed-tools: Read, Bash, Grep, Task
description: Perform comprehensive security audit scanning for secrets, vulnerabilities, and misconfigurations
argument-hint: "[target-directory]"
---

# /audit

Comprehensive security audit of project files, dependencies, and configurations.

## Context

- Target directory: $ARGUMENTS (defaults to current directory)
- Current directory: !`pwd`
- Project type: !`fd "(package\.json|go\.mod|Cargo\.toml|requirements\.txt)" . -d 3 | head -5 || echo "No build files detected"`
- Git repository: !`git rev-parse --is-inside-work-tree 2>/dev/null && echo "Yes" || echo "No"`
- Repository files: !`fd . -t f | wc -l | tr -d ' '` files total

## Usage

```
/audit                    # Audit current directory
/audit ./src             # Audit specific directory
/audit /path/to/project  # Audit specific project path
```

## Your Task

**Step 1: Credential and Secret Scanning**

SEARCH for hardcoded credentials and secrets:
- USE Grep to scan for common secret patterns:
  - API keys: `(api[_-]?key|apikey)\s*[:=]\s*['\"][^'\"]+['\"]`
  - Passwords: `(password|passwd|pwd)\s*[:=]\s*['\"][^'\"]+['\"]`
  - Tokens: `(token|auth[_-]?token)\s*[:=]\s*['\"][^'\"]+['\"]`
  - Database URLs: `(mongodb|postgres|mysql)://[^\s]+`
  - Private keys: `-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----`
- EXCLUDE common false positives (test files, examples, placeholders)
- RECORD findings with file locations and line numbers

**Step 2: Dependency Vulnerability Analysis**

IF package manager files detected:
- FOR Node.js projects: RUN `npm audit --audit-level=moderate`
- FOR Go projects: RUN `go list -json -deps ./... | jq -r '.Module.Path' | sort -u`
- FOR Python projects: CHECK `requirements.txt` and suggest `pip-audit`
- FOR Rust projects: RUN `cargo audit` if available
- ANALYZE output for critical and high severity vulnerabilities

**Step 3: Configuration Security Assessment**

ANALYZE configuration files for security issues:
- SEARCH for exposed debug modes: `debug\s*[:=]\s*(true|1|on)`
- CHECK for insecure protocols: `http://` in production configs
- SCAN Docker files for root user, exposed ports, secrets
- REVIEW CI/CD files (.github, .gitlab-ci.yml) for credential exposure
- EXAMINE environment files (.env) if present

**Step 4: File Permission and Exposure Analysis**

CHECK for security-sensitive file exposure:
- SEARCH for accidentally committed sensitive files:
  - `.env`, `.env.local`, `.env.production`
  - Private keys: `*.pem`, `*.key`, `*_rsa`
  - Database files: `*.db`, `*.sqlite`
  - Backup files: `*.bak`, `*.backup`
- VERIFY `.gitignore` covers sensitive patterns

**Step 5: Generate Security Audit Report**

CREATE comprehensive markdown report with:

```markdown
# Security Audit Report

## Executive Summary
- Total files scanned: [count]
- Critical issues found: [count]
- High priority issues: [count]
- Medium/Low issues: [count]

## Critical Findings
[List critical security issues requiring immediate attention]

## High Priority Issues
[List high priority security concerns]

## Dependency Vulnerabilities
[Package manager audit results and recommendations]

## Configuration Security Issues
[Misconfigurations and hardening recommendations]

## Recommendations
1. Immediate actions required
2. Security improvements to implement
3. Ongoing security practices to adopt

## Next Steps
[Specific, actionable tasks to improve security posture]
```

**Step 6: Provide Actionable Remediation**

GENERATE specific remediation steps:
- CREATE secure `.gitignore` patterns if missing
- SUGGEST environment variable usage for secrets
- RECOMMEND dependency update commands for vulnerabilities
- PROVIDE configuration hardening guidelines

## Expected Output

- Comprehensive security audit report in markdown format
- Prioritized list of security issues with severity levels
- Specific remediation steps and commands
- Security best practices recommendations

## Examples

### Example 1: Full Project Audit
`/audit`

Scans current directory for secrets, dependencies, configs, and generates complete security report.

### Example 2: Targeted Directory Audit
`/audit ./backend/src`

Focuses security audit on specific application directory.

**IMPORTANT**: This audit identifies common security issues but does not replace professional security testing. Consider additional tools like static analysis scanners for production systems.