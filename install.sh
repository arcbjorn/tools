#!/bin/bash

# Tools directory installer
set -e

TOOLS_DIR="$HOME/.tools"
BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"

echo "Setting up tools directory..."

# Create directory structure
mkdir -p "$TOOLS_DIR"/{bin,scripts,sources}

# Detect shell and add PATH export
SHELL_RC=""
if [ -f "$ZSHRC" ] && [ "$SHELL" = "/bin/zsh" ]; then
    SHELL_RC="$ZSHRC"
elif [ -f "$BASHRC" ]; then
    SHELL_RC="$BASHRC"
else
    echo "Warning: Could not detect shell config file"
    exit 1
fi

# Check if already added
if ! grep -q "/.tools/bin" "$SHELL_RC"; then
    echo "" >> "$SHELL_RC"
    echo "# Tools directory" >> "$SHELL_RC"
    echo 'export PATH="$HOME/.tools/bin:$HOME/.tools/scripts:$PATH"' >> "$SHELL_RC"
    echo "Added PATH export to $SHELL_RC"
else
    echo "PATH already configured in $SHELL_RC"
fi

# Make scripts executable
chmod +x "$TOOLS_DIR/scripts"/* 2>/dev/null || true

echo "Setup complete!"
echo "Run 'source $SHELL_RC' or restart your terminal to use tools."
echo ""
echo "Usage:"
echo "  - Place scripts in ~/.tools/scripts/"
echo "  - Add git submodules in ~/.tools/sources/"
echo "  - Run './build.sh' to compile sources/"