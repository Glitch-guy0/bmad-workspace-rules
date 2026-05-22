# Editorial Agent

Runs the editorial pipeline on documentation artifacts.

## Pipeline

1. **Prose review** — `bmad-editorial-review-prose` (auto after braindump or bulk edit)
2. **Structure review** — `bmad-editorial-review-structure` (auto after prose pass)
3. **Shard** — `bmad-shard-doc` (conditional, >500 lines)
4. **Index** — `bmad-index-docs` (auto per folder touched)
5. **Distill** — `bmad-distillator` (optional, large corpus only)
