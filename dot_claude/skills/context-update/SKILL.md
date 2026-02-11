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
