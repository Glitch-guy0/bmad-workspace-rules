---
name: workspace-rules
description: Workspace conventions reference — Q1-Q10 lifecycle, naming, frontmatter, progressive disclosure, artifact types, file indexing, decision hierarchy
---

# Workspace Rules

Self-contained reference for the workspace conventions Archiver enforces.

> **Path context:** All artifact paths in this document (ideas/, milestones/, planning/, reports/, etc.) resolve from `{output-folder}`. Config and memory paths (`_bmad/`, sanctum) resolve from the real `{project-root}`. See SKILL.md Path Resolution for details.

## The Q1-Q10 Lifecycle

The complete milestone lifecycle from idea capture through implementation and retrospective.

### Business & Product Level (Q1-Q5)

| Phase | What | Output |
|-------|------|--------|
| Q1 — Idea Capture | Raw concept captured | `ideas/[slug].md` |
| Q2 — Requirement Structuring | Validated idea becomes requirement with AC | `milestones/active/[slug]/requirements/[req-slug].md` |
| Q3 — Milestone Structure | Epic → Milestone → Story → Task | `milestones/active/[slug]/milestone.md` |
| Q4 — Dependency Check | Map against current product state | Delta analysis in milestone |
| Q5 — Milestone Confirmation | Signed-off handoff to engineering | `milestones/confirmed/[slug]/milestone-confirmed.md`, DTO 1 |

### Technical & Structural Level (Q6-Q10)

| Phase | What | Output |
|-------|------|--------|
| Q6 — Technical Document Stack | TDD, ADR, API contracts, ERD, Spikes | `planning/[slug]/` artifacts |
| Q7 — Validation & Sign-Off | Two-gate review (product + technical) | Gate records, sign-off |
| Q8 — Implementation Planning | 3 layers: brainstorm → breakdown → timeline | `implementation-brainstorm.md`, `atomic-change-plan.md` |
| Q9 — Testing & Atomic Changes | Test scenarios + atomic commits | `test-scenarios.md`, atomic PRs |
| Q10 — Implementation & Doc Updates | Build, ship, update docs, retro | Implementation, `reports/[slug]-report.md`, DTO 2 |

## Progressive Disclosure (Layer 1-4)

Every document structured in 4 progressive layers:

| Layer | Depth | What |
|-------|-------|------|
| Layer 1 | One-liner | What this is in one sentence |
| Layer 2 | Summary | A few sentences on scope and purpose |
| Layer 3 | Brief flow | Key details, process, constraints |
| Layer 4 | Detailed spec | Full reference, edge cases, rationale |

Applied to both docs AND file system: repo `_index.md` → folder `_index.md` → file header → file content.

## Two-Gate Validation System

Before implementation begins, two separate review gates:

**Gate 1 — Milestone Confirmation Review (product-level, before TDD)**
- Reviewers: PM, senior engineer, stakeholder
- Checklist: goal clear, AC testable, out-of-scope explicit, dependencies confirmed, metrics defined, scope achievable, no contradictions
- Output: Confirmed (proceed to TDD) or Revise

**Gate 2 — Technical Design Review (engineering-level, after TDD draft)**
- Reviewers: Engineering lead + senior engineer not on team
- Checklist: TDD addresses all reqs, data model backward-compatible, API follows conventions, edge cases handled, performance/security reviewed, no conflicts, ADRs filed, implementation breakable into independent pieces
- Output: Approved (proceed to planning) or Revise

## Frontmatter Format

All documents open with YAML frontmatter. Required fields:

| Field | Purpose |
|-------|---------|
| `slug` | Unique kebab-case identifier |
| `type` | Document type (idea, milestone, adr, report, etc.) |
| `status` | Lifecycle status (draft, active, confirmed, completed, etc.) |
| `owner` | Who owns this document |
| `created` | ISO 8601 date (YYYY-MM-DD) |
| `updated` | Last modified date |
| `upstream` | Source document this derives from |
| `downstream` | Consumer of this document |

## Status Values Per Type

| Type | Status Values |
|------|---------------|
| idea | 💡 raw / 🔍 exploring / ✅ validated / ⏸ parked / ❌ rejected |
| milestone | 📋 planning / ✅ confirmed / 🚀 in-progress / ✓ complete / ⏸ paused |
| requirement | 📝 draft / ✅ confirmed / ❌ descoped |
| nfr | 📝 proposed / 🔍 reviewing / ✅ confirmed / ❌ rejected |
| tech-debt | ⏸ postponed / ✅ accepted / 🔨 resolving / ✓ resolved |
| feature | 🔬 experimental / 🔶 beta / ✅ live / ❌ deprecated |
| adr | 📝 proposed / ✅ accepted / → superseded by ADR-[n] |
| tdd | 📝 draft / 🔍 in-review / ✅ approved / ✓ implemented |
| spike | 🔍 in-progress / ✓ complete |
| report | 📝 draft / ✅ sent |
| stress-test | 🔍 in-progress / ⚠️ open-items / ✓ complete |
| progress | 🔨 in-progress / ⏸ blocked / ✓ complete |

## File Naming Conventions

- **Slugs**: kebab-case (e.g., `multi-photo-upload`, `bulk-export-feature`, `nfr-upload-concurrency`, `debt-session-management`)
- **Dates**: ISO 8601 YYYY-MM-DD (e.g., `session-2026-05-21.md`)
- **ADR numbering**: padded integers, sequential per repo (ADR-001, ADR-002). Never reuse. Superseded ADR links to replacement.
- **PDR numbering**: sequential per repo (PDR-001, PDR-002). Same format as ADRs.
- **SDR numbering**: sequential per repo (SDR-001, SDR-002). Same format as ADRs.
- **NFR slug prefix**: `nfr-`. Tech debt slug prefix: `debt-`. Feature slug: same as idea slug pattern.
- **Versioning**: inside confirmed file header (v1.0, v1.1). Never in filename. Version increments logged in sign-off-log.md.
- **Status**: never in filename. Lives in the file header.
- **Lifecycle**: communicated by folder location (active → confirmed → completed; postponed → nfr-proposals → planning).
- **Index files**: every folder has `_index.md`. Underscore prefix keeps it sorted to the top.

## Documentation Lifecycle (10 Phases)

1. **Idea** — raw concept → `ideas/[slug].md`
2. **Validation** — explored, pressure-tested
3. **Milestone** — requirements structured, added to milestone
4. **Stress Test** — Q&A for edge cases and scope
5. **Sign-off** — ready for approval
6. **Dev Planning** — TDD, ADRs, API contracts, ERDs drafted
7. **Implementation** — active development
8. **Report** — implementation report generated
9. **Update** — product docs updated post-implementation
10. **Complete** — done, archived

## Artifact Types and Paths

| Artifact | Path Pattern | Type |
|----------|-------------|------|
| Idea | `ideas/[slug].md` | idea |
| Milestone | `milestones/active/[slug]/milestone.md` | milestone |
| Requirement | `milestones/active/[slug]/requirements/[req-slug].md` | requirement |
| Stress Test Session | `milestones/active/[slug]/stress-test/session-[date].md` | stress-test |
| Milestone Confirmed | `milestones/confirmed/[slug]/milestone-confirmed.md` | milestone-confirmed |
| Sign-off Log | `milestones/confirmed/[slug]/sign-off-log.md` | sign-off-log |
| PDR | `milestones/active/[slug]/pdrs/PDR-[n]-[title].md` | pdr |
| Product Research Doc | `milestones/active/[slug]/research/research-[slug].md` | product-research |
| ADR | `planning/[slug]/adrs/ADR-[n]-[title].md` | adr |
| TDD | `planning/[slug]/tdd.md` | tdd |
| API Contract | `planning/[slug]/api-contracts/[endpoint].md` | api-contract |
| ERD | `planning/[slug]/erd.md` | erd |
| Spike | `planning/[slug]/spikes/[slug].md` | spike |
| Implementation Brainstorm | `planning/[slug]/implementation-brainstorm.md` | implementation-brainstorm |
| Atomic Change Plan | `planning/[slug]/atomic-change-plan.md` | atomic-change-plan |
| Test Scenarios | `planning/[slug]/test-scenarios.md` | test-scenarios |
| Vertical Slice Plan | `planning/[slug]/vertical-slices/vs-[n]-[name].md` | vertical-slice |
| Progress Log | `implementation/[slug]/progress.md` | progress |
| Decisions Log | `implementation/[slug]/decisions-log.md` | decisions-log |
| Implementation Report | `reports/[slug]-report.md` | report |
| NFR Proposal | `nfr-proposals/[slug].md` | nfr |
| NFR Entry (in milestone) | `milestones/active/[slug]/requirements/nfr-[slug].md` | nfr |
| Tech Debt Accepted | `tech-debt/accepted/[debt-slug].md` | tech-debt |
| Tech Debt Postponed | `tech-debt/postponed/[debt-slug].md` | tech-debt |
| SDR | `strategy/sdrs/SDR-[n]-[title].md` | sdr |
| Strategic Directive | `strategy/directives/[directive-slug].md` | strategic-directive |
| Strategic Research Doc | `strategy/research/[slug].md` | strategic-research |
| Retro Note | appended to milestone doc after ship | — |
| Release Note Entry | in release notes file | — |

## DTO Handoff Formats

Three DTOs cross the repo boundary:

### DTO 1 — Milestone Confirmation (product→dev)
- Path: `dto/outgoing/[milestone-slug]-confirmed.md`
- Status: CONFIRMED, read-only after creation
- Trigger: Stress test passed + sign-off complete (Gate 1)

### DTO 2 — Implementation Report (dev→product)
- Path: `dto/outgoing/[milestone-slug]-report.md`
- Fields: Status (Complete/Partial/Blocked), What shipped (per req with ✅/⚠️/❌), Deviations, New ADRs, Product doc updates required, Evolution timeline entry, Feature index entries, Retro note

### DTO 3 — NFR Proposal (dev→product)
- Path: `nfr-proposals/[slug].md`
- Crosses from dev repo to product repo for review

## NFR — Non-Functional Requirements

### Three Patterns
- **Pattern A (Cross-cutting)**: affects whole system → standalone NFR milestone
- **Pattern B (Feature-attached)**: belongs alongside planned milestone → attaches as NFR entry
- **Pattern C (Debt-driven)**: fixing something degrading → standalone NFR milestone, urgent

### NFR Flow
Senior dev observes need → creates `nfr-proposals/[slug].md` → crosses to product repo (DTO 3) → PM reviews → standalone milestone or attach to existing

### NFR Proposal File
Frontmatter: slug, type=nfr, status (📝 proposed), owner, created/updated, upstream, downstream
Body: Raised by, Date, Category (Performance/Security/Scalability/Reliability/Maintainability/Observability/Compliance), What, Why now, Current state (measurable gap), Target threshold, Impact if not addressed, Affected systems, Milestone preference, Rough effort

### NFR Entry in Milestone
Frontmatter: slug=nfr-[slug], type=nfr, status, owner, upstream (nfr-proposals/[slug]), downstream
Body: NFR name, Category, Raised by + date, Priority (MoSCoW), What, AC (threshold/measured by/baseline), Scope, Engineering Review Notes, Sign-off

## Tech Debt

### Accepted Debt
Conscious documented decision to live with suboptimal. Always links to an ADR. Deliberate trade-off with known cost + documented exit conditions.

Frontmatter: slug, type=tech-debt, status (✅ accepted), owner, created/updated, upstream, downstream (adrs/ADR-[n])
Body: What, Why it exists, Known cost/risk, Why accepted, Exit conditions

### Postponed Debt
Will be fixed but not now. Has trigger condition or milestone target. When trigger hit → converts to NFR proposal.

Frontmatter: slug, type=tech-debt, status (⏸ postponed), owner, upstream, downstream (nfr-proposals/[slug] when trigger hit)
Body: What, Why it exists, Current impact, Why postponed, Resolution plan (trigger condition OR target milestone + effort), Escalation condition

### Tech Debt Flow
Engineer spots debt → creates entry in `tech-debt/` → decision: Accepted (ADR filed immediately) OR Postponed (linked to future milestone, when trigger hit → converts to NFR proposal)

## Decision Record Hierarchy

Three levels, one record type per level:

| Level | Role | Record Type | Research Domain |
|-------|------|-------------|-----------------|
| VP | Strategic | SDR (Strategic Decision Record) | Market, competitive, business model |
| PM | Product | PDR (Product Decision Record) | User behavior, product data, scope |
| Senior Dev | Technical | ADR (Architecture Decision Record) | Architecture, algorithms, constraints |

Decisions flow down; feedback flows up.

### Strategic Layer
- Strategic Research Doc → SDR → Strategic Directive (VP→PM)
- Filed at: `strategy/`

### Product Layer
- Product Research Doc → PDR → Milestone doc (PM→Milestone)
- Filed at: `milestones/active/[slug]/`

### Technical Layer
- Spike Doc → ADR → TDD (Senior Dev→Implementation)
- Filed at: `planning/[slug]/`

## File Indexing System

### Four-Layer Model
- Layer 1: Repo `_index.md` (What exists in entire repo?)
- Layer 2: Folder `_index.md` (What exists in this folder?)
- Layer 3: File header block (What is this file at a glance?)
- Layer 4: File content (actual detail)

### Folder _index.md Standard
One-line description, Last updated date, Status-grouped tables (active work first). Columns: Name, Status, One-liner, Updated, File.

### The Link Chain
Every file knows upstream (where it came from) and downstream (what it produces). Agent traces any chain forwards or backwards without reading content.

Example: `ideas/bulk-export.md` → `milestones/active/bulk-export/milestone.md` → `requirements/csv-export.md` → `milestones/confirmed/bulk-export/milestone-confirmed.md` → `dto/outgoing/bulk-export-confirmed.md` → [crosses to dev] → `planning/bulk-export/tdd.md` → `planning/bulk-export/adrs/ADR-007-csv-streaming.md` → `reports/bulk-export-report.md` → `dto/outgoing/bulk-export-report.md`

### Agent Navigation Modes
- **Mode 1 (Top-down discovery)**: Read repo `_index.md` → pick section → read folder `_index.md` → open specific file
- **Mode 2 (Chain traversal)**: Read file upstream/downstream → trace origin backwards or impact forwards
- **Mode 3 (Status scan)**: Scan `_index.md` files for specific status across repo

## Vertical Slice Plan

A vertical slice = thinnest complete cut through all system layers proving design works before committing to full build.

- One specific user action, fully working end-to-end: UI → API → DB → response
- Each requirement or group → one vertical slice. All slices planned and ordered before implementation starts
- Ahead planning: if VS N+1 depends only on VS N design (not code) → planning begins in parallel

### Vertical Slice Plan File
Frontmatter: slug=vs-[n]-[milestone-slug], type=vertical-slice, status (planned/in-progress/validated/implemented/combined), owner, created/updated, upstream, downstream
Body: Milestone slug, Slice number, Combined with, Ahead planning, What this slice proves, User action covered, Layers touched, Thin implementation plan, Validation gate, Next slice dependency

## Documentation Debt

- Phase 1 (1-2 days): headers everywhere — Layer 1+2 for every existing feature
- Phase 2 (1-2 weeks): flow diagrams for 20% of features causing 80% of questions/bugs
- Phase 3 (ongoing): deep docs on demand — only when actively changing, new engineer confused, bug revealed unknown edge case
- Never: document stable things nobody touches; dead docs mislead more than no docs

## Phase Transition Prerequisites

| From | To | Prerequisites |
|------|----|---------------|
| Idea | Validation | Idea doc exists with one-liner and summary |
| Validation | Milestone | Idea validated, requirements drafted |
| Milestone | Stress Test | All requirements have acceptance criteria |
| Stress Test | Sign-off | All open items resolved, scope locked |
| Sign-off | Dev Planning | Milestone confirmed file created, DTO 1 dispatched |
| Dev Planning | Implementation | TDD, ADRs, API contracts, vertical slices planned |
| Implementation | Report | All DoD items checked off |
| Report | Update | Report generated, decisions logged |
| Update | Complete | Product docs updated, milestone archived |

## Format Rules

- Lead with status and ownership
- Collapse detail by default
- Tables for comparisons, diagrams before prose
- Short sentences, active voice
- Every doc says where it is in its lifecycle
- Status visible in frontmatter, never filename
