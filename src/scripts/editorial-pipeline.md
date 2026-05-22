# Editorial Pipeline

Runs the editorial pipeline on documentation artifacts.

## Steps

1. **Prose review** — run `bmad-editorial-review-prose` on content after braindump or bulk edit
2. **Structure review** — run `bmad-editorial-review-structure` after prose pass
3. **Shard** — if document >500 lines, run `bmad-shard-doc` to split into atomic files
4. **Index** — run `bmad-index-docs` on every folder touched
5. **Distill** — optional: run `bmad-distillator` for large corpora or compression needs

## When to Run

- After any documentation braindump
- After bulk editing existing docs
- Before releasing documentation to stakeholders
