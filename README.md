# Tools Directory Setup

A clean system for managing personal CLI utilities and scripts.

## Directory Structure

```
~/tools/
├── bin/              # Compiled binaries (auto-generated)
├── scripts/          # Shell scripts (place directly here)
├── sources/          # Git repos/submodules for tools needing compilation
├── assistants/       # AI assistant configuration system
│   ├── common/       # Shared instructions and commands
│   ├── claude/       # Claude-specific configurations
│   ├── codex/        # Codex-specific configurations (uses prompts/)
│   └── gemini/       # Gemini-specific configurations
├── manage.sh         # Interactive management interface
├── tools             # Interactive tool launcher
├── build.sh          # Build script for sources/
├── init.sh           # Initial setup (adds PATH, runs build)
├── init-new-tool     # Create new tool as submodule in sources/
└── set_permissions   # Fix permissions for scripts/executables
```

## Installation

Run the initialization script (only needed once):
```bash
cd ~/tools
./init.sh
```

This will:
- Build all tools from `sources/`
- Add directories to your PATH
- Make scripts executable

## Usage

### Interactive Interfaces
```bash
./manage.sh    # Management interface for core tools
./tools        # Launch any script or executable
```

### AI Assistant Configuration
Configure global settings for Claude, Codex, and Gemini:
```bash
./scripts/configure-assistants-global   # Setup global configurations
./scripts/clean-global-assistants-configs  # Remove all configurations
```

Creates:
- `~/.claude/CLAUDE.md` + `~/.claude/commands/`
- `~/.codex/AGENTS.md` + `~/.codex/prompts/` 
- `~/.gemini/GEMINI.md` + `~/.gemini/commands/`

### Adding Scripts
Place shell scripts directly in `scripts/`:
```bash
cp myscript.sh ~/tools/scripts/
chmod +x ~/tools/scripts/myscript.sh
```

### Adding Compiled Tools

#### Create new tool (recommended):
```bash
cd ~/tools
./init-new-tool
```

#### Add existing remote repo as submodule:
```bash
cd ~/tools
git submodule add https://github.com/user/tool.git sources/tool-name
```

### Building All Tools
```bash
cd ~/tools
./build.sh
```

### Setting Permissions
Fix permissions for all scripts and executables:
```bash
./set_permissions
```

## Development Workflow

### Working on submodules locally
```bash
cd ~/tools/sources/your-tool
# Make changes, commit, push as normal
git add . && git commit -m "fix: some bug" && git push
```

### Using tools locally
```bash
cd ~/tools
./build.sh  # Compile all tools from current local state
```

### Syncing parent repo with latest submodule versions
```bash
cd ~/tools
git submodule update --remote  # Update all submodules to latest
git add . && git commit -m "chore: update all submodules" && git push
```
1 command:
```sh
git submodule update --remote && git add . && git commit -m "chore: update all submodules" && git push
```

## Build Script
The `build.sh` script automatically:
- Detects language (Rust, Go, Zig, etc.)
- Compiles projects in `sources/`
- Places binaries in `bin/`

## Notes
- `scripts/` for direct shell scripts (no build needed)
- `sources/` for projects requiring compilation
- `bin/` is auto-generated, don't manually place files there
- Develop in submodules independently, sync parent repo when needed
