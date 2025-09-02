#!/bin/bash

# Sync parent repo with latest submodule versions
set -e

TOOLS_DIR="$HOME/tools"

echo "Syncing submodules with latest versions..."
echo "=========================================="

cd "$TOOLS_DIR"

# Update all submodules to latest
echo "Updating all submodules to latest versions..."
git submodule update --remote

# Check if there are any changes
if git diff --quiet && git diff --cached --quiet; then
    echo "No updates available - all submodules are already at latest versions."
else
    echo ""
    echo "Committing submodule updates..."
    git add .
    git commit -m "chore: update all submodules"
    
    echo ""
    echo "Pushing changes to remote..."
    git push
    
    echo ""
    echo "Submodules synced successfully!"
fi