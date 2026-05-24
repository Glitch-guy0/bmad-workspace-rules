This section covers Architecture Decision Records.

## ADR 001 — Shared DTO Package
- **Status**: Accepted. **Date**: 2026-05-19. **Decider**: Prajwal
- Context: BE and FE must share API contracts without duplicating types; brainstorming resolved T1 for internal package at packages/dto/
- Decision: Create packages/dto/ as workspace-internal package; export TypeScript types + Zod schemas used at API boundaries; FE and BE depend via package name; no business logic in DTO package
- Versioning: lockstep with API changes; breaking changes require coordinated release
- Structure: `packages/dto/{package.json, tsconfig.json, src/{index.ts, auth/{auth.dto.ts, auth.types.ts}}}`
- Positives: single contract source, compiler catches drift
- Negatives: extra package to publish/build in CI
- Risks: scope creep (services in dto) — forbid via lint/rule
- Migration (brownfield): extract types from BE controllers → packages/dto/ → add FE dep on @workspace/dto → replace FE inline types with DTO imports → add lint rule

## ADR 002 — Repository Triad Pattern
- **Status**: Accepted. **Date**: 2026-05-19. **Decider**: Prajwal
- Context: data access needs consistent placement for schemas, domain models, cache layers; per-module *.repository.ts orchestrates calls
- Decision: `src/repository/{schemas/, models/, cache/}` + `src/modules/*/*.repository.ts` (orchestration only)
- Module repositories must not embed schema definitions inline; services call module repositories; repositories call triad layers
- Positives: predictable data layer, easier onboarding
- Negatives: more files per entity, migration effort on brownfield
- Risks: triad becomes dumping ground — enforce naming + review
- Migration (brownfield): create src/repository/ structure → move schemas → move models → extract cache → update module repositories

## Promise Exception Registry
- **Status**: Accepted. **Date**: 2026-05-20. **Decider**: Prajwal
- Resolves T2 tension between constitution (async/await only) and braindump allowance for .then().catch()
- Default: async/await in application code; Exception: native callbacks in promisify, stream pipelines, third-party APIs with no async variant; Never: .then() for business logic
- Registry entries: `fs.promises` pipeline with streams (*.repository.ts, src/utils/stream*.ts — rationale: streams with known error types, backpressure control); `zlib` stream chaining (src/utils/compression*.ts — multi-step transform pipes); third-party callback APIs (*.adapter.ts — no native async variant)
- Process: PR → explain why async/await not viable → 1 senior reviewer approval → add entry with date
- Future: `@typescript-eslint/no-restricted-syntax` with allowlist


