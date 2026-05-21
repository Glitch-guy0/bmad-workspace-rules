This section covers Architecture Decision Records and Published Engineering Practices. Part 4 of 5 from docs/decisions/adrs-complete.md, docs/engineering/engineering-complete.md.

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

## BMad Skill Anatomy (Engineering Published)
- Skill families table: Workflow (thin SKILL.md → workflow.md), Agent (resolver → persona → menu), Multi-agent (orchestrator + agents/*.md), Builder/meta (long SKILL.md + references/ + scripts/)
- Directory structure: SKILL.md, workflow.md, steps/*.md, references/, assets/, scripts/, agents/, customize.toml
- Frontmatter: name (kebab-case), description ([5-8 word summary]. [Use when user says 'phrase'.])
- Helper vs Writer: Helper = prose → structure → shard → index → distill; Writer = tech-writer, document-project, generate-project-context
- Quality bar: "Would an LLM do this correctly without being told?"; outcome-based instructions over numbered trivia

## Editorial Pipeline Automation (Engineering Published)
- Chain: prose review → structure review → shard (conditional >500 lines) → index → distill (optional)
- Prose review: auto after braindump or bulk edit; Structure review: auto after prose pass; Shard: conditional; Index: auto per folder; Distill: optional (brainstorm/compression only)
- Config: editorial_pipeline_enabled, auto_shard_threshold (500), dry_run_mode

## TanStack-First Frontend (Engineering Published)
- Server state: TanStack Query; Routing: TanStack Router (SPA) or Next App Router; Tables: TanStack Table; Client UI: Redux Toolkit or React state
- Greenfield checklist: QueryClientProvider, API hooks under src/lib/api/ with query keys, no useEffect+fetch, Redux slices must not store server entities, TanStack Table before MUI DataGrid
- Brownfield: new files TanStack-only; legacy Redux-server code → migration ticket; ADR for third-party widget exceptions
- Query key convention: `{ users: ['users'], user: (id) => ['users', id] }`

## k6 Load Testing Grid (Engineering Published)
- Layer strategy: Backend (Protocol HTTP — latency, throughput, error rate); Microservices (Protocol — SLOs, timeouts); Frontend (Browser module — web vitals, render, critical flows)
- Layout: `testing/load/{shared/config.js + thresholds.js, backend/*.js, microservices/*.js, frontend/*.browser.js}`
- Thresholds: API p95 < 500ms, Frontend LCP < 2.5s
- NPM scripts: load:backend, load:frontend, load:all

## Mirror Docs Cartographer (Engineering Published)
- Mirror mapping: code paths → docs/ mirrored structure; post-commit: git diff HEAD~1 → filter (.ts, .tsx, .prisma, .js) → create/update mirrors → coverage report
- File types tracked: TypeScript (.ts, .tsx), Prisma (.prisma), k6 (.js), config schemas

## Prisma Multi-File Schema (Engineering Published)
- Prisma v6.7.0+ required for GA multi-file support
- Layout: `backend/prisma/{schema.prisma (generator+datasource only), models/{user,auth,...}.prisma, migrations/}`
- Config: `package.json: { "prisma": { "schema": "./prisma" } }` or prisma.config.ts (v7+)
- Commands: `prisma validate`, `prisma generate`, `prisma migrate dev --schema ./prisma`
- Rules: schema.prisma must sit at configured schema root; do not split datasource without verifying version; avoid duplicate definitions

## Utility Taxonomy (Engineering Published)
- Start atomic, promote at ≥3 related functions; domain over generic; no business logic; max class size <150 lines
- Directory: `src/utils/{datetime/{formatIso, parseSafe, DateTimeUtils}, auth/password.utils.ts}`
- Naming: atomic (formatIso.ts), grouped (DateTimeUtils.ts), domain (auth/password.utils.ts)
- Tests: co-located *.test.ts per utility file

## YOLO Safety Interlock (Engineering Published)
- Constitution missing → refuse; >N files → refuse; destructive op → dry-run; brownfield + no project-context.md → suggest generate-project-context; YOLO keyword → skip Q&A with file cap + undo note
- Pre-flight quiz: max 2 architecture questions, verify constitution path, check git context
- Dry-run: unified diff + undo block in session log (git checkout + rm commands)

## PDR — Product Decision Record
- Product-level equivalent of ADR; for decisions that shape requirements rather than define them
- Captures decisions previously invisible (made in Slack/meetings, quietly assumed in milestone doc)
- Examples: "Should export be a feature or a standalone product?", "Onboarding: wizard or blank state?", "Which user segment first?"
- Format: PDR-[n]: Title | Status (Proposed/Accepted/Superseded) | Date | Raised by | Affects | QUESTION | CONTEXT | RESEARCH DONE | OPTIONS CONSIDERED (A/B with pros/cons) | DECISION | TRADE-OFFS ACCEPTED | OUTCOME (filled post-ship)
- Filed at: `product-repo/milestones/active/[slug]/pdrs/PDR-[n]-[title].md`
- Product Decision Records live in the product repo, not the dev repo

## SDR — Strategic Decision Record
- VP-level equivalent of ADR; for strategic bets that frame multiple milestones
- Research domains: market sizing, segment analysis, competitive landscape, business model, build vs buy vs partner
- Filed at: `strategy/sdrs/SDR-[n]-[title].md`
- Feeds into Strategic Directive documents that trigger PM work

## Decision Record Hierarchy
- Three levels, one record type per level:
  - **VP**: SDR (Strategic Decision Record) — market + business context
  - **PM**: PDR (Product Decision Record) — user + product context
  - **Senior Dev**: ADR (Architecture Decision Record) — technical + system context
- Each level has its own research doc (Strategic Research Doc → Product Research Doc → Spike Doc) feeding the decision record
- Decisions flow down; feedback flows up
