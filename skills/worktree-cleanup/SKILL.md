---
name: worktree-cleanup
description: Audit and prune stale git worktrees, then reclaim other disk space such as simulators and caches. Use when the user asks to clean up worktrees or free disk space.
---

# Worktree cleanup

Adapted from the poteto-mode worktree-cleanup playbook in
[cursor/plugins](https://github.com/cursor/plugins) (MIT, Lauren Tan).

This skill deletes user state with no code review to catch a mistake, so the
gates below are the review.

1. **Snapshot and audit.** Record `df -h /`, then run
   `scripts/worktree-audit.sh [-b <pr-base-ref>] [repo-path]` from this skill's
   folder. Without `-b` it checks `MERGED` against `origin/HEAD`, so pass
   `-b origin/<branch>` when PRs target another branch. It reads paths from
   `git worktree list`, never hand-typed ones, so worktrees outside the usual
   folder are not missed. It classifies each worktree by size, age, merge state,
   uncommitted work, PR state, and the newest Claude Code or Codex chat that
   touched it, then suggests a bucket. The transcript scan is slow, so run it in
   the background.
2. **Treat the bucket as advice, not permission.** Pinned and active chats are
   the real signal. Get that set from the user and cross-check every candidate.
   The script can mark `safe` a worktree the user still uses, so the user's set
   wins.
3. **Verify usage before deleting.** For every `verify-recent-chat` row, or any
   row you doubt, delegate transcript reading to subagents (transcripts are
   large) and have them report whether the chat is ongoing and which worktrees it
   touches. An active chat can run background agents in sibling worktrees whose
   names never appear in the chat list; those are in use.
4. **Pause on irreversible loss.** `wip:N` means N tracked uncommitted edits.
   Show the diff and get a decision first: a clean worktree is recoverable from
   its branch, but uncommitted work is gone. `scratch:N` means untracked
   throwaway files; they are safe to drop, but name them. Proceed without asking
   only for worktrees that are clean, merged, and not in use. Pause on `wip` and
   in-use worktrees.
5. **Prune the confirmed set.** For each path, run
   `git worktree remove --force <path>`. If the directory survives because of
   ignored build artifacts, `rm -rf` it, then run `git worktree prune`. Branch
   refs survive, so no commits are lost. Confirm with `df -h /` and list again.
6. **Other space, only when asked or when more is needed.** Simulators are
   usually the next-biggest win: `xcrun simctl --set testing delete all`
   (XCTestDevices clones), `xcrun simctl delete unavailable`, and
   `xcrun simctl runtime list` then `xcrun simctl runtime delete <id>` for old
   runtimes. Then Xcode `DerivedData` and `iOS DeviceSupport`, and package
   caches (pnpm, uv, brew, yarn). Clear only caches the user has not said to
   keep.

**Reply:** `df -h /` before and after with the space reclaimed, the worktrees
pruned, and a one-line reason for each worktree held back (in use by which chat,
or uncommitted work).
