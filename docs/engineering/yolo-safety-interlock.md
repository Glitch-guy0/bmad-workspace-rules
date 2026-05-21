---
title: YOLO Safety Interlock
status: published
source: _bmad-output/research/R-11-yolo-safety-interlock.md
---

# YOLO Safety Interlock

Allow YOLO defaults while refusing low-confidence autonomous runs with DX guardrails.

## Interlock Rules

| Condition | Behavior |
|-----------|----------|
| Constitution path missing | Refuse YOLO; require `init.md` |
| > N files would change | Refuse; require explicit confirm |
| Destructive op detected | Dry-run only with diff |
| Brownfield + no `project-context.md` | Suggest `bmad-generate-project-context` first |
| YOLO keyword invoked | Skip Q&A but apply file cap + undo note |

## Pre-flight Quiz

- Maximum 2 questions for architecture choices
- Verify constitution path exists
- Check git context for post-commit mode

## Dry-run Format

Show unified diff before applying changes. Include undo block in session log:

```markdown
## Undo
```bash
git checkout -- path/to/file1 path/to/file2
rm docs/new-file.md
```
```

## Undo Log Location

Session log stores undo commands at session end.