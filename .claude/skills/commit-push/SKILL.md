---
description: Check current changes/branch, commit, and push
disable-model-invocation: true
allowed-tools: Bash(git add:*), Bash(git commit:*), Bash(git push:*), Bash(git checkout:*), Bash(git switch:*)
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`

## Your task

Based on the above changes:

1. Create a new branch if on main
2. Create a single commit with an appropriate message
3. Push the branch to origin
