# OpenCode-specific instructions

## Command Format
OpenCode commands use Markdown files with YAML frontmatter:

```yaml
---
description: Brief explanation of what this command does
agent: agent-name (optional)
model: model-identifier (optional)
---
Your prompt content here with $ARGUMENTS placeholder
```

## Command Features
- **Arguments**: Use `$ARGUMENTS` placeholder for dynamic values
- **Shell output**: Inject bash commands with `!`command`` syntax
- **File references**: Include files using `@filename` notation

## Directory Structure
- Global commands: `~/.config/opencode/command/`
- Project commands: `.opencode/command/`
- Config file: `~/.config/opencode/opencode.json` or `opencode.jsonc`
