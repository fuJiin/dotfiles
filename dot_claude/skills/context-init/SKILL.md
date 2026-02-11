# Initialize Project Context

Scaffold a new `.agents/CONTEXT.md` file for the current project:

1. Check if `.agents/CONTEXT.md` already exists. If it does, report that it already exists and stop.
2. Create the `.agents/` directory if it doesn't exist.
3. Check if `.agents/` is listed in `.gitignore`. If not, append it.
4. Create `.agents/CONTEXT.md` from this template, filling in project-specific details based on the repo:

```markdown
# Context: [Project Name]

## Overview
[Brief project description, key technologies]

## Current Work
[What's in progress, which branch(es), current state]

## Key Decisions
[Important choices made during this work and rationale]

## Next Steps
- [ ] Concrete task 1
- [ ] Concrete task 2
```

Populate the template by examining:
- The repo name and any README for the overview
- `git branch`, `git status`, and recent `git log --oneline` for current work
- Leave Key Decisions empty if this is a fresh init
- Derive next steps from current branch state and any open work
