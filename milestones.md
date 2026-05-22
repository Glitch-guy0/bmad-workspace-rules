## Workflow Reference: Repo-Update Process

Applicable when a skill is invoked against an existing repository with user requirements ready.

1. Divide the whole repo into sections.
2. Create a temporary file `{{project root}}/_repo-update-task-list.md` containing all required context.
3. Prompt user that sections are allocated and ready to implement.
4. After implementing each section, prompt user to commit changes and rerun the process in a new session.
5. After completion, prompt user to approve deletion of the `{{project root}}/_repo-update-task-list.md` file.
6. On subsequent skill invocations, check `_repo-update-task-list.md` to determine if this is a repo-update session.
