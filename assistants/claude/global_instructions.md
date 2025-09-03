# Large Codebase Analysis

For large codebases exceeding context limits, use Gemini CLI with massive context window:

## Basic Usage
```bash
gemini -p "@src/ Analyze architecture"           # entire directory
gemini -p "@file.js @other.js Compare these"     # multiple files  
gemini --all_files -p "Project overview"         # all files
```

## Implementation Verification
```bash
gemini -p "@src/ Is dark mode implemented?"
gemini -p "@api/ @middleware/ Is JWT auth implemented?"
gemini -p "@src/ Any SQL injection protections?"
```

## When to Use
- Analyzing entire codebases (>100KB)
- Project-wide pattern searches
- Architecture understanding
- Feature implementation verification
- Context exceeds Claude's limits

**Note**: `@` paths relative to current working directory