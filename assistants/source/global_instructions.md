COMMIT: conventional commits, 1 granular commit per goal, 50 char max

## Tools
- **ast-grep**: code searches (functions, classes, patterns, refactoring)
- **grep**: text searches (docs, comments, logs, non-code)
- **pnpm**: always use instead of npm
- **TypeScript**: always use instead of JavaScript

## ast-grep
```bash
ast-grep -p 'function $name($$$) { $$$ }' -l js    # search
ast-grep -p 'var $v = $val' -r 'const $v = $val' -l js --interactive  # replace
```
Variables: `$VAR` (single node), `$$$` (zero+ nodes), `$$VAR` (multiple nodes)

## Always Use Standard CLI Tools
**Use official tools for ALL tasks, not just initialization:**
- **Go**: `go mod init`, `go get` for dependencies
- **React**: `pnpm create vite@latest app -- --template react`
- **Alpine.js**: `pnpm create vite@latest app -- --template vanilla-ts`
- **Svelte**: `npx sv create app`
- **Rust**: `cargo new`, `cargo add`, `cargo check`, `cargo test`
- **Zig**: `zig init`, `zig build`, `zig test`
- **Ruby**: `bundle init`, `bundle add`, `rails new`, `rails generate`
- **Elixir**: `mix new`, `mix phx.new` (Phoenix), `mix deps.get`
- ALWAYS use `pnpm` instead of `npm`
- ALWAYS use TypeScript instead of JavaScript
- **Never manually create package.json/go.mod** - use official scaffolding
- **Always use language-specific package managers and build tools**