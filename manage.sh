#!/bin/bash

# Tools management script
set -e

# Handle Ctrl+C gracefully
trap 'echo -e "\nGoodbye!"; exit 0' INT

echo "Tools Management"
echo "================"
echo ""
echo "Select a tool to run:"
echo "1) Set Permissions"
echo "   Set appropriate permissions for all tools (755 for executables, 644 for docs)"
echo ""
echo "2) Initialize Tools"
echo "   Complete setup: build tools, configure shell, set permissions"
echo ""
echo "3) Build Tools"
echo "   Compile all tools from sources directory"
echo ""
echo "4) Create New Tool"
echo "   Initialize a new tool repository and add as submodule"
echo ""
echo "5) Sync Submodules"
echo "   Update all submodules to latest versions and commit changes"
echo ""
echo "6) Configure Shell"
echo "   Configure shell to source tools configuration"
echo ""
echo "7) View All Tools"
echo "   List both scripts and executables"
echo ""
echo -e "\033[90m(Press q to quit, Ctrl+C to exit)\033[0m"

read -n1 -p "Enter your choice: " choice
echo ""

case $choice in
    1)
        echo ""
        echo "Running set_permissions..."
        ./tools_management/set-permissions.sh
        ;;
    2)
        echo ""
        echo "Running init-tools..."
        ./tools_management/init-tools.sh
        ;;
    3)
        echo ""
        echo "Running build..."
        ./tools_management/build.sh
        ;;
    4)
        echo ""
        echo "Running init-new-tool..."
        ./tools_management/init-new-tool.sh
        ;;
    5)
        echo ""
        echo "Running sync-submodules..."
        ./tools_management/sync-submodules.sh
        ;;
    6)
        echo ""
        echo "Running configure-shell..."
        ./tools_management/configure-shell.sh
        ;;
    7)
        echo ""
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
            echo "  No executables found. Run option 3 to build tools."
        fi
        ;;
    q|Q)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid choice. Please select 1-7 or q."
        exit 1
        ;;
esac