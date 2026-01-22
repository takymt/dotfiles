---
name: pr
description: Manage PRs (create/list/view)
argument-hint: [create|list|view]
allowed-tools: Bash(gh pr create:*), Bash(gh pr list:*), Bash(gh pr view:*), Bash(git log:*), Bash(git diff:*)
---

## Context
- Branch: !`git branch --show-current`
- Command: $ARGUMENTS

## Task

Based on $ARGUMENTS, execute:

- **create**: Analyze `git log main..HEAD` and `git diff main...HEAD --stat`, then `gh pr create --base main` with summary/test plan body
- **list**: Run `gh pr list` and display results
- **view**: Run `gh pr view` for current branch's PR
- **empty/unknown**: Show available subcommands (create, list, view)
