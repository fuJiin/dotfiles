# Update Project Context

Update `.agents/CONTEXT.md` to reflect the current session state:

1. If `.agents/CONTEXT.md` doesn't exist, run `/context-init` first.
2. Read the existing `.agents/CONTEXT.md`.
3. Check git state to understand what changed:
   - Current branch (`git branch --show-current`)
   - Working tree status (`git status`)
   - Recent commits (`git log --oneline -10`)
4. Update the context file to reflect:
   - Current work in progress (branch, uncommitted changes, open PRs)
   - Key decisions made during this session
   - Next steps to pick up in a future session
5. After updating the file, run `/context-clean` to keep it succinct.

## Linear Sync

After updating the context file, check if **both** conditions are met:
- Linear MCP tools are available (tools with names starting with `mcp__linear` or `linear`)
- The `## Integrations` section has a **Linear Project** set to something other than "none"

If both are true, sync the context to Linear:

1. **Search for existing issues** in the mapped Linear project that were created by previous context syncs (search for issues with titles matching the next-step items).
2. **Create issues** for any new `- [ ]` items in the Next Steps section that don't already have a matching Linear issue. Use concise titles derived from the checklist text.
3. **Close/complete issues** for any items that were previously `- [ ]` but are now `- [x]` or have been removed (i.e., the work is done based on git history).
4. **Add Linear issue identifiers** back into the context file next to each synced item, e.g.:
   ```
   - [ ] Implement caching layer (ENG-123)
   - [ ] Write migration script (ENG-124)
   ```
5. Report what was synced (created, closed, unchanged).
