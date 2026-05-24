# Project Plan — Source of Truth

## About This Folder (`docs/`)

This folder is the **source-of-truth documentation corpus** for the `agent-archiver` bmad-agent-module.

- These 10 documents define the full product-development lifecycle framework (Q1-Q10), two-repo architecture, NFR/debt indexing, decision-making hierarchy, BMAD skill anatomy, coding constitution, ADRs, documentation guidelines, export structure, and project charter.
- They serve as the specification and reference material from which the standalone `agent-archiver` module is built.
- The `docs/` folder content is **compiled and exported** into the `src/agent-archiver/` module during the build process — becoming its embedded knowledge base (references, templates, scripts, and rules).
- Every document here is a formal input to the Archiver agent's capabilities.

> Validated content. Foundation for all forward planning and implementation.

10 documents covering framework, repo architecture, NFR/debt, decision hierarchy, BMAD skills, constitution, ADRs, doc guidelines, export structure, and project goal.

## Files

- **[01-documentation-framework.md](./01-documentation-framework.md)** — Q1-Q10 product lifecycle from idea capture through implementation and retrospective
- **[02-repo-agent-structure.md](./02-repo-agent-structure.md)** — Two-repo architecture with DTO handoffs, file trees, and agent lifecycle
- **[03-nfr-tech-debt-indexing.md](./03-nfr-tech-debt-indexing.md)** — NFR management, tech debt tracking, and four-layer file indexing system
- **[04-decision-making-org-flow.md](./04-decision-making-org-flow.md)** — PDR/SDR decision hierarchy, three-tier org, and feedback loops
- **[05-bmad-skill-setup-slice.md](./05-bmad-skill-setup-slice.md)** — BMAD skill operations, skill anatomy, editorial pipeline, and vertical slice planning
- **[06-project-constitution.md](./06-project-constitution.md)** — Architecture philosophy, BE/FE coding standards, testing, naming, TSDoc, and DX
- **[07-architecture-decisions.md](./07-architecture-decisions.md)** — Formal ADRs: shared DTO, repository triad, and promise exception registry
- **[08-documentation-guidelines.md](./08-documentation-guidelines.md)** — Documentation types, general guidelines, and workflow principles
- **[09-export-boilerplate.md](./09-export-boilerplate.md)** — Export folder structure, agent layout conventions, and adding new agents
- **[10-project-goal.md](./10-project-goal.md)** — Project charter, Archiver agent overview, design principles, and scope boundaries

## Cross-Cutting Items

- Progressive disclosure: 4 layers (Layer 1: one-liner, Layer 2: summary, Layer 3: brief flow, Layer 4: detailed spec) — applied to docs AND file system (repo _index.md → folder _index.md → file header → content)
- The 5-Year Arc: Month 1-2 (MVP, no docs needed) → Year 1-2 (tribal knowledge, 3-4 people hold system) → Year 3 (key person leaves, panic doc sprint → Confluence graveyard) → Year 4-5 (nobody knows why decisions made, debt compounds). Root cause: failure of structure, not discipline
- Big org patterns: Google (one doc per feature, owner named, status visible, written justifications), Amazon (Six-Pager), Stripe (RFC process). Common thread: one owner per doc, visible status, recorded why
- The Master Flow: Raw idea → [Q1] Idea Capture → Discovery Backlog → [Q2] Validated → Added to Milestone → [Q3] Milestone Structured (Epic→Stories→AC) → [Q4] Dependency check → [Q5] Milestone Confirmation File (handoff) → [Q6] Tech Document Stack (TDD/ADR/API/ERD/Spike) → [Q7] Validation & Sign-Off → [Q8] Implementation Planning (layers 1-3) → [Q9] Test scenarios + atomic change plan → [Q10] Implementation + doc updates
- Format rules that work: lead with status and ownership; collapse detail by default; d2lang diagrams before prose; tables for comparisons; short sentences, active voice
- Tackling documentation debt: Phase 1 (1-2 days): headers everywhere with Layer 1-2. Phase 2 (1-2 weeks): flow diagrams for 20% of features responsible for 80% of questions/bugs. Phase 3 (ongoing): deep docs on demand. Never document stable things nobody touches — dead docs mislead more than no docs
- Decision reference copies in both repos: type=decision-reference, contains source path in originating repo, synced date, summary from receiving team's perspective, impact on this side
- Kebab-case slugs for all files/folders. ISO 8601 dates (YYYY-MM-DD). Status lives in file header, never filename. Lifecycle communicated by folder location (active → confirmed → completed; postponed → nfr-proposals → planning)
- All documents open with YAML frontmatter: slug, type, status, owner, created, updated, upstream, downstream
- Three DTOs: DTO 1 (Milestone Confirmation, product→dev), DTO 2 (Implementation Report, dev→product), DTO 3 (NFR Proposal, dev→product)
- Every folder must have _index.md. Underscore prefix keeps it sorted to top
- Repo-update operations use a `_repo-update-task-list.md` temp file at project root for section allocation and session continuity
- Editorial pipeline: bmad-editorial-review-prose → bmad-editorial-review-structure → bmad-shard-doc (conditional >500 lines) → bmad-index-docs → bmad-distillator (optional)
- Brownfield strategy: Surgical Strike — new files follow new rules, legacy files get migration tickets
- Sections 01-05 from final-plan.md distillate. Sections 06-08 preserved from earlier project-plan source-of-truth. Sections 09-10 added during agent build (Archiver documentation orchestrator).
- **Planning must reference this document first** before creating any new docs, architecture, or implementation.
