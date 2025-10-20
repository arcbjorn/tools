# Fix Bad Commit

You MUST follow these steps to fix the last commit:

## Step 1: Uncommit and Unstage Last Commit
```bash
git reset --mixed HEAD~1
```
This will:
- Remove the last commit from history
- Unstage all changes (move to working directory)
- Allow you to selectively stage files for separate commits

## Step 2: Review What You're Working With
```bash
git status
git diff
```

## Step 3: Stage Files for One Specific Goal
```bash
git add <specific-files>
```
Only add files that accomplish ONE goal together.

## Step 4: Commit Properly
Use conventional commits format: `<type>(<scope>): <description>`

### Rules (MANDATORY)
- **50 characters max**
- **Lowercase everything**
- **Include scope in parentheses**
- **No period at end**
- **One specific goal only**

### Types
- `feat` - new feature
- `fix` - bug fix
- `docs` - documentation
- `style` - formatting only
- `refactor` - code restructuring
- `test` - tests
- `chore` - build/tools

### Examples
```
feat(auth): add login form
fix(api): handle null responses
docs(readme): update install steps
refactor(db): simplify queries
```

## Step 5: Make Granular Commits
```bash
git commit -m "type(scope): description"
```

Repeat steps 3-5 for each separate goal/change.

**DO THIS NOW:** Uncommit the last commit, unstage everything, and create proper granular commits.