#!/bin/sh
# Install skills (Claude Code + Codex) and Claude Code impl-* agents.
# Usage: install.sh [project-dir]   Without a directory, installs globally.
set -e

src=$(cd "$(dirname "$0")" && pwd)

if [ -n "$1" ]; then
  target=$(cd "$1" && pwd)
  (cd "$target" && npx -y skills add "$src" -s '*' -a claude-code -a codex -y)
  agents="$target/.claude/agents"
  # Starter rules for a new repo; existing files are kept.
  for f in AGENTS.md CLAUDE.md; do
    [ -e "$target/$f" ] || { cp "$src/$f" "$target/$f"; echo "Added $f"; }
  done
else
  npx -y skills add "$src" -g -s '*' -a claude-code -a codex -y
  agents="$HOME/.claude/agents"
fi

mkdir -p "$agents"
cp "$src"/agents/*.md "$agents/"
echo "Agents installed to $agents"
