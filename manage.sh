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
echo -e "\033[90m(Press q to quit, Ctrl+C to exit)\033[0m"

read -n1 -p "Enter your choice: " choice
echo ""

case $choice in
    1)
        echo ""
        echo "Running set_permissions..."
        ./tools_management/set_permissions
        ;;
    q|Q)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid choice. Please select 1 or q."
        exit 1
        ;;
esac