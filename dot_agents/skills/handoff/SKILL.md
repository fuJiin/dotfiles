---
name: handoff
description: Write or resume a short-lived handoff note (.agents/HANDOFF.md) for passing in-flight work to a later session or a different agent. Use only when the user explicitly asks to hand off, pause, or resume work.
argument-hint: "[resume]"
---

# Handoff

A handoff note is a baton, not a journal. It exists only between "I'm stopping here" and "I've picked this back up", then it is deleted. Durable knowledge never lives in it.

## Write (default)

1. Gather live state: `git branch --show-current`, `git status --short`, `git log --oneline -10`, and open PRs (`gh pr list --author @me`) if available.
2. Route anything durable to its real home first, and tell the user what you moved:
   - Project conventions, architecture, gotchas → the repo's committed `AGENTS.md` (propose the edit; don't commit without asking).
   - Tasks that outlive this pause → Linear (if Linear MCP tools are available) or the PR description.
3. Write `.agents/HANDOFF.md` with only what can't be recovered from git, the PR, or the tracker:

   ```markdown
   # Handoff — <branch> — <YYYY-MM-DD>

   ## State
   <what's done, what's half-done, uncommitted changes and why>

   ## Open questions / decisions in flight
   <anything undecided, with the options considered>

   ## Next
   1. <the very next concrete action>
   ```

   Keep it under ~30 lines. Overwrite any existing note — there is only ever one.
4. Make sure it is untracked: if `.agents/HANDOFF.md` isn't already ignored (`git check-ignore -q`), add it to `.git/info/exclude` (not the project's `.gitignore`).

## Resume (`resume` argument)

1. If `.agents/HANDOFF.md` doesn't exist, say so and stop.
2. Read it and check it against live git state: does the branch still exist, is it already merged, have the "Next" items already landed in commits?
3. Summarize where things stand, call out anything in the note that is now stale, and recommend the next action.
4. Once the user confirms they've picked the work up, delete `.agents/HANDOFF.md` (and `.agents/` if it's now empty).
