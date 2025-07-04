---
description: Analyse code for refactoring opportunities with language-specific patterns and best practices
---

Analyse code in $ARGUMENTS for refactoring opportunities.

Steps:

1. Read and understand the code structure in the specified file/directory
2. Identify code smells and anti-patterns:

   **Common smells:**
   - Convoluted logic
   - Duplicate code blocks
   - Complex conditionals
   - Large classes/modules
   - Feature envy
   - Data clumps

   **TypeScript-specific:**
   - Overuse of `any` type
   - Missing type definitions
   - Excessive type assertions
   - Complex union types that should be discriminated
   - Props drilling in React components
   - Missing generics for reusable functions

   **React-specific:**
   - Components with too many responsibilities
   - Missing key props in lists
   - Direct DOM manipulation instead of React patterns
   - Unnecessary re-renders
   - Missing error boundaries

3. Suggest specific refactoring techniques:

   **Universal patterns:**
   - Extract Method/Function
   - Rename for clarity
   - Replace Magic Numbers with Constants when it makes sense

   **TypeScript patterns:**
   - Replace `any` with proper types
   - Extract type definitions to separate files
   - Use discriminated unions for complex state
   - Implement proper generic constraints
   - Replace type assertions with type guards
   - Use `const` assertions for immutable data

   **React patterns:**
   - Extract custom hooks for logic reuse
   - Split large components into smaller ones but in the same file
   - Use composition over inheritance
   - Implement proper error boundaries

   **React Server Components patterns:**
   - Separate server and client components properly
   - Use async/await in server components
   - Optimise data fetching patterns
   - Implement proper streaming patterns
   - Use suspense boundaries effectively

4. Verify existing test coverage before refactoring:
   - **TypeScript**: Use `nyc` or `c8` for coverage
   - **React**: Use Vitest with React Testing Library
   - **E2E**: Use Playwright
   - Ensure critical paths have tests
   - Add tests if coverage is insufficient

5. Apply refactoring incrementally:
   - Make one change at a time
   - Run tests after each change:
     - **TypeScript**: `[npm|pnpm|bun] run test`
     - **Type checking**: `tsc --noEmit`
     - **Linting**: `eslint` and `prettier`
   - Commit working states with clear messages

6. Document the refactoring rationale in commit messages

Prioritise refactorings by:

- Impact on readability and maintainability
- Risk assessment (use static analysis tools):
  - **TypeScript**: ESLint
  - **React**: React DevTools Profiler
  - **Bundle analysis**
- Performance improvements (measure with React Profiler)
- Business value and technical debt reduction
- Team expertise and codebase conventions

Deliverables:

- Refactored code with improved structure
- Updated tests maintaining coverage
- Performance benchmarks (if applicable)
- Documentation of changes and rationale
