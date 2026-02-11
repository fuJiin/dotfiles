# Read Project Context

Read the project context and recommend next steps:

1. If `.agents/CONTEXT.md` doesn't exist, run `/context-init` first.
2. Read `.agents/CONTEXT.md`.
3. Check live git state:
   - Current branch (`git branch --show-current`)
   - Working tree status (`git status`)
   - Recent history (`git log --oneline -10`)
4. Cross-reference the context file against the actual repo state:
   - Are branches mentioned in the file still active?
   - Have next steps been completed (check commits, merged branches)?
   - Is the current branch consistent with what the context says?
5. Summarize the current status and recommend concrete next steps.
