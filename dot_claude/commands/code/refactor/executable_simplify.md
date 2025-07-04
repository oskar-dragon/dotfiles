---
description: Refactor complex code to be more readable, maintainable, and easier to understand while preserving functionality
---

Refactor complex code to be more readable, maintainable, and easier to understand while preserving functionality.

## Usage

```
/simplify [file path or code block]
```

## Simplification Process

### 1. Complexity Analysis

```bash
# Identify complexity hotspots
rg "if.*if.*if|for.*for|while.*while" -A 10  # Nested structures
rg "&&.*&&|\\|\\|.*\\|\\|" -A 5              # Complex conditionals
rg "function.*{.*function|=>.*=>" -A 10       # Nested functions
fd "test" --type f | xargs rg -l "skip|todo"  # Untested code
```

### 2. Simplification Strategies

#### Extract Methods

**Before:**

```javascript
function processOrder(order) {
  // 50 lines of validation logic
  // 30 lines of calculation
  // 40 lines of formatting
}
```

**After:**

```javascript
function processOrder(order) {
  const validatedOrder = validateOrder(order);
  const calculations = calculateTotals(validatedOrder);
  return formatOrderResponse(calculations);
}
```

#### Simplify Conditionals

**Before:**

```typescript
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
```

**After:**

```typescript
function isEligibleUser(user: User): boolean {
  const isValidAge = user.age >= 18 && user.age <= 65;
  const isActive = user.status === "active" && !user.suspended;
  const hasFunds = user.balance > 0 || user.creditLimit > 0;

  return isValidAge && isActive && hasFunds;
}
```

#### Replace Loops with Higher-Order Functions

**Before:**

```typescript
const results = [];
for (const item of items) {
  if (item.isValid()) {
    results.push(item.transform());
  }
}
```

**After:**

```typescript
const results = items
  .filter((item) => item.isValid())
  .map((item) => item.transform());
```

#### Use Early Returns

**Before:**

```typescript
function process(data: Data): Result {
  if (data !== null) {
    if (data.isValid()) {
      const result = compute(data);
      if (result !== null) {
        return result;
      } else {
        throw new Error("computation failed");
      }
    } else {
      throw new Error("invalid data");
    }
  } else {
    throw new Error("nil data");
  }
}
```

**After:**

```typescript
function process(data: Data): Result {
  if (data === null) {
    throw new Error("nil data");
  }

  if (!data.isValid()) {
    throw new Error("invalid data");
  }

  const result = compute(data);
  if (result === null) {
    throw new Error("computation failed");
  }

  return result;
}
```

#### Extract Constants and Magic Numbers

**Before:**

```typescript
if (retries > 3 && delay > 1000) {
  await wait(delay * 1.5);
}
```

**After:**

```typescript
const MAX_RETRIES = 3;
const MIN_DELAY_MS = 1000;
const BACKOFF_MULTIPLIER = 1.5;

if (retries > MAX_RETRIES && delay > MIN_DELAY_MS) {
  await wait(delay * BACKOFF_MULTIPLIER);
}
```

### 3. Naming Improvements

- Replace abbreviations with full words
- Use domain-specific terminology
- Make boolean names interrogative
- Avoid generic names (data, info, temp)

### 4. Structure Improvements

#### Before

```typescript
class OrderProcessor {
  // 500 lines of mixed concerns
}
```

#### After

```typescript
class OrderProcessor {
  constructor(
    private validator: OrderValidator,
    private calculator: PriceCalculator,
    private notifier: CustomerNotifier,
  ) {}

  async process(order: Order): Promise<ProcessedOrder> {
    const validated = await this.validator.validate(order);
    const priced = await this.calculator.calculate(validated);
    await this.notifier.notify(priced);
    return priced;
  }
}
```

### 5. Testing Simplification

- Extract test helpers
- Use descriptive test names
- Remove test duplication
- Add missing edge cases

### 6. Documentation

Add clear, concise comments only where necessary:

```typescript
// Calculate compound interest using the formula: A = P(1 + r/n)^(nt)
function calculateCompoundInterest(
  principal: number,
  rate: number,
  time: number,
  compoundsPerYear: number,
): number {
  return (
    principal * Math.pow(1 + rate / compoundsPerYear, compoundsPerYear * time)
  );
}
```

## Validation

After simplification, ensure:

- All tests still pass
- No functionality is lost
- Performance hasn't degraded
- Code coverage is maintained

## Output Format

```markdown
## Simplification Summary

**Complexity Reduced From:** [metrics]
**Complexity Reduced To:** [metrics]

### Changes Made:

1. Extracted X methods for better separation of concerns
2. Simplified Y conditional expressions
3. Replaced Z loops with functional constructs
4. Improved naming for N variables/functions

### Key Improvements:

- Reduced cyclomatic complexity from A to B
- Improved readability score from C to D
- Decreased file length from E to F lines

### Code Diff:

[Show key before/after examples]
```

## Guidelines

- Preserve all functionality
- Maintain or improve performance
- Keep domain logic intact
- Follow language idioms
- Consider team conventions
- Add tests for refactored code
