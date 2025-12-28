# AI Agent Git Commit Guidelines

As an AI agent collaborating on this project, you must follow these best practices for every git commit you propose or execute. High-quality commit messages ensure a maintainable and understandable project history.

## 1. Core Principles

### Clean, Single-Purpose Commits
- Each commit should represent a single logical change (e.g., one bug fix, one feature, or one refactor).
- If you've made multiple unrelated changes, split them into separate commits.
- Small, focused commits are easier to review, revert, and track.

### Commit Early, Commit Often
- Don't wait for "perfection." Propose commits for meaningful increments of progress.
- This minimizes merge conflicts and keeps the team updated on your work.

### Meaningful Subject Lines
- Write informative summaries that give a clear overview of the change.
- Other developers should understand what happened without needing to read the code immediately.

---

## 2. Mandatory AI Workflow

To ensure accuracy and context, every AI agent MUST follow these steps before generating a commit message:

1.  **Analyze All Changes**:
    *   Read and understand the full diff of the changes made.
    *   Base the commit message strictly on what was actually modified in the code.
2.  **Review Previous History**:
    *   Read previous commit messages from the git history (e.g., `git log -n 5`).
    *   This helps you understand the context, recent work, and current focus area.
3.  **Consult Task Documentation**:
    *   Always check `docs/AI/Tasks` for new or recently edited files.
    *   Task files are the primary source of truth for the "why" and "what" behind the changes. Even if code is self-explanatory, the task documentation provides the broader intent.

---

## 3. Formatting Rules

### Subject Line (The Header)
- **Format**: `<type>(<optional scope>): <subject>`
- **Imperative Mood**: Use the present tense (e.g., `feat: add` instead of `feat: added` or `feat: adds`).
- **Case**: The subject should be written in lower case or sentence case as per project style, but the imperative verb is key.
- **Length**: Keep the subject line under **50 characters**.
- **No Period**: Do not end the subject line with a period.
- **No Punctuations**: Remove unnecessary punctuation marks.

### The Body (Optional but Recommended)
- **BLANK LINE**: Always add a blank line between the subject and the body.
- **Explanation**: Use the body to explain **what** and **why** the change was made, not "how" (the code shows how).
- **Wrapping**: Wrap lines in the body at **72 characters**.

### The Footer (Optional)
- Use for referencing issue IDs (e.g., `Resolves: #123`) or breaking changes.

---

## 4. Commit Types (`<type>`)

You MUST use one of the following types:

- `feat`: A new feature for the user.
- `fix`: A bug fix for the user.
- `docs`: Documentation-only changes.
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc).
- `refactor`: A code change that neither fixes a bug nor adds a feature.
- `perf`: A code change that improves performance.
- `test`: Adding missing tests or correcting existing tests.
- `build`: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm).
- `chore`: Other changes that don't modify src or test files (e.g., updating `.gitignore`).

---

## 5. Examples

### Minimal Commit
```bash
feat: add dark mode support
```

### Commit with Body and Footer
```bash
fix: prevent racing of requests

Introduce a request id and a reference to the latest request. Dismiss
incoming responses other than from the latest request.

Resolves: #123
```

### Documentation Update
```bash
docs: update readme with installation steps
```
