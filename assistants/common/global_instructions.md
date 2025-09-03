COMMIT INSTRUCTIONS: use conventional commits guidelines, 1 GRANULAR COMMIT PER 1 GOAL, MESSAGE 50 CHARACTERS MAX, NO DESCRIPTION

## Tool Preferences
- **USE ast-grep** for code searches instead of grep/ripgrep when searching for:
  - Function/class/method definitions
  - Code patterns and structures  
  - Language-specific syntax
  - Code transformations and refactoring

- **USE grep/ripgrep** for:
  - Simple text searches
  - Documentation/comments
  - Log files
  - Non-code content

## ast-grep Quick Reference
```bash
# Search functions
ast-grep -p 'function $name($$$) { $$$ }' -l javascript

# Search classes
ast-grep -p 'class $name { $$$ }' -l typescript

# Search and replace
ast-grep -p 'var $v = $val' -r 'const $v = $val' -l javascript

# Interactive mode for safe transformations
ast-grep -p 'pattern' -r 'replacement' -l language --interactive
```

## Pattern Variables
- `$VAR` - matches any single AST node
- `$$$` - matches zero or more nodes (ellipsis)
- `$$VAR` - matches multiple nodes as array

## Always Use Standard CLI Tools Whenever Possible
- **Use official CLI tools for ALL tasks**, not just initialization
- **Go Backend**: Use `go mod init` to initialize Go modules, `go get` for dependencies
- **React Frontend**: Use `pnpm create vite@latest my-app -- --template react`
- **Alpine.js**: `pnpm init vite@latest my-alpine-app -- --template vanilla-ts`
- ALWAYS use `pnpm` instead of `npm`
- ALWAYS use Typescript instead of Javascript
- **Svelte**: `npx sv create my-app`
- **Rust**: `cargo new`, `cargo add`, `cargo check`, `cargo test`
- **Zig**: `zig init`, `zig build`, `zig test`
- **Ruby**: `bundle init`, `bundle add gem_name`, `bundle install`, `bundle exec`
- **Ruby on Rails**: `rails new my_app`, `rails generate scaffold ModelName`, `rails db:migrate`
- **Elixir**: `mix new my_app`, `mix phx.new my_app` (for Phoenix), `mix deps.get`, `mix test`
- **Never manually create package.json or go.mod files**
- **ALWAYS use official scaffolding tools**
- **ALWAYS use language-specific package managers and build tools**