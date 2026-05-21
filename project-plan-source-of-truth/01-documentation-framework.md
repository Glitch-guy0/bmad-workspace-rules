This section covers the Product Documentation Framework — the source-of-truth methodology for product documentation across the full lifecycle. Part 1 of 5 from framework.md (2455 lines). **Highest priority — this is the primary reference.**

## Core Problem & Solution
- Documentation fails not from lack of writing but from no information hierarchy; everything at same depth, dead docs look identical to live ones
- Fix: layered documentation with right doc at right stage, not more documentation
- Progressive disclosure: show shape first, reveal detail on demand

## The Layered Model
- Layer 1 (one-liner): "What is this?" — one sentence, always up-to-date
- Layer 2 (summary): "What does it do, who uses it, what state?" — short paragraph for newcomer orientation
- Layer 3 (brief flow): "How does it work end-to-end?" — diagram or short walkthrough, skimmable in 2 minutes
- Layer 4 (detailed spec): "Everything to build or debug this" — full depth, read only when needed

## The 5-Year Arc
- Month 1-2: MVP ships, everyone knows everything, no docs needed
- Month 3-6: "We'll document later" — nothing written
- Year 1-2: tribal knowledge accumulates in 3-4 people's heads
- Year 3: key person leaves, panic documentation sprint → Confluence graveyard
- Year 4-5: nobody knows why decisions were made; tech debt + doc debt compound
- Root cause: failure of structure, not discipline

## Big Org Patterns
- Google: Design Doc culture — one doc per feature, strict format, named owner, visible status, non-obvious decisions require written justification
- Amazon: Six-Pager — no slide decks, written narrative read in silence, forces clarity
- Stripe: RFC process — every change gets RFC (what, why, alternatives), permanent record
- Common thread: one owner per doc, status always visible, "why" is recorded

## Master Flow (Q1-Q10)
- Product level: Raw idea → [Q1] Idea Capture → Discovery Backlog → [Q2] Validated → Milestone List → [Q3] Milestone Structured → [Q4] Dependency Check → [Q5] Milestone Confirmation File (THE HANDOFF)
- Technical level: [Q6] Technical Doc Stack (TDD, ADR, API contracts) → [Q7] Validation & Sign-off → [Q8] Implementation Planning → [Q9] Test Scenarios + Atomic Changes → [Q10] Implementation + Doc Updates

### Q1: New Requirement Ideas
- Every new idea gets entry in Idea Capture Log (flat list, not prioritized)
- Entry: name, captured by, source, status, one-liner, hypothesis, signal, open questions, rough size
- Status progression: 💡 Raw → 🔍 Exploring → ✅ Validated → ⏸ Parked → ❌ Rejected
- Rule: validated ideas leave the log; unvalidated ideas never enter a milestone

### Q2: Adding to a Milestone
- Write as user story: "As a [user] I want [thing] so that [outcome]"
- Acceptance criteria: Given/When/Then format
- Assign with MoSCoW priority: Must Have, Should Have, Nice to Have, Won't Have
- Milestone entry: requirement name, user story, AC, priority, milestone, dependencies, linked idea

### Q3: Milestone Structure
- Milestone = meaningful shippable unit (not sprint, not quarter goal)
- Structure: one-liner, target date, status, owner, goal, out-of-scope, success metric, requirements (grouped by MoSCoW), dependencies (blocked by/blocks), risks, history (scope changes)
- Hierarchy: Epic (months) → Milestone (weeks) → Story → Task (hours)

### Q4: Planning Against Existing
- Dependency check per requirement before technical design: existing features touched, data read/written, user flows affected, regression risk, reusable components, net-new work
- Principle: describe as delta from current state, not from scratch

### Q5: Milestone Confirmation File
- Signed-off handoff document between product and engineering
- Contains: goal, user flows (step-by-step), confirmed requirements with AC, explicit out-of-scope, success metrics, resolved open questions, confirmed dependencies, acknowledged risks, linked docs
- Versioned (v1.0, v1.1...) with changelog; original preserved on scope changes

### Q6: Technical Document Stack
- TDD (Technical Design Document): how system will be built — overview, system context, approach, data model, API design, component design, edge cases, performance, security, open questions
- ADR (Architecture Decision Record): why each non-obvious technical choice — context, options considered, decision, trade-offs accepted, outcome
- API Contract: source of truth for endpoint request/response — endpoint, auth, rate limit, request schema, response schema, error codes
- ERD: visual data model — must reflect current state (not intended)
- Spike/Research Doc: time-boxed investigation — time-box, question, approach, finding, recommendation

### Q7: Validation & Sign-Off
- Gate 1 (Milestone Confirmation Review): PM + senior engineer + stakeholder — checklist (goal clarity, testable AC, explicit out-of-scope, dependencies, success metrics, resolved questions, achievable scope, no contradictions)
- Gate 2 (Technical Design Review): engineering lead + senior engineer not on team — checklist (TDD addresses all requirements, backward-compatible data model, API conventions, edge cases, performance, security, no conflicts, ADRs filed, shippable pieces)
- Sign-off record: product confirmed by @pm/@eng-lead, technical approved by @eng-lead/@reviewer

### Q8: Implementation Planning
- Layer 1 (Options & Brainstorm): capture options with approach, pros, cons, unknowns, effort estimate → recommendation
- Layer 2 (Implementation Breakdown): ordered, independently shippable pieces; each mergeable to main without breaking (feature flags); piece = name, what, why now, risk, estimate, done-when condition
- Layer 3 (Timeline): buffer-aware week-by-week view with 20% buffer, confidence level, assumptions

### Q9: Testing Scenarios & Atomic Changes
- Test scenarios before implementation: happy path, edge cases, failure cases, regression check per acceptance criterion
- Three levels: Unit/Integration/E2E
- Atomic change plan: each change does one thing, has its own tests, reviewable <30 min, main stays deployable after each merge
- Forbidden: catch-all PRs, schema migration bundled with business logic, tests only in final PR

### Q10: Implementation & Doc Updates
- Definition of Done: code merged + tests passing + reviewed + no regressions + feature flag configured + all docs updated (TDD, API contracts, ERD, ADRs, Feature Index, Current State Map, inline comments, README) + AC verified + PM sign-off + release notes + Evolution Timeline updated
- Doc update table: TDD (design changes), API Contract (endpoint changes), ERD (schema migration), ADR (new decisions), Feature Index (feature ships), Current State Map (status changes), Evolution Timeline (significant capability), Release Notes (user-facing change), Inline comments (non-obvious logic)
- Post-implementation retro note: shipped date, scope delivered, what worked, what to improve, surprises, outcome vs metric

## Documentation Debt
- Phase 1 (1-2 days): headers everywhere — Layer 1+2 for every existing feature
- Phase 2 (1-2 weeks): flow diagrams for 20% of features causing 80% of questions/bugs
- Phase 3 (ongoing): deep docs on demand — only when actively changing, new engineer confused, bug revealed unknown edge case
- Never: document stable things nobody touches; dead docs mislead more than no docs

## Format That Works
- Lead with status and ownership on every doc header
- Collapse detail by default (skeleton readable without expanding)
- Diagrams before prose (diagram = 10 seconds, prose = nuance)
- Tables for comparisons (never paragraphs)
- Short sentences, active voice

## Repo Architecture
- Two repos: Product Repo (capture → validate → confirm, owned by Product Agent) + Developer Repo (plan → implement → report, owned by Senior Developer Agent)
- Why two repos: different cadences, audiences, failure modes; product repo has no implementation code; dev repo has no unvalidated ideas
- Cross-boundary DTO files: Milestone Confirmation File (product → dev) + Implementation Report (dev → product)

### DTO 1: Milestone Confirmation File
- Direction: Product repo → Developer repo
- Trigger: user stress test passed + PM + eng-lead sign-off
- File: `dto/outgoing/[milestone-slug]-confirmed.md` (product) → `dto/incoming/[slug]-confirmed.md` (dev)
- Never edited after confirmation; dev planning cannot start without it

### DTO 2: Implementation Report
- Direction: Developer repo → Product repo
- Trigger: implementation complete, all DoD items checked
- File: `dto/outgoing/[milestone-slug]-report.md` (dev) → `dto/incoming/[slug]-report.md` (product)
- Contains: what shipped (with deviations), new decisions/ADRs, product doc updates required, evolution timeline entry, feature index entries, retro note

## Product Repo File Structure
- `dto/{incoming, outgoing}/` — cross-repo handoff files
- `product/{product-brief.md, evolution-timeline.md, current-state-map.md, direction.md}` — core product docs
- `feature-index/{_index.md, [slug].md}` — one file per live feature
- `ideas/{_index.md, [slug].md}` — unvalidated ideas (never touch milestones)
- `milestones/{active, confirmed, completed}/[slug]/` — milestone lifecycle
- Key rules: ideas never enter milestones/active/ until validated; milestones/confirmed/ is read-only; dto/outgoing/ never edited after sending; current-state-map + feature-index updated only from incoming DTO reports

## Developer Repo File Structure
- `dto/{incoming, outgoing}/` — milestone confirmed files in, implementation reports out
- `planning/[slug]/{tdd.md, erd.md, adrs/, api-contracts/, spikes/, implementation-brainstorm.md, atomic-change-plan.md, test-scenarios.md}`
- `implementation/[slug]/{progress.md, decisions-log.md}`
- `reports/[slug]-report.md`, `archive/[slug]/`
- Key rules: no planning file until dto/incoming/ has the confirmed file; dto/incoming/ never edited; ADRs filed at decision moment not at end; decisions-log promoted to ADRs before report generation

## Agent Flow (Full Milestone Lifecycle)
- Product Agent: Idea phase → Validation → Stress Test (structured Q&A) → Sign-off → Waiting → Update phase (on incoming report)
- Developer Agent: Receipt → Technical Design → Validation (Gate 2 self-check) → Implementation Planning → Implementation → Report (promote decisions-log → ADRs, generate report, archive)
- Stress test: per-requirement clarity check + edge case pressure + scope boundary test + conflict detection + dependency reveal; sign-off cannot proceed until all open items resolved

## Non-Functional Requirements (NFR)
- Three patterns: Cross-cutting (standalone NFR milestone, e.g., "All endpoints p95<200ms"), Feature-attached (attached to existing milestone, e.g., "Upload must handle 1000 concurrent uploads"), Debt-driven (fixing existing degradation, e.g., "Auth has no rate limiting")
- Flow: senior dev observes need → NFR proposal → product review → standalone or attached milestone → engineering review replaces user stress test → confirmed → standard DTO flow
- NFR entry: category, acceptance criteria (threshold, measured by, baseline), scope, engineering review notes, sign-off (engineering lead + PM acknowledgment)

## Tech Debt
- Accepted debt: conscious, documented, linked to ADR with exit conditions; without ADR = forgotten debt
- Postponed debt: will fix later with trigger condition or milestone target; converts to NFR proposal when trigger hit
- Key rule: accepted debt without ADR = forgotten debt; accepted debt with ADR = conscious debt with exit conditions
- Flow: engineer spots debt → entry in dev-repo/tech-debt/ → accepted (file ADR immediately, notify product) or postponed (link to future milestone/trigger, monthly review, convert to NFR on trigger)

## File Indexing System
- Layer model applied to files: Repo _index.md (what exists entire repo) → Folder _index.md (what exists in this folder) → File header block (what is this file) → File content (actual detail)
- File header standard: slug, type (idea|requirement|nfr|tech-debt|milestone|feature|adr|tdd|api-contract|spike|stress-test|report|implementation-brainstorm|atomic-change-plan|test-scenarios|progress), status (per-type valid values only), owner, created, updated, upstream (origin), downstream (produces)
- Status values per type with emoji: idea (raw/exploring/validated/parked/rejected), milestone (planning/confirmed/in-progress/complete/paused), requirement (draft/confirmed/descoped), nfr (proposed/reviewing/confirmed/rejected), tech-debt (postponed/accepted/resolving/resolved), feature (experimental/beta/live/deprecated), adr (proposed/accepted/superseded), tdd (draft/in-review/approved/implemented)
- Folder _index.md standard: one-line description, last-updated, status-grouped tables (active first)
- Repo-level _index.md: full map, one section per document type — what agent reads first when entering repo
- Link chain: every file knows upstream (origin) and downstream (produces); agent can trace any chain forwards/backwards without reading content
- Agent navigation modes: Top-down discovery (repo index → folder index → file), Chain traversal (upstream/downstream fields), Status scan (scan _index.md for specific status across repo)
- File naming: kebab-case slugs, ISO 8601 dates (YYYY-MM-DD), padded integer ADR numbering (ADR-001), never encode status in filename (use folder location: active/→confirmed/→completed/)

## Complete Cross-Repo Document Map
- 31 document types across Product and Developer repos
- DTOs (4 files): milestone-confirmed.md (product OUT → dev IN), implementation-report.md (dev OUT → product IN)
- Business layer (product repo): product-brief, evolution-timeline, current-state-map, direction, feature-index, ideas, nfr-proposals, milestones (active/confirmed/completed)
- Technical layer (dev repo): tdd, adrs, api-contracts, erd, spikes, implementation-brainstorm, atomic-change-plan, test-scenarios, progress, decisions-log
