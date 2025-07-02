---
description: Refactors complex code for better readability
---

# /simplify

Refactor complex TypeScript/JavaScript code to be more readable, maintainable, and easier to understand whilst preserving functionality.

## Usage

```
/simplify [file path or code block]
```

## Simplification Process

### 1. Complexity Analysis

```bash
# Identify TypeScript/JavaScript complexity hotspots
rg "if.*if.*if|for.*for|while.*while" --type ts --type js -A 10  # Nested structures
rg "&&.*&&|\\|\\|.*\\|\\|" --type ts --type js -A 5              # Complex conditionals
rg "function.*{.*function|=>.*=>" --type ts --type js -A 10       # Nested functions
fd "\.(test|spec)\.(ts|js)$" | xargs rg -l "skip|todo"           # Untested code
rg "any\s|unknown\s" --type ts -A 3                             # Poor TypeScript typing
```

### 2. TypeScript/JavaScript Simplification Strategies

#### Extract Methods

**Before:**

```typescript
function processOrder(order: Order): ProcessedOrder {
  // Validation (20 lines)
  if (!order.customerId) throw new Error("Missing customer ID");
  if (!order.items?.length) throw new Error("No items");
  // ... more validation

  // Calculation (30 lines)
  let subtotal = 0;
  for (const item of order.items) {
    subtotal += item.price * item.quantity;
  }
  // ... more calculations

  // Formatting (15 lines)
  return {
    id: order.id,
    total: subtotal,
    // ... more formatting
  };
}
```

**After:**

```typescript
function processOrder(order: Order): ProcessedOrder {
  const validatedOrder = validateOrder(order);
  const calculations = calculateOrderTotals(validatedOrder);
  return formatOrderResponse(validatedOrder, calculations);
}

function validateOrder(order: Order): Order {
  if (!order.customerId) throw new Error("Missing customer ID");
  if (!order.items?.length) throw new Error("No items");
  return order;
}

function calculateOrderTotals(order: Order): OrderTotals {
  const subtotal = order.items.reduce(
    (sum, item) => sum + item.price * item.quantity,
    0,
  );
  return { subtotal, tax: subtotal * 0.1, total: subtotal * 1.1 };
}
```

#### Simplify Conditionals with Guard Clauses

**Before:**

```typescript
function isEligibleUser(user: User): boolean {
  if (
    user.age >= 18 &&
    user.age <= 65 &&
    user.status === "active" &&
    !user.suspended
  ) {
    if (user.balance > 0 || user.creditLimit > 0) {
      return true;
    }
  }
  return false;
}
```

**After:**

```typescript
function isEligibleUser(user: User): boolean {
  const isValidAge = user.age >= 18 && user.age <= 65;
  const isActiveUser = user.status === "active" && !user.suspended;
  const hasFunds = user.balance > 0 || user.creditLimit > 0;

  return isValidAge && isActiveUser && hasFunds;
}
```

#### Replace Loops with Array Methods

**Before:**

```javascript
function processItems(items) {
  const results = [];
  for (let i = 0; i < items.length; i++) {
    if (items[i].isValid) {
      const transformed = {
        id: items[i].id,
        name: items[i].name.toUpperCase(),
        price: items[i].price * 1.2,
      };
      results.push(transformed);
    }
  }
  return results;
}
```

**After:**

```typescript
function processItems(items: Item[]): ProcessedItem[] {
  return items
    .filter((item) => item.isValid)
    .map((item) => ({
      id: item.id,
      name: item.name.toUpperCase(),
      price: item.price * MARKUP_MULTIPLIER,
    }));
}
```

#### Use Early Returns and Optional Chaining

**Before:**

```typescript
function getUserDisplayName(user: User | null): string {
  if (user !== null) {
    if (user.profile !== null) {
      if (
        user.profile.displayName !== null &&
        user.profile.displayName !== ""
      ) {
        return user.profile.displayName;
      } else {
        if (user.firstName !== null && user.lastName !== null) {
          return user.firstName + " " + user.lastName;
        } else {
          return user.email;
        }
      }
    } else {
      return user.email;
    }
  } else {
    return "Guest";
  }
}
```

**After:**

```typescript
function getUserDisplayName(user: User | null): string {
  if (!user) return "Guest";

  if (user.profile?.displayName?.trim()) {
    return user.profile.displayName;
  }

  if (user.firstName && user.lastName) {
    return `${user.firstName} ${user.lastName}`;
  }

  return user.email;
}
```

#### Extract Constants and Use Enums

**Before:**

```javascript
function processPayment(payment) {
  if (payment.method === "credit_card" && payment.amount > 1000) {
    return processLargePayment(payment);
  } else if (payment.method === "paypal" && payment.amount > 500) {
    return processPayPalPayment(payment);
  }
  return processStandardPayment(payment);
}
```

**After:**

```typescript
const PAYMENT_THRESHOLDS = {
  CREDIT_CARD_LARGE: 1000,
  PAYPAL_LARGE: 500,
} as const;

function processPayment(payment: Payment): PaymentResult {
  const { method, amount } = payment;

  if (
    method === "credit-card" &&
    amount > PAYMENT_THRESHOLDS.CREDIT_CARD_LARGE
  ) {
    return processLargePayment(payment);
  }

  if (method === "pay-pal" && amount > PAYMENT_THRESHOLDS.PAYPAL_LARGE) {
    return processPayPalPayment(payment);
  }

  return processStandardPayment(payment);
}
```

### 3. TypeScript/JavaScript Naming Improvements

#### Use Descriptive Names

**Before:**

```typescript
function calc(u: User, o: Order): number {
  const d = getDiscount(u);
  const t = o.items.reduce((acc, i) => acc + i.p * i.q, 0);
  return t - t * d;
}
```

**After:**

```typescript
function calculateDiscountedTotal(user: User, order: Order): number {
  const userDiscount = getUserDiscount(user);
  const orderSubtotal = order.items.reduce(
    (total, item) => total + item.price * item.quantity,
    0,
  );
  return orderSubtotal - orderSubtotal * userDiscount;
}
```

#### Boolean Function Names

**Before:**

```typescript
function active(user: User): boolean {
  return user.status === "active";
}
function permission(user: User, action: string): boolean {
  return user.permissions.includes(action);
}
```

**After:**

```typescript
function isUserActive(user: User): boolean {
  return user.status === "active";
}
function canUserPerformAction(user: User, action: string): boolean {
  return user.permissions.includes(action);
}
```

### 4. Modern JavaScript/TypeScript Patterns

#### Use Destructuring and Template Literals

**Before:**

```javascript
function createUserMessage(user) {
  return (
    "Hello " +
    user.firstName +
    " " +
    user.lastName +
    "! You have " +
    user.unreadCount +
    " unread messages."
  );
}
```

**After:**

```typescript
function createUserMessage(user: User): string {
  const { firstName, lastName, unreadCount } = user;
  return `Hello ${firstName} ${lastName}! You have ${unreadCount} unread messages.`;
}
```

#### Use Async/Await over Promises

**Before:**

```javascript
function fetchUserData(userId) {
  return fetchUser(userId)
    .then((user) => {
      return fetchUserPreferences(user.id).then((preferences) => {
        return { ...user, preferences };
      });
    })
    .catch((error) => {
      console.error("Error fetching user:", error);
      throw error;
    });
}
```

**After:**

```typescript
async function fetchUserData(userId: string): Promise<UserWithPreferences> {
  try {
    const user = await fetchUser(userId);
    const preferences = await fetchUserPreferences(user.id);
    return { ...user, preferences };
  } catch (error) {
    console.error("Error fetching user:", error);
    throw error;
  }
}
```

### 5. Class Structure Improvements

#### Before

```typescript
class OrderProcessor {
  // 300 lines of mixed validation, calculation, and notification logic
  processOrder(order: Order) {
    // validation logic
    // calculation logic
    // notification logic
    // formatting logic
  }
}
```

#### After

```typescript
class OrderProcessor {
  constructor(
    private readonly validator: OrderValidator,
    private readonly calculator: PriceCalculator,
    private readonly notifier: CustomerNotifier,
    private readonly formatter: OrderFormatter,
  ) {}

  async processOrder(order: Order): Promise<ProcessedOrder> {
    const validatedOrder = await this.validator.validate(order);
    const calculatedOrder = await this.calculator.calculate(validatedOrder);
    const formattedOrder = this.formatter.format(calculatedOrder);

    await this.notifier.notify(formattedOrder);
    return formattedOrder;
  }
}
```

### 6. Testing Simplification

#### Use Descriptive Test Names and Setup

**Before:**

```javascript
describe("UserService", () => {
  it("should work", () => {
    const user = { id: 1, name: "John", active: true };
    const result = userService.process(user);
    expect(result).toBeTruthy();
  });
});
```

**After:**

```typescript
describe("UserService", () => {
  describe("processActiveUser", () => {
    it("should return processed user data when user is active", () => {
      // Arrange
      const activeUser: User = createMockUser({ status: "active" });

      // Act
      const result = userService.processActiveUser(activeUser);

      // Assert
      expect(result).toEqual(
        expect.objectContaining({
          id: activeUser.id,
          processedAt: expect.any(Date),
          status: "processed",
        }),
      );
    });
  });
});
```

### 7. Documentation

Add JSDoc comments for complex functions:

```typescript
/**
 * Calculates compound interest using the standard formula
 * @param principal - Initial investment amount
 * @param annualRate - Annual interest rate (as decimal, e.g., 0.05 for 5%)
 * @param years - Investment period in years
 * @param compoundingFrequency - Number of times interest compounds per year
 * @returns The final amount after compound interest
 */
function calculateCompoundInterest(
  principal: number,
  annualRate: number,
  years: number,
  compoundingFrequency: number = 12,
): number {
  return (
    principal *
    Math.pow(
      1 + annualRate / compoundingFrequency,
      compoundingFrequency * years,
    )
  );
}
```

## Validation

After TypeScript/JavaScript simplification, ensure:

- All tests still pass
- TypeScript compilation succeeds
- Linting passes (`eslint` or equivalent)
- No functionality is lost
- Performance hasn't degraded
- Code coverage is maintained

## Output Format

```markdown
## TypeScript/JavaScript Simplification Summary

**Files Modified:** [list of files]
**Complexity Metrics:**

- Cyclomatic complexity: [before] → [after]
- Lines of code: [before] → [after]
- Function count: [before] → [after]

### Changes Made:

1. ✅ Extracted [X] methods for better separation of concerns
2. ✅ Simplified [Y] conditional expressions using guard clauses
3. ✅ Replaced [Z] imperative loops with functional array methods
4. ✅ Improved naming for [N] variables/functions
5. ✅ Added proper TypeScript types where missing
6. ✅ Modernised syntax (async/await, destructuring, template literals)

### Key Improvements:

- **Readability**: Reduced nested conditionals and improved variable names
- **Maintainability**: Better separation of concerns and single responsibility
- **Type Safety**: Added proper TypeScript types and removed `any` usage
- **Modern Patterns**: Used contemporary JavaScript/TypeScript features

### Code Diff:

[Show key before/after examples with file paths]
```

## Guidelines

- Preserve all functionality exactly
- Maintain or improve performance
- Keep domain logic intact
- Follow TypeScript/JavaScript idioms
- Use modern ES2020+ features appropriately
- Maintain existing team conventions
- Add tests for refactored code
- Ensure proper error handling
- Use appropriate TypeScript strict mode settings
