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

## Setup and Initialization
```bash
./manage.sh                    # Interactive management interface (requires gum)
./tools_management/init-tools.sh    # Complete setup (build, configure, permissions)
```

## Building and Development
```bash
./tools_management/build.sh         # Compile all tools from sources/
./tools_management/set-permissions.sh   # Fix executable permissions
./tools_management/sync-submodules.sh   # Update all submodules to latest
```

## Tool Management
```bash
./tools_management/init-new-tool.sh     # Create new tool repository as submodule
./tools                              # Interactive launcher for all tools
```

## Assistant Configuration
```bash
./scripts/configure-assistants-global      # Setup global AI assistant configurations
./scripts/sync-assistant-commands          # Sync commands to global directories
./scripts/create-assistant-command         # Create new command/prompt templates
./scripts/clean-global-assistants-configs  # Remove all assistant configurations
```

# Architecture Details

## Directory Structure
- `manage.sh` - Main interactive interface using gum for navigation
- `shell/` - Shell configuration and runtime integration
  - `shell/rc` - Main shell config (exports PATH, loads other configs)
  - `shell/shortcuts` - Custom aliases and shortcuts
- `tools_management/` - Core management automation scripts
- `scripts/` - Utility scripts (automatically in PATH)
- `bin/` - Compiled executables from sources/ (automatically in PATH)
- `sources/` - Source code repositories as git submodules
- `assistants/` - Multi-assistant AI configuration system

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
The `assistants/` system provides centralized configuration management:
- **`common/`**: Shared instructions and commands synced to all assistants
- **`claude/`, `codex/`, `gemini/`**: Assistant-specific configurations
- **Configuration merging**: Preserves existing settings while adding new ones
- **Command formats**:
  - Claude/Gemini: `.md` files in `commands/` (uses `$ARGUMENTS` placeholder)
  - Codex: `.md/.toml` files in `prompts/` (entire file becomes prompt)
  - Common: `.md` files automatically synced to all assistants

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
   ./tools_management/build.sh  # Compile from current local state
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
- **Interactive interfaces**: Main interfaces (`manage.sh`, `tools`) use gum for navigation

# Important Reminders
- Do what has been asked; nothing more, nothing less
- ALWAYS prefer editing an existing file to creating a new one
- NEVER create files unless absolutely necessary for achieving your goal
- NEVER proactively create documentation files (*.md) or README files unless explicitly requested
