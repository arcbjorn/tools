# Personal CLI Utilities Management System

A sophisticated git-based system for managing development tools, scripts, and AI assistant configurations with clean separation between management, build, and runtime layers.

## Architecture Overview

This system follows a three-layer architecture:

- **Management Layer**: Interactive interfaces and automation scripts
- **Build System**: Language-agnostic compilation pipeline
- **Runtime Layer**: Shell integration and PATH management

## Directory Structure

```
~/tools/
├── bin/                    # Compiled executables (auto-generated)
├── scripts/                # Shell scripts (immediately available)
├── sources/                # Git submodules for tools needing compilation
│   ├── gh-activity-graph-sh/  # GitHub activity visualization
│   ├── agents-orchestrator/   # AI agents management system
│   ├── workflow/              # Workflow automation tools
│   └── assistants-cli/        # Assistant CLI utilities
├── assistants/             # Multi-assistant AI configuration system
│   ├── source/                # Single source of truth
│   │   ├── commands/          # Reusable command templates
│   │   ├── agents/            # Specialized AI agents
│   │   └── global_instructions.md  # Shared development guidelines
│   ├── claude/                # Claude-specific configurations
│   ├── codex/                 # Codex-specific configurations
│   ├── gemini/                # Gemini-specific configurations
│   └── opencode/              # OpenCode-specific configurations
├── tools_management/       # Core automation scripts
│   ├── build.sh               # Universal build system
│   ├── init-tools.sh          # Complete setup script
│   ├── configure-shell.sh     # Shell PATH integration
│   ├── set-permissions.sh     # Permission management
│   ├── init-new-tool.sh       # Create new tool submodules
│   └── sync-submodules.sh     # Update all submodules
├── shell/                  # Shell configuration and runtime
│   ├── rc                     # Main shell config (PATH + modular loading)
│   ├── shortcuts              # Custom aliases and shortcuts
│   └── temp                   # Temporary commands (git-ignored)
├── CLAUDE.md               # Project-specific development guidelines
└── .gitmodules             # Git submodule configuration
```

## Installation

### Quick Start (Recommended)
Run the complete setup once (call it directly the first time, before `tools` is on PATH):
```bash
cd ~/tools
./scripts/tools init
```

This will:
- Build all tools from `sources/` using the universal build system
- Configure shell integration and PATH management
- Set executable permissions for all scripts and binaries
- Initialize the modular shell configuration system

After PATH is set up (new shell), drive everything with the single `tools` command.

## Usage

Everything goes through one command:
```bash
tools                 # Interactive picker (autodiscovers bin/ + scripts/)
tools build           # Compile all tools from sources/ -> bin/
tools submodules      # Update all submodules to latest
tools permissions     # Fix executable permissions
tools new-tool        # Add a new tool repo as a submodule
```

### AI Assistant Configuration System
Supports Claude, Codex, Gemini, OpenCode, and Pi. Source of truth is `assistants/source/`; everything else is generated.

```bash
tools assist gen          # Regenerate all assistant configs from source/
tools assist gen pi       # Regenerate one (claude|codex|gemini|opencode|pi)
tools assist sync         # Push to global config dirs (merges, non-destructive)
tools assist doctor       # Check assistant config health
tools assist import       # Import global commands/agents back into source/
```

**Configuration Locations**:
- **Settings**: `~/.claude/settings.json`, `~/.codex/config.toml`, `~/.gemini/settings.json`
- **Memory files**: `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md`, `~/.gemini/GEMINI.md`, `~/.pi/agent/AGENTS.md`
- **Commands**: `~/.claude/commands/`, `~/.codex/prompts/`, `~/.gemini/commands/`
- **Pi skills**: `~/.pi/agent/skills/<name>/SKILL.md`

**Command Formats by Assistant**:
- Claude/Gemini: `.md` files in `commands/` (uses `$ARGUMENTS` placeholder)
- Codex: `.md` files in `prompts/` (entire file becomes prompt)
- Pi: no slash-commands; each command becomes a skill, instructions share Codex's `AGENTS.md`

**Safe Merging**: Preserves existing settings while adding new configurations.

## Adding Tools and Scripts

### Adding Shell Scripts
Place shell scripts directly in `scripts/` (immediately available in PATH):
```bash
cp myscript.sh ~/tools/scripts/
chmod +x ~/tools/scripts/myscript.sh
```

### Adding Compiled Tools

#### Create New Tool (Recommended)
```bash
cd ~/tools
tools new-tool
```

#### Add Existing Repository as Submodule
```bash
cd ~/tools
git submodule add https://github.com/user/tool.git sources/tool-name
```

## Development Workflow

### Local Development on Submodules
```bash
cd ~/tools/sources/your-tool
# Make changes, commit, push as normal
git add . && git commit -m "fix: some bug" && git push
```

### Build from Current Local State
```bash
cd ~/tools
./tools_management/build.sh  # Compile all tools from current local state
```

### Sync Parent Repository with Latest Submodules
```bash
cd ~/tools
git submodule update --remote && git add . && git commit -m "chore: update all submodules" && git push
```

## Universal Build System

The `tools_management/build.sh` script automatically handles multiple languages:

### Supported Languages
- **Rust**: `cargo build --release` → copies executables to `bin/`
- **Go**: `go build -o $TOOLS_DIR/bin/` (supports `cmd/` directory structure)
- **Zig**: `zig build --prefix $TOOLS_DIR/`
- **Make**: `make` with PREFIX support
- **Bun**: Entry point detection (`cli.ts`, `index.ts`)
- **Python**: pip installs to `bin/`

### Intelligent Detection
- Auto-detects project type based on configuration files
- Handles multiple binary projects in single repositories
- Respects language-specific conventions and build patterns

## Shell Integration System

The `shell/rc` configuration provides:
- **PATH Management**: Automatically exports `~/tools/bin:~/tools/scripts`
- **Modular Loading**: Dynamically sources all files in `shell/` directory
- **Runtime Integration**: Immediate availability of tools and functions

### Shell Configuration Structure
- `shell/rc` - Main configuration (PATH exports, modular loading)
- `shell/shortcuts` - Custom aliases and shortcuts
- `shell/temp` - Temporary commands with secrets (git-ignored)

## Important Notes

- **`scripts/`**: Direct shell scripts (no compilation needed, immediately available)
- **`sources/`**: Projects requiring compilation (managed as git submodules)
- **`bin/`**: Auto-generated directory, never manually place files here
- **Development**: Work in submodules independently, sync parent repository when ready
- **Permissions**: Use `tools_management/set-permissions.sh` to fix executable permissions
- **Configuration**: Use `tools_management/configure-shell.sh` to set up shell integration
