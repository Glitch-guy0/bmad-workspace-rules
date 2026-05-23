---
type: bmad-distillate
sources:
  - "../final-plan.md"
  - "../framework.md"
  - "../_bmad-output/brainstorming/consolidated-session-complete.md"
  - "../_bmad-output/research/research-complete.md"
  - "../docs/decisions/adrs-complete.md"
  - "../docs/engineering/engineering-complete.md"
  - "../documentation.md"
downstream_consumer: "project-planning"
created: "2026-05-23"
token_estimate: 13000
parts: 10
validation_status: "draft"
verified_by: ""
verified_date: ""
---

# Project Plan — Source of Truth

> Validated content. Foundation for all forward planning and implementation.

## Orientation

- Distilled from `final-plan.md` (34,765 source tokens), a living documentation framework for products from MVP to year 5+. Describes layered documentation model, two-repo product/engineering system, decision-tracking hierarchy, and BMAD skill automation.
- Supporting sources: brainstorming session, research backlog, ADRs, engineering docs, documentation guidelines.
- All processes, templates, rules, file structures, and conventions preserved factually. Prose elaboration removed.
- Split into 10 sections covering framework, repo architecture, NFR/debt/indexing, decision-making hierarchy, BMAD skill setup, project constitution, ADRs, documentation guidelines, export boilerplate structure, and project goal.

## Section Manifest

| # | File | Topic | Priority |
|---|------|-------|----------|
| 1 | `01-documentation-framework.md` | Q1-Q10: Idea capture, milestone structure, TDD, ADR, API, ERD, validation gates, implementation planning, testing, definition of done | PRIMARY |
| 2 | `02-repo-agent-structure.md` | Two-repo architecture, DTO handoffs, product/dev file trees, agent flow, stress test, naming conventions, cross-repo doc map | PRIMARY |
| 3 | `03-nfr-tech-debt-indexing.md` | NFR patterns/flows, tech debt (accepted/postponed), file indexing system (headers, indexes, link chain, agent nav modes) | PRIMARY |
| 4 | `04-decision-making-org-flow.md` | PDR & Product Research Doc, three-tier org (VP/PM/Senior Dev), handoff documents, feedback loops, strategic layer structure, SDR | PRIMARY |
| 5 | `05-bmad-skill-setup-slice.md` | BMAD skill internal structure, INIT setup, submodule/single-repo options, Sync decision layer, vertical slice planning, three operations (INIT/VALIDATE/SYNC) | PRIMARY |
| 6 | `06-project-constitution.md` | Project Constitution — architecture philosophy, layered BE/FE, testing strategy, DX, naming, libraries of choice; detailed coding standards (module structure, controller/service/repository patterns, middleware, DB conventions, component patterns, API client, naming, testing, quality rules, git conventions, AI agent rules) | supporting |
| 7 | `07-architecture-decisions.md` | ADR 001 (Shared DTO), ADR 002 (Repository Triad), Promise Exception Registry, PDR/SDR hierarchy, engineering practices | supporting |
| 8 | `08-documentation-guidelines.md` | Documentation types, general guidelines, contribution docs philosophy | supporting |
| 9 | `09-export-boilerplate.md` | Export folder structure (`src/`), agent layout conventions, adding new agents | PRIMARY |
| 10 | `10-project-goal.md` | Project goal, context, problem, Archiver agent overview, design principles, scope boundaries | PRIMARY |

## Cross-Cutting Items

- Progressive disclosure: 4 layers (Layer 1: one-liner, Layer 2: summary, Layer 3: brief flow, Layer 4: detailed spec) — applied to docs AND file system (repo _index.md → folder _index.md → file header → content)
- The 5-Year Arc: Month 1-2 (MVP, no docs needed) → Year 1-2 (tribal knowledge, 3-4 people hold system) → Year 3 (key person leaves, panic doc sprint → Confluence graveyard) → Year 4-5 (nobody knows why decisions made, debt compounds). Root cause: failure of structure, not discipline
- Big org patterns: Google (one doc per feature, owner named, status visible, written justifications), Amazon (Six-Pager), Stripe (RFC process). Common thread: one owner per doc, visible status, recorded why
- The Master Flow: Raw idea → [Q1] Idea Capture → Discovery Backlog → [Q2] Validated → Added to Milestone → [Q3] Milestone Structured (Epic→Stories→AC) → [Q4] Dependency check → [Q5] Milestone Confirmation File (handoff) → [Q6] Tech Document Stack (TDD/ADR/API/ERD/Spike) → [Q7] Validation & Sign-Off → [Q8] Implementation Planning (layers 1-3) → [Q9] Test scenarios + atomic change plan → [Q10] Implementation + doc updates
- Format rules that work: lead with status and ownership; collapse detail by default; diagrams before prose; tables for comparisons; short sentences, active voice
- Tackling documentation debt: Phase 1 (1-2 days): headers everywhere with Layer 1-2. Phase 2 (1-2 weeks): flow diagrams for 20% of features responsible for 80% of questions/bugs. Phase 3 (ongoing): deep docs on demand. Never document stable things nobody touches — dead docs mislead more than no docs
- Decision reference copies in both repos: type=decision-reference, contains source path in originating repo, synced date, summary from receiving team's perspective, impact on this side
- Kebab-case slugs for all files/folders. ISO 8601 dates (YYYY-MM-DD). Status lives in file header, never filename. Lifecycle communicated by folder location (active → confirmed → completed; postponed → nfr-proposals → planning)
- All documents open with YAML frontmatter: slug, type, status, owner, created, updated, upstream, downstream
- Three DTOs: DTO 1 (Milestone Confirmation, product→dev), DTO 2 (Implementation Report, dev→product), DTO 3 (NFR Proposal, dev→product)
- Every folder must have _index.md. Underscore prefix keeps it sorted to top
- Editorial pipeline: bmad-editorial-review-prose → bmad-editorial-review-structure → bmad-shard-doc (conditional >500 lines) → bmad-index-docs → bmad-distillator (optional)
- Brownfield strategy: Surgical Strike — new files follow new rules, legacy files get migration tickets
- Sections 01-05 from final-plan.md distillate. Sections 06-08 preserved from earlier project-plan source-of-truth. Sections 09-10 added during agent build (Archiver documentation orchestrator).
- **Planning must reference this document first** before creating any new docs, architecture, or implementation.
