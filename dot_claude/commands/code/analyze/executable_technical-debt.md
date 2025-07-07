---
description: Assess and prioritize technical debt with actionable remediation strategies and comprehensive analysis
---

Assess and prioritize technical debt in $ARGUMENTS with actionable remediation strategies.

Steps:

1. **Code Quality Analysis:**

   **Static Analysis Tools:**

   ```bash
   # Go
   if [ -f "go.mod" ]; then
     golangci-lint run
     staticcheck ./...
     go mod tidy && git diff --exit-code go.mod go.sum
   fi

   # TypeScript
   if [ -f "tsconfig.json" ]; then
     npx tsc --noEmit
     npx eslint . --ext .ts,.tsx
   fi

   # Deno/TypeScript
   if [ -f "deno.json" ]; then
     deno lint
     deno check **/*.ts
   fi
   ```

   **Code Complexity Metrics:**

   ```bash
   # Cyclomatic complexity
   rg "if|else|while|for|match|switch|case|catch|\?\?" --count-matches

   # Function/method length (>20 lines flagged)
   rg "fn |func |def |function " -A 25 -B 1 | rg "^--$" --count

   # Large files (>500 lines)
   find . -name "*.go" -o -name "*.ts" -o -name "*.tsx" | \
     xargs wc -l | sort -nr | head -20
   ```

2. **Code Smell Detection:**

   **Duplication Analysis:**

   ```bash
   # Find duplicate code blocks (simplified detection)
   rg "(.{50,})" --only-matching | sort | uniq -c | sort -nr | head -10

   # Similar function signatures
   rg "fn |func |def |function " -o | sort | uniq -c | sort -nr

   # Repeated string literals
   rg '"[^"]{10,}"' -o | sort | uniq -c | sort -nr | head -20
   ```

   **Anti-Pattern Detection:**

   ```bash
   # God objects/classes (many methods)
   rg "impl.*{|class.*{" -A 100 | rg "fn |def |public.*(" --count-matches

   # Long parameter lists (>5 parameters)
   rg "\([^)]*,[^)]*,[^)]*,[^)]*,[^)]*," -n

   # Nested complexity (deep indentation)
   rg "^[[:space:]]{16,}" --count-matches

   # Magic numbers and hardcoded values
   rg "\b\d{2,}\b" --type go --type ts | head -20
   ```

   **Language-Specific Smells:**

   ```bash
   # Go-specific
   rg "interface\{\}" --type go -n
   rg "panic\(|recover\(\)" --type go -n
   rg "//.*TODO|//.*FIXME|//.*HACK" --type go -n

   # TypeScript-specific
   rg "any\b|as any" --type ts -n
   rg "// @ts-ignore|// @ts-nocheck" --type ts -n
   rg "\.toString\(\)|String\(\)" --type ts -n
   ```

3. **Dependency Health Assessment:**

   **Outdated Dependencies:**

   ```bash
   # Go
   go list -u -m all | grep "\["

   # TypeScript/Node.js
   npm outdated || bun outdated

   # Deno
   deno info --json | jq '.modules[] | select(.specifier | startswith("http"))'
   ```

   **Security Vulnerabilities:**

   ```bash
   # Go
   govulncheck ./...

   # TypeScript/Node.js
   npm audit || bun audit
   ```

   **Unused Dependencies:**

   ```bash
   # Find potentially unused imports/dependencies
   rg "^import |^from.*import" | sort | uniq -c | sort -n

   # TypeScript/Node.js unused dependencies
   npx depcheck || echo "Install depcheck for unused dependency analysis"
   ```

4. **Performance Debt Analysis:**

   **Inefficient Patterns:**

   ```bash
   # Potential memory leaks and inefficiencies
   rg "make\(.*\).*for|append.*loop" --type go
   rg "new.*Array.*for|\.push.*loop" --type ts

   # Synchronous operations that could be async
   rg "\.wait\(\)|setTimeout.*0" -n

   # Database N+1 query patterns
   rg "query.*loop|select.*for.*in" -n
   ```

   **Resource Management:**

   ```bash
   # Missing resource cleanup
   rg "os\.Open|http\.Get" --type go -A 5 | rg -v "defer.*Close"
   rg "fetch\(|XMLHttpRequest" --type ts -A 5 | rg -v "finally|catch"

   # Large allocations
   rg "make.*[0-9]{4,}" --type go
   rg "new Array\([0-9]{4,}" --type ts
   ```

5. **Test Debt Assessment:**

   **Test Coverage Analysis:**

   ```bash
   # Go
   go test -cover ./...

   # TypeScript/Node.js
   npm test -- --coverage || jest --coverage

   # Find untested files
   find src/ -name "*.go" -o -name "*.ts" | \
     while read f; do
       test_file="test_$(basename "$f")"
       [ ! -f "tests/$test_file" ] && echo "Missing tests: $f"
     done
   ```

   **Test Quality Issues:**

   ```bash
   # Flaky tests (sleeps, timeouts)
   rg "sleep|Sleep|Thread\.sleep|setTimeout" tests/ -n

   # Missing assertions
   rg "test.*fn|it\(|describe\(" -A 10 | rg -v "assert|expect|should" -B 10 -A 5

   # Test naming issues (non-descriptive)
   rg "test.*fn test[0-9]|it\(\"test[0-9]" tests/ -n
   ```

6. **Documentation Debt:**

   **Missing Documentation:**

   ```bash
   # Public APIs without docs
   rg "export.*function|export.*class|export.*interface" -A 1 | rg -v "//|/\*|\*|#"

   # Outdated documentation
   rg "TODO|FIXME|XXX|HACK|@deprecated" docs/ README.md -n

   # Missing README sections
   [ ! -f README.md ] && echo "Missing README.md"
   rg "Installation|Usage|Contributing|License" README.md -c
   ```

   **Code Comments Debt:**

   ```bash
   # Commented-out code (potential dead code)
   rg "//.*fn |//.*function|//.*def |//.*class" -n

   # Misleading comments
   rg "//.*TODO.*\d{4}|//.*FIXME.*\d{4}" -n
   ```

7. **Architecture Debt Analysis:**

   **Dependency Violations:**

   ```bash
   # Circular dependencies
   # Go
   go mod graph | awk '{print $1, $2}' | sort | uniq | \
     awk '{print $2, $1}' | sort | comm -12 - <(go mod graph | sort)

   # TypeScript
   npx madge --circular src/ --extensions ts,tsx

   # Inappropriate dependencies (high-level depending on low-level)
   rg "use.*database|import.*database" src/domain/ -n
   ```

   **Coupling Issues:**

   ```bash
   # High coupling indicators
   rg "import.*\*" -n

   # Feature flag sprawl
   rg "feature.*flag|if.*enabled|toggle" -c
   ```

8. **Security Debt:**

   **Security Anti-Patterns:**

   ```bash
   # Hardcoded secrets
   rg "password.*=|secret.*=|key.*=|token.*=" -n
   rg "\\b[A-Za-z0-9]{20,}\\b" --type go --type ts | head -10

   # Unsafe operations
   rg "eval\(|exec\(|system\(" -n

   # SQL injection risks
   rg "query.*\+|SELECT.*\+|INSERT.*\+" -n
   ```

9. **Technical Debt Scoring:**

   **Priority Matrix:**

   ```bash
   # Create debt assessment matrix
   echo "# Technical Debt Assessment"
   echo "## High Priority (Fix First)"
   echo "- [ ] Security vulnerabilities"
   echo "- [ ] Performance bottlenecks in critical paths"
   echo "- [ ] Test gaps in core functionality"
   echo ""
   echo "## Medium Priority"
   echo "- [ ] Code duplication >20%"
   echo "- [ ] Outdated dependencies with breaking changes"
   echo "- [ ] Missing documentation for public APIs"
   echo ""
   echo "## Low Priority (Refactor Later)"
   echo "- [ ] Stylistic issues"
   echo "- [ ] Minor complexity improvements"
   echo "- [ ] Non-critical dependency updates"
   ```

   **Debt Quantification:**

   ```bash
   # Lines of code metrics
   total_lines=$(find . -name "*.go" -o -name "*.ts" -o -name "*.tsx" | xargs wc -l | tail -1 | awk '{print $1}')
   test_lines=$(find tests/ -name "*.go" -o -name "*.ts" -o -name "*.tsx" 2>/dev/null | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}' || echo 0)

   echo "Total LOC: $total_lines"
   echo "Test LOC: $test_lines"
   echo "Test Ratio: $(echo "scale=2; $test_lines / $total_lines" | bc 2>/dev/null || echo "N/A")"
   ```

10. **Remediation Roadmap:**

    **Immediate Actions (This Sprint):**
    - Fix critical security vulnerabilities
    - Address performance bottlenecks in hot paths
    - Add tests for core business logic gaps
    - Update dependencies with known CVEs

    **Short-term Actions (Next 2-3 Sprints):**
    - Refactor large functions/classes
    - Eliminate code duplication
    - Improve error handling patterns
    - Add missing API documentation

    **Long-term Actions (Next Quarter):**
    - Architectural improvements
    - Technology stack modernization
    - Comprehensive test suite enhancement
    - Documentation overhaul

**Output Deliverables:**

- Technical debt assessment report with priorities
- Quantified metrics (complexity, duplication, coverage)
- Security vulnerability analysis
- Dependency health report
- Remediation roadmap with effort estimates
- Automated tooling setup for ongoing monitoring
- Integration with CI/CD for debt prevention

**Automation Setup:**

- Pre-commit hooks for code quality checks
- CI pipeline integration for continuous monitoring
- Regular dependency update automation
- Security scanning in deployment pipeline
- Code quality gates for pull requests

**Follow-up Actions:**

- Schedule regular debt assessment reviews
- Set up team debt reduction sprints
- Create debt prevention guidelines
- Integrate with project planning processes
- Track debt metrics over time
