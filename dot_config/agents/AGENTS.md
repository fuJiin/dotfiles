# AI Agent Configuration

## Project Knowledge

- Durable project knowledge (conventions, architecture, gotchas) belongs in the repo's committed `AGENTS.md`/`CLAUDE.md`, where teammates and every agent see it. Propose edits there rather than keeping private notes.
- In-flight work state lives in git, PR descriptions, and Linear. Don't keep a parallel status file.
- For handing work to a later session or another agent, use the `handoff` skill only when asked. The note is short-lived and deleted once picked up.

## Dotfiles and Skills

Agent config and skills are managed by chezmoi (source: `~/.local/share/chezmoi`). Never edit targets directly in `~/.claude/`, `~/.agents/`, `~/.codex/`, or `~/.gemini/`. Edit the chezmoi source and run `chezmoi apply`.

- Cross-agent skills (Open Agent Skills `SKILL.md` format) go in `dot_agents/skills/<name>/`. Codex and Gemini discover `~/.agents/skills/` natively. Claude Code needs a symlink: `dot_claude/skills/symlink_<name>.tmpl` containing `{{ .chezmoi.homeDir }}/.agents/skills/<name>`.
- Claude-only skills go in `dot_claude/skills/<name>/`.
- In Claude Code, always use skills, never `~/.claude/commands/`.
- Removing a skill from the source doesn't delete it from the target. Add the path to `.chezmoiremove` or delete it manually.
