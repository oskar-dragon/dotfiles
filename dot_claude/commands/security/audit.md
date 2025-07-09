---
allowed-tools: Task, Read, Bash(rg:*), Bash(fd:*), Bash(jq:*), Bash(gdate:*), Bash(git:*), Bash(docker:*), Bash(trivy:*), Bash(gosec:*), Bash(npm:*), Bash(kubectl:*), Bash(bat:*), Bash(eza:*), Bash(wc:*), Bash(head:*), Bash(tail:*)
description: Comprehensive security audit with parallel analysis using modern tools and sub-agent coordination.
---

# /audit

Perform a comprehensive security audit of the project, including checking for hardcoded secrets, scanning for vulnerabilities, and assessing the security of the infrastructure.

## Context

- Session ID: !`gdate +%s%N`
- Current directory: !`pwd`
- Project type: !`fd "(package\.json|go\.mod)" . -d 3 | head -5 || echo "No build files detected"`
- Git repository: !`git rev-parse --is-inside-work-tree 2>/dev/null && echo "Yes" || echo "No"`
- Repository files: !`fd . -t f | wc -l | tr -d ' ' ` files total

## Your Task

STEP 1: Initialize Comprehensive Security Audit Session

- CREATE session state file: `/tmp/audit-session-$SESSION_ID.json`
- ANALYZE project context and DETERMINE scanning strategy.
- ESTABLISH security baseline for comparison.

STEP 2: Parallel Security Discovery (Sub-Agent Coordination)

- THINK HARD about the optimal security audit strategy based on project context.
- LAUNCH parallel sub-agents for comprehensive security analysis:
  - **Credential Scanner**: Search for hardcoded secrets and credentials.
  - **Code Security Analyzer**: Language-specific security vulnerability analysis.
  - **Dependency Vulnerability Scanner**: Third-party dependency security analysis.
  - **Infrastructure Security Auditor**: Container and orchestration security.
  - **File Permissions Auditor**: File system security and access controls.
  - **Git Security Scanner**: Version control security analysis.
  - **Configuration Security Analyzer**: Security configuration assessment.
  - **CI/CD Pipeline Security Auditor**: DevOps security analysis.

STEP 3: Language-Specific Security Analysis

- EXECUTE targeted scanning based on detected project languages (Go, JavaScript/TypeScript).
- USE tools like `gosec` for Go and `npm audit` for Node.js.

STEP 4: Infrastructure Security Assessment

- IF Docker files detected, perform Docker security analysis (e.g., `trivy`).
- ANALYZE Kubernetes manifests for security misconfigurations.

STEP 5: Comprehensive Findings Aggregation and Risk Assessment

- AGGREGATE findings from all sub-agents.
- CLASSIFY findings by severity (Critical, High, Medium, Low).
- GENERATE security statistics and risk level.

STEP 6: Generate Comprehensive Security Audit Report

- CREATE a structured security audit report (`/tmp/security-audit-$SESSION_ID.md`) including:
  - Executive Summary
  - Critical, High, Medium, and Low Issues
  - Language-Specific Findings
  - Infrastructure Security Assessment
  - Compliance Assessment (OWASP Top 10, CIS Benchmarks)
  - Remediation Roadmap
  - Technical Recommendations
  - Monitoring and Continuous Security

STEP 7: Security Remediation and Prevention

- IMPLEMENT immediate security actions (e.g., create comprehensive `.gitignore` patterns, setup automated pre-commit security hooks).
- PROVIDE security recommendations for ongoing security.

STEP 8: Finalization and Cleanup

- UPDATE session state with audit results.
- CLEAN temporary working files (preserve audit results).
- PROVIDE actionable next steps based on findings.
