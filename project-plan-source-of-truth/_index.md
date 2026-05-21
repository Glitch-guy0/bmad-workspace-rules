---
type: bmad-distillate
sources:
  - "../framework.md"
  - "../_bmad-output/brainstorming/consolidated-session-complete.md"
  - "../_bmad-output/research/research-complete.md"
  - "../docs/decisions/adrs-complete.md"
  - "../docs/engineering/engineering-complete.md"
  - "../documentation.md"
downstream_consumer: "project-planning"
created: "2026-05-21"
token_estimate: 4800
parts: 5
validation_status: "verified"
verified_by: "user"
verified_date: "2026-05-21"
---

# Project Plan — Source of Truth

> **Validated content.** All contents below have been reviewed and confirmed by the user. This is the foundation for all forward planning and implementation.

- Distilled 6 source documents (~48K tokens) into 5 self-contained sections
- **Primary source of truth: Product Documentation Framework** (framework.md — 2455 lines) — the governing methodology for product docs lifecycle, repo architecture, and file indexing
- Supporting sources: brainstorming session, research backlog, ADRs, engineering docs, documentation guidelines
- All decisions, constraints, named entities, and relationships preserved
- Project-specific tech stack details (architecture, skills, ADRs) follow the framework sections
- **Planning must reference this document first** before creating any new docs, architecture, or implementation

## Section Manifest

| # | File | Description | Priority |
|---|------|-------------|----------|
| 1 | `01-documentation-framework.md` | **Product Documentation Framework** — layered model, master flow (Q1-Q10), repo architecture, DTO handoffs, NFRs, tech debt, file indexing system | PRIMARY |
| 2 | `02-project-constitution.md` | Project Constitution — architecture philosophy, layered BE/FE, testing strategy, DX, naming, libraries of choice | supporting |
| 3 | `03-bmad-skill-system.md` | BMad skill anatomy, families (Helper/Writer), all R-01 through R-12 research findings | supporting |
| 4 | `04-architecture-decisions.md` | ADR 001 (Shared DTO), ADR 002 (Repository Triad), Promise Exception Registry, engineering practices | supporting |
| 5 | `05-documentation-guidelines.md` | Documentation types, general guidelines, contribution docs philosophy | supporting |

## Cross-Cutting Items

- **Documentation Framework governs all**: the methodologies in section 01 (layered model, Q1-Q10, repo architecture, file indexing) are the highest-priority reference for how documentation is structured and maintained
- Project Constitution provides tech-specific architecture rules; framework provides the doc methodology
- ADRs override constitution when conflicts arise; ADRs live in `docs/decisions/`
- Research topics (R-01 through R-12) inform both engineering docs and skill scaffolding
- BMad skills operate on a two-family system: Helpers (refine/compress) and Writers (create/maintain)
- Editorial pipeline: prose review → structure review → shard → index → distill (optional)
- Brownfield strategy: Surgical Strike — new files follow new rules, legacy files get migration tickets
