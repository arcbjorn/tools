#!/bin/bash

# Tools management script
set -e

# Handle Ctrl+C gracefully
trap 'echo -e "\nGoodbye!"; exit 0' INT

# Check if gum is installed
if ! command -v gum &> /dev/null; then
    echo "Error: 'gum' is not installed."
    echo "Please install gum first:"
    echo "  • On macOS: brew install gum"
    echo "  • On Ubuntu/Debian: sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && echo 'deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *' | sudo tee /etc/apt/sources.list.d/charm.list && sudo apt update && sudo apt install gum"
    echo "  • On Arch: pacman -S gum"
    echo "  • Or download from: https://github.com/charmbracelet/gum"
    exit 1
fi

# Menu options
MENU_OPTIONS=(
    "Set Permissions"
    "Initialize Tools"  
    "Build Tools"
    "Create New Tool"
    "Sync Submodules"
    "Configure Shell"
    "View All Tools"
)

# Show menu and get selection
echo "Tools Management"
echo "================"
echo ""

choice=$(gum choose \
    --header "Select a tool to run:" \
    --cursor-prefix "→ " \
    --selected-prefix "✓ " \
    --unselected-prefix "  " \
    "${MENU_OPTIONS[@]}")

# Handle empty selection (user pressed Ctrl+C or ESC)
if [ -z "$choice" ]; then
    echo "Goodbye!"
    exit 0
fi

echo ""

case $choice in
    "Set Permissions")
        echo "Running set_permissions..."
        ./tools_management/set-permissions.sh
        ;;
    "Initialize Tools")
        echo "Running init-tools..."
        ./tools_management/init-tools.sh
        ;;
    "Build Tools")
        echo "Running build..."
        ./tools_management/build.sh
        ;;
    "Create New Tool")
        echo "Running init-new-tool..."
        ./tools_management/init-new-tool.sh
        ;;
    "Sync Submodules")
        echo "Running sync-submodules..."
        ./tools_management/sync-submodules.sh
        ;;
    "Configure Shell")
        echo "Running configure-shell..."
        ./tools_management/configure-shell.sh
        ;;
    "View All Tools")
        echo "All Available Tools:"
        echo "==================="
        echo ""
        echo "Scripts (scripts/):"
        if [ -d "scripts" ] && [ "$(ls -A scripts 2>/dev/null)" ]; then
            ls -la scripts/ | grep -v "^total" | tail -n +2 | while read -r line; do
                filename=$(echo "$line" | awk '{print $9}')
                if [ "$filename" != "." ] && [ "$filename" != ".." ]; then
                    echo "  $filename"
                fi
            done
        else
            echo "  No scripts found."
        fi
        echo ""
        echo "Executables (bin/):"
        if [ -d "bin" ] && [ "$(ls -A bin 2>/dev/null)" ]; then
            ls -la bin/ | grep -v "^total" | tail -n +2 | while read -r line; do
                filename=$(echo "$line" | awk '{print $9}')
                if [ "$filename" != "." ] && [ "$filename" != ".." ]; then
                    echo "  $filename"
                fi
            done
        else
            echo "  No executables found. Run Build Tools to compile them."
        fi
        ;;
esac