# Claude Code User Configuration

## Project Context Management

**At the start of every session**, check if `.context/CONTEXT.md` exists in the project root. If it does, read it to restore context from previous sessions.

### `.context/CONTEXT.md`

A single file that captures project context for resuming work across sessions (and across different AI tools). This file should be:
- **Gitignored** - it's a working document, not part of the codebase
- **Tool-agnostic** - usable by Claude, Cursor, or other AI assistants
- **Concise** - only what's needed to resume, not a full history

#### What to include:
- **Project context**: Brief overview, key technologies
- **Current focus**: What work is in progress, which branch(es)
- **Key decisions**: Important choices made and why
- **Next steps**: Concrete tasks to pick up

#### When to update:
- After completing significant work
- Before ending a long session
- When the user explicitly asks

#### When NOT to update:
- Short, self-contained tasks
- When changes are fully captured in commits/PRs
- Trivial updates that add noise

### Template

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

## Git Integration

Add to `.gitignore`:
```
.context/
```
