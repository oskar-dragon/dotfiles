---
description: Helps to access and prioritise technical debt in the codebase.
---

Assess and prioritize technical debt in $ARGUMENTS with actionable remediation strategies.

Steps:

1. **Code Quality Analysis:**

- Check for code smells and anti-patterns
- check for duplication
- check for code complexity metrics
- check for anti-patterns in a codebase
- check language specific smells

3. **Dependency Health Assessment:**

- Look for outdated Dependencies
- look for security vulnerabilities
- Look for unused dependencies

4. **Performance Debt Analysis:**

- Look for inefficient patterns
- Look for resource management issues

5. **Documentation Debt:**

- Check for missing documentation in our application
- Check for outdated documentation
- Check for missing README sections

8. **Security Debt:**

- Check for hardcoded secrets
- Check for unsafe operations

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

**Output Deliverables:**

- Technical debt assessment report with priorities
- Quantified metrics (complexity, duplication, coverage)
- Security vulnerability analysis
- Dependency health report
- Remediation roadmap with effort estimates
- Automated tooling setup for ongoing monitoring
- Integration with CI/CD for debt prevention
