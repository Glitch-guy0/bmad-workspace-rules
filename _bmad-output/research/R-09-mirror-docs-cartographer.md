---
id: R-09
status: open
priority: P1
brainstorm_ref: 'Part 2 R-09; Cat #3, #8, #9'
blocked_by: [R-07]
---

# R-09 — Mirror docs layout + post-commit cartographer

## Goal

Specify how `docs/` mirrors code structure and how post-commit automation updates only changed paths (Cat #3 Mirror Docs, Cat #8 Post-Commit Cartographer, Cat #9 bmad-dev-story).

## Research questions

| # | Question |
|---|----------|
| 1 | 1:1 path mirror (`src/modules/auth/` → `docs/backend/modules/auth/`) or semantic grouping? |
| 2 | What file types get mirrors (ts only, or prisma, k6 too)? |
| 3 | Coverage report format — markdown table, JSON, skill output? |
| 4 | Undocumented file policy — warn vs block commit? |
| 5 | Decision-log workspace for long-running doc sessions? |

## Proposed mirror mapping

| Code path | Mirror path |
|-----------|-------------|
| `backend/src/modules/{domain}/` | `docs/backend/modules/{domain}/index.md` |
| `frontend/src/components/{feature}/` | `docs/frontend/components/{feature}/index.md` |
| `packages/dto/` | `docs/contracts/dto/index.md` |
| OpenAPI | `docs/backend/openapi.yaml` (living spec) |

**Post-commit algorithm (Cat #8):**

1. `git diff HEAD~1 --name-only`
2. Filter extensions: `.ts`, `.tsx`, `.prisma`, `.js` (k6)
3. Map each path → mirror target
4. If mirror missing: create stub from template
5. If mirror exists: update "Last synced" + changed symbols summary (LLM-assisted)
6. Emit coverage report: `{documented, undocumented, stale}`

## Cartographer output (draft)

```markdown
## Coverage Report — {commit_sha}

| Status | Path |
|--------|------|
| documented | backend/src/modules/auth/auth.service.ts |
| missing | backend/src/modules/billing/billing.service.ts |
| stale | docs/backend/modules/auth/index.md (>30d) |
```

## Acceptance criteria

- [ ] Mirror convention documented in `references/mirror-docs-rules.md` (R-07)
- [ ] Coverage template in skill `assets/`
- [ ] `init.md` flow matches implemented behavior
- [ ] ADR created if mirror policy changes constitution doc strategy

## References

- `init.md` — git diff HEAD~1 integration
- Brainstorm Cat #3, #8, #9
- R-07 skill skeleton
