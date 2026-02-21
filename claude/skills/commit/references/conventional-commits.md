# Conventional Commits Specification

## Format

```
<type>: <description>

[optional body]

[optional footer(s)]
```

## Type

Must be one of the following:

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes that affect the build system or external dependencies
- **ci**: Changes to CI configuration files and scripts
- **chore**: Other changes that don't modify src or test files
- **revert**: Reverts a previous commit

## Description

- Use imperative, present tense: "change" not "changed" nor "changes"
- Don't capitalize the first letter
- No period (.) at the end
- Limit to 50-72 characters

## Body

- Use imperative, present tense
- Include motivation for the change and contrast with previous behavior
- Explain the "why" not the "what"

## Footer

- Reference issues, breaking changes, etc.
- Breaking changes should start with `BREAKING CHANGE:` with a space or two newlines
- Include Co-Authored-By for pair programming or AI assistance

## Examples

### Simple feature
```
feat: add user authentication endpoint
```

### Bug fix with body
```
fix: prevent race condition in user login

Previously, concurrent login requests could cause session conflicts.
This adds proper locking to ensure sequential session creation.
```

### Breaking change
```
feat: change API response format

BREAKING CHANGE: API now returns JSON instead of XML
```

### With Co-Author
```
feat: implement OAuth2 flow

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```
