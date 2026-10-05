---
name: orchestrate-implementation
argument-hint: <issue-number-or-task>
description: Delegate implementation to Claude Code's built-in subagents through the Agent tool. Use when the user asks for delegated or orchestrated implementation, or invokes this skill.
---

# Orchestrate implementation

The root session orchestrates and delegates implementation to Claude Code's built-in
subagents through the Agent tool. Use `Explore` for read-only fan-out searches.
For implementation, choose the `impl-<effort>` agent type that matches each unit of work:

| `subagent_type` | Use for |
| --- | --- |
| `impl-low` | Small, mechanical changes with clear instructions and no design decisions |
| `impl-medium` | Ordinary changes across a few files with a clear plan and known patterns |
| `impl-high` | Multi-file features, cross-repo boundaries, or behavior that needs careful verification |
| `impl-xhigh` | Large or risky work, such as new flows across many files or unclear root causes |

Honor a user-requested effort. The definitions live in `.claude/agents/`. Subagents
inherit the session model. Pass `model` only when the task's complexity warrants a
different model, or when the user requests one.

## Set up and assign

- Read applicable repository instructions and inspect the working tree, branch, HEAD, and relevant PR state. Preserve unrelated changes and capture the requested behavior and constraints.
- If the task names an issue, read it and any existing implementation plan. Resolve
  its number and title from the issue; ask only if the named target is ambiguous.
  Without an issue, use the user's task description and any existing relevant plan.
- Before implementation, create a dedicated Git worktree and branch named
  `issue-<number>-<title-slug>` for an issue or `task-<task-slug>` otherwise. Use a
  lowercase, hyphen-separated slug with punctuation removed. For example, issue
  #48 "Connect Studio chat" becomes `issue-48-connect-studio-chat`.
  Place `<repo-name>-<branch>` in a permitted writable root, beside the repository
  when permitted. Honor user-specified locations and filesystem approval requirements.
- Use the repository's default branch as the base unless the user or approved plan
  specifies another base. Verify
  the base ref before running `git worktree add -b <branch> <worktree-path> <base>`.
  Keep the original checkout and its uncommitted changes intact.
- Inspect `git worktree list` and existing branches/paths first. Reuse a matching
  task worktree only after verifying its branch, base, and local changes. If the
  intended branch exists without a worktree, verify it belongs to this task and
  attach it without `-b`. For unrelated name collisions, choose an unused numeric
  suffix; never overwrite a directory, reset a branch, or force a worktree lock.
- Give each subagent the task worktree's absolute path. Do not also set the Agent
  tool's `isolation: "worktree"`, because it creates a separate unnamed worktree.
- Give the implementation agent ownership of implementation and relevant tests, docs, and builds. The root independently inspects companion code or integration points and resolves boundary questions. Add agents only for concrete independent work, such as one agent per repository; avoid overlapping edits.
- Launch independent agents in a single message so they run concurrently. Use
  `run_in_background: true` when several agents run at once or the root has other
  work. Run an agent in the foreground when the root needs its result before it can
  continue.
- Assign one owner for Git mutations in a shared checkout. Use separate worktrees when writers need independent branches.
- Run implementation, checks, builds, and Git mutations in the task worktree.
  Include its absolute path, branch, and verified base in the agent brief.
- Subagents run under the session's permission mode. Never ask a subagent to
  perform an action that was denied in the root session.

Pass a self-contained brief as the Agent tool's `prompt`. The subagent cannot see
this conversation, so state everything it needs. Omit irrelevant fields:

```text
Task: <requested behavior, scope, acceptance scenario>
Repository/state: <absolute path, branch, HEAD, relevant base/PR, existing changes>
Ownership: <agent's files and checks; root's independent investigation>
Constraints: <architecture, exclusions, allowed builds and external actions>
Dependencies: <results expected from other agents and how the root relays them>
Publication gate: Complete any requested or warranted simplification, then have
the root verify the final diff and required checks before code push or PR publication.
Handoff: <local diff, commit, or authorized draft PR and base>
Report to: final message. Use SendMessage to "main" for early scope flags or results
another agent needs.
Flag scope changes early. Return changed behavior/files, check results, limitations,
and commit/PR details when applicable.
```

## Coordinate and verify

Background agents notify the root when they finish. Do not poll them, read their
transcript output files, or predict their results. Use SendMessage with the agent's
ID to relay discoveries, user steering, and other agents' output, such as a generated
contract path. Also use it for follow-ups, so the agent keeps its context; a new
Agent call starts fresh. Stop agents that are no longer needed with TaskStop.
A subagent's final report is not shown to the user, so relay what matters.

Companion-code findings do not authorize edits to that repository. Keep external actions within the current task's authorization; unrelated historical permission does not carry over.

The root verifies the final diff and acceptance scenario, including relevant failure cases. Ensure tests exercise the requested behavior rather than passing through unrelated automatic behavior. Run targeted checks and required builds; repeat only after changes, failures, or unresolved concerns. Distinguish synthetic checks from live-system evidence. Use independent review when it adds confidence, without fixed review loops unless required.

## Simplify when needed and verify before publishing

After implementation, apply the [code-simplification](../code-simplification/SKILL.md) skill
to changed code only when the user requests it or the changes warrant cleanup.
Delegate to a subagent when the benefit outweighs coordination overhead; otherwise
complete the pass directly. Preserve behavior and avoid unrelated cleanup.

If delegating, continue an existing agent with SendMessage or launch a new one in
the task worktree. Give it the agreed scope, base ref, changed files, and existing
validation results. Pause other writers while it owns simplification; it must not
push or publish a PR. Wait for its handoff covering changes, checks, and remaining
concerns.

The root inspects the final diff and ensures required checks pass before any code
push or PR publication, including draft PRs and pushes to an existing PR. After
further code changes, inspect those changes and rerun affected checks. A separate
simplification pass is not required for every task; do not force cleanup edits.

## Finish

For authorized draft PRs, use `gh pr create` with the verified base. Keep one PR per repository for the task. Verify the PR URL, draft status, base, commit, and working-tree state. PR preparation alone does not authorize merging, deployment, or other external actions.

Resolve remaining work before handoff. Include a concise **Change | Related code** Markdown table linking meaningful behavior to verified file lines, followed by validation and material limitations or commit/PR status. Use absolute clickable file targets with repository-relative labels.

Before the final response, stop any subagents still running for this task.

Report the task worktree path and branch at handoff. Keep the worktree available
for user review; remove it only when cleanup is explicitly authorized, after
verifying that no uncommitted or unpushed work would be lost.

Summarize what changes were made and what code was affected in each file, excluding test files.
