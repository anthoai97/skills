# Skills

Skills for Codex and Claude Code, with separate instructions for each agent.

## Project structure

| Path | Contents |
| --- | --- |
| [`.agents/skills/`](.agents/skills/) | Codex skills, with `SKILL.md` instructions and optional `agents/openai.yaml` metadata or reference files. |
| [`.claude/skills/`](.claude/skills/) | Claude Code skills, with `SKILL.md` instructions and optional reference files. |
| [`.claude/agents/`](.claude/agents/) | Claude Code implementation subagents: `impl-low`, `impl-medium`, `impl-high`, and `impl-xhigh`. |
| [`AGENTS.md`](AGENTS.md) | Repository rules for Codex. |
| [`CLAUDE.md`](CLAUDE.md) | Repository rules for Claude Code. |

To list the current skill and agent files:

```sh
rg --files --hidden .agents .claude
```

## Available skills

Both skill directories contain the following skills. Each link opens the Codex instructions. Claude Code instructions use the same skill name under `.claude/skills/`.

| Skill | Purpose |
| --- | --- |
| [code-simplification](.agents/skills/code-simplification/SKILL.md) | Simplify code without changing behavior. |
| [grilling](.agents/skills/grilling/SKILL.md) | Stress-test a plan, decision, or idea with questions. |
| [issue-investigation](.agents/skills/issue-investigation/SKILL.md) | Investigate a GitHub issue and report its root cause before implementation. |
| [issue-planning](.agents/skills/issue-planning/SKILL.md) | Clarify an issue's requirements and write a plan before implementation. |
| [orchestrate-implementation](.agents/skills/orchestrate-implementation/SKILL.md) | Delegate implementation through Herdr in Codex or built-in subagents in Claude Code. |
| [technical-writing](.agents/skills/technical-writing/SKILL.md) | Write and review technical documentation. |
| [typescript-best-practices](.agents/skills/typescript-best-practices/SKILL.md) | Apply TypeScript practices when editing or reviewing code. |
| [unslop](.agents/skills/unslop/SKILL.md) | Remove AI writing patterns from prose. |

## Install

```sh
npx skills add anthoai97/skills
```

## Uninstall

```sh
npx skills remove
```
