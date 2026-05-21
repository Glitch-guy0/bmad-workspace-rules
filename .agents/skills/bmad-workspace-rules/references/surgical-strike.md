# Surgical Strike Protocol

Diff-only documentation update for brownfield projects (Cat #4). No full tree walk.

## When to Use

- Brownfield touch where full repo scan is wasteful
- Post-commit mode with specific file changes
- Incremental updates preferred over complete rebuilds

## Protocol

1. Run `git diff --name-only HEAD~1` to get changed paths
2. Filter to source files (exclude lock files, build artifacts)
3. For each changed file, determine doc impact:
   - API change → update `docs/backend/openapi.yaml`
   - New module → add to `docs/backend/index.md`
   - Architecture change → check constitution deviation
4. Only update docs that are affected by the changes

## Path Filters

Always exclude:
- `package-lock.json`, `yarn.lock`
- `.next/`, `node_modules/`, `dist/`
- Test output, coverage reports

Focus on:
- `src/**/*.ts` (new/changed modules)
- `prisma/*.prisma` (schema changes)
- `docs/**/*` (doc modifications)

## Completion Criteria

- [ ] All changed source files accounted for in docs
- [ ] No undocumented public APIs
- [ ] Mirror docs reflect current state