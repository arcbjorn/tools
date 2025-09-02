#!/bin/bash

# Tools Management Script - Interactive interface for managing development tools
set -euo pipefail

# Constants
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TOOLS_MGMT_DIR="$SCRIPT_DIR/tools_management"

# Theme-aware colors using terminal palette slots
readonly RED='\033[38;5;1m'
readonly GREEN='\033[38;5;2m'
readonly YELLOW='\033[38;5;3m'
readonly BLUE='\033[38;5;4m'
readonly MAGENTA='\033[38;5;5m'
readonly CYAN='\033[38;5;6m'
readonly WHITE='\033[38;5;7m'
readonly NC='\033[0m'

# Menu configuration
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
    ["init-tools"]="Complete setup (build, configure, temp file, permissions)"
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

# Logging functions
log_info() { echo -e "${BLUE}ℹ${NC} $1"; }
log_success() { echo -e "${GREEN}✓${NC} $1"; }
log_error() { echo -e "${RED}✗${NC} $1" >&2; }
log_warning() { echo -e "${YELLOW}⚠${NC} $1"; }

# Exit handler
cleanup_and_exit() {
    echo -e "\n${YELLOW}Goodbye!${NC}"
    exit 0
}

# Check dependencies
check_dependencies() {
    if ! command -v gum &> /dev/null; then
        log_error "'gum' is not installed."
        echo "Please install gum first:"
        echo "  • On macOS: ${CYAN}brew install gum${NC}"
        echo "  • On Ubuntu/Debian: ${CYAN}sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && echo 'deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *' | sudo tee /etc/apt/sources.list.d/charm.list && sudo apt update && sudo apt install gum${NC}"
        echo "  • On Arch: ${CYAN}pacman -S gum${NC}"
        echo "  • Or download from: https://github.com/charmbracelet/gum"
        exit 1
    fi
}

# Validate environment
validate_environment() {
    if [[ ! -d "$TOOLS_MGMT_DIR" ]]; then
        log_error "Tools management directory not found: $TOOLS_MGMT_DIR"
        exit 1
    fi
}

# Build menu options
build_menu_options() {
    local -a options=()
    for key in "${!MENU_ITEMS[@]}"; do
        options+=("${MENU_ITEMS[$key]} - ${MENU_DESCRIPTIONS[$key]}")
    done
    printf '%s\n' "${options[@]}" | sort
}

# Extract key from menu choice
extract_key_from_choice() {
    local choice="$1"
    for key in "${!MENU_ITEMS[@]}"; do
        if [[ "$choice" == "${MENU_ITEMS[$key]} - ${MENU_DESCRIPTIONS[$key]}" ]]; then
            echo "$key"
            return 0
        fi
    done
    return 1
}

# Execute script
execute_script() {
    local key="$1"
    local script="${MENU_SCRIPTS[$key]}"
    local script_path="$TOOLS_MGMT_DIR/$script"
    
    [[ ! -f "$script_path" ]] && { log_error "Script not found: $script_path"; return 1; }
    
    if [[ ! -x "$script_path" ]]; then
        log_warning "Script not executable, attempting to fix permissions..."
        chmod +x "$script_path" || { log_error "Failed to make script executable"; return 1; }
    fi
    
    log_info "Running $script..."
    "$script_path"
}

# List available tools
list_tools() {
    echo -e "${MAGENTA}All Available Tools:${NC}"
    echo "==================="
    echo ""
    
    echo -e "${GREEN}Scripts (scripts/):${NC}"
    if [[ -d "scripts" && -n "$(ls -A scripts 2>/dev/null)" ]]; then
        find scripts -type f -executable -printf "  ${CYAN}%f${NC}\n" 2>/dev/null | sort || {
            ls -1 scripts/ 2>/dev/null | while IFS= read -r file; do
                [[ -x "scripts/$file" ]] && echo -e "  ${CYAN}$file${NC}"
            done | sort
        }
    else
        echo -e "  ${WHITE}No scripts found.${NC}"
    fi
    
    echo ""
    
    echo -e "${GREEN}Executables (bin/):${NC}"
    if [[ -d "bin" && -n "$(ls -A bin 2>/dev/null)" ]]; then
        find bin -type f -executable -printf "  ${CYAN}%f${NC}\n" 2>/dev/null | sort || {
            ls -1 bin/ 2>/dev/null | while IFS= read -r file; do
                [[ -x "bin/$file" ]] && echo -e "  ${CYAN}$file${NC}"
            done | sort
        }
    else
        echo -e "  ${WHITE}No executables found. Run Build Tools to compile them.${NC}"
    fi
}

# Display header
show_header() {
    echo -e "${YELLOW}Tools Management${NC}"
    echo -e "${WHITE}================${NC}"
    echo ""
}

# Main menu
show_menu() {
    local choice key
    mapfile -t menu_options < <(build_menu_options)
    
    choice=$(gum choose \
        --header "Select a tool to run:" \
        --cursor-prefix "→ " \
        --selected-prefix "✓ " \
        --unselected-prefix "  " \
        --cursor.foreground="3" \
        --header.foreground="5" \
        --item.foreground="7" \
        --selected.foreground="2" \
        "${menu_options[@]}")
    
    [[ -z "$choice" ]] && cleanup_and_exit
    
    echo ""
    
    if key=$(extract_key_from_choice "$choice"); then
        [[ "$key" == "view-tools" ]] && list_tools || execute_script "$key"
    else
        log_error "Unknown menu choice: $choice"
        return 1
    fi
}

# Main function
main() {
    trap cleanup_and_exit INT TERM
    
    check_dependencies
    validate_environment
    
    show_header
    show_menu
}

# Execute main function if script is run directly
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"