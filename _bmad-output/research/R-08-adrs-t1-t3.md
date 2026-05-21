---
id: R-08
status: closed
priority: P0
brainstorm_ref: 'Part 2 R-08; T1, T3; Cat #7'
---

# R-08 — ADRs for resolved tensions T1 and T3

## Goal

Record architecture decisions for shared DTO package and repository triad so implementation and `bmad-workspace-rules` deviations have a durable audit trail (Cat #7 ADR-First).

## Research questions

| # | Question |
|---|----------|
| 1 | What exactly is in scope for `packages/dto/` — types only, or Zod schemas too? |
| 2 | How do FE/BE import without circular deps or runtime coupling? |
| 3 | Repository triad: what lives in `schemas/` vs `models/` vs `cache/` vs module `*.repository.ts`? |
| 4 | Migration path for brownfield projects violating T1/T3? |

## ADR 001 — Shared DTO package (T1 resolved)

**Status:** Proposed — ready to file  
**Path:** `docs/decisions/001-shared-dto-package.md`

### Context

Backend and frontend must share API contracts without duplicating types. Brainstorm resolved T1: internal package at `packages/dto/`.

### Decision

- Create `packages/dto/` as a workspace-internal package
- Export **TypeScript types and Zod schemas** used at API boundaries (confirm in spike: types-only vs schemas)
- FE and BE depend on `packages/dto` via package name; **no** business logic in DTO package
- Versioning: lockstep with API changes; breaking changes require coordinated release

### Consequences

**Positive:** Single contract source; compiler catches drift  
**Negative:** Extra package to publish/build in CI  
**Risks:** Scope creep (putting services in dto package) — forbid via lint/rule

### Structure (recommended)

```
packages/dto/
├── package.json
├── tsconfig.json
├── src/
│   ├── index.ts
│   └── auth/
│       ├── auth.dto.ts      # Zod + inferred types
│       └── auth.types.ts    # if split needed
```

## ADR 002 — Repository triad (T3 resolved)

**Status:** Proposed — ready to file  
**Path:** `docs/decisions/002-repository-triad.md`

### Context

Data access needs consistent placement for schemas, domain models, and cache layers. Per-module `*.repository.ts` orchestrates calls.

### Decision

```
src/repository/
  schemas/     # DB/ORM schema definitions (e.g. User.schema.ts)
  models/      # Domain models / mappers
  cache/       # Cache adapters (e.g. UserSession.cache.ts)
src/modules/*/
  *.repository.ts   # Orchestration only — composes triad, no raw SQL scattered
```

- Module repositories **must not** embed schema definitions inline
- Services call module repositories; repositories call triad layers
- Prisma client usage: see R-02 for schema file layout

### Consequences

**Positive:** Predictable data layer; easier onboarding  
**Negative:** More files per entity; migration effort on brownfield  
**Risks:** Triad becomes dumping ground — enforce naming + review

## Acceptance criteria

- [ ] Both ADR files exist under `docs/decisions/`
- [ ] Consolidated brainstorm marks T1/T3 as ADR-documented
- [ ] `bmad-workspace-rules` references ADR paths for deviation detection
- [ ] Brownfield migration notes included in each ADR

## Next steps

- [ ] Confirm Zod-in-dto vs types-only with one example module
- [ ] File ADRs (copy sections above into `docs/decisions/`)
- [ ] Add entries to `docs/engineering/deferred-decisions.md` only if items remain open

## References

- Brainstorm Appendix A — backend layered architecture
- Brainstorm Part 4 — repository layout target tree
- Cat #16 Shared DTO Bridge, Cat #13 Repository Triad
