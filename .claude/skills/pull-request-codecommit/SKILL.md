---
name: pr-codecommit
description: Manage CodeCommit PRs (create/list/view)
argument-hint: [create|list|view]
allowed-tools: Bash(aws codecommit:*), Bash(git log:*), Bash(git diff:*), Bash(git remote:*)
---

## Context
- Branch: !`git branch --show-current`
- Remote: !`git remote get-url origin`
- Command: $ARGUMENTS

## Task

Based on $ARGUMENTS, execute:

- **create**: Analyze commits/diff, then run `aws codecommit create-pull-request`
- **list**: Run `aws codecommit list-pull-requests` and display results
- **view**: Run `aws codecommit get-pull-request` for current branch's PR
- **empty/unknown**: Show available subcommands (create, list, view)

Note: Extract repository name from remote URL.

## Additional resources

- For PR description format, see [template.md](template.md)
