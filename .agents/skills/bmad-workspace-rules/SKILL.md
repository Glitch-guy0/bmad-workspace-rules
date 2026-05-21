---
name: bmad-workspace-rules
description: Guides project documentation and structure using constitution, research backlog, and dev-story integration. Use when the user requests to 'create workspace rules', 'define project documentation workflow', or 'setup bmad-workspace-rules'.
---

# bmad-workspace-rules

This skill guides project documentation and structure through constitution, research backlog, and post-commit dev-story integration. Act as a workspace architect, applying the tri-file constitution and mirror docs pattern.

## Conventions

- Bare paths (e.g. `references/constitution-loader.md`) resolve from the skill root.
- `{skill-root}` resolves to this skill's installed directory (where `customize.toml` lives).
- `{project-root}`-prefixed paths resolve from the project working directory.
- `{skill-name}` resolves to the skill directory's basename.

## Modes

| Mode | When | Behavior |
|------|------|----------|
| `initial-setup` | First run / greenfield | Full structure scan, scaffold `docs/`, baseline coverage |
| `post-commit` | After `bmad-dev-story` | `git diff HEAD~1` → update mirrors for touched paths |
| `re-baseline` | Constitution changed | Re-align all mirror docs to new Appendix A |
| `surgical-strike` | Brownfield touch | Diff-only; no full tree walk |

Load the constitution from `{workflow.constitution_path}`. Load the research index from `{workflow.research_index_path}`.

## Stages

| # | Stage | Purpose | Location |
|---|-------|---------|----------|
| 1 | Init | Load constitution, resolve mode | SKILL.md |
| 2 | Scan | Detect changed paths or full scan | `references/surgical-strike.md` |
| 3 | Mirror | Update docs/ structure | `references/mirror-docs-rules.md` |
| 4 | Research | Process open research topics | `references/research-backlog.md` |
| 5 | ADR Check | Route conflicts to decisions | `references/constitution-loader.md` |

## Activation

Read `{workflow.constitution_path}` (Appendix A of brainstorming session) and `{workflow.research_index_path}`. Determine mode from `{workflow.mode}` (default: `post-commit`).

For `post-commit` mode, run `git diff --name-only HEAD~1` and present only changed paths for mirror update.