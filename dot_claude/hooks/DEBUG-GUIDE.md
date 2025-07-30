# Code Formatter Hook Debug Guide

The hook isn't working in your other codebase? Here's how to debug it systematically.

## Updated: Global Hook Configuration

This hook is now designed to work globally from `~/.claude/hooks/` and automatically detect the correct project root for any project you're working on. You **don't need to copy it to each project**.

## Step 1: Verify Hook System is Working

First, test if hooks are working at all:

1. **Make sure this hook is in your global Claude Code configuration** (`~/.claude/hooks/`)
2. **Temporarily replace `index.ts` with `debug-hook-test.ts`**:
   ```bash
   mv index.ts index.ts.backup
   cp debug-hook-test.ts index.ts
   ```
3. **Test with Claude Code** - create or edit any file and watch for debug output
4. **Look for these messages**:
   - `🔍 DEBUG HOOK: PreToolUse triggered!`
   - `🔍 DEBUG HOOK: PostToolUse triggered!`
   - `🎯 This would trigger code formatting!`

**If you see NO debug messages**: Hook system isn't working
**If you see debug messages**: Hook system is working, issue is in formatter logic

## Step 2: Debug the Formatter Logic

If hooks are working, restore the original `index.ts`:
```bash
mv index.ts.backup index.ts
```

The formatter now has extensive debug logging. Look for these messages:

### Expected Log Sequence:
```
🔍 HOOK DEBUG: PostToolUse called for tool: Write
🔍 HOOK DEBUG: Tool success: true
🔍 HOOK DEBUG: About to call formatCode
[timestamp] 🔍 CODE-FORMATTER: formatCode() called
[timestamp] 🔍 CODE-FORMATTER: Inspecting payload
[timestamp] 🔍 CODE-FORMATTER: Checking tool name
[timestamp] 🔍 CODE-FORMATTER: Extracting file paths from payload
[timestamp] 🔍 CODE-FORMATTER: Project root detection
[timestamp] 🔍 CODE-FORMATTER: Processing file: /path/to/file.js
[timestamp] 🔍 CODE-FORMATTER: File checks
🎨 Formatting: file.js
```

### New: Project Root Detection
The hook now automatically detects the correct project root by looking for:
- `package.json`
- Lock files (`bun.lock`, `pnpm-lock.yaml`, `yarn.lock`, `package-lock.json`)
- `.git` directory

It walks up the directory tree from the file being formatted to find these indicators.

### Common Issues & Solutions:

#### Issue: No hook messages at all
**Cause**: Hook not registered or not executable
**Solution**: 
- Check Claude Code settings for hook path
- Ensure hook has execute permissions: `chmod +x index.ts`
- Verify hook path in `~/.claude/settings.json`

#### Issue: Hook runs but "Skipping: not PostToolUse"
**Cause**: Wrong hook type
**Solution**: Check the payload structure - might be PreToolUse instead

#### Issue: "Skipping: tool response not successful"
**Cause**: Tool reported failure
**Solution**: Check why the tool (Write/Edit) is failing first

#### Issue: "Skipping: not a file modification tool"
**Cause**: Tool name doesn't match expected values
**Solution**: Check debug output for actual tool name, add it to the list

#### Issue: "Skipping: no file paths found"
**Cause**: File path extraction failed
**Solution**: Check payload structure - might be different format

#### Issue: Formatter runs but no files processed
**Cause**: Files filtered out by exclusion rules or not supported
**Solution**: Check "File checks" debug output

## Step 3: Common Configuration Issues

### Hook Registration
Check your Claude Code settings (`~/.claude/settings.json`):
```json
{
  "hooks": {
    "postToolUse": "/path/to/your/hooks/index.ts"
  }
}
```

### File Permissions
```bash
chmod +x /path/to/your/hooks/index.ts
ls -la /path/to/your/hooks/index.ts
```

### Package Manager Detection
The formatter detects package managers by looking for lock files:
- `bun.lock` or `bun.lockb` → bun
- `pnpm-lock.yaml` → pnpm  
- `yarn.lock` → yarn
- `package-lock.json` → npm

If none found, formatting will fail.

## Step 4: Test in This Directory

Test the formatter works in this hooks directory:
```bash
cd /Users/herrschade/.claude/hooks
echo 'function test(){console.log("hello")}' > test.js
# Use Claude Code to edit the file - should see formatting
```

## Step 5: Enable File Logging (If Console Output Not Visible)

If you can't see console output, add file logging:

```typescript
// Add to debug-hook-test.ts or index.ts
import {writeFileSync} from 'node:fs'

function fileLog(message: string) {
  const timestamp = new Date().toISOString()
  const logMessage = `[${timestamp}] ${message}\n`
  writeFileSync('/tmp/hook-debug.log', logMessage, {flag: 'a'})
}

// Use fileLog() instead of console.log()
```

Then check: `tail -f /tmp/hook-debug.log`

## Need More Help?

If none of this helps, share:
1. Output from the debug messages
2. Your Claude Code settings.json (hooks section)
3. Your project structure (package.json, lock files)
4. What file types you're trying to format