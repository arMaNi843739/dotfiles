---
name: create-pr
description: Create GitHub pull requests with auto-generated descriptions that focus on WHY changes were made (extracted from commit messages), not WHAT was changed. Includes Jira ticket information extracted from branch names. Use when the user requests to create a PR, pull request, or says "/create-pr". Asks user for clarification if commit messages don't explain the motivation. Supports PR templates and integrates with Atlassian MCP for ticket context.
---

# Create Pull Request

Automatically create GitHub pull requests with descriptions that focus on WHY changes were made (extracted from commit messages), not WHAT was changed. Includes linked Jira ticket information when available.

## Workflow

Follow these steps to create a pull request:

### 1. Analyze Current State

Run these commands in parallel to understand the current branch and changes:

```bash
# Check current branch and status (never use -uall flag)
git status

# View commit history with full messages since diverging from main
git log main..HEAD --format="%h %s%n%b"
```

### 2. Determine if Jira Ticket Should Be Retrieved

Check if the branch name follows the Jira ticket pattern to determine whether to fetch ticket information.

**Jira ticket extraction logic**:

1. Extract the current branch name from `git status` or `git branch --show-current`
2. Check if it matches the pattern: `<prefix>/<JIRA-ID>` or `<prefix>/<JIRA-ID>-<description>`
3. Jira ticket ID format: `[A-Z]+-\d+` (uppercase letters, hyphen, digits)

```python
import re

# Get current branch name
branch_name = "feat/MOX-123-add-user-auth"  # example

# Pattern: <prefix>/<UPPERCASE-DIGITS> with optional -<description>
# This matches: feat/MOX-123 or feat/MOX-123-some-description
match = re.match(r'^[^/]+/([A-Z]+-\d+)(?:-.*)?$', branch_name)

if match:
    ticket_id = match.group(1)  # e.g., "MOX-123"
    # Proceed to fetch Jira ticket (step 3)
else:
    ticket_id = None
    # Skip Jira integration - branch name doesn't follow the pattern
```

**Examples**:
- `feat/MOX-123` → Extract `MOX-123` ✓
- `feat/MOX-123-add-auth` → Extract `MOX-123` ✓
- `fix/PROJ-456` → Extract `PROJ-456` ✓
- `feature/new-login` → No match, skip Jira ✗
- `hotfix-critical` → No match, skip Jira ✗
- `main` → No match, skip Jira ✗

### 3. Fetch Jira Ticket Information (if applicable)

If a ticket ID was extracted and Atlassian MCP is available, fetch the ticket information:

Use the appropriate MCP tool to retrieve:
- **Title**: The ticket summary
- **Description**: The ticket description
- **Status**: Current ticket status
- **Type**: Issue type (Bug, Story, Task, etc.)

If Atlassian MCP is not available or the ticket cannot be found, proceed without ticket information.

### 4. Check for PR Template

Check if a pull request template exists in the repository:

```bash
# Common locations for PR templates
test -f .github/pull_request_template.md && echo "Template found"
test -f .github/PULL_REQUEST_TEMPLATE.md && echo "Template found"
test -f docs/pull_request_template.md && echo "Template found"
```

If a template exists, read it and structure the PR description to match the template format.

### 5. Generate PR Description

Create a comprehensive PR description with these sections:

**IMPORTANT**: Extract the "why" (motivation/rationale) from commit messages. Do NOT list specific file changes or implementation details.

#### Analyzing Commit Messages

1. Review all commit messages from `git log main..HEAD`
2. Extract the **reason/motivation** for the changes from commit messages (typically found in the commit body or inferred from well-written commit subjects)
3. If the commit messages don't clearly explain WHY the changes were made, use `AskUserQuestion` to ask the user for clarification before creating the PR

#### Without Template

Use this default structure (in Japanese):

```markdown
## 概要
[コミットメッセージから抽出した、この変更がなぜ必要だったのかを説明する2-3文。動機と目的に焦点を当て、変更されたファイルや実装の詳細は記載しない。]

## Jira チケット
[TICKET-ID]: [チケットタイトル]
[チケットへのリンク: https://your-domain.atlassian.net/browse/TICKET-ID]

**ステータス**: [チケットステータス]
**タイプ**: [課題タイプ]

### チケット説明
[Jira チケットの説明からの抜粋または主要なポイント]

## テスト計画
- [ ] [テストアクション 1]
- [ ] [テストアクション 2]
- [ ] [テストアクション 3]

---
🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

#### With Template

If a PR template exists, follow its structure exactly. Populate the template sections with:
- **Summary/Description**: Extract WHY from commit messages (motivation/rationale). Do NOT list specific file changes or implementation details.
- **Motivation/Why**: Reason for the change extracted from commit messages
- **Jira/Related Issues**: Ticket information if available
- **Testing**: Test plan checklist based on the changes
- If commit messages don't explain WHY, use `AskUserQuestion` to clarify before proceeding

### 6. Push Branch and Create PR

Ensure the branch is pushed to remote and create the PR:

```bash
# Push to remote if needed (check if branch is tracking remote first)
git push -u origin HEAD

# Create PR using gh CLI with heredoc for proper formatting (in Japanese)
gh pr create --title "簡潔なPRタイトル（70文字以内）" --body "$(cat <<'EOF'
[ステップ5で生成されたPR説明]
EOF
)"
```

**Important Notes**:
- Keep the PR title short and descriptive (under 70 characters) in Japanese
- Use the PR description/body for detailed information
- Always use a HEREDOC when passing the body to `gh pr create` to ensure correct formatting
- Return the PR URL to the user when complete
- **All PR titles and descriptions should be written in Japanese**

### 7. Open PR in Browser

After the PR is created, open it in the browser:

```bash
gh pr view --web
```

## Branch Name Pattern Examples

### Branches WITH Jira Ticket (will fetch ticket information)

Pattern: `<prefix>/<JIRA-ID>` or `<prefix>/<JIRA-ID>-<description>`

- `feat/MOX-123` → Extract `MOX-123` ✓
- `feat/MOX-123-add-authentication` → Extract `MOX-123` ✓
- `fix/PROJ-456` → Extract `PROJ-456` ✓
- `fix/PROJ-456-fix-login-bug` → Extract `PROJ-456` ✓
- `refactor/TEAM-789-cleanup-code` → Extract `TEAM-789` ✓
- `docs/DOC-111-update-readme` → Extract `DOC-111` ✓

### Branches WITHOUT Jira Ticket (skip Jira integration)

Any branch name that doesn't match the pattern above:

- `main` → No Jira ticket ✗
- `develop` → No Jira ticket ✗
- `feature/new-login` → No Jira ticket ✗
- `hotfix-production` → No Jira ticket ✗
- `add-user-auth` → No Jira ticket ✗
- `feat/add-new-feature` → No Jira ticket ✗

## Example PR Description Output (in Japanese)

```markdown
## 概要
この変更は、プライベートエンドポイントを保護し、ユーザー固有の機能を有効にするためのユーザー認証を実装します。以前は、システムが認証なしで誰でもアクセス可能であったため、セキュリティ上の懸念があり、ユーザー固有の機能を構築できませんでした。

## Jira チケット
MOX-123: ユーザー認証システムの実装
https://your-domain.atlassian.net/browse/MOX-123

**ステータス**: 進行中
**タイプ**: ストーリー

### チケット説明
ユーザーとして、パーソナライズされた機能にアクセスできるように、アカウントを作成してログインできるようにしたい。システムは、自動更新機能を備えたJWTトークンをサポートする必要があります。

## テスト計画
- [ ] 新しいユーザーアカウントを登録
- [ ] 有効な認証情報でログイン
- [ ] トークンの有効期限前に更新が機能することを確認
- [ ] 保護されたエンドポイントが未認証リクエストを拒否することを確認
- [ ] ログアウト機能をテスト

---
🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

## Handling Edge Cases

### No Jira Ticket in Branch Name
If the branch name doesn't match the Jira ticket pattern (`<prefix>/<JIRA-ID>` or `<prefix>/<JIRA-ID>-<description>`), omit the "Jira Ticket" section entirely from the PR description.

### Atlassian MCP Not Available
If the MCP tool is not available, skip ticket fetching and use only branch name information:
```markdown
## 関連課題
ブランチ: feat/MOX-123-add-authentication
Jira チケットの可能性: MOX-123
```

### PR Template Not Following Expected Format
Read the template carefully and adapt the content to match its structure. Common template sections include:
- What/Description/Summary
- Why/Motivation/Context
- How/Implementation Details
- Testing/QA
- Screenshots (for UI changes)
- Breaking Changes
- Related Issues/Tickets

### Clean Working Tree
If there are no changes to commit and the branch is already pushed, proceed directly to creating the PR without additional git operations.
