---
allowed-tools: Task, Read, Write, Edit, MultiEdit, Bash(fd:*), Bash(rg:*), Bash(jq:*), Bash(bat:*), Bash(eza:*), Bash(gdate:*), Bash(wc:*), Bash(head:*), Bash(mvn:*), Bash(gradle:*), Bash(cargo:*), Bash(go:*), Bash(deno:*), Bash(npm:*)
description: Intelligent test suite generator with framework detection, programmatic structure analysis, and comprehensive test creation
---

## Context

- Session ID: !`gdate +%s%N 2>/dev/null || date +%s%N 2>/dev/null || echo "$(date +%s)$(jot -r 1 100000 999999 2>/dev/null || shuf -i 100000-999999 -n 1 2>/dev/null || echo $RANDOM$RANDOM)"`
- Target: $ARGUMENTS
- Current directory: !`pwd`
- Project structure: !`eza -la --tree --level=2 2>/dev/null | head -10 || fd . -t d -d 2 | head -8`
- Existing tests: !`fd "(test|spec)\.(js|ts|jsx|tsx|go)$" . | wc -l | tr -d ' '` files
- Build files: !`fd "(package\.json|go\.mod)" . -d 3 | head -5 || echo "No build files detected"`
- Testing frameworks: !`fd "package.json" . | xargs jq -r '.devDependencies // {} | keys[]' 2>/dev/null | rg "(vitest|playwright)" | head -3 || echo "No JS test frameworks"`
- Modern tools status: !`echo "fd: $(which fd >/dev/null && echo ✓ || echo ✗) | rg: $(which rg >/dev/null && echo ✓ || echo ✗) | jq: $(which jq >/dev/null && echo ✓ || echo ✗)"`

## Your Task

STEP 1: Initialize intelligent test generation session with comprehensive project analysis

- CREATE session state file: `/tmp/test-gen-session-$SESSION_ID.json`
- ANALYZE project structure and technology stack from Context section
- DETECT primary programming language and testing frameworks
- IDENTIFY existing test patterns and coverage gaps

```bash
# Initialize test generation session state
echo '{
  "sessionId": "'$SESSION_ID'",
  "target": "'$ARGUMENTS'",
  "detectedLanguages": [],
  "testingFrameworks": [],
  "existingTestCount": 0,
  "generatedTests": []
}' > /tmp/test-gen-session-$SESSION_ID.json
```

STEP 2: Multi-language framework detection with intelligent routing

**JavaScript/TypeScript Projects:**

```bash
# Detect testing framework from package.json
fd "package.json" . | xargs jq -r '.devDependencies // {} | keys[]' 2>/dev/null | rg "(jest|vitest|mocha|ava)"

# Test file patterns
fd "(test|spec)\.(js|ts|jsx|tsx)$" . --max-depth 2
```

**Go Projects:**

```bash
# Test file detection
fd "_test\.go$" . 2>/dev/null || echo "No Go test files found"
go list ./... 2>/dev/null | rg "test" || echo "Go modules not available"
```

STEP 3: Parallel test analysis and generation with sub-agent coordination

TRY:

IF project_complexity == "multi-language" OR codebase_size > 50_files:

LAUNCH parallel sub-agents for comprehensive test generation:

- **Agent 1: Unit Test Analysis**: Analyze existing unit tests and identify gaps
  - Focus: Function coverage, edge cases, error handling patterns
  - Tools: rg for test pattern analysis, code complexity assessment
  - Output: Unit test coverage report and generation targets

- **Agent 2: Integration Test Strategy**: Design integration test architecture
  - Focus: API endpoints, database interactions, service boundaries
  - Tools: fd for endpoint discovery, dependency mapping
  - Output: Integration test plan and mock requirements

- **Agent 3: E2E Test Planning**: Analyze user flows and critical paths
  - Focus: Frontend interactions, user journeys, business workflows
  - Tools: Component analysis, routing discovery
  - Output: E2E test scenarios and automation strategy

- **Agent 4: Test Data Management**: Design test data generation and management
  - Focus: Realistic test data, factories, fixtures, mocks
  - Tools: Schema analysis, data model discovery
  - Output: Test data strategy and generation utilities

ELSE:

EXECUTE streamlined single-agent test generation:

## Test Generation Strategies

STEP 4: Language-specific test generation with programmatic structure analysis

**Analysis Phase with Dynamic Language Detection:**

```bash
# Extract function signatures and interfaces based on detected project type
PROJECT_LANG=$(fd "(package\.json|go\.mod)" . | head -1 | sed 's/.*\.//' || echo "unknown")

case $PROJECT_LANG in
  "json")
    echo "📦 JavaScript/TypeScript project detected"
    # Parse TypeScript/JavaScript for functions and classes
    rg "^(export\s+)?(function|class|const|let)\s+\w+" --type-add 'web:*.{js,ts,jsx,tsx}' --type web -A 3 2>/dev/null || echo "No JS/TS functions found"
    ;;
  "mod")
    echo "🐹 Go project detected"
    # Extract public functions and types
    rg "^func\s+[A-Z]\w*|^type\s+[A-Z]\w*" --type go -A 2 2>/dev/null || echo "No public Go items found"
    ;;
  *)
    echo "🔍 Multi-language or unknown project - analyzing all supported types"
    ;;
esac
```

### Unit/Component Test Generation Framework

STEP 5: Test template generation with framework-specific patterns

**Session State Management:**

```bash
# Update session state with generation progress
jq --arg lang "$PROJECT_LANG" --arg timestamp "$(gdate -Iseconds 2>/dev/null || date -Iseconds)" '
  .detectedLanguages += [$lang] |
  .lastAnalysis = $timestamp
' /tmp/test-gen-session-$SESSION_ID.json > /tmp/test-gen-session-$SESSION_ID.tmp && \
mv /tmp/test-gen-session-$SESSION_ID.tmp /tmp/test-gen-session-$SESSION_ID.json
```

**TypeScript/Deno Test Generation:**

```typescript
// Generated comprehensive tests for $ARGUMENTS
import { assertEquals, assertExists, assertRejects } from "@std/assert";
import { $ARGUMENTS } from "../src/$ARGUMENTS.ts";

// Test data generation utilities
const generateTestData = () => ({
  valid: {
    email: "test@example.com",
    name: "Test User",
    id: crypto.randomUUID(),
  },
  invalid: {
    email: "invalid-email",
    name: "",
    id: null,
  },
});

// Happy path tests
Deno.test("$ARGUMENTS - successful operations with valid data", async () => {
  const service = new $ARGUMENTS();
  const testData = generateTestData().valid;

  const result = await service.create(testData);

  assertEquals(result.email, testData.email);
  assertEquals(result.name, testData.name);
  assertExists(result.id);
});

// Error handling tests
Deno.test("$ARGUMENTS - validation errors with invalid data", async () => {
  const service = new $ARGUMENTS();
  const testData = generateTestData().invalid;

  await assertRejects(
    () => service.create(testData),
    Error,
    "Validation failed",
  );
});

// Edge case tests
Deno.test("$ARGUMENTS - edge cases and boundary conditions", async () => {
  const service = new $ARGUMENTS();

  // Test with null/undefined inputs
  await assertRejects(() => service.create(null));
  await assertRejects(() => service.create(undefined));

  // Test with empty objects
  await assertRejects(() => service.create({}));
});

// Performance and load tests
Deno.test("$ARGUMENTS - performance with multiple operations", async () => {
  const service = new $ARGUMENTS();
  const operations = [];

  for (let i = 0; i < 100; i++) {
    operations.push(service.create(generateTestData().valid));
  }

  const results = await Promise.allSettled(operations);
  const successful = results.filter((r) => r.status === "fulfilled").length;

  assertEquals(successful, 100);
});
```

STEP 6: API and integration test generation with comprehensive coverage

TRY:

**State Management for API Discovery:**

```bash
# Discover and catalog API endpoints
echo "🔍 Discovering API endpoints for $ARGUMENTS..."
API_ENDPOINTS=$(rg "(GET|POST|PUT|DELETE|PATCH).*$ARGUMENTS" --type-add 'web:*.{js,ts,go}' --type web 2>/dev/null | head -10 || echo "No API endpoints found")
echo "$API_ENDPOINTS" > /tmp/api-endpoints-$SESSION_ID.txt
```

### API Test Generation Framework

**Dynamic API Endpoint Discovery:**

```bash
# Intelligent framework detection and endpoint analysis
DETECTED_FRAMEWORK="unknown"



# Check for Node.js frameworks
if fd "package.json" . | xargs rg "(express|fastify|koa)" >/dev/null 2>&1; then
  DETECTED_FRAMEWORK="nodejs-web"
  echo "🟢 Node.js web framework detected"
  rg "(app|router|server)\.(get|post|put|delete|patch)" --type-add 'web:*.{js,ts}' --type web -A 2 2>/dev/null || echo "No Node.js routes found"
fi

# Check for Go frameworks
if fd "go.mod" . | xargs rg "(gin|echo|fiber|mux)" >/dev/null 2>&1; then
  DETECTED_FRAMEWORK="go-web"
  echo "🐹 Go web framework detected"
  rg "func.*Handler|router\.(GET|POST|PUT|DELETE)" --type go -A 2 2>/dev/null || echo "No Go routes found"
fi

# Update session state with framework detection
jq --arg framework "$DETECTED_FRAMEWORK" '.detectedFramework = $framework' /tmp/test-gen-session-$SESSION_ID.json > /tmp/test-gen-session-$SESSION_ID.tmp && mv /tmp/test-gen-session-$SESSION_ID.tmp /tmp/test-gen-session-$SESSION_ID.json
```

STEP 7: Framework-specific API test generation with comprehensive scenarios

**Deno/Fresh API Test Generation:**

```typescript
// Generated API tests for user endpoints
import { assertEquals } from "@std/assert";
import { createHandler } from "../routes/api/users/index.ts";

Deno.test("POST /api/users - create user successfully", async () => {
  const request = new Request("http://localhost:8000/api/users", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      email: "test@example.com",
      name: "Test User",
    }),
  });

  const response = await createHandler(request);

  assertEquals(response.status, 201);
  const body = await response.json();
  assertEquals(body.email, "test@example.com");
  assertEquals(body.name, "Test User");
});

Deno.test("POST /api/users - validation error", async () => {
  const request = new Request("http://localhost:8000/api/users", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      email: "invalid-email",
      name: "",
    }),
  });

  const response = await createHandler(request);

  assertEquals(response.status, 400);
  const body = await response.json();
  assertEquals(body.error, "Validation failed");
});
```

STEP 8: End-to-end test generation with modern testing frameworks

CATCH (test_generation_failed):

- LOG error details to session state
- PROVIDE fallback test generation strategies
- SUGGEST manual test creation guidelines

```bash
echo "⚠️ Test generation encountered errors. Providing fallback strategies..."
echo "Available testing tools:"
echo "  Node.js: $(which node >/dev/null && echo '✓ available' || echo '❌ install with: brew install node')"
```

### End-to-End Test Generation Framework

**E2E Test Setup:**

**Playwright/Deno Example:**

```typescript
// Generated E2E tests with Playwright
import { expect, test } from "@playwright/test";

test.describe("User Management Flow", () => {
  test.beforeEach(async ({ page }) => {
    await page.goto("http://localhost:8000");
  });

  test("complete user registration flow", async ({ page }) => {
    // Navigate to registration
    await page.click('[data-testid="register-link"]');
    await expect(page).toHaveURL(/.*\/register/);

    // Fill registration form
    await page.fill('[data-testid="email-input"]', "test@example.com");
    await page.fill('[data-testid="name-input"]', "Test User");
    await page.fill('[data-testid="password-input"]', "SecurePass123!");

    // Submit form
    await page.click('[data-testid="register-button"]');

    // Verify success
    await expect(page.locator('[data-testid="success-message"]')).toBeVisible();
    await expect(page).toHaveURL(/.*\/dashboard/);
  });

  test("user login and logout flow", async ({ page }) => {
    // Login
    await page.click('[data-testid="login-link"]');
    await page.fill('[data-testid="email-input"]', "test@example.com");
    await page.fill('[data-testid="password-input"]', "SecurePass123!");
    await page.click('[data-testid="login-button"]');

    // Verify dashboard access
    await expect(page).toHaveURL(/.*\/dashboard/);
    await expect(page.locator('[data-testid="user-name"]')).toContainText(
      "Test User",
    );

    // Logout
    await page.click('[data-testid="logout-button"]');
    await expect(page).toHaveURL(/.*\/login/);
  });
});
```

STEP 10: Test data generation and management with realistic patterns

**Session State Finalization:**

```bash
# Finalize session state with generation summary
jq --arg timestamp "$(gdate -Iseconds 2>/dev/null || date -Iseconds)" --arg target "$ARGUMENTS" '
  .completedAt = $timestamp |
  .generationSummary = {
    "target": $target,
    "testFilesGenerated": (.generatedTests | length),
    "frameworksSupported": [.detectedFramework],
    "testTypes": ["unit", "integration", "e2e", "api"]
  }
' /tmp/test-gen-session-$SESSION_ID.json > /tmp/test-gen-session-$SESSION_ID.tmp && mv /tmp/test-gen-session-$SESSION_ID.tmp /tmp/test-gen-session-$SESSION_ID.json
```

FINALLY:

- SAVE session state for test execution and maintenance
- PROVIDE comprehensive test running instructions
- SUGGEST CI/CD integration patterns
- CLEAN UP temporary analysis files

```bash
echo "✅ Test generation completed for $ARGUMENTS"
echo "📊 Session: $SESSION_ID"
echo "📁 Session state: /tmp/test-gen-session-$SESSION_ID.json"
echo "🧪 Generated comprehensive test suite with:"
echo "  - Unit tests with edge cases and error handling"
echo "  - Integration tests for API endpoints"
echo "  - E2E tests for user workflows"
echo "  - Performance and load tests"
echo "  - Test data generation utilities"
echo "  - Mock and stub implementations"
```

## Test Data Generation Strategies

### Realistic Test Data Creation Framework

**Faker Integration:**

```typescript
// Generated test data utilities
import { faker } from "@faker-js/faker";

export class TestDataGenerator {
  static generateUser() {
    return {
      id: faker.string.uuid(),
      email: faker.internet.email(),
      name: faker.person.fullName(),
      createdAt: faker.date.recent().toISOString(),
      isActive: faker.datatype.boolean(),
    };
  }

  static generateProduct() {
    return {
      id: faker.string.uuid(),
      name: faker.commerce.productName(),
      price: parseFloat(faker.commerce.price()),
      category: faker.commerce.department(),
      inStock: faker.number.int({ min: 0, max: 100 }),
    };
  }

  static generateBulkUsers(count: number) {
    return Array.from({ length: count }, () => this.generateUser());
  }
}
```

## Mock and Stub Generation

### Database Mocks

**TypeScript/Deno Example:**

```typescript
// Generated database mocks
export class MockUserRepository implements UserRepository {
  private users: Map<string, User> = new Map();

  async create(user: CreateUserRequest): Promise<User> {
    const newUser: User = {
      id: crypto.randomUUID(),
      ...user,
      createdAt: new Date().toISOString(),
    };
    this.users.set(newUser.id, newUser);
    return newUser;
  }

  async findById(id: string): Promise<User | null> {
    return this.users.get(id) || null;
  }

  async findByEmail(email: string): Promise<User | null> {
    for (const user of this.users.values()) {
      if (user.email === email) return user;
    }
    return null;
  }

  clear() {
    this.users.clear();
  }
}
```

### External Service Mocks

**HTTP Mocks with MSW:**

```typescript
// Generated API mocks
import { http, HttpResponse } from "msw";
import { setupServer } from "msw/node";

export const handlers = [
  http.get("https://api.external-service.com/users/:id", ({ params }) => {
    const { id } = params;
    return HttpResponse.json({
      id,
      name: "Mock User",
      email: "mock@example.com",
    });
  }),

  http.post("https://api.payment-service.com/charge", async ({ request }) => {
    const body = await request.json();
    return HttpResponse.json({
      id: "charge_123",
      amount: body.amount,
      status: "succeeded",
    });
  }),
];

export const server = setupServer(...handlers);
```

## Test Configuration Generation

### Framework-Specific Configuration

**Deno Test Configuration:**

```json
{
  "tasks": {
    "test": "deno test --allow-all --coverage=coverage",
    "test:watch": "deno test --allow-all --watch",
    "test:unit": "deno test --allow-all tests/unit/",
    "test:integration": "deno test --allow-all tests/integration/",
    "test:e2e": "deno test --allow-all tests/e2e/",
    "coverage": "deno coverage coverage --html"
  },
  "exclude": ["coverage/"]
}
```

## Output

The command generates:

1. **Test Files**: Comprehensive test suites with realistic scenarios
2. **Test Data Utilities**: Faker integration and mock data generators
3. **Mock Services**: Database and external service mocks
4. **Configuration**: Framework-specific test configuration
5. **CI Integration**: Automated testing workflows
6. **Coverage Reports**: HTML and XML coverage reporting setup

## Integration with Other Commands

- Use with `/coverage` for detailed coverage analysis
- Combine with `/flaky-fix` for test reliability improvements
- Integrate with `/ci-gen` for automated test execution
- Use with `/debug` for test troubleshooting
