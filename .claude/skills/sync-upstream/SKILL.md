---
description: Sync with upstream main branch
argument-hint: "[--merge]"
disable-model-invocation: true
allowed-tools: Bash(git fetch:*), Bash(git rebase:*), Bash(git merge:*), Bash(git push:*)
---

## Arguments

$ARGUMENTS

- `--merge`: Use merge instead of rebase (default: rebase)

## Context

- Current branch: !`git branch --show-current`
- Remotes: !`git remote -v`
- Current status: !`git status --short`

## Your task

1. Fetch upstream
2. Rebase onto upstream/main (or merge if `--merge` specified)
3. Push to origin (use `--force-with-lease` if rebased)

## Output

After completion, show:
- **Strategy:** rebase or merge
- **Result:** success or conflict details
