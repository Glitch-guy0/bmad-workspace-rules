# Features — User's Guide

> How to use the BMad workspace rules & Archiver documentation workflow orchestrator.

---

## 1. Initialize Documentation Workspace

**What:** Scaffold the full folder structure (ideas/, milestones/, planning/, reports/, nfr-proposals/, tech-debt/, strategy/, dto/) and import existing docs.

**Example:**
```
> archiver init

Where should I create the documentation workspace?
Default: /my-project/_bmad-docs
> (accept or type a path)

Do you have existing documentation to import? (path or 'skip')
> ~/Documents/old-project-docs/

Done. 12 files imported across ideas/, milestones/, reports/.
```

---

## 2. Capture an Idea (Q1)

**What:** Log a raw, unvalidated idea before it enters the milestone pipeline.

**Example:**
```
> I need to capture an idea for bulk CSV export

Generated: ideas/bulk-export-feature.md

One-liner: Users can export their data as CSV from any list view.
Summary: Currently no export exists — users manually copy data.
Signal: 3 support tickets this quarter requesting it.
Status: 💡 Raw idea
```

---

## 3. Generate Any Template On Demand

**What:** Instantly produce a properly formatted doc (idea, milestone, ADR, PDR, SDR, TDD, API contract, NFR proposal, tech debt, stress test, vertical slice, report, etc.).

**Example:**
```
> Generate an ADR for choosing PostgreSQL vs DynamoDB

Created: planning/photo-upload/adrs/ADR-007-database-choice.md

# ADR-007: Database Choice for Photo Storage

Status: Proposed
Context: Photo upload milestone needs blob storage — current SQLite won't scale.
Options:
  - A: PostgreSQL + pg_largeobject
  - B: DynamoDB + S3
Decision: TBD
Consequences: TBD
```

**Example — milestone template:**
```
> I need a milestone template for multi-photo-upload

Created: milestones/active/multi-photo-upload/milestone.md

One-liner: Users can select and upload multiple photos in one action.
Requirements:
  - [REQ-001] As a user I want to select multiple files...
  - [REQ-002] As a user I want a progress bar...
```

---

## 4. Track Lifecycle State (Q1–Q10)

**What:** Know exactly where every item is in the pipeline — from raw idea through shipped feature.

**Example:**
```
> Where is bulk-export-feature?

Phase: Q6 — Dev Planning
Artifacts: planning/bulk-export/tdd.md, 2 ADRs filed
Blockers: Missing API contract for export endpoint
Next action: File API contract before implementation planning
```

```
> What's the overall state?

Q1 Idea:   2 items (parked)
Q6 Dev:    1 item (blocked — missing API contract)
Q10 Ship:  1 item (ready for retro)
Stalled:   bulk-export-feature — 14 days in Q6 without update
```

---

## 5. Validate Before Moving to Next Phase (Phase Gate)

**What:** Before any Q-phase transition, Archiver checks prerequisites and tells you what's missing.

**Example:**
```
> Move photo-upload from Q3 milestone to Q4 stress test

Gate check failed. Missing:
  - Requirement "REQ-003" has no acceptance criteria (Given/When/Then)
  - Requirement "REQ-002" has no MoSCoW priority assigned

Resolve these before stress testing.
```

```
> Move photo-upload from Q7 Gate 2 to Q8 implementation planning

Gate 2 check passed. Ready for implementation planning.
Invoke the Developer Agent to create vertical slices and atomic change plan.
```

---

## 6. Record Decisions (SDR / PDR / ADR)

**What:** Capture decisions at every level — strategic (VP), product (PM), technical (senior dev) — with context, options, and trade-offs.

**Example — technical decision:**
```
> I decided to use CSV streaming instead of loading everything in memory

Filed: planning/bulk-export/adrs/ADR-008-csv-streaming.md

Context: Exporting 50k+ rows would OOM with naive approach.
Options:
  - A: Stream rows one-by-one (chosen — constant memory)
  - B: Paginate + batch (rejected — complex progress tracking)
Decision: Stream rows via Node transform stream.
```

**Example — product decision:**
```
> I need a PDR: should onboarding be a wizard or a blank state?

Filed: milestones/active/user-onboarding/pdrs/PDR-001-onboarding-ux.md

Question: First-time users — guided wizard or explore-on-own?
Options:
  - A: Wizard (pro: lower drop-off, con: slower for power users)
  - B: Blank state with hints (pro: flexible, con: confused beginners)
Decision: Wizard for first-run, skip button.
```

---

## 7. Stress Test a Milestone

**What:** Structured Q&A to pressure-test requirements before sign-off. Ensures edge cases, scope boundaries, and dependencies are surfaced.

**Example:**
```
> Run a stress test on bulk-export-feature

Session created: milestones/active/bulk-export/stress-test/session-2026-05-24.md

Clarity check — "User exports CSV":
  Q: What happens if the user has 0 records?
  A: Show "No data to export" message. AC updated.
Edge case — concurrent exports:
  Q: Can user request 3 exports at once?
  A: Queue limit of 1 pending export. Second request shows "Export in progress".
Open items:
  - Define export retention policy (owner: you, resolve before sign-off)
```

---

## 8. Hand Off Between Product and Dev (DTOs)

**What:** Formal handoff documents cross repos — Milestone Confirmation (product→dev) and Implementation Report (dev→product).

**Example — sending a confirmed milestone to dev:**
```
> photo-upload is signed off, dispatch DTO 1

Created: dto/outgoing/photo-upload-confirmed.md
Copied to: dev-repo/dto/incoming/photo-upload-confirmed.md

Developer Agent can now begin technical design.
```

**Example — receiving implementation report:**
```
> The dev report for photo-upload came in

DTO 2 received at dto/incoming/photo-upload-report.md

What shipped:
  ✅ Multi-file selection
  ✅ Progress bar
  ⚠️ Drag-and-drop descoped to v1.1

Product docs updated:
  - feature-index/photo-gallery.md → marked "live"
  - evolution-timeline.md → entry added
  - current-state-map.md → updated
```

---

## 9. Track Non-Functional Requirements (NFRs)

**What:** Capture NFRs (performance, security, scalability) separately from functional requirements — with measurable thresholds.

**Example — proposing an NFR:**
```
> We need rate limiting on auth endpoints

Created: nfr-proposals/nfr-auth-rate-limit.md

What: Auth API must rate-limit to 10 req/min per IP
Current state: No limit — 1,000+ req/min possible
Target threshold: p99 latency < 200ms at 10 req/min
Milestone preference: Attach to auth-service milestone
```

---

## 10. Track Tech Debt

**What:** Document accepted debt (conscious decision with exit conditions) and postponed debt (trigger condition for future fix).

**Example — accepted debt:**
```
> We took a shortcut on the session management — log it as accepted debt

Created: tech-debt/accepted/debt-session-management.md

What: Session tokens stored in-memory, not Redis
Why accepted: MVP timeline — Redis adds infra complexity
Exit condition: When we have >100 concurrent users OR deploy multi-instance
ADR: ADR-009-session-storage linked
```

**Example — postponed debt:**
```
> The CSV exporter lacks error recovery — postpone it

Created: tech-debt/postponed/debt-csv-error-recovery.md

Current impact: Failed exports show generic "Something went wrong"
Trigger condition: 5+ support tickets about failed exports
Resolution: Add per-row error reporting + retry mechanism
```

---

## 11. Keep Indexes Up to Date

**What:** Every folder has a `_index.md` — Archiver maintains them automatically so you never wonder what's where.

**Example:**
```
I updated the indexes. Current state:
  docs/ — 12 docs listed, 1 orphan removed
  ideas/ — 4 ideas (2 raw, 1 validated, 1 parked)
  milestones/active/ — 2 milestones
  tech-debt/ — 3 accepted, 2 postponed
```

---

## 12. Find the Right Agent for the Job

**What:** Archiver knows all installed agents and recommends the right one for the current phase.

**Example:**
```
> Who should handle the stress test for photo-upload?

This milestone needs stress testing — invoke the Product Agent.
It will guide you through requirement-by-requirement Q&A.
The milestone doc is at milestones/active/photo-upload/milestone.md.
```

```
> The DTO 1 for photo-upload has been dispatched

The Developer Agent can now start. It will:
  1. Read the confirmed milestone
  2. Create TDD, ADRs, API contracts
  3. Report back with an Implementation Report

DTO is at dto/outgoing/photo-upload-confirmed.md.
```

---

## 13. Non-Milestone Work: Vertical Slices

**What:** Plan implementation as thin end-to-end slices (UI→API→DB) rather than horizontal layers.

**Example:**
```
> Plan vertical slices for photo-upload

VS-1: User selects files → upload starts → progress shown
       (stubs: actual S3 upload, real progress calculation)
VS-2: Files processed → thumbnails generated → user sees gallery
       (depends on VS-1: validated only — can plan in parallel)
VS-3: User edits metadata → saves → gallery updates
       (depends on VS-2: implemented — must wait)

All 3 slices planned and ordered in planning/photo-upload/vertical-slices/
```

---

## 14. Strategic Planning (VP Layer)

**What:** Capture strategic bets, market research, and directives at the org level — even for a single-person shop.

**Example:**
```
> Let's decide: build AI tagging in-house or use a third-party API?

Filed: strategy/sdrs/SDR-001-ai-tagging-strategy.md

Question: Build custom image tagging or integrate Google Vision API?
Options:
  - A: Google Vision API (pro: fast to ship, con: ongoing API cost)
  - B: Custom model (pro: no per-call cost, con: 3 months to train)

Decision: Start with Google Vision, re-evaluate at 10k monthly users.
Direction: strategy/directives/directive-ai-tagging.md
```

---

## 15. Session Continuity (Memory)

**What:** Archiver remembers between sessions — what was done, what's in progress, what's blocked.

**Example (next session):**
```
Welcome back. Since last session:
  - photo-upload moved from Q6 to Q7 (Gate 1 passed)
  - bulk-export got a new ADR (CSV streaming)
  - user-onboarding PDR is still open — needs a decision

Open blockers:
  - bulk-export: missing API contract (3 days stalled)
```

---

## Quick Reference: What to Say

| When you want to... | Say... |
|---|---|
| Set up docs from scratch | `archiver init` |
| Log a raw idea | "Capture an idea for [X]" |
| Get a template | "Generate a [template type] for [X]" |
| Check where something is | "Where is [X]?" or "What's the state of everything?" |
| Move to next phase | "Move [X] to Q[next]" or "Gate this for [next phase]" |
| Record a decision | "I decided [decision] — file an ADR / PDR / SDR" |
| Stress test | "Run a stress test on [milestone]" |
| Mark as ready for dev | "Dispatch DTO 1 for [milestone]" |
| Log tech debt | "Log accepted/postponed debt: [description]" |
| Propose an NFR | "We need [NFR requirement]" |
| Update indexes | "Update the indexes" |
| Find the right agent | "Who should handle [task]?" |
