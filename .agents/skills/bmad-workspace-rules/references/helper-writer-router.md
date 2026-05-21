# Helper-vs-Writer Router

Decision tree for routing tasks to Helper chain vs Writer agents.

## Classification

| User intent | Route | Skills |
|-------------|-------|--------|
| Unstructured notes → structured doc | Helper chain | prose → structure → shard → index |
| Compress long session / brainstorm | Helper | `bmad-distillator` |
| New API / module technical doc | Writer | `bmad-agent-tech-writer` |
| Unknown brownfield codebase | Writer (first) | `bmad-generate-project-context` |
| Post-implementation doc sync | Workspace rules | `bmad-workspace-rules` |
| Architecture deviation | ADR | manual |

## Decision Flow

1. **Brownfield?** → Run `bmad-generate-project-context` first
2. **Needs structuring?** → Helper chain
3. **Net-new technical doc?** → Writer agent
4. **After dev-story?** → `bmad-workspace-rules`