---
title: Editorial Pipeline Automation
status: published
source: _bmad-output/research/R-10-editorial-pipeline-automation.md
---

# Editorial Pipeline Automation

Wire the Helper skill chain (prose → structure → shard → index → distill).

## Pipeline Chain

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

## Pipeline Steps

| Step | Skill | Auto? | Notes |
|------|-------|-------|-------|
| 1 | `bmad-editorial-review-prose` | yes | After user braindump or bulk edit |
| 2 | `bmad-editorial-review-structure` | yes | After prose pass |
| 3 | `bmad-shard-doc` | conditional | Files > ~500 lines or user flag |
| 4 | `bmad-index-docs` | yes | Per folder touched |
| 5 | `bmad-distillator` | optional | Brainstorm/compression only |

## Configuration

- `editorial_pipeline_enabled` — Enable pipeline (default: true)
- `auto_shard_threshold` — Line count for auto-sharding (default: 500)
- `dry_run_mode` — Show diff before apply (Cat #6 guardrail)