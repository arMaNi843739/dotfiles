---
name: commit
description: Commit changes with auto-generated commit messages in English. Commits staged changes if they exist, otherwise asks user confirmation to stage and commit unstaged changes. Use when the user requests to commit changes or create a commit. Analyzes diffs to generate Conventional Commits format messages including the purpose and reason for changes. Handles pre-commit hooks with user confirmation on failure.
---

# Commit

## Overview

This skill commits changes with automatically generated commit messages in English following Conventional Commits format. It intelligently handles both staged and unstaged changes:
- If there are staged changes, commits them immediately
- If there are no staged changes but unstaged changes exist, asks for user confirmation before staging and committing
- Ignores untracked files unless explicitly requested by the user

## Workflow

Follow these steps in order:

### 1. Check current git status

Run these commands in parallel to understand the current state:

```bash
git status
git diff --cached
git diff
git log -5 --oneline
```

- `git status`: Shows which files are staged, unstaged, or untracked
- `git diff --cached`: Shows the actual staged changes
- `git diff`: Shows unstaged changes
- `git log -5 --oneline`: Shows recent commit message style for consistency

### 2. Determine what to commit

Based on the git status:

**If there are staged changes:**
- Proceed to analyze and commit the staged changes
- Use `git diff --cached` output for analysis

**If there are NO staged changes but unstaged changes exist:**
- Show the user what files have unstaged changes
- Use AskUserQuestion to confirm if they want to stage and commit these changes
- If confirmed, stage the modified files with `git add -u` (only stages modified/deleted files, not untracked)
- Then proceed to commit

**If there are no staged or unstaged changes:**
- Inform the user there are no changes to commit
- Do not create an empty commit

### 3. Analyze changes

Examine the diff output to understand:

- **Nature of changes**: New feature, bug fix, refactor, docs, etc.
- **Scope of changes**: Which files/components are affected
- **Purpose and reason**: Why these changes were made

### 4. Clarify purpose

**Always ask the user for the purpose and reason** before generating the commit message:

- Use AskUserQuestion to ask the user why these changes were made
- Ask about the goal or problem being solved
- Example: "What is the purpose of these changes?"
- This ensures the commit message body accurately reflects the user's intent

### 5. Generate commit message

Create a commit message in English following Conventional Commits format:

**Format:**

```
<type>: <description>

[optional body explaining why]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Key principles:**

- Use imperative, present tense in English
- Keep first line concise (50-72 characters)
- Include the **purpose and reason** in the body if not obvious
- Focus on "why" rather than "what"

See [references/conventional-commits.md](references/conventional-commits.md) for detailed specification.

### 6. Create the commit

Use a heredoc to ensure proper formatting:

```bash
git commit -m "$(cat <<'EOF'
<type>: <description>

[optional body]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF
)"
```

### 7. Handle pre-commit hook failures

If the commit fails due to pre-commit hooks:

1. **Report the error** to the user with the hook output
2. **Ask for confirmation** using AskUserQuestion:
   - Show what failed (linter errors, formatting issues, etc.)
   - Ask if they want you to fix the issues automatically
3. **If approved**, fix the issues, re-stage, and create a NEW commit
4. **Important**: Never use `--amend` or `--no-verify` unless explicitly requested

### 8. Verify success

```bash
git status
```

Confirm the commit was created and changes are now committed.

## Important Notes

- **Smart staging**: Commits staged changes immediately; asks confirmation before staging unstaged changes
- **Ignores untracked files**: Only handles modified/deleted files, not new untracked files (unless explicitly requested)
- **User confirmation for unstaged**: Always ask the user before staging and committing unstaged changes
- **English commit messages**: Always write commit messages in English following Conventional Commits format
- **Include purpose and reason**: The commit message body should explain why the changes were made, not just what was changed
- **Always ask for purpose**: Always ask the user for the purpose and reason of changes using AskUserQuestion before generating the commit message
- **Pre-commit hooks**: If hooks fail, the commit does NOT happen - report to user and ask for confirmation before fixing
- **Never skip hooks**: Do not use `--no-verify` or `--amend` unless explicitly requested by the user
- **No push**: Do not push to remote unless the user explicitly requests it

## References

- [Conventional Commits Specification](references/conventional-commits.md) - Detailed format and examples
