# Clean Project Context

Make `.agents/CONTEXT.md` more succinct by removing stale content:

1. Read `.agents/CONTEXT.md`. If it doesn't exist, report that and stop.
2. Check git state for reference (`git branch -a`, `git log --oneline -20`).
3. **Auto-remove without asking:**
   - Completed checkboxes (`- [x] ...`)
   - References to branches that have been merged or deleted
   - Resolved status entries or outdated state descriptions
   - Work items fully captured in merged commits/PRs
4. **Ask the user** about uncertain removals — sections that might still be relevant but look potentially stale.
5. **Tighten prose:**
   - Collapse completed work into brief summary lines (e.g., "Implemented X in PR #123")
   - Shorten verbose descriptions while preserving meaning
6. **Always preserve:**
   - Active work in progress
   - Pending next steps
   - Key decisions that are still relevant to ongoing work
