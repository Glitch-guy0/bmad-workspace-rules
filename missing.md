# Missing — Known Issues

> Tracks known issues from failing test cases. Human-operated.

## Open

| # | Issue | File | Discovered | Status |
|---|-------|------|------------|--------|
| 1 | Define repo-update workflow skill for already-implemented repos | skill-definition | 2026-05-22 | Open |

## Resolved

| # | Issue | File | Discovered | Resolved |
|---|-------|------|------------|----------|

## Workflow Reference: Repo-Update Process

Applicable when a skill is invoked against an existing repository with user requirements ready.

1. Divide the whole repo into sections.
2. Create a temporary file `{{project root}}/_repo-update-task-list.md` containing all required context.
3. Prompt user that things are allocated and ready to implement.
4. After each section implementation completion, prompt user to commit changes and rerun process in a new session.
5. After completion, prompt user to approve deletion of `{{project root}}/_repo-update-task-list.md` file.
6. On subsequent skill invocations, check `_repo-update-task-list.md` to determine if this is a repo-update session.