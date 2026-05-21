---
title: Mirror Docs Cartographer
status: published
source: _bmad-output/research/R-09-mirror-docs-cartographer.md
---

# Mirror Docs Cartographer

Specify how `docs/` mirrors code structure with post-commit automation.

## Mirror Mapping

| Code path | Mirror path |
|-----------|-------------|
| `backend/src/modules/{domain}/` | `docs/backend/modules/{domain}/index.md` |
| `frontend/src/components/{feature}/` | `docs/frontend/components/{feature}/index.md` |
| `packages/dto/` | `docs/contracts/dto/index.md` |
| OpenAPI | `docs/backend/openapi.yaml` (living spec) |

## Post-commit Algorithm

1. `git diff HEAD~1 --name-only`
2. Filter extensions: `.ts`, `.tsx`, `.prisma`, `.js` (k6)
3. Map each path → mirror target
4. If mirror missing: create stub from template
5. If mirror exists: update "Last synced" + changed symbols
6. Emit coverage report

## Coverage Report

```markdown
## Coverage Report — {commit_sha}

| Status | Path |
|--------|------|
| documented | backend/src/modules/auth/auth.service.ts |
| missing | backend/src/modules/billing/billing.service.ts |
| stale | docs/backend/modules/auth/index.md (>30d) |
```

## File Types Tracked

- TypeScript source files (`.ts`, `.tsx`)
- Prisma schemas (`.prisma`)
- k6 scripts (`.js`)
- Configuration schemas