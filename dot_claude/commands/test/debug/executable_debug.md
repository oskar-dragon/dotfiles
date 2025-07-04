---
description: Help debug issues with comprehensive analysis and language-specific strategies
---

Help debug issue: $ARGUMENTS

Steps:

1. Understand the problem:
   - Parse error messages and stack traces
   - **Typescript**: Analyze full stack trace, check caused-by chains
   - **Go**: Read panic output, trace goroutine dumps
   - Locate the exact file and line where error occurs
   - Check logs at INFO/DEBUG/TRACE levels
   - Review monitoring/APM data if available

2. Analyze the code path:
   - Trace execution flow leading to the error
   - Identify all variables and their states
   - Check function/method signatures and calls
   - Review recent changes that might have introduced the bug

3. Suggest debugging strategies:
   **Go:**
   - Delve debugger usage
   - pprof for runtime analysis
   - race detector: go run -race
   - Structured logging with context

   **TypeScript:**
   - Chrome DevTools debugging: node --inspect-brk <file>
   - Console debugging with
   - Stack traces with

   **React:**
   <!-- TODO -->

   **Nextjs:**
   <!-- TODO -->

   **General:**
   <!-- TODO -->

4. Identify common pitfalls:
   **Go:**
   - Nil pointer dereferences
   - Goroutine leaks
   - Channel deadlocks
   - Interface{} type assertions
   - Slice capacity vs length issues

   **Rust:**
   - Borrow checker violations
   - Lifetime issues
   - Move semantics confusion
   - Unsafe code problems
   - Panic in production code

   **TypeScript:**
   - Permission errors (file, network, env access)
   - Module resolution failures
   - Import map configuration issues
   - Top-level await deadlocks
   - Memory leaks in long-running processes

   **React:**
   <!-- TODO -->

   **Nextjs:**
   - Server/client code mixing
   - Middleware ordering issues
   - Static file serving problems

   **Common:**
   - Race conditions in concurrent code
   - Resource exhaustion
   - Network timeouts and retries
   - Database connection pool exhaustion

5. Create minimal reproduction:
   - Isolate the problem code
   - Remove unnecessary dependencies
   - Create simple test case that reproduces the issue
   - Document steps to reproduce

6. Propose solutions:
   - Provide specific code fixes with examples
   - Defensive programming techniques:
     - **Go**: Error wrapping, defer cleanup
     - **Typescript**: try/catch with proper error types, using Deno.errors
     - **Next.JS/React**: Error boundaries, proper async handling in routes

   - Add comprehensive error handling
   - Circuit breakers for external services
   - Implement proper timeout handling
   - Add observability (metrics, logs, traces)
   - Include unit tests to prevent regression
   - Consider integration tests for complex issues

Output format:

- Root cause analysis
- Step-by-step debugging plan
- Specific code changes needed
- Test cases to verify the fix
- Prevention strategies:
  - Code review checklist items
  - Static analysis rules to add
  - Monitoring alerts to implement
  - Documentation updates needed
