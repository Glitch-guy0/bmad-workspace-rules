---
title: Helper-vs-Writer Dispatcher
status: published
source: _bmad-output/research/R-12-helper-writer-dispatcher.md
---

# Helper-vs-Writer Dispatcher

Task classification for routing to Helper chain vs Writer agents.

## Classification

| User intent | Route | Skills |
|-------------|-------|--------|
| Unstructured notes → structured doc | Helper chain | prose → structure → shard → index |
| Compress long session / brainstorm | Helper | `bmad-distillator` |
| New API / module technical doc | Writer | `bmad-agent-tech-writer` |
| Unknown brownfield codebase | Writer (first) | `bmad-generate-project-context` |
| Post-implementation doc sync | Workspace rules | `bmad-workspace-rules` |
| Architecture deviation | ADR | manual + Cat #7 |

## Decision Flow

**Brownfield?** → Run `bmad-generate-project-context` first.

**Needs structuring?** (unstructured input) → Helper chain.

**Net-new technical doc?** → Writer agent.

**After dev-story?** → `bmad-workspace-rules`.

## Helper Skills

- `bmad-editorial-review-prose` — Review text communication
- `bmad-editorial-review-structure` — Propose cuts, reorganize
- `bmad-shard-doc` — Split large documents
- `bmad-index-docs` — Generate index references
- `bmad-distillator` — Compress for LLM context

## Writer Skills

- `bmad-agent-tech-writer` — Technical documentation
- `bmad-document-project` — Brownfield project docs
- `bmad-generate-project-context` — Project context for AI