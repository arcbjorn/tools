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
        # Check if there's a cmd/ directory structure
        if [[ -d "cmd" ]]; then
            # Build each command in cmd/
            for cmd_dir in cmd/*/; do
                if [[ -d "$cmd_dir" ]]; then
                    cmd_name=$(basename "$cmd_dir")
                    echo "    Building $cmd_name..."
                    go build -o "$TOOLS_DIR/bin/" "./$cmd_dir"
                fi
            done
        else
            # Standard Go build from root
            go build -o "$TOOLS_DIR/bin/"
        fi
    elif [[ -f build.zig ]]; then
        echo "  Building Zig project..."
        zig build --prefix "$TOOLS_DIR/"
    elif [[ -f bun.lock || -f bunfig.toml ]]; then
        if command -v bun >/dev/null 2>&1; then
            echo "  Building Bun project..."
            # Determine entry point
            ENTRY=""
            if [[ -f cli.ts ]]; then
                ENTRY="cli.ts"
            elif [[ -f index.ts ]]; then
                ENTRY="index.ts"
            elif [[ -f src/index.ts ]]; then
                ENTRY="src/index.ts"
            else
                # Try to infer from package.json's module/main fields
                if [[ -f package.json ]]; then
                    if grep -q '"module"\s*:\s*"cli.ts"' package.json; then
                        ENTRY="cli.ts"
                    elif grep -q '"module"\s*:\s*"index.ts"' package.json; then
                        ENTRY="index.ts"
                    elif grep -q '"main"\s*:\s*"cli.ts"' package.json; then
                        ENTRY="cli.ts"
                    elif grep -q '"main"\s*:\s*"index.ts"' package.json; then
                        ENTRY="index.ts"
                    fi
                fi
            fi
            if [[ -n "$ENTRY" ]]; then
                OUT_NAME="$(basename "$(pwd)")"
                OUT_PATH="$TOOLS_DIR/bin/$OUT_NAME"
                bun build --compile "$ENTRY" --outfile "$OUT_PATH"
            else
                echo "  Could not determine Bun entrypoint (cli.ts, index.ts or src/index.ts). Skipping..."
            fi
        else
            echo "  Bun is not installed; skipping Bun build."
        fi
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
