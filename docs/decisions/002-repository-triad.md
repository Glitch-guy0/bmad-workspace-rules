---
id: 002
title: Repository Triad Pattern
status: accepted
date: 2026-05-19
deciders: Prajwal
---

# ADR 002 — Repository Triad Pattern

## Status

Accepted

## Context

Data access needs consistent placement for schemas, domain models, and cache layers. Per-module `*.repository.ts` orchestrates calls.

## Decision

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

## Consequences

**Positive:**
- Predictable data layer; easier onboarding

**Negative:**
- More files per entity; migration effort on brownfield

**Risks:**
- Triad becomes dumping ground — enforce naming + review

## Migration (Brownfield)

For existing projects:
1. Create `src/repository/` structure
2. Move existing schemas to `schemas/`
3. Move model definitions to `models/`
4. Extract cache logic to `cache/`
5. Update module repositories to use triad paths