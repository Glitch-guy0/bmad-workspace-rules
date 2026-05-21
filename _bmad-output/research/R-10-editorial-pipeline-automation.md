---
id: R-10
status: closed
priority: P2
brainstorm_ref: 'Part 2 R-10; Cat #19'
blocked_by: [R-09]
---

# R-10 — Editorial pipeline automation

## Goal

Wire the Helper skill chain (prose → structure → shard → index → distill) to run after substantive doc writes without manual skill invocation each time.

## Research questions

| # | Question |
|---|----------|
| 1 | Full chain every time vs threshold (word count, file count)? |
| 2 | Which skills are safe to auto-run vs need user approval? |
| 3 | Trigger: `bmad-workspace-rules` only, or any doc write? |
| 4 | Output locations — in place vs `_bmad-output/staging/`? |

## Proposed pipeline (Cat #19)

```mermaid
flowchart LR
  W[Doc write complete]
  P[bmad-editorial-review-prose]
  S[bmad-editorial-review-structure]
  H[bmad-shard-doc]
  I[bmad-index-docs]
  D[bmad-distillator optional]

  W --> P --> S --> H --> I
  I -.->|large corpus| D
```

| Step | Skill | Auto? | Notes |
|------|-------|-------|-------|
| 1 | `bmad-editorial-review-prose` | yes | After user braindump or bulk edit |
| 2 | `bmad-editorial-review-structure` | yes | After prose pass |
| 3 | `bmad-shard-doc` | conditional | Files &gt; ~500 lines or user flag |
| 4 | `bmad-index-docs` | yes | Per folder touched |
| 5 | `bmad-distillator` | optional | Brainstorm/compression only |

## Acceptance criteria

- [ ] Pipeline documented in `bmad-workspace-rules` references
- [ ] `customize.toml` flag: `editorial_pipeline_enabled = true`
- [ ] Dry-run mode respects Cat #6 (show diff before apply)

## References

- Appendix B — Helper skills registry
- Brainstorm Cat #19 Editorial Pipeline Chain
