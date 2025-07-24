---
allowed-tools: Bash(gh:*), Bash(jq:*)
description: Search GitHub for code using GitHub CLI and display formatted results
argument-hint: "[search-query]"
---

# /github/github-codesearch

Search GitHub repositories for code patterns using GitHub CLI and display formatted results with permalinks.

## Context

- Search query: $ARGUMENTS
- Current directory: !`pwd`
- GitHub CLI auth status: !`gh auth status 2>/dev/null || echo "Not authenticated"`

## Usage

```
/github/github-codesearch "react hooks"              # Search for React hooks
/github/github-codesearch "language:go func main"    # Search Go main functions
/github/github-codesearch "path:**/*.ts interface"   # Search TypeScript interfaces
```

## Your Task

**STEP 1: Validate Prerequisites**

IF no search query in $ARGUMENTS:

- DISPLAY usage examples and search patterns
- EXIT with guidance

IF GitHub CLI not authenticated:

- INSTRUCT user to run `gh auth login`
- EXPLAIN authentication requirement for code search
- EXIT with setup instructions

**STEP 2: Execute Search**

RUN GitHub code search with proper error handling:

```bash
gh api search/code \
  --header "Accept: application/vnd.github.text-match+json" \
  --raw-field q="$ARGUMENTS" \
  --jq '.items[:10] | .[] | {
    repo: .repository.full_name,
    description: .repository.description // "No description",
    path: .path,
    url: .html_url,
    snippet: .text_matches[0].fragment // "No preview available"
  }'
```

**STEP 3: Format Results**

FOR EACH result from API response:

- PARSE JSON output using jq
- FORMAT repository information clearly
- INCLUDE direct links to code locations
- TRUNCATE long snippets for readability

DISPLAY formatted results:

```markdown
# 🔍 GitHub Code Search: {query}

**Found results in {result_count} repositories**

## 📁 {repository_name}
> {description}

**File:** `{file_path}`  
**Code:** ```{language}
{code_snippet}
```
**Link:** [View on GitHub]({permalink_url})

---
```

**STEP 4: Handle Edge Cases**

IF GitHub API returns errors:

```bash
# Check for common error patterns
if [[ "$output" == *"rate limit"* ]]; then
  echo "⚠️ Rate limit exceeded. Try again in 60 seconds."
  exit 1
elif [[ "$output" == *"Bad credentials"* ]]; then
  echo "🔐 Authentication failed. Run: gh auth login"
  exit 1
elif [[ "$output" == *"total_count\":0"* ]]; then
  echo "🔍 No results found. Try refining your search query."
fi
```

IF no results found:

- SUGGEST more specific search terms
- RECOMMEND using language filters
- SHOW common search patterns for guidance

IF search is too broad:

- WARN about result limits (1000 max)
- SUGGEST adding filters like `language:` or `path:`

## Common Search Patterns

- `"exact phrase"` - Search for exact phrase matches
- `language:javascript react` - Search JavaScript files containing "react"
- `path:**/*.ts interface` - Search TypeScript files for interfaces
- `extension:md documentation` - Search Markdown files for documentation
- `filename:package.json` - Search specific filenames
- `user:username repo:reponame` - Search within specific repositories
- `created:>2023-01-01` - Search recent code
- `size:<1000` - Search smaller files

## Examples

### Example 1: Language-Specific Search

`/github/github-codesearch "language:python def __init__"`
Searches for Python class constructors across GitHub.

### Example 2: Framework Search

`/github/github-codesearch "react useEffect cleanup"`
Finds React useEffect patterns with cleanup functions.

### Example 3: Configuration Files

`/github/github-codesearch "filename:docker-compose.yml postgres"`
Searches Docker Compose files using PostgreSQL.

**IMPORTANT**: GitHub code search requires authentication and has rate limits. Use specific queries for better results.
