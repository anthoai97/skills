# Skills

Skills for Claude Code and Codex. Each skill has one copy that works in both agents.

## Project structure

| Path | Contents |
| --- | --- |
| [`skills/`](skills/) | Skills, with `SKILL.md` instructions and optional `agents/openai.yaml` (Codex metadata) or reference files. |
| [`agents/`](agents/) | Claude Code implementation subagents: `impl-low`, `impl-medium`, `impl-high`, and `impl-xhigh`. |
| [`install.sh`](install.sh) | Installs the skills and agents. |
| [`AGENTS.md`](AGENTS.md) | Repository rules for Codex. |
| [`CLAUDE.md`](CLAUDE.md) | Repository rules for Claude Code. |

## Available skills

| Skill | Purpose |
| --- | --- |
| [code-simplification](skills/code-simplification/SKILL.md) | Simplify code without changing behavior. |
| [grilling](skills/grilling/SKILL.md) | Stress-test a plan, decision, or idea with questions. |
| [issue-investigation](skills/issue-investigation/SKILL.md) | Investigate a GitHub issue and report its root cause before implementation. |
| [issue-planning](skills/issue-planning/SKILL.md) | Clarify an issue's requirements and write a plan before implementation. |
| [orchestrate-implementation](skills/orchestrate-implementation/SKILL.md) | Delegate implementation to Claude Code subagents or Herdr agents in Codex. |
| [technical-writing](skills/technical-writing/SKILL.md) | Write and review technical documentation. |
| [typescript-best-practices](skills/typescript-best-practices/SKILL.md) | Apply TypeScript practices when editing or reviewing code. |
| [unslop](skills/unslop/SKILL.md) | Remove AI writing patterns from prose. |

## Install

Skills and agents into a project:

```sh
git clone https://github.com/anthoai97/skills ~/Code/tools/skills
~/Code/tools/skills/install.sh /path/to/project
```

Omit the project path to install globally (`~/.claude`, `~/.agents`).

Skills only, without cloning:

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
