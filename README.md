# Skills

Skills for Claude Code and Codex. Each skill has one copy that works in both agents.

## Project structure

| Path | Contents |
| --- | --- |
| [`skills/`](skills/) | Skills, with `SKILL.md` instructions and optional `agents/openai.yaml` (Codex metadata), reference files, or scripts. |
| [`agents/`](agents/) | Claude Code implementation subagents: `impl-low`, `impl-medium`, `impl-high`, and `impl-xhigh`. |
| [`install.sh`](install.sh) | Installs the skills, agents, and starter rules. |
| [`AGENTS.md`](AGENTS.md) | Rules for Codex, also the starter rules for new repos. |
| [`CLAUDE.md`](CLAUDE.md) | Rules for Claude Code, also the starter rules for new repos. |

## Available skills

| Skill | Purpose |
| --- | --- |
| [code-simplification](skills/code-simplification/SKILL.md) | Simplify code without changing behavior. |
| [grilling](skills/grilling/SKILL.md) | Stress-test a plan, decision, or idea with questions. |
| [issue-investigation](skills/issue-investigation/SKILL.md) | Investigate a GitHub issue and report its root cause before implementation. |
| [issue-planning](skills/issue-planning/SKILL.md) | Clarify an issue's requirements and write a plan before implementation. |
| [orchestrate-implementation](skills/orchestrate-implementation/SKILL.md) | Delegate implementation to Claude Code subagents or Herdr agents in Codex. |
| [principles](skills/principles/SKILL.md) | Engineering principles for building, testing, debugging, and verifying work. |
| [technical-writing](skills/technical-writing/SKILL.md) | Write and review technical documentation. |
| [typescript-best-practices](skills/typescript-best-practices/SKILL.md) | Apply TypeScript practices when editing or reviewing code. |
| [unslop](skills/unslop/SKILL.md) | Remove AI writing patterns from prose. |
| [worktree-cleanup](skills/worktree-cleanup/SKILL.md) | Audit and prune stale git worktrees, then reclaim other disk space. |

## Use in a new repo

1. Clone this repository once:

   ```sh
   git clone https://github.com/anthoai97/skills ~/Code/tools/skills
   ```

2. Install into the project:

   ```sh
   ~/Code/tools/skills/install.sh /path/to/project
   ```

   This adds:

   | Path in the project | Contents |
   | --- | --- |
   | `.agents/skills/` | All skills, read by Codex. |
   | `.claude/skills/` | Symlinks to `.agents/skills/`, read by Claude Code. |
   | `.claude/agents/` | The `impl-*` subagents used by `orchestrate-implementation`. |
   | `skills-lock.json` | The installed skill versions. |
   | `AGENTS.md`, `CLAUDE.md` | Starter rules, only when the project has none. |

3. Edit `AGENTS.md` and `CLAUDE.md` for the project, such as its default PR branch, test commands, and environment setup. Keep the two files in sync.
4. Commit the added files so every clone gets the same skills.
5. Start Claude Code or Codex in the project. Call a skill by name, for example `/issue-planning 42` in Claude Code or `$issue-planning 42` in Codex. Agents also load a skill on their own when a task matches its description.

To install for every project on your machine instead, omit the path: `install.sh` installs skills to `~/.claude/skills` and `~/.agents/skills`, and agents to `~/.claude/agents`. It does not add rule files.

To install skills only, without cloning or agents:

```sh
npx skills add anthoai97/skills
```

## Update

Pull this repository and run `install.sh` again.

## Uninstall

```sh
npx skills remove
rm .claude/agents/impl-*.md
```
