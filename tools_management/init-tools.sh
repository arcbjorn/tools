#!/bin/bash

# Initial setup for tools directory
set -e

TOOLS_DIR="$HOME/tools"

echo "Initializing tools directory..."

# Run build script to compile everything
echo "Building tools from sources..."
"$TOOLS_DIR/tools_management/build.sh"

# Create shell/temp file for functions with secrets if it doesn't exist
if [ ! -f "$TOOLS_DIR/shell/temp" ]; then
    echo "Creating shell/temp for functions with secrets..."
    cat > "$TOOLS_DIR/shell/temp" << 'EOF'
# Temporary shell commands with secrets
# This file contains functions that include secrets, tokens, or sensitive data
# Add functions like glm() here that need authentication or contain secrets
# 
# Example:
# glm() {
#     ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic ANTHROPIC_AUTH_TOKEN=your_token claude "$@"
# }
EOF
fi

# Configure shell to source tools configuration
echo "Configuring shell..."
"$TOOLS_DIR/tools_management/configure-shell.sh"

# Set all permissions
echo "Setting permissions..."
"$TOOLS_DIR/tools_management/set-permissions.sh"

echo "Initialization complete!"
echo "Run 'source ~/.bashrc' or 'source ~/.zshrc' or restart your terminal to use tools."