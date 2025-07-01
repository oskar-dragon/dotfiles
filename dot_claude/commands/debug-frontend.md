---
description: Debug frontend issues in Next.js, React, TypeScript, JavaScript, and Turborepo
---

Help debug frontend issue: $ARGUMENTS

Steps:

1. Understand the problem:
   - Parse error messages and stack traces
   - **React**: Analyze component error boundaries and dev tools warnings
   - **Next.js**: Check both client and server-side errors
   - **TypeScript**: Read type errors and compiler diagnostics
   - **Turborepo**: Review build pipeline and task dependencies
   - Check browser console, network tab, and React DevTools
   - Review build logs and development server output

2. Analyze the code path:
   - Trace component rendering lifecycle
   - Identify props flow and state changes
   - Check hooks dependencies and effects
   - Review routing and data fetching patterns
   - Examine recent changes in affected components

3. Suggest debugging strategies:
   **React:**
   - React DevTools Profiler for performance issues
   - Component state inspection
   - Props drilling analysis
   - useEffect dependency debugging
   - Error boundary implementation

   **Next.js:**
   - Bundle analyzer: @next/bundle-analyzer
   - API routes debugging with console.log or debugger statements

   **TypeScript:**
   - Type checking: npx tsc --noEmit
   - Strict mode analysis
   - Generic constraints debugging
   - Module resolution tracing: tsc --traceResolution

   **Turborepo:**
   - Task graph debugging: turbo run build --graph
   - Cache debugging: turbo run build --force
   - Dependency analysis: turbo run build --dry-run
   - Pipeline debugging with --verbose flag

   **Browser:**
   - Chrome DevTools debugging with source maps
   - Network tab for API and asset loading issues
   - Performance tab for rendering bottlenecks
   - Lighthouse audits for optimization opportunities

4. Identify common pitfalls:
   **React:**
   - Infinite re-renders from useEffect dependencies
   - State mutations causing stale closures
   - Key prop issues in lists
   - Conditional rendering bugs
   - Context provider placement issues

   **Next.js:**
   - Hydration mismatches between server and client
   - Static vs dynamic rendering confusion
   - API route CORS issues
   - Image optimization problems
   - Environment variable scope (client vs server)

   **TypeScript:**
   - Type assertion overuse (as keyword)
   - any type escape hatches
   - Generic constraint violations
   - Module augmentation issues
   - Path mapping resolution problems

   **Turborepo:**
   - Circular dependencies between packages
   - Incorrect task pipeline configuration
   - Cache invalidation issues
   - Build output path conflicts
   - Environment variable inheritance problems

   **Common:**
   - Async/await error handling
   - Memory leaks from event listeners
   - Bundle size and code splitting issues
   - Third-party library compatibility

5. Create minimal reproduction:
   - Isolate the problematic component
   - Create CodeSandbox or minimal Next.js app
   - Remove unnecessary dependencies and features
   - Document exact steps to reproduce
   - Include relevant package versions

6. Propose solutions:
   - Provide specific code fixes with examples
   - Defensive programming techniques:
     - **React**: PropTypes or TypeScript for runtime/compile-time validation
     - **Next.js**: Error pages (\_error.tsx, \_500.tsx) and proper error handling
     - **TypeScript**: Strict null checks and proper type guards
     - **Turborepo**: Pipeline dependency management and proper caching
   - Add comprehensive error boundaries
   - Implement proper loading and error states
   - Add client-side monitoring (Sentry, LogRocket)
   - Include unit tests with Jest/Testing Library
   - Add end-to-end tests with Playwright/Cypress

Output format:

- Root cause analysis
- Step-by-step debugging plan
- Specific code changes needed
- Test cases to verify the fix
- Prevention strategies:
  - ESLint rules to add
  - TypeScript strict mode settings
  - Code review checklist items
  - Monitoring and error tracking setup
  - Documentation updates needed
