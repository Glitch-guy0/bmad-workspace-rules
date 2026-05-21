This section covers BMad Skill Anatomy, Skill Families, and Research Findings (R-01 through R-12). Part 3 of 5 from consolidated-session-complete.md, research-complete.md, engineering-complete.md.

## BMad Skill Anatomy (R-01)

### Skill Families
- **Workflow**: Thin SKILL.md → workflow.md or inline stages; examples: `bmad-brainstorming` (workflow.md, steps/*.md, assets/)
- **Agent (persona)**: Resolver → persona → menu → dispatch child skills; examples: `bmad-cis-agent-brainstorming-coach` (SKILL.md, customize.toml)
- **Multi-agent**: Orchestrator + `agents/*.md` sub-prompts; examples: `bmad-distillator` (agents/, resources/, scripts/)
- **Builder/meta**: Long SKILL.md + heavy references/ + scripts/; examples: `bmad-workflow-builder`

### Layer Responsibilities
- `SKILL.md`: Entry (name, description, activation, routing) — always required; keep thin if workflow is large
- `workflow.md`: Multi-step orchestration separate from entry — use when workflow has many stages + shared preamble
- `steps/*.md`: Sequential micro-steps with embedded rules — use when steps independently loaded (brainstorming pattern)
- `references/`: Carved prompts readable without SKILL.md — use when SKILL.md would exceed context
- `assets/`: Templates, CSV, static inputs — content is copied/filled, not executed
- `scripts/`: Deterministic ops (tests, scans, analysis) — use when wrong answer has a cost
- `agents/`: Subagent prompts for parallel/serial sub-runs — use when parent skill spawns focused sub-tasks
- `customize.toml`: Team overrides (activation, paths, persistent_facts) — use when skill is installed and team needs config without editing SKILL.md

### Frontmatter (Required)
- `name`: kebab-case, equals folder name
- `description`: `[5-8 word summary]. [Use when user says 'phrase' or 'phrase'.]` — quote trigger phrases, conservative (explicit) triggering is default

### Naming
- Official BMad: `bmad-{name}` prefix reserved
- Module skills: `{modulecode}-{name}` (e.g., `cis-brainstorm`)

### Path Conventions
- Bare paths resolve from skill root
- `{skill-root}` → skill install directory (where customize.toml lives)
- `{project-root}` → project working directory
- `{skill-name}` → skill directory basename

### Quality Bar
- Every line must pass: "Would an LLM do this correctly without being told?"
- Outcome-based instructions over numbered trivia steps
- Exact steps only for fragile ops (scripts, APIs, security)

### When to Choose Architecture
- <200 lines/few stages: inline everything in SKILL.md
- Many sequential stages/user checkpoints: workflow.md + steps/
- Large skill with independently useful sections: references/ carve-out
- Validation/scanning/metrics: scripts/ with tests
- Persona + menu of child skills: agent skill + customize.toml
- Cross-session artifact with resume: decision-log workspace

### Helper vs Writer (Project Registry)
- **Helper**: Refine/compress project docs — prose → structure → shard → index → distill
- **Writer**: Create/maintain technical docs — tech-writer, document-project, generate-project-context

### References
- `.agents/skills/bmad-workflow-builder/references/skill-quality-principles.md`
- `.agents/skills/bmad-workflow-builder/references/standard-fields.md`
- `.agents/skills/bmad-workflow-builder/references/complex-workflow-patterns.md`

## Research Topics (R-02 through R-12)

### R-02: Prisma Multi-File Schema
- GA in Prisma v6.7.0+ (was preview `prismaSchemaFolder` in 5.15+)
- Layout: `backend/prisma/schema.prisma` (generator + datasource only) + `models/{user,auth,...}.prisma` + `migrations/`
- Configuration: `package.json` `prisma: { schema: "./prisma" }` or `prisma.config.ts` (v7+)
- Commands: `prisma validate`, `prisma generate`, `prisma migrate dev --schema ./prisma`
- Rules: schema.prisma and migrations/ at configured schema root; do not split datasource across files; avoid duplicate definitions between prisma models and repository/schemas/*.ts

### R-03: k6 Per-Layer Load/Performance Grid
- Backend: Protocol (HTTP) — API latency, throughput, error rate
- Microservices: Protocol — service SLOs, dependency timeouts
- Frontend: Browser module (Chromium CDP) — web vitals, render, critical flows
- Layout: `testing/load/{shared/config.js + thresholds.js, backend/*.js, microservices/*.js, frontend/*.browser.js}`
- Thresholds: API p95 < 500ms, Frontend LCP < 2.5s
- NPM scripts: `load:backend`, `load:frontend`, `load:all`

### R-04: TanStack-First Frontend Scaffold Gate
- State split: TanStack Query for server state, TanStack Router (SPA) or Next App Router, TanStack Table for data grids, Redux Toolkit for client-only state
- Greenfield checklist: @tanstack/react-query with QueryClientProvider, API hooks under `src/lib/api/` with query keys convention, no useEffect+fetch for server data, Redux slices must not store server-fetched entities, TanStack Table before MUI DataGrid
- Brownfield: surgical strike (new files TanStack-only); legacy Redux-server code → migration ticket; ADR if exception needed
- Query key convention: `const queryKeys = { users: ['users'], user: (id) => ['users', id] }`

### R-05: Utility/Static Class Taxonomy
- Start atomic: one function per file until 3+ functions share a topic
- Promote at ≥3: group into TopicUtils static class or topic/ folder
- Domain over generic: prefer `auth/password.utils.ts` over mega `StringUtils`
- No business logic: utils are pure transforms; services own workflows
- Max class size: <150 lines; split by sub-topic if larger
- Directory: `src/utils/{datetime/{formatIso,parseSafe,DateTimeUtils},auth/password.utils.ts}`
- Tests: co-located `*.test.ts` per utility file

### R-06: Promise Exception Registry (T2)
- Default: async/await in application code (services, controllers)
- Exception: native callbacks wrapped in promisify, stream pipelines, third-party APIs with no async variant
- Never: `.then()` for business logic flow control
- Registry at `docs/decisions/promise-exceptions.md` (ADR-style, append-only)
- Approved entries: `fs.promises` pipeline with streams (*.repository.ts, src/utils/stream*.ts), `zlib` stream chaining (src/utils/compression*.ts), third-party callback APIs (*.adapter.ts)
- Process: PR referencing registry → explain why async/await not viable → 1 senior reviewer approval → add entry with date
- Future: `@typescript-eslint/no-restricted-syntax` with allowlist

### R-07: bmad-workspace-rules Skill Skeleton
- Skill package: `.agents/skills/bmad-workspace-rules/` — SKILL.md + customize.toml + references/ (constitution-loader, mirror-docs-rules, surgical-strike, coverage-report, helper-writer-router) + assets/ (coverage-report-template)
- Recommended family: complex workflow skill (not persona agent) with optional customize.toml hooks
- Activation flow: bmad-dev-story → bmad-workspace-rules (prepend hook) → resolve customize.toml → load constitution → git diff HEAD~1 → route to mode (initial-setup, post-commit, re-baseline, surgical-strike) → deviation check → ADR if needed
- Config keys: constitution_path, research_index_path, docs_output_path, adr_path, mode (initial-setup|post-commit|re-baseline|surgical-strike), max_files_per_session, yolo_defaults_enabled

### R-08: ADRs for T1 + T3
- ADR 001 (Shared DTO): packages/dto/ internal package — TypeScript types + Zod schemas, no business logic, lockstep versioning
- ADR 002 (Repository Triad): src/repository/{schemas,models,cache} + per-module *.repository.ts orchestration

### R-09: Mirror Docs Layout + Post-Commit Cartographer
- Mirror mapping: `backend/src/modules/{domain}/` → `docs/backend/modules/{domain}/index.md`; `frontend/src/components/{feature}/` → `docs/frontend/components/{feature}/index.md`; `packages/dto/` → `docs/contracts/dto/index.md`; OpenAPI → `docs/backend/openapi.yaml`
- Post-commit algorithm: git diff HEAD~1 → filter (.ts, .tsx, .prisma, .js) → map to mirror targets → create stub if missing / update "Last synced" if exists → emit coverage report
- Coverage report: table with Status (documented/missing/stale) per path

### R-10: Editorial Pipeline Automation
- Chain: bmad-editorial-review-prose → bmad-editorial-review-structure → bmad-shard-doc (conditional, >500 lines) → bmad-index-docs → bmad-distillator (optional, large corpus only)
- Configuration: editorial_pipeline_enabled (default: true), auto_shard_threshold (default: 500), dry_run_mode
- Prose review: auto after user braindump or bulk edit
- Structure review: auto after prose pass
- Shard: conditional at >500 lines or user flag
- Index: auto per folder touched

### R-11: YOLO Safety Interlock + Pre-Flight Quiz
- Constitution path missing → refuse YOLO, require init.md
- >N files would change → refuse, require explicit confirm
- Destructive op detected → dry-run only with diff
- Brownfield + no project-context.md → suggest bmad-generate-project-context first
- YOLO keyword invoked → skip Q&A but apply file cap + undo note
- Pre-flight quiz: max 2 questions for architecture choices, verify constitution path exists, check git context
- Dry-run format: unified diff + undo block in session log (git checkout + rm commands)

### R-12: Helper-vs-Writer Skill Dispatcher
- Classification: unstructured notes → Helper chain; compress brainstorm → Helper (distillator); new API/module tech doc → Writer; unknown brownfield → Writer (generate-project-context); post-implementation → workspace rules; architecture deviation → ADR
- Decision flow: Brownfield? → generate-project-context first. Needs structuring? → Helper chain. Net-new tech doc? → Writer. After dev-story? → bmad-workspace-rules
