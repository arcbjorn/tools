#!/bin/bash

# Build script for compiling tools from sources/
set -e

TOOLS_DIR="$HOME/tools"

echo "Building tools from sources..."

mkdir -p "$TOOLS_DIR/bin"
cd "$TOOLS_DIR/sources"

for dir in */; do
    [ -d "$dir" ] || continue
    
    echo "Processing $dir..."
    cd "$dir"
    
    # Detect language and build
    if [[ -f Cargo.toml ]]; then
        echo "  Building Rust project..."
        cargo build --release
        find target/release -maxdepth 1 -type f -executable ! -name ".*" -exec cp {} "$TOOLS_DIR/bin/" \;
    elif [[ -f go.mod ]]; then
        echo "  Building Go project..."
        go build -o "$TOOLS_DIR/bin/"
    elif [[ -f build.zig ]]; then
        echo "  Building Zig project..."
        zig build --prefix "$TOOLS_DIR/"
    elif [[ -f Makefile ]]; then
        echo "  Running make..."
        make
        # Copy executables to bin (you may need to adjust this based on your Makefiles)
        find . -maxdepth 1 -type f -executable ! -name ".*" ! -name "Makefile" -exec cp {} "$TOOLS_DIR/bin/" \;
    else
        echo "  No known build system found, skipping..."
    fi
    
    cd ..
done

echo "Making binaries executable..."
chmod +x "$TOOLS_DIR/bin"/* 2>/dev/null || true

echo "Build complete!"