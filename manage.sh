#!/bin/bash

# Tools Management Script
# Provides an interactive interface for managing development tools
set -euo pipefail

# Constants
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TOOLS_MGMT_DIR="$SCRIPT_DIR/tools_management"

# Gruvbox colors for output
readonly GRV_BG='\033[48;2;40;40;40m'     # Dark background
readonly GRV_FG='\033[38;2;235;219;178m'  # Light foreground
readonly GRV_RED='\033[38;2;251;73;52m'   # Bright red
readonly GRV_GREEN='\033[38;2;184;187;38m' # Bright green
readonly GRV_YELLOW='\033[38;2;250;189;47m' # Bright yellow
readonly GRV_BLUE='\033[38;2;131;165;152m' # Bright blue
readonly GRV_PURPLE='\033[38;2;211;134;155m' # Bright purple
readonly GRV_AQUA='\033[38;2;142;192;124m' # Bright aqua
readonly GRV_ORANGE='\033[38;2;254;128;25m' # Bright orange
readonly GRV_GRAY='\033[38;2;168;153;132m' # Gray
readonly NC='\033[0m' # No Color

# Menu configuration - associative arrays for better maintainability
declare -A MENU_ITEMS=(
    ["set-permissions"]="Set Permissions"
    ["init-tools"]="Initialize Tools"
    ["build-tools"]="Build Tools"
    ["create-tool"]="Create New Tool"
    ["sync-submodules"]="Sync Submodules"
    ["configure-shell"]="Configure Shell"
    ["view-tools"]="View All Tools"
)

declare -A MENU_DESCRIPTIONS=(
    ["set-permissions"]="Make scripts and binaries executable"
    ["init-tools"]="Complete setup (build, configure, permissions)"
    ["build-tools"]="Compile tools from sources/ directory"
    ["create-tool"]="Initialize new tool repository as submodule"
    ["sync-submodules"]="Update all submodules to latest versions"
    ["configure-shell"]="Setup shell to source tools configuration"
    ["view-tools"]="List available scripts and executables"
)

declare -A MENU_SCRIPTS=(
    ["set-permissions"]="set-permissions.sh"
    ["init-tools"]="init-tools.sh"
    ["build-tools"]="build.sh"
    ["create-tool"]="init-new-tool.sh"
    ["sync-submodules"]="sync-submodules.sh"
    ["configure-shell"]="configure-shell.sh"
)

# Utility functions
log_info() {
    echo -e "${GRV_BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GRV_GREEN}✓${NC} $1"
}

log_error() {
    echo -e "${GRV_RED}✗${NC} $1" >&2
}

log_warning() {
    echo -e "${GRV_YELLOW}⚠${NC} $1"
}

# Graceful exit handler
cleanup_and_exit() {
    echo -e "\n${GRV_ORANGE}Goodbye!${NC}"
    exit 0
}

# Check dependencies
check_dependencies() {
    if ! command -v gum &> /dev/null; then
        log_error "'gum' is not installed."
        echo "Please install gum first:"
        echo "  • On macOS: ${GRV_AQUA}brew install gum${NC}"
        echo "  • On Ubuntu/Debian: ${GRV_AQUA}sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && echo 'deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *' | sudo tee /etc/apt/sources.list.d/charm.list && sudo apt update && sudo apt install gum${NC}"
        echo "  • On Arch: ${GRV_AQUA}pacman -S gum${NC}"
        echo "  • Or download from: https://github.com/charmbracelet/gum"
        exit 1
    fi
}

# Validate tools management directory
validate_environment() {
    if [[ ! -d "$TOOLS_MGMT_DIR" ]]; then
        log_error "Tools management directory not found: $TOOLS_MGMT_DIR"
        exit 1
    fi
}

# Build menu options array for gum
build_menu_options() {
    local -a options=()
    local key
    
    for key in "${!MENU_ITEMS[@]}"; do
        options+=("${MENU_ITEMS[$key]} - ${MENU_DESCRIPTIONS[$key]}")
    done
    
    printf '%s\n' "${options[@]}" | sort
}

# Extract key from menu choice
extract_key_from_choice() {
    local choice="$1"
    local key
    
    for key in "${!MENU_ITEMS[@]}"; do
        if [[ "$choice" == "${MENU_ITEMS[$key]} - ${MENU_DESCRIPTIONS[$key]}" ]]; then
            echo "$key"
            return 0
        fi
    done
    
    return 1
}

# Execute script for given key
execute_script() {
    local key="$1"
    local script="${MENU_SCRIPTS[$key]}"
    local script_path="$TOOLS_MGMT_DIR/$script"
    
    if [[ ! -f "$script_path" ]]; then
        log_error "Script not found: $script_path"
        return 1
    fi
    
    if [[ ! -x "$script_path" ]]; then
        log_warning "Script not executable, attempting to fix permissions..."
        chmod +x "$script_path" || {
            log_error "Failed to make script executable"
            return 1
        }
    fi
    
    log_info "Running $script..."
    "$script_path"
}

# List available tools
list_tools() {
    echo -e "${GRV_PURPLE}All Available Tools:${NC}"
    echo "==================="
    echo ""
    
    # List scripts
    echo -e "${GRV_GREEN}Scripts (scripts/):${NC}"
    if [[ -d "scripts" ]] && [[ -n "$(ls -A scripts 2>/dev/null)" ]]; then
        find scripts -type f -executable -printf "  ${GRV_AQUA}%f${NC}\n" 2>/dev/null | sort || {
            # Fallback for systems without -printf
            ls -1 scripts/ 2>/dev/null | while IFS= read -r file; do
                if [[ -x "scripts/$file" ]]; then
                    echo -e "  ${GRV_AQUA}$file${NC}"
                fi
            done | sort
        }
    else
        echo -e "  ${GRV_GRAY}No scripts found.${NC}"
    fi
    
    echo ""
    
    # List executables
    echo -e "${GRV_GREEN}Executables (bin/):${NC}"
    if [[ -d "bin" ]] && [[ -n "$(ls -A bin 2>/dev/null)" ]]; then
        find bin -type f -executable -printf "  ${GRV_AQUA}%f${NC}\n" 2>/dev/null | sort || {
            # Fallback for systems without -printf
            ls -1 bin/ 2>/dev/null | while IFS= read -r file; do
                if [[ -x "bin/$file" ]]; then
                    echo -e "  ${GRV_AQUA}$file${NC}"
                fi
            done | sort
        }
    else
        echo -e "  ${GRV_GRAY}No executables found. Run Build Tools to compile them.${NC}"
    fi
}

# Display header
show_header() {
    echo -e "${GRV_ORANGE}Tools Management${NC}"
    echo -e "${GRV_GRAY}================${NC}"
    echo ""
}

# Main menu display and selection
show_menu() {
    local choice
    local key
    
    mapfile -t menu_options < <(build_menu_options)
    
    choice=$(gum choose \
        --header "Select a tool to run:" \
        --cursor-prefix "→ " \
        --selected-prefix "✓ " \
        --unselected-prefix "  " \
        --cursor.foreground="#fe8019" \
        --header.foreground="#d3869b" \
        --item.foreground="#ebdbb2" \
        --selected.foreground="#b8bb26" \
        "${menu_options[@]}")
    
    # Handle empty selection
    if [[ -z "$choice" ]]; then
        cleanup_and_exit
    fi
    
    echo ""
    
    # Extract key and execute corresponding action
    if key=$(extract_key_from_choice "$choice"); then
        if [[ "$key" == "view-tools" ]]; then
            list_tools
        else
            execute_script "$key"
        fi
    else
        log_error "Unknown menu choice: $choice"
        return 1
    fi
}

# Main function
main() {
    # Set up signal handlers
    trap cleanup_and_exit INT TERM
    
    # Validate environment and dependencies
    check_dependencies
    validate_environment
    
    # Show interface
    show_header
    show_menu
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi