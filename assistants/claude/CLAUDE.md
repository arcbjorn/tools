<!-- GLOBAL INSTRUCTIONS START -->
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

## Package Manager Commands for Dependencies
**ALWAYS use these commands to add dependencies (gets latest versions):**
- **Node/JS/TS**: `pnpm add <package>` (NEVER use npm)
- **Python**: `uv add <package>` (NEVER use pip or poetry directly)
- **Go**: `go get -u <module>` or `go get <module>@latest`
- **Rust**: `cargo add <crate>` (auto-fetches latest)
- **Ruby**: `bundle add <gem>` (adds to Gemfile)
- **PHP**: `composer require <package>`
- **C#/.NET**: `dotnet add package <package>`
- **Java**: Add to `pom.xml` or `build.gradle` with version `LATEST` or `+`
- **Elixir**: `mix deps.get` after adding to `mix.exs`
- **Zig**: Add to `build.zig.zon` then `zig build`
- **Bun**: `bun add <package>` for Bun projects

**Dev Dependencies:**
- **Node**: `pnpm add -D <package>`
- **Python**: `uv add --dev <package>`
- **Rust**: `cargo add --dev <crate>`
- **Go**: Add with `// indirect` comment in go.mod

**Python Project Setup:**
- `uv init` for new projects
- `uv venv` to create virtual environment
- `uv pip install` only when absolutely necessary
- `uv run` to run scripts with dependencies

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
- **Python**: `uv init`, `uv add` for dependencies (NEVER pip or poetry)
- ALWAYS use `pnpm` instead of `npm`
- ALWAYS use `uv` instead of `pip` or `poetry`
- ALWAYS use TypeScript instead of JavaScript
- **Never manually create package.json/go.mod/pyproject.toml** - use official scaffolding
- **Always use language-specific package managers and build tools**
<!-- GLOBAL INSTRUCTIONS END -->

## mcp codex
```bash
mcp__codex__codex --prompt "Review all Python services and provide refactoring instructions"
mcp__codex__codex --prompt "Analyze this codebase for security vulnerabilities and bugs"
mcp__codex__codex --prompt "Review FastAPI architecture and suggest improvements"
```
Use for: comprehensive code reviews, refactoring guidance, architecture analysis