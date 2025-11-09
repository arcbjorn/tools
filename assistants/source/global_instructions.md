NEVER use emojis in communication, code, or commits unless explicitly requested

COMMIT: conventional commits, 1 granular commit per goal, 50 char max

## Tools
- **ast-grep**: structural code searches (functions, classes, patterns) and refactoring
- **grep/rg**: text searches (docs, comments, logs, non-code content)
- **git**: version control (use conventional commits, atomic commits per goal)
- **strace/ltrace**: system call tracing and debugging
- **docker/podman**: containerization (prefer podman for rootless)
- **make/cmake**: build automation (always check for existing Makefiles)
- **jq/yq**: JSON/YAML parsing and manipulation
- **curl/httpie**: HTTP requests (prefer httpie for readability)
- **fd**: fast file finder (modern alternative to find)
- **bat**: syntax-highlighted file viewer (modern alternative to cat)

## ast-grep
```bash
ast-grep -p 'function $name($$$) { $$$ }' -l js    # search
ast-grep -p 'var $v = $val' -r 'const $v = $val' -l js --interactive  # replace
```
Variables: `$VAR` (single node), `$$$` (zero+ nodes), `$$VAR` (multiple nodes)

## Package Manager Commands for Dependencies
**ALWAYS use these commands to add dependencies (gets latest versions):**
- **Node/JS/TS**: `pnpm add <package>` or `bun add <package>` (NEVER use npm)
- **Python**: `uv add <package>` (NEVER use pip or poetry directly)
- **Go**: `go get -u <module>` or `go get <module>@latest`
- **Rust**: `cargo add <crate>` (auto-fetches latest)
- **Ruby**: `bundle add <gem>` (adds to Gemfile)
- **PHP**: `composer require <package>`
- **C#/.NET**: `dotnet add package <package>`
- **Java**: Add to `pom.xml` or `build.gradle` with version `LATEST` or `+`
- **Elixir**: `mix deps.get` after adding to `mix.exs`
- **Zig**: Add to `build.zig.zon` then `zig build`

**Dev Dependencies:**
- **Node**: `pnpm add -D <package>` or `bun add -D <package>`
- **Python**: `uv add --dev <package>`
- **Rust**: `cargo add --dev <crate>`
- **Go**: Add with `// indirect` comment in go.mod

**Python Project Setup:**
- `uv init` for new projects
- `uv venv` to create virtual environment
- `uv pip install` only when absolutely necessary
- `uv run` to run scripts with dependencies

## Project Initialization & Standard CLI Tools
**Use official tools for ALL tasks, not just initialization:**
- **Go**: `go mod init`
- **React**: `pnpm create vite@latest app -- --template react`
- **Alpine.js**: `pnpm create vite@latest app -- --template vanilla-ts`
- **Svelte**: `npx sv create app`
- **Rust**: `cargo new`, `cargo check`, `cargo test`
- **Zig**: `zig init`, `zig build`, `zig test`
- **Ruby**: `bundle init`, `rails new`, `rails generate`
- **Elixir**: `mix new`, `mix phx.new` (Phoenix)

## Language Preferences
- **JavaScript/TypeScript**: ALWAYS use TypeScript instead of JavaScript
- **Node package managers**: ALWAYS use `pnpm` or `bun` (NEVER use npm)
- **Python package managers**: ALWAYS use `uv` (NEVER use pip or poetry directly)
- **Never manually create package.json/go.mod/pyproject.toml** - use official scaffolding tools
- **Always use language-specific package managers and build tools**