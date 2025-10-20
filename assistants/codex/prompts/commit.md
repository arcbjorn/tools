---
description: "You MUST follow these commit guidelines exactly:"
---
You MUST follow these commit guidelines exactly:

## Conventional Commits Format
```
<type>(<scope>): <description>
```

## Rules (MANDATORY)
1. **Message Length**: Maximum 50 characters total
2. **One Commit Per File/Folder**: 1 conventional commit for 1 file OR 1 folder (folder only if absolutely same change across all files, e.g., rename)
3. **One Goal Per Commit**: Each commit should accomplish exactly one specific goal
4. **Single Line Only**: One line commit message only (no description/body required)
5. **Lowercase**: Use lowercase for type, scope, and description
6. **No Period**: Do not end with a period
7. **Scope Required**: Always include scope in parentheses

## Types (use these exact words)
- `feat` - new feature
- `fix` - bug fix
- `docs` - documentation only
- `style` - formatting, missing semicolons (no code change)
- `ref` - code restructuring without changing functionality
- `test` - adding/correcting tests
- `chore` - build process, auxiliary tools, libraries

## Scope Examples
- Component: `auth`, `nav`, `sidebar`, `modal`
- Feature: `login`, `search`, `export`, `upload`
- File/Module: `api`, `db`, `config`, `utils`
- Area: `ui`, `backend`, `cli`, `docs`

## Examples
```
feat(auth): add dark mode toggle
fix(login): resolve timeout issue
docs(readme): update installation guide
ref(api): simplify user validation
test(auth): add unit tests for login
chore(deps): update dependencies
```

## Before Committing
1. Run `git status` to see changes
2. Run `git diff` to review changes  
3. Stage only files related to ONE goal
4. Write commit message following format above
5. Commit with the properly formatted message

## What NOT to do
- ❌ "update files" (no scope, too vague)
- ❌ "fix bugs and add feature" (multiple goals)
- ❌ Messages over 50 characters
- ❌ Using past tense ("added", "fixed")
- ❌ Missing scope: "feat: add toggle"
- ❌ Uppercase: "FEAT(auth):" or "feat(AUTH):"

COMMIT THE CURRENT UNSTAGED CHANGES NOW using these exact guidelines.
