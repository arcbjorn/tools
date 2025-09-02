#!/bin/bash

# Create a new tool as a submodule in sources/
set -e

TOOLS_DIR="$HOME/tools"

echo "Initialize New Tool in sources/"
echo "=============================="

# Change to sources directory
cd "$TOOLS_DIR/sources"

# Run init-new-repo and capture the remote URL
echo "Creating new repository..."
REPO_OUTPUT=$(init-new-repo)
echo "$REPO_OUTPUT"

# Extract remote URL from output and get directory name from the last created directory
REMOTE_URL=$(echo "$REPO_OUTPUT" | grep "Remote:" | sed 's/Remote: //')
LOCAL_DIR=$(ls -t | head -1)

# Go back to tools root
cd "$TOOLS_DIR"

echo ""
echo "Adding as submodule..."
git submodule add "$REMOTE_URL.git" "sources/$LOCAL_DIR"

echo ""
echo "Committing submodule addition..."
git add .gitmodules "sources/$LOCAL_DIR"
git commit -m "feat: add $LOCAL_DIR submodule"

echo ""
echo "Tool created and added as submodule!"
echo "Run manage.sh option 3 to compile the tool."