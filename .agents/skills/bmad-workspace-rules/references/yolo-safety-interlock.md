# YOLO Safety Interlock

Allow YOLO defaults while refusing low-confidence autonomous runs with DX guardrails.

## Interlock Rules

| Condition | Behavior |
|-----------|----------|
| Constitution path missing | Refuse YOLO; require `init.md` |
| > N files would change | Refuse; require explicit confirm |
| Destructive op detected | Dry-run only with diff |
| Brownfield + no `project-context.md` | Suggest `bmad-generate-project-context` first |

## Trigger Phrase

Use when user says 'run workspace rules yolo' or 'yolo mode'.