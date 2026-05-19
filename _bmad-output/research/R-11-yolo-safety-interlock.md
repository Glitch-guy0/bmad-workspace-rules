---
id: R-11
status: open
priority: P2
brainstorm_ref: 'Part 2 R-11; Cat #2, #5, #6'
blocked_by: [R-07]
---

# R-11 — YOLO safety interlock + pre-flight quiz

## Goal

Allow YOLO defaults (Cat #2) while refusing low-confidence autonomous runs (Cat #5) and enforcing DX guardrails (Cat #6).

## Research questions

| # | Question |
|---|----------|
| 1 | What signals define "low confidence" — missing constitution, empty git context? |
| 2 | Pre-flight quiz — how many questions max (brainstorm: ≤2 architecture choices)? |
| 3 | Dry-run diff presentation format? |
| 4 | Undo instructions — per session log location? |

## Proposed interlock rules

| Condition | Behavior |
|-----------|----------|
| Constitution path missing | **Refuse** YOLO; require `init.md` |
| &gt; N files would change (configurable) | **Refuse**; require explicit confirm |
| Destructive op detected | **Dry-run only** with diff |
| Brownfield + no `project-context.md` | Suggest `bmad-generate-project-context` first |
| User invoked YOLO keyword | Skip Q&A but still apply file cap + undo note |

## YOLO keystroke / phrase

Document in skill: explicit trigger phrases in description (e.g. "run workspace rules yolo") per BMad conservative triggering.

## Acceptance criteria

- [ ] Interlock rules in `bmad-workspace-rules` references
- [ ] Session log template includes undo block
- [ ] Aligns with Cat #6 guardrails table in consolidated brainstorm

## References

- Brainstorm Cat #2 YOLO Default Engine, Cat #5 Safety Interlock, Cat #6 DX Guardrails
