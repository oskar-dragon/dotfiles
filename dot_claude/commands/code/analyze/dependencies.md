---
allowed-tools: Read, Bash(fd:*), Bash(rg:*), Bash(go:*), Bash(npm:*), Bash(yarn:*), Bash(pip:*), Bash(cargo:*), Task
description: Analyze project dependencies for security, updates, and optimization opportunities
---

# /dependencies

Analyze project dependencies to identify security vulnerabilities, outdated packages, unused dependencies, and optimization opportunities.

## Context

Current directory: !`pwd`
Package managers detected: !`fd "(package\.json|go\.mod|requirements\.txt|Cargo\.toml|pom\.xml|build\.gradle)$" . | head -10 || echo "No package managers detected"`
Technology stack: !`fd "(package\.json|go\.mod|requirements\.txt|Cargo\.toml)$" . | head -5 | xargs -I {} basename {} || echo "Unknown stack"`

## Usage

```
/dependencies
```

## Your Task

**Step 1: Package Manager Detection**

Detect and analyze package managers in the project:

- **Go Projects**: Analyze go.mod, go.sum files
- **Node.js Projects**: Analyze package.json (npm/yarn/pnpm/bun)
- **Python Projects**: Analyze requirements.txt, pyproject.toml
- **Rust Projects**: Analyze Cargo.toml, Cargo.lock
- **Java Projects**: Analyze pom.xml, build.gradle

**Step 2: Dependency Mapping**

Map dependencies and their relationships:

- List direct dependencies from manifest files
- Identify dependency depth and complexity
- Detect circular dependencies if present
- Analyze internal module dependencies

**Step 3: Security Audit**

Run security audits for each package manager:

- **Go**: `go list -m all` with vulnerability scanning
- **Node.js**: `npm audit` or `yarn audit`
- **Python**: `pip-audit` or `safety check` (if available)
- **Rust**: `cargo audit` (if available)
- **Java**: `mvn dependency:tree` with security checks

Prioritize findings by severity (Critical > High > Medium > Low)

**Step 4: Outdated Dependencies Analysis**

Check for outdated packages:

- **Go**: `go list -u -m all`
- **Node.js**: `npm outdated` or `yarn outdated`
- **Python**: `pip list --outdated`
- **Rust**: `cargo outdated` (if available)
- **Java**: `mvn versions:display-dependency-updates`

Categorize updates by type (patch/minor/major) and identify breaking changes

**Step 5: Unused Dependencies Detection**

Find unused dependencies:

- Use `rg` to scan codebase for actual dependency usage
- Identify dependencies never imported/required
- Find dev dependencies leaked to production
- Check for duplicate functionality packages

**Step 6: Optimization Analysis**

Suggest optimizations:

- Recommend lighter alternatives (e.g., date-fns vs moment.js)
- Identify packages replaceable with native code
- Find bundle size reduction opportunities
- Check for obsolete polyfills

**Step 7: License Compliance**

Check license compatibility:

- Extract dependency licenses
- Flag potentially incompatible licenses
- Identify copyleft licenses requiring attention

## Expected Output

Generate a structured dependency analysis report:

````markdown
# Dependency Analysis Report

## Executive Summary

- **Total Dependencies**: [direct] direct, [transitive] transitive
- **Security Issues**: [critical] critical, [high] high, [medium] medium, [low] low
- **Outdated Packages**: [count] packages need updates
- **Unused Dependencies**: [count] packages can be removed
- **Potential Savings**: [size] bundle size reduction possible

## Security Vulnerabilities

### Critical Issues

- [Package Name] v[version]: [Description] → Update to v[new_version]

### High Priority

- [Package Name] v[version]: [Description] → Update to v[new_version]

## Outdated Dependencies

### Patch Updates (Safe)

- [Package Name]: v[current] → v[latest] (fixes: [description])

### Minor Updates (Low Risk)

- [Package Name]: v[current] → v[latest] (adds: [description])

### Major Updates (Breaking Changes)

- [Package Name]: v[current] → v[latest] (breaking: [description])

## Unused Dependencies

### Can Be Removed

- [Package Name]: Not found in codebase
- [Package Name]: Only used in tests but listed as dependency

### Recommendations

- Remove unused packages: `npm uninstall package1 package2`
- Move dev dependencies: `npm install --save-dev package3`

## Optimization Opportunities

### Bundle Size Reduction

- Replace [heavy-package] with [lighter-alternative] (saves [size])
- Use tree-shaking with [package-name]
- Remove [obsolete-polyfill] (no longer needed)

### Performance Improvements

- Upgrade [package-name] for better performance
- Consider native alternatives for [package-name]

## License Compliance

### Potential Issues

- [Package Name]: [License] may conflict with project license
- [Package Name]: Copyleft license requires attention

## Update Strategy

### Immediate Actions (Security)

```bash
# Update security vulnerabilities
npm install package1@latest package2@latest
```
````

### Safe Updates (Patches)

```bash
# Apply patch updates
npm update
```

### Planned Updates (Breaking Changes)

```bash
# Test in development first
npm install package3@latest
# Review breaking changes and update code
```

## Next Steps

1. [ ] Apply security patches immediately
2. [ ] Remove unused dependencies
3. [ ] Test patch updates in development
4. [ ] Plan major version upgrades
5. [ ] Review license compliance issues

```

## Examples

### Example 1: Node.js Project
`/dependencies` on a React project would analyze package.json, run npm audit, check for outdated packages, and suggest optimizations like replacing moment.js with date-fns.

### Example 2: Go Project
`/dependencies` on a Go project would analyze go.mod, check for security vulnerabilities, suggest updates, and identify unused imports.

### Example 3: Multi-language Project
`/dependencies` on a project with multiple package managers would analyze each stack separately and provide consolidated recommendations.

**IMPORTANT**: Focus on actionable recommendations with specific commands for updates and removals.
```
