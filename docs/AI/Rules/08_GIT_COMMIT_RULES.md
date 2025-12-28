# Rule 08: Git Commit Generation for AI Agents

Every AI agent working on this project MUST follow the established git commit guidelines when proposing or executing commits.

## Operational Rules

1.  **Mandatory Change Analysis**:
    - Before writing a commit message, the agent MUST perform a comprehensive analysis of all code changes (e.g., using `git diff`).
    - The message must accurately reflect the specific modifications observed.

2.  **Contextual History Check**:
    - The agent MUST review previous commit messages (`git log`) to ensure consistency in project terminology and to understand the current development context.

3.  **Task Documentation Alignment**:
    - The agent MUST consult the `docs/AI/Tasks` directory.
    - If a task file exists or was updated for the current work, its contents must be used to define the intent and "why" of the commit.

## Reference
For detailed formatting, types, and examples, refer to the full guide:
[Git Commit Guidelines](../git_commit_guidelines.md)
