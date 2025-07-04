---
description: Generate comprehensive test suites with intelligent test case creation based on code analysis and testing best practices
---

Generate comprehensive test suites for $ARGUMENT with intelligent test case creation based on code analysis and testing best practices.

## Context Intelligence

### Framework Detection

**JavaScript/TypeScript Projects:**

```bash
# Detect testing framework from package.json
fd "package.json" | xargs jq -r '.devDependencies | keys[]' | rg "(jest|vitest|playwright)"

# Test file patterns
fd "(test|spec)\.(js|ts|jsx|tsx)$" --max-depth 2
```

**Go Projects:**

```bash
# Test file detection
fd "_test\.go$"
go list ./... | rg "test"
```

## Test Generation Strategies

### 1. Unit/Component Test Generation

**Analysis Phase:**

```bash
# Extract function signatures and interfaces
case $DETECTED_LANGUAGE in
  "typescript"|"javascript")
    # Parse TypeScript/JavaScript for functions and classes
    rg "^(export\s+)?(function|class|const|let)\s+\w+" --type ts --type js -A 3
    ;;
  "go")
    # Extract public functions and types
    rg "^func\s+[A-Z]\w*|^type\s+[A-Z]\w*" --type go -A 2
    ;;
esac
```

**Test Template Generation:**

**TypeScript/Vitest Example:**

```typescript
// Generated tests for UserService
import { describe, it, expect } from "vitest";
import { UserService } from "../src/user-service.ts";

describe("UserService", () => {
  it("should create user with valid data", async () => {
    const userService = new UserService();
    const userData = {
      email: "test@example.com",
      name: "Test User",
    };

    const result = await userService.createUser(userData);

    expect(result.email).toBe(userData.email);
    expect(result.name).toBe(userData.name);
    expect(typeof result.id).toBe("string");
  });

  it("should reject user creation with invalid email", async () => {
    const userService = new UserService();
    const userData = {
      email: "invalid-email",
      name: "Test User",
    };

    await expect(() => userService.createUser(userData)).rejects.toThrow(
      "Invalid email format",
    );
  });

  it("should find user by ID", async () => {
    const userService = new UserService();

    // Test existing user
    const existingUser = await userService.findUser("user123");
    expect(existingUser.id).toBe("user123");

    // Test non-existing user
    const nonExistingUser = await userService.findUser("nonexistent");
    expect(nonExistingUser).toBeNull();
  });
});
```

### 2. API Test Generation

**API Endpoint Discovery:**

```bash
# Analyze API routes and endpoints
case $FRAMEWORK in
  "express"|"hono")
    rg "(app|router)\.(get|post|put|delete|patch)" --type js --type ts -A 2
    ;;
  "connectrpc"|"gin")
    rg "func.*Handler|router\.(GET|POST|PUT|DELETE)" --type go -A 2
    ;;
esac
```

**Generated API Tests:**

**Vitest/Node.js Example:**

```typescript
// Generated API tests for user endpoints
import { describe, it, expect } from "vitest";
import { createHandler } from "../routes/api/users/index.ts";

describe("User API endpoints", () => {
  it("should create user successfully", async () => {
    const request = new Request("http://localhost:8000/api/users", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        email: "test@example.com",
        name: "Test User",
      }),
    });

    const response = await createHandler(request);

    expect(response.status).toBe(201);
    const body = await response.json();
    expect(body.email).toBe("test@example.com");
    expect(body.name).toBe("Test User");
  });

  it("should return validation error for invalid data", async () => {
    const request = new Request("http://localhost:8000/api/users", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        email: "invalid-email",
        name: "",
      }),
    });

    const response = await createHandler(request);

    expect(response.status).toBe(400);
    const body = await response.json();
    expect(body.error).toBe("Validation failed");
  });
});
```

### 3. End-to-End Test Generation

**E2E Test Setup:**

**Playwright/Vitest Example:**

```typescript
// Generated E2E tests with Playwright
import { expect, test } from "@playwright/test";

test.describe("User Management Flow", () => {
  test.beforeEach(async ({ page }) => {
    await page.goto("http://localhost:3000");
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

## Test Data Generation

### Realistic Test Data Creation

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

**TypeScript/Vitest Example:**

```typescript
// Generated database mocks
import { vi } from "vitest";

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

  // Vitest spy methods
  static createSpy() {
    return vi.fn().mockImplementation(() => new MockUserRepository());
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

**Vitest Test Configuration:**

```typescript
// vitest.config.ts
import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    globals: true,
    environment: "node",
    coverage: {
      reporter: ["text", "json", "html"],
      exclude: ["node_modules/", "dist/", "coverage/"],
    },
  },
});
```

**Package.json Scripts:**

```json
{
  "scripts": {
    "test": "vitest run --coverage",
    "test:watch": "vitest",
    "test:unit": "vitest run tests/unit/",
    "test:integration": "vitest run tests/integration/",
    "test:e2e": "vitest run tests/e2e/",
    "test:ui": "vitest --ui"
  }
}
```

## CI/CD Integration

### Test Automation in CI

**GitHub Actions Integration:**

```yaml
# Generated test workflow
- name: Run tests with coverage
  run: |
    case ${{ matrix.language }} in
      "javascript"|"typescript")
        npm run test
        ;;
      "go")
        go test -v -race -coverprofile=coverage.out ./...
        go tool cover -html=coverage.out -o coverage.html
        ;;
    esac

- name: Upload coverage reports
  uses: codecov/codecov-action@v3
  with:
    file: coverage.xml
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
