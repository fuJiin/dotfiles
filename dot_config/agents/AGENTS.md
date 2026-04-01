# AI Agent Configuration

## Project Context Management

**At the start of every session**, check if `.agents/CONTEXT.md` exists in the project root. If it does, read it to restore context from previous sessions.

### `.agents/CONTEXT.md`

A single file that captures project context for resuming work across sessions (and across different AI tools). This file should be:
- **Tool-agnostic** - usable by Claude, Cursor, or other AI assistants
- **Concise** - only what's needed to resume, not a full history

#### What to include:
- **Project context**: Brief overview, key technologies
- **Current focus**: What work is in progress on which branch(es)
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

## Shared Skills

Cross-agent skills live in `~/.agents/skills/` using the Open Agent Skills standard (`SKILL.md` format). Codex and Gemini discover this path natively. Claude Code accesses them via symlinks from `~/.claude/skills/`.

**Available shared skills:**
- `review-code` — Structural review, test/CI gaps, performance, observability
- `review-research` — Research progress audit, literature review, principles assessment, bibliography

**Invocation by agent:**
| Agent | Syntax |
|-------|--------|
| Claude Code | `/review-code`, `/review-research` |
| Codex CLI | `$review-code`, `$review-research` |
| Gemini CLI | `/skills run review-code`, `/skills run review-research` |

Skills are composable: each references related skills and can optionally dispatch to other installed agents for independent verification.

## Claude Code Skills

When creating or modifying Claude Code customizations (slash commands, skills, etc.):

- **Always use skills** (`~/.claude/skills/<name>/SKILL.md`), never commands (`~/.claude/commands/`). Skills support auto-invocation, frontmatter, and supporting files.
- **Always manage through chezmoi.** Cross-agent skills go in `dot_agents/skills/`, Claude-only skills go in `dot_claude/skills/`. Run `chezmoi apply` after changes. Never edit skills directly in `~/.claude/skills/` or `~/.agents/skills/`.
