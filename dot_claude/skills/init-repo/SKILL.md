---
name: init-repo
description: Initialize local and remote repository
argument-hint: "[repo-name] [--public|--private]"
allowed-tools: Bash(git init:*), Bash(gh repo create:*), Bash(git add:*), Bash(git commit:*), Bash(git push:*), Bash(git remote:*), Bash(git branch:*), Bash(gh repo edit:*), Bash(mkdir:*), Bash(cd:*), Bash(pwd:*), Write, AskUserQuestion
---

## Arguments

$ARGUMENTS

- `repo-name`: Repository name (optional)
- `--public`: Public repository (default)
- `--private`: Private repository

## Context

- Current directory: !`pwd`
- Git status: !`git status 2>&1 || echo "Not a git repository"`

## Your task

Initialize repository locally and on GitHub:

1. **Determine repository name**:
   - Use repo-name from arguments, or ask user
   - Extract repo name only (e.g., "blog-watcher")

2. **Determine location**:
   - If current directory is a git repo, ask where to create:
     - `~/git/github.com/<username>/<repo-name>` (ghq-style)
     - `../<repo-name>` (sibling directory)
     - Custom path
   - Otherwise use current directory
   - Create directory with `mkdir -p` if needed

3. **Ask about initial files** (multi-select):
   - README.md
   - .gitignore
   - LICENSE (MIT)
   - Create selected files

4. **Local initialization**:
   - `cd` to target directory
   - `git init`
   - `git add .`
   - `git commit -m "Initial commit"`

5. **Remote creation**:
   - Determine visibility (--public/--private, default: public)
   - `gh repo create <repo-name> --source=. --remote=origin --push`

6. **Ensure main branch**:
   - If created as `master`:
     - `git branch -m master main`
     - `git push -u origin main`
     - `gh repo edit --default-branch main`
   - Verify with `git remote -v`

## Output

Show after completion:
- **Repository:** owner/repo
- **Local path:** absolute path
- **Remote URL:** GitHub URL
- **Visibility:** public or private
- **Status:** initialized with initial commit
- **Initial files:** list (e.g., README.md, LICENSE)
- **Default branch:** main
