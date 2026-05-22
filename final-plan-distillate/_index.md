---
type: bmad-distillate
sources:
  - "../final-plan.md"
downstream_consumer: "general"
created: "2026-05-22"
token_estimate: 12321
distillate_total_tokens: 12321
parts: 6
---

## Orientation
- Distilled from `final-plan.md` (34,765 source tokens), a living documentation framework for products from MVP to year 5+. Describes a layered documentation model, two-repo product/engineering system, decision-tracking hierarchy, and BMAD skill automation.
- All processes, templates, rules, file structures, and conventions are preserved factually. Prose elaboration and decorative formatting removed.
- Split into 6 sections matching the document's natural part boundaries. Each section is self-contained.

## Section Manifest
| Section | Topic |
|---|---|
| 01-business-product-level | Q1-Q5: Idea capture, milestone structure, requirement planning, milestone confirmation |
| 02-technical-structural-level | Q6-Q10: TDD, ADR, API contract, ERD, Spike, validation gates, implementation planning, testing, definition of done |
| 03-repo-agent-file-structure | Two-repo architecture, DTOs, product/dev repo file trees, agent flow, stress test, naming conventions, cross-repo doc map |
| 04-nfr-tech-debt-indexing | NFR patterns/flows, tech debt (accepted/postponed), file indexing system (headers, indexes, link chain, agent nav modes) |
| 05-decision-making-org-flow | PDR & Product Research Doc, three-tier org (VP/PM/Senior Dev), handoff documents, feedback loops, strategic layer structure |
| 06-bmad-skill-setup-slice | BMAD skill internal structure, INIT setup, submodule/single-repo options, Sync decision layer, vertical slice planning, three operations (INIT/VALIDATE/SYNC) |

## Cross-Cutting Items
- Progressive disclosure: 4 layers (Layer 1: one-liner, Layer 2: summary, Layer 3: brief flow, Layer 4: detailed spec) — applied to docs AND file system (repo _index.md → folder _index.md → file header → content)
- The 5-Year Arc: Month 1-2 (MVP, no docs needed) → Year 1-2 (tribal knowledge, 3-4 people hold system) → Year 3 (key person leaves, panic doc sprint → Confluence graveyard) → Year 4-5 (nobody knows why decisions made, debt compounds). Root cause: failure of structure, not discipline
- Big org patterns: Google (one doc per feature, owner named, status visible, written justifications), Amazon (Six-Pager: written narrative read in silence, no slide decks for proposals), Stripe (RFC process: what/why/alternatives considered, permanent record). Common thread: one owner per doc, visible status, recorded why
- The Master Flow: Raw idea → [Q1] Idea Capture → Discovery Backlog → [Q2] Validated → Added to Milestone → [Q3] Milestone Structured (Epic→Stories→AC) → [Q4] Dependency check → [Q5] Milestone Confirmation File (handoff) → [Q6] Tech Document Stack (TDD/ADR/API/ERD/Spike) → [Q7] Validation & Sign-Off → [Q8] Implementation Planning (layers 1-3) → [Q9] Test scenarios + atomic change plan → [Q10] Implementation + doc updates
- Format rules that work: lead with status and ownership; collapse detail by default; diagrams before prose; tables for comparisons; short sentences, active voice
- Tackling documentation debt: Phase 1 (1-2 days): headers everywhere with Layer 1-2. Phase 2 (1-2 weeks): flow diagrams for 20% of features responsible for 80% of questions/bugs. Phase 3 (ongoing): deep docs on demand (only when actively changed, new engineer confused, or bug revealed edge cases). Never document stable things nobody touches — dead docs mislead more than no docs
- Decision reference copies in both repos: type=decision-reference, contains source path in originating repo, synced date, summary written from receiving team's perspective, impact on this side
- Kebab-case slugs for all files/folders. ISO 8601 dates (YYYY-MM-DD). Status lives in file header, never filename. Lifecycle communicated by folder location (active → confirmed → completed; postponed → nfr-proposals → planning)
- All documents open with YAML frontmatter: slug, type, status, owner, created, updated, upstream, downstream
- Upstream: the file that created this one. Downstream: what this file feeds into. Enables forward/backward chain tracing
- Rule: Ideas never enter milestones until validated. Confirmed milestones are read-only. DTO outgoing files never edited after sending
- Three DTOs: DTO 1 (Milestone Confirmation, product→dev), DTO 2 (Implementation Report, dev→product), DTO 3 (NFR Proposal, dev→product)
- Every folder must have _index.md. Underscore prefix keeps it sorted to top
