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

## Linear Cross-Reference

If Linear MCP tools are available and a **Linear Project** is mapped in the `## Integrations` section:

1. Fetch active issues from the mapped Linear project (in progress, todo, backlog).
2. Cross-reference Linear issues against the Next Steps in the context file:
   - Flag items in the context file that have been completed in Linear but not locally.
   - Flag Linear issues that aren't reflected in the context file.
3. Include relevant Linear context in your summary (e.g., issue priorities, assignees, cycle deadlines).
