# Version Tag and Push

Create and push a new version tag by incrementing the current version by 0.0.1.

## Process
1. **Detect version file**: Search for version files in common locations
2. **Extract current version**: Parse the version number (format: X.Y.Z)
3. **Increment patch version**: Add 0.0.1 to patch (e.g., 1.2.3 → 1.2.4)
4. **Update version file**: Write new version back to file
5. **Commit changes**: Use conventional commits format and push
6. **Detect tag format**: Check existing tags with `git tag -l` to match format
7. **Create git tag**: Use same format as existing tags (e.g., `v0.0.1` or `marketing v0.0.1`)
8. **Push tag**: Run `git push origin <tag>`

## Version File Detection (check in order)

### JavaScript/TypeScript
- `package.json`: `"version": "X.Y.Z"`
- `lerna.json`: `"version": "X.Y.Z"`
- `bower.json`: `"version": "X.Y.Z"`

### Rust
- `Cargo.toml`: `version = "X.Y.Z"` under `[package]`

### Go
- `go.mod`: `module example.com/project/vX` (major version in path)
- `version.go`: `const Version = "X.Y.Z"`
- `VERSION`: Plain text file

### Python
- `pyproject.toml`: `version = "X.Y.Z"` under `[project]` or `[tool.poetry]`
- `setup.py`: `version="X.Y.Z"` in setup()
- `__init__.py`: `__version__ = "X.Y.Z"`
- `VERSION`: Plain text file

### Ruby
- `*.gemspec`: `spec.version = "X.Y.Z"`
- `lib/<gem>/version.rb`: `VERSION = "X.Y.Z"`
- `VERSION`: Plain text file

### PHP
- `composer.json`: `"version": "X.Y.Z"`

### Java/Kotlin
- `pom.xml`: `<version>X.Y.Z</version>` under `<project>`
- `build.gradle`: `version = "X.Y.Z"`
- `build.gradle.kts`: `version = "X.Y.Z"`

### C#/.NET
- `*.csproj`: `<Version>X.Y.Z</Version>`
- `AssemblyInfo.cs`: `[assembly: AssemblyVersion("X.Y.Z")]`

### C/C++
- `CMakeLists.txt`: `project(name VERSION X.Y.Z)`
- `configure.ac`: `AC_INIT([name], [X.Y.Z])`
- `VERSION`: Plain text file

### Zig
- `build.zig`: `.version = "X.Y.Z"` in `std.SemanticVersion`

### Elixir
- `mix.exs`: `version: "X.Y.Z"` in project()

### Dart/Flutter
- `pubspec.yaml`: `version: X.Y.Z`

### Swift
- `Package.swift`: version in Package()
- `*.podspec`: `s.version = "X.Y.Z"`

### Generic
- `VERSION`: Plain text file with `X.Y.Z`
- `version.txt`: Plain text file with `X.Y.Z`

## Git Tag Format Detection
1. Run `git tag -l` to list existing tags
2. Identify pattern (examples):
   - `v0.0.1`, `v0.0.2` → use `vX.Y.Z`
   - `marketing v0.0.1` → use `marketing vX.Y.Z`
   - `0.0.1`, `0.0.2` → use `X.Y.Z`
   - `release-0.0.1` → use `release-X.Y.Z`
3. If no tags exist, use `vX.Y.Z` as default

## Commit and Push Flow
1. **Stage changes**: `git add <version_file>`
2. **Commit**: `git commit -m "chore(version): bump to X.Y.Z"`
3. **Push commits**: `git push`
4. **Create tag**: `git tag <format> vX.Y.Z`
5. **Push tag**: `git push origin <tag>`

## Example
```
Current: 0.0.5 (from package.json)
New: 0.0.6
Existing tags: marketing v0.0.1, marketing v0.0.5
Update package.json
git add package.json
git commit -m "chore(version): bump to 0.0.6"
git push
git tag "marketing v0.0.6"
git push origin "marketing v0.0.6"
```

TAG AND PUSH A NEW VERSION NOW following these exact steps.