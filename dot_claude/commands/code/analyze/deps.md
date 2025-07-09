---
allowed-tools: Read, Write, Bash(fd:*), Bash(rg:*), Bash(jq:*), Bash(mvn:*), Bash(gradle:*), Bash(go:*), Bash(cargo:*), Bash(npm:*), Bash(yarn:*), Bash(deno:*), Bash(helm:*), Bash(trivy:*), Task
description: Intelligent dependency analysis and management with security auditing
---

## Context

- Session ID: !`gdate +%s%N`
- Current directory: !`pwd`
- Project structure: !`fd . -t d -d 2 | head -10`
- Package managers detected: !`fd "(package\.json|go\.mod)$" . | head -10 || echo "No package managers detected"`
- Git status: !`git status --porcelain | head -5 || echo "Not a git repository"`
- Current branch: !`git branch --show-current 2>/dev/null || echo "No git repository"`
- Technology stack summary: !`fd "(package\.json|go\.mod)$" . | head -5 | xargs -I {} basename {} || echo "Unknown stack"`

## Your task

STEP 1: Initialize Session State

- Create session state file: /tmp/deps-analysis-$SESSION_ID.json
- Initialize dependency registry and risk tracking
- Set up parallel analysis coordination
- Create checkpoint system for resumable analysis

STEP 2: Package Manager Detection and Parallel Analysis

FOR EACH detected package manager type:

- **Go Projects**: Analyze go.mod, go.sum files
- **Node.js Projects**: Analyze package.json (npm/yarn/pnpm/bun)

IF multiple package managers detected:

- Launch parallel sub-agents for each technology stack:
  - Agent 1: JavaScript/Node.js dependency analysis
  - Agent 2: Go dependency analysis

ELSE:

- Proceed with single-stack analysis
- Focus deep analysis on detected technology

STEP 3: Security Audit Execution

TRY:

- **Go**: Execute `go list -m all` with vulnerability scanning
- **Node.js**: Execute `npm audit`
- Check CVE databases and security advisories
- Prioritize findings by severity (Critical > High > Medium > Low)
- Generate SBOM (Software Bill of Materials)
- Save checkpoint: security_audit_complete

CATCH (command_not_found OR audit_tool_missing):

- Document missing security tools
- Provide installation instructions for required tools
- Fall back to manual security analysis
- Update state with tool availability status

STEP 4: Outdated Dependencies Analysis

FOR EACH package manager:

- **Go**: Execute `go list -u -m all`
- **Node.js**: Execute `npm outdated`
- Categorize updates by type (patch/minor/major)
- Check breaking changes in changelogs/release notes
- Identify packages not updated in >1 year
- Flag unmaintained or archived packages
- Save checkpoint: outdated_analysis_complete

STEP 5: Unused Dependencies Detection

- Use `rg` to scan codebase for actual dependency usage
- Identify dependencies never imported/required
- Find dev dependencies leaked to production
- Check for duplicate functionality packages
- Calculate size impact of unused packages
- Generate removal recommendations with commands

STEP 6: Dependency Optimization Analysis

- Suggest lighter alternatives (e.g., date-fns vs moment.js)
- Identify packages replaceable with native code
- Find bundle size reduction opportunities
- Recommend tree-shakeable alternatives
- Check for obsolete polyfills
- Calculate potential performance improvements

STEP 7: Update Strategy Generation

CREATE staged update plan:

1. **Priority 1**: Security patches (execute immediately)
2. **Priority 2**: Patch updates (low risk)
3. **Priority 3**: Minor updates (moderate risk)
4. **Priority 4**: Major updates (high risk, requires testing)

GENERATE update commands:

- **Go**: `go get -u package@version`
- **Node.js**: `npm update package@version` OR `pnpm upgrade package@version` OR `bun upgrade package@version`

INCLUDE rollback strategy:

- Git tag before updates: `git tag pre-deps-update-$(date +%Y%m%d)`
- Rollback commands for each package manager
- Testing requirements for each update batch
- PR-ready update batches with descriptions

STEP 8: License Compliance Audit

- Extract all dependency licenses using package manager tools
- Flag potentially incompatible licenses
- Identify copyleft licenses requiring attention
- Generate license compliance report
- Suggest alternatives for problematic licenses

STEP 9: Report Generation and State Management

CREATE comprehensive analysis report:

```json
// /tmp/deps-analysis-$SESSION_ID.json
{
  "sessionId": "$SESSION_ID",
  "timestamp": "ISO_8601_TIMESTAMP",
  "project": {
    "path": "CURRENT_DIRECTORY",
    "technologies": ["detected_stack"],
    "packageManagers": ["npm", "cargo", "go"]
  },
  "security": {
    "vulnerabilities": {
      "critical": 0,
      "high": 2,
      "medium": 5,
      "low": 3
    },
    "riskScore": "medium",
    "sbomGenerated": true
  },
  "outdated": {
    "totalPackages": 45,
    "patchUpdates": 12,
    "minorUpdates": 8,
    "majorUpdates": 3,
    "unmaintained": 1
  },
  "unused": {
    "dependencies": ["package1", "package2"],
    "devDependencies": ["dev-package1"],
    "potentialSavings": "2.3MB"
  },
  "updateStrategy": {
    "securityPatches": ["immediate_updates"],
    "safeUpdates": ["patch_updates"],
    "riskUpdates": ["major_updates"]
  },
  "license": {
    "compliant": true,
    "issues": [],
    "copyleftLicenses": ["GPL-3.0"]
  },
  "recommendations": [
    "Update security vulnerabilities immediately",
    "Remove unused dependencies to reduce bundle size",
    "Consider lighter alternatives for heavy packages"
  ]
}
```

STEP 10: Cleanup and Final Output

TRY:

- Generate executive summary with actionable insights
- Create categorized issue list with priorities
- Provide specific remediation commands
- Generate testing checklist for updates
- Estimate effort and risk for each update category
- Save final analysis report

FINALLY:

- Clean up temporary analysis files
- Archive session state for future reference
- Update project dependency tracking if configured
