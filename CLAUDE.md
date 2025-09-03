COMMIT INSTRUCTIONS: use conventional commits guidelines, 1 GRANULAR COMMIT PER 1 GOAL, MESSAGE 50 CHARACTERS MAX

# Tools Directory Structure
This is a tools management system with the following structure:

## Core Components
- `manage.sh` - Main interface using gum for navigation (requires gum: `pacman -S gum`)
- `shell/` - Shell configuration files
  - `shell/rc` - Main shell config (sourced by .bashrc/.zshrc)  
  - `shell/shortcuts` - Custom aliases and shortcuts
- `tools_management/` - Management scripts
  - `set-permissions.sh` - Set file permissions
  - `init-tools.sh` - Complete setup (build, configure, permissions)
  - `build.sh` - Build tools from sources/
  - `configure-shell.sh` - Configure shell to source tools
  - `sync-submodules.sh` - Update all submodules
  - `init-new-tool.sh` - Create new tool repository
- `scripts/` - Utility scripts (in PATH)
- `bin/` - Compiled executables (in PATH)  
- `sources/` - Source code as git submodules
- `assistants/` - AI assistant configuration system
  - `common/` - Shared instructions and commands for all assistants
  - `claude/`, `codex/`, `gemini/` - Assistant-specific configurations

## Usage
1. Run `./manage.sh` for interactive menu
2. Use arrow keys to navigate, Enter to select
3. All tools automatically added to PATH via shell/rc

## Commands to Remember
- `./manage.sh` - Main interface
- `tools` - Interactive launcher for all scripts and executables
- Option 2: Initialize Tools - Complete setup for new systems
- Option 7: View All Tools - See available scripts and executables

## Assistant Configuration
- `configure-assistants-global` - Setup global assistant settings and commands
- `clean-global-assistants-configs` - Remove all assistant configuration files
- Creates modular system with shared and assistant-specific instructions
- Copies command templates to appropriate directories (Claude: commands/, Codex: prompts/, Gemini: commands/)

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
