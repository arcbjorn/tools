#!/bin/bash

# Configure shell to source tools/shell/rc
set -e

TOOLS_DIR="$HOME/tools"
BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"

echo "Configuring shell to load tools..."

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
SOURCE_LINE="[ -f \"\$HOME/tools/shell/rc\" ] && source \"\$HOME/tools/shell/rc\""
if ! grep -qF "$SOURCE_LINE" "$SHELL_RC"; then
    echo "" >> "$SHELL_RC"
    echo "# Tools directory" >> "$SHELL_RC"
    echo "$SOURCE_LINE" >> "$SHELL_RC"
    echo "Added tools configuration sourcing to $SHELL_RC"
else
    echo "Tools configuration already configured in $SHELL_RC"
fi

echo "Shell configuration complete!"