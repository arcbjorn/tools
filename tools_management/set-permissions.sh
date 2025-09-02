#!/bin/bash

# Set appropriate permissions for scripts and executables
set -e

TOOLS_DIR="$HOME/tools"

echo "Setting permissions for tools directory..."

# Make scripts executable (755 - owner can read/write/execute, group/others can read/execute)
if [ -d "$TOOLS_DIR/scripts" ]; then
  echo "Setting permissions for scripts/..."
  find "$TOOLS_DIR/scripts" -type f -name "*.sh" -exec chmod 755 {} \;
  find "$TOOLS_DIR/scripts" -type f ! -name "*.sh" -exec chmod 755 {} \;
fi

# Make binaries executable (755)
if [ -d "$TOOLS_DIR/bin" ]; then
  echo "Setting permissions for bin/..."
  find "$TOOLS_DIR/bin" -type f -exec chmod 755 {} \;
fi

# Make build and init scripts executable (755)
chmod 755 "$TOOLS_DIR/build.sh" 2>/dev/null || true
chmod 755 "$TOOLS_DIR/init-tools.sh" 2>/dev/null || true
chmod 755 "$TOOLS_DIR/tools_management/set-permissions.sh" 2>/dev/null || true

# Keep README and other docs readable (644 - owner read/write, group/others read-only)
chmod 644 "$TOOLS_DIR/README.md" 2>/dev/null || true

echo "Permissions set successfully!"
echo "- Scripts and executables: 755 (rwxr-xr-x)"
echo "- Documentation files: 644 (rw-r--r--)"

