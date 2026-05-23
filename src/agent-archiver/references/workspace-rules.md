---
name: workspace-rules
description: Workspace conventions reference — naming, frontmatter, progressive disclosure, phases, artifact types
---

# Workspace Rules

Self-contained reference for the workspace conventions Archiver enforces.

> **Path context:** All artifact paths in this document (ideas/, milestones/, planning/, reports/, etc.) resolve from `{output-folder}` — the configured output directory. Config and memory paths (`_bmad/`, sanctum) resolve from the real `{project-root}`. See SKILL.md Path Resolution for details.

## Progressive Disclosure (Layer 1-4)

Every document structured in 4 progressive layers:

| Layer | Depth | What |
|-------|-------|------|
| Layer 1 | One-liner | What this is in one sentence |
| Layer 2 | Summary | A few sentences on scope and purpose |
| Layer 3 | Brief flow | Key details, process, constraints |
| Layer 4 | Detailed spec | Full reference, edge cases, rationale |

Applied to both docs AND file system: repo `_index.md` → folder `_index.md` → file header → file content.

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

## File Naming Conventions

- **Slugs**: kebab-case (e.g., `multi-photo-upload`, `bulk-export-feature`)
- **Dates**: ISO 8601 YYYY-MM-DD (e.g., `session-2026-05-21.md`)
- **ADR numbering**: padded integers, sequential per repo (ADR-001, ADR-002). Never reuse. Superseded ADR links to replacement.
- **Versioning**: inside confirmed file header (v1.0, v1.1). Never in filename. Version increments are logged in sign-off-log.md.
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
| ADR | `planning/[slug]/adrs/ADR-[n]-[title].md` | adr |
| TDD | `planning/[slug]/tdd.md` | tdd |
| API Contract | `planning/[slug]/api-contracts/[endpoint].md` | api-contract |
| ERD | `planning/[slug]/erd.md` | erd |
| Spike | `planning/[slug]/spikes/[slug].md` | spike |
| Implementation Report | `reports/[slug]-report.md` | report |
| Retro Note | appended to milestone after ship | — |

## DTO Handoff Formats

### DTO 1 — Milestone Confirmation (product→dev)
- Path: `dto/outgoing/[milestone-slug]-confirmed.md`
- Status: CONFIRMED, read-only after creation
- Trigger: Stress test passed + sign-off complete

### DTO 2 — Implementation Report (dev→product)
- Path: `dto/outgoing/[milestone-slug]-report.md`
- Fields: Status (Complete/Partial/Blocked), What shipped (per req with ✅/⚠️/❌), Deviations, New ADRs, Product doc updates required, Evolution timeline entry, Feature index entries, Retro note

### DTO 3 — NFR Proposal (dev→product)
- Path: `nfr-proposals/[slug].md`
- Crosses from dev repo to product repo for review

## Phase Transition Prerequisites

| From | To | Prerequisites |
|------|----|---------------|
| Idea | Validation | Idea doc exists with one-liner and summary |
| Validation | Milestone | Idea validated, requirements drafted |
| Milestone | Stress Test | All requirements have acceptance criteria |
| Stress Test | Sign-off | All open items resolved, scope locked |
| Sign-off | Dev Planning | Milestone confirmed file created |
| Dev Planning | Implementation | TDD, ADRs, API contracts created |
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
