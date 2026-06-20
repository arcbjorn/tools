# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

COMMIT INSTRUCTIONS: use conventional commits guidelines, 1 GRANULAR COMMIT PER 1 GOAL, MESSAGE 50 CHARACTERS MAX

# Architecture Overview
This is a personal CLI utilities management system organized as a git repository with submodules. The architecture follows a clean separation between:
- **Management layer**: Interactive interfaces and automation scripts
- **Build system**: Language-agnostic compilation pipeline
- **Runtime layer**: Shell integration and PATH management
- **Configuration system**: Multi-assistant AI configuration management

# Common Development Tasks

Everything is driven by a single `tools` command (in `scripts/`, on PATH).

## Setup, Building, Tool Management
```bash
tools                 # Interactive menu (autodiscovers bin/ + scripts/)
tools init            # Complete setup (build, configure shell, permissions)
tools build           # Compile all tools from sources/ -> bin/
tools submodules      # Update all submodules to latest
tools permissions     # Fix executable permissions
tools new-tool        # Create a new tool repository as a submodule
```

## Assistant Configuration
```bash
tools assist gen        # Regenerate all assistant configs from assistants/source/
tools assist gen pi     # Regenerate just one (claude|codex|gemini|opencode|pi)
tools assist sync       # Push generated configs to global dirs (merges, non-destructive)
tools assist sync --dry # Preview the sync
tools assist doctor     # Check assistant config health
tools assist import     # Import global commands/agents back into source/
```
`tools assist` runs `sources/assistants-cli/cli.ts` via `bun run` (no compiled binary).

# Architecture Details

## Directory Structure
- `scripts/tools` - Single entry point / dispatcher (the `tools` command)
- `shell/` - Shell configuration and runtime integration
  - `shell/rc` - Main shell config (exports PATH, loads other configs)
  - `shell/shortcuts` - Custom aliases and shortcuts
- `tools_management/` - Leaf scripts invoked by `tools` (build, submodules, permissions)
- `scripts/` - Utility scripts (automatically in PATH)
- `bin/` - Compiled executables from sources/ (gitignored, automatically in PATH)
- `sources/` - Source code repositories as git submodules
- `assistants/` - Multi-assistant AI configuration system (only `source/` is tracked)

## Build System Architecture
The build system in `tools_management/build.sh` automatically detects project types and compiles:
- **Rust projects**: `cargo build --release` → copies executables to bin/
- **Go projects**: `go build -o $TOOLS_DIR/bin/`
- **Zig projects**: `zig build --prefix $TOOLS_DIR/`
- **Make projects**: `make` with PREFIX support
- **Python projects**: pip installs to bin/

## Shell Integration System
`shell/rc` is the core runtime component that:
- Exports `$HOME/tools/bin:$HOME/tools/scripts` to PATH
- Dynamically sources all files in `shell/` directory (except itself)
- Provides modular configuration loading for shortcuts, temp secrets, and functions

## AI Assistant Configuration Architecture
The `assistants/` system is driven by `sources/assistants-cli/cli.ts` (run via `bun run`, wrapped by `tools assist`). Supported assistants: Claude, Codex, Gemini, OpenCode, Pi.

**Source of truth (only thing tracked in git)**: `assistants/source/`
- `global_instructions.md`: merged into every assistant config inside `<!-- GLOBAL INSTRUCTIONS START/END -->` block
- `commands/`: commands synced to all assistants
- `agents/`: agents synced to assistants that support them (Claude, OpenCode)

The per-assistant trees (`assistants/{claude,codex,gemini,opencode,pi}/`) are **generated and gitignored** — never edit them by hand; edit `source/` and regenerate.

**Per-assistant globals** (`claude/CLAUDE.md`, `codex/AGENTS.md`, `gemini/GEMINI.md`, `opencode/global_instructions.md`, `pi/AGENTS.md`): `gen` only updates the `<!-- GLOBAL INSTRUCTIONS -->` block, leaving any hand-written remainder intact.

**Workflow**:
```bash
tools assist gen          # regenerate all from source/
tools assist gen claude   # regenerate one (claude|codex|gemini|opencode|pi)
tools assist sync         # push to ~/.claude, ~/.codex, ~/.gemini, ~/.config/opencode, ~/.pi/agent (merges)
tools assist doctor       # check config health
```

**Command / instruction formats per assistant**:
- Claude / Gemini / OpenCode: `.md` (or `.toml` for Gemini) files in `commands/`
- Codex: `.md` files in `prompts/`
- Pi: no slash-commands — each command becomes a skill at `skills/<name>/SKILL.md`; global instructions share Codex's `AGENTS.md` format, synced to `~/.pi/agent/`

# Development Guidelines

## Submodule Development Workflow
1. **Working on submodules locally**:
   ```bash
   cd sources/your-tool
   # Make changes, commit, push as normal
   git add . && git commit -m "fix: some bug" && git push
   ```

2. **Compile and test locally**:
   ```bash
   tools build  # Compile from current local state
   ```

3. **Sync parent repo with latest submodule versions**:
   ```bash
   git submodule update --remote && git add . && git commit -m "chore: update all submodules" && git push
   ```

## Theme and Color System
Scripts use omarchy-compatible terminal palette colors:
- Terminal palette slots: `\033[38;5;1m` (red), `\033[38;5;2m` (green), etc.
- Gum foreground: `--foreground 1` (red), `--foreground 2` (green), `--foreground 4` (blue)
- Color constants defined: RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE, GRAY
- Always use terminal palette slots instead of hex colors for theme consistency

## Key Implementation Notes
- **PATH management**: Handled automatically by `shell/rc` - tools and scripts are immediately available
- **Permissions**: `tools_management/set-permissions.sh` handles executable permissions for both scripts/ and bin/
- **Language detection**: Build system automatically detects Rust (Cargo.toml), Go (go.mod), Zig (build.zig), Make (Makefile)
- **Configuration merging**: Assistant configs preserve existing settings while adding new ones
- **Interactive interface**: `tools` (with no args) opens a gum picker that autodiscovers everything in bin/ and scripts/

# Important Reminders
- Do what has been asked; nothing more, nothing less
- ALWAYS prefer editing an existing file to creating a new one
- NEVER create files unless absolutely necessary for achieving your goal
- NEVER proactively create documentation files (*.md) or README files unless explicitly requested
