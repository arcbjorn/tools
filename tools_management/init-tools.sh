#!/bin/bash

# Initial setup for tools directory
set -e

TOOLS_DIR="$HOME/tools"

echo "Initializing tools directory..."

# Run build script to compile everything
echo "Building tools from sources..."
"$TOOLS_DIR/tools_management/build.sh"

# Configure shell to source tools configuration
echo "Configuring shell..."
"$TOOLS_DIR/tools_management/configure-shell.sh"

# Set all permissions
echo "Setting permissions..."
"$TOOLS_DIR/tools_management/set-permissions.sh"

echo "Initialization complete!"
echo "Run 'source ~/.bashrc' or 'source ~/.zshrc' or restart your terminal to use tools."