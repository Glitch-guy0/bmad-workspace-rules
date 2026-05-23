---
name: template-forge
description: Generate properly formatted documentation artifacts on demand
code: TF
---

# Template Forge

Conventions reference: `references/workspace-rules.md` — naming, frontmatter, progressive disclosure, artifact paths and formats.

## What Success Looks Like
The owner says "I need a [artifact] for X" and you generate a properly structured artifact with the right frontmatter, progressive disclosure layers, cross-references, and status indicators. The owner fills in details — they don't fix the format.

## Standard Artifact Templates

### Idea Capture
```markdown
---
type: idea
status: draft
slug: [kebab-case-slug]
created: YYYY-MM-DD
owner: user
---

# [Title]

**One-liner:** [Layer 1 — what this is in one sentence]

**Summary:** [Layer 2 — a few sentences on what's being proposed]

**Details:** [Layer 3 — what needs to be explored, known constraints]
```

### Milestone
```markdown
---
type: milestone
status: active
slug: [kebab-case-slug]
created: YYYY-MM-DD
owner: user
---

# [Title]

**One-liner:** One sentence on what this milestone delivers.

**Summary:** Scope, why it matters, success criteria.

## Requirements

### [REQ-001] [Title]
**User Story:** AS A [user] I WANT [action] SO THAT [outcome]
**AC:** GIVEN [condition] WHEN [action] THEN [outcome]
**Priority:** [Must Have / Should Have / Nice to Have]
**Edge cases:** [optional]
```

### ADR
```markdown
---
type: adr
status: proposed
slug: ADR-[NNN]-[title]
created: YYYY-MM-DD
owner: user
---

# ADR-[NNN]: [Title]

**Status:** [Proposed / Accepted / Deprecated / Superseded by ADR-[N]]

**Context:** What prompted this decision — situation, constraints, forces.

**Options Considered:**
- Option A: [what] — [pros/cons]
- Option B: [what] — [pros/cons]

**Decision:** What we decided and why.

**Consequences:** Trade-offs accepted, impact on project.
```

### PDR — Product Decision Record
```markdown
---
type: pdr
status: proposed
slug: PDR-[NNN]-[title]
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# PDR-[NNN]: [Title]

**Status:** [Proposed / Accepted / Superseded by PDR-[N]]

**Raised by:** [name]
**Affects:** [milestone slug or product area]
**Linked research:** [path to research doc]

**Question:** [one sentence]

**Context:** Situation making decision necessary, constraints, goals.

**Options Considered:**
- Option A: [what] — [pros/cons]
- Option B: [what] — [pros/cons]

**Decision:** Chosen option + core reason.

**Trade-offs accepted:** [explicit statement of what was given up]

**Outcome:** [filled after milestone ships]
```

### SDR — Strategic Decision Record
```markdown
---
type: sdr
status: proposed
slug: SDR-[NNN]-[title]
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# SDR-[NNN]: [Title]

**Status:** [Proposed / Accepted / Superseded by SDR-[N]]

**Raised by:** [name]
**Affects:** [strategic area]
**Linked research:** [path]

**Question:** [one sentence]

**Context:** Market/business situation forcing decision.

**Options Considered:**
- Option A: [what] — [pros/cons]
- Option B: [what] — [pros/cons]

**Decision:** Chosen option + core reason.

**Trade-offs accepted:** [explicit]

**Outcome:** [filled after horizon closes]
```

### Strategic Directive
```markdown
---
type: strategic-directive
status: draft
slug: directive-[slug]
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# Strategic Directive: [Title]

**Issued by:** [VP name]
**Horizon:** [Quarter / Half / Year]
**Status:** [Draft / Issued / Closed]

**Strategic bet:** [commitment + why now]

**Context for PM:**
- Target segment
- Success looks like
- Hard constraints
- Out of bounds

**Linked research:** [path]

**Open questions for PM:** [list]

**Outcome:** [filled after horizon closes]
```

### NFR Proposal (DTO 3 — dev→product)
```markdown
---
type: nfr
status: proposed
slug: nfr-[slug]
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# NFR Proposal: [Title]

**Raised by:** [name]
**Date:** YYYY-MM-DD
**Category:** [Performance / Security / Scalability / Reliability / Maintainability / Observability / Compliance]

**What:** [one line]

**Why now:** [urgency rationale]

**Current state:** [measurable gap]

**Target threshold:** [specific measurable]

**Impact if not addressed:** [what degrades / breaks]

**Affected systems:** [list]

**Milestone preference:** [Standalone / Attach to [slug] / Next milestone touching [system]]

**Rough effort:** [Unknown / Small (days) / Medium (1-2 weeks) / Large (sprint+)]
```

### NFR Entry (in milestone)
```markdown
---
type: nfr
status: proposed
slug: nfr-[slug]
created: YYYY-MM-DD
owner: user
upstream: nfr-proposals/[slug]
downstream:
---

# NFR: [Name]

**Category:** [category]
**Raised by:** [name]
**Date:** YYYY-MM-DD
**Priority:** [Must Have / Should Have / Nice to Have]

**What:** [description]

**Acceptance Criteria:**
- Threshold: [measurable target]
- Measured by: [how measured]
- Baseline: [current value]

**Scope:** [systems affected, milestone attachment]

**Engineering Review Notes:** [findings]

**Sign-off:** [engineering lead + PM]
```

### Tech Debt — Accepted
```markdown
---
type: tech-debt
status: accepted
slug: debt-[slug]
created: YYYY-MM-DD
owner: user
upstream:
downstream: adrs/ADR-[n]
---

# [Title] (Accepted)

**What:** [description of the technical debt]

**Why it exists:** [how the debt was created]

**Known cost/risk:** [specific impact]

**Why accepted:** [trade-off reasoning]

**Exit conditions:** [what triggers revisiting, or accept permanently]
```

### Tech Debt — Postponed
```markdown
---
type: tech-debt
status: postponed
slug: debt-[slug]
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# [Title] (Postponed)

**What:** [description]

**Why it exists:** [how created]

**Current impact:** [specific]

**Why postponed:** [rationale]

**Resolution plan:**
- Trigger condition: [what activates this]
- OR Target milestone: [when targeted]
- Effort estimate: [estimate]

**Escalation condition:** [what forces above threshold]
```

### Product Research Doc
```markdown
---
type: product-research
status: in-progress
slug: research-[slug]
created: YYYY-MM-DD
owner: user
upstream:
downstream: pdrs/PDR-[n]-[title]
---

# Product Research: [Question]

**Time-box:** [duration]

**Feeds into:** [PDR or milestone]

**Question:** [one sentence]

**Method:** [user interviews / data analysis / competitor review / support ticket analysis / desk research]

**Findings:** [structured findings]

**Implications:** [what this means]

**Recommendation:** [what research suggests]
```

### TDD — Technical Design Document
```markdown
---
type: tdd
status: draft
slug: [slug]-tdd
created: YYYY-MM-DD
owner: user
upstream: dto/incoming/[slug]-confirmed.md
downstream:
---

# TDD: [Feature Name]

**Status:** [Draft / In Review / Approved / Implemented]

**Linked to Milestone Confirmation:** [path]

**Overview:** [brief description]

**System context:** [diagram or description with new component highlighted]

**Approach:** [high-level + why over alternatives]

**Data model:**
- Current: [existing schema]
- New: [schema changes]
- Migration: [plan if needed]

**API design:** [endpoints, request/response]

**Component/service design:** [responsibilities, boundaries]

**Edge cases and failure modes:** [list]

**Performance considerations:** [implications]

**Security considerations:** [auth, permissions, data sensitivity]

**Open questions:** [list]
```

### API Contract
```markdown
---
type: api-contract
slug: [endpoint-name]
status: draft
created: YYYY-MM-DD
owner: user
---

# API: [Method] [path]

**Status:** [Live / Draft / Deprecated]

**Auth:** [required / optional / none]
**Rate limit:** [limit]

**Request:**
- Content-Type: [type]
- Fields: [name, type, required/optional, constraints]

**Response (200):**
```json
{
  "success": true,
  "data": {}
}
```

**Errors:**
| Code | Status | Meaning |
|------|--------|---------|
| 400 | Bad Request | Invalid input |
| 401 | Unauthorized | Missing/invalid auth |
```

### Spike / Research Doc
```markdown
---
type: spike
status: in-progress
slug: spike-[slug]
created: YYYY-MM-DD
owner: user
---

# Spike: [Question]

**Time-box:** [duration]

**Question:** [one sentence — what we need to know]

**Approach:** [how we'll investigate]

**Finding:** [what we learned]

**Recommendation:** [what to do based on finding]
```

### Stress Test Session
```markdown
---
type: stress-test
status: complete
slug: [milestone-slug]-stress-test-[date]
date: YYYY-MM-DD
owner: user
---

# Stress Test: [Milestone]

**Requirements reviewed:** [list]

**Findings:**
| Requirement | Issue | Resolution | AC Updated |
|---|---|---|---|

**Open items:** [owner, must resolve before sign-off]
```

### Implementation Report
```markdown
---
type: report
status: draft
slug: [milestone-slug]-report
date: YYYY-MM-DD
---

# Implementation Report: [Milestone]

**Status:** [Complete / Partial / Blocked]

**What shipped:**
- ✅ [Requirement] — what was delivered

**Deviations:** [if any]

**New decisions:** ADR-[NNN] — [Title]

**Product doc updates required:** [list]

**Evolution timeline entry:** [ready to paste]

**Feature index entries:** [ready to paste]

**Retro note:** [brief retro]
```

### Vertical Slice Plan
```markdown
---
type: vertical-slice
status: planned
slug: vs-[n]-[milestone-slug]
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# VS-[n]: [Name]

**Milestone slug:** [slug]
**Slice number:** VS-[n] of [total]
**Combined with:** [VS-[n] or —]
**Ahead planning:** [Enabled / Blocked]

**What this slice proves:** [specific design question or risk]

**User action covered:** [one specific action start to finish]

**Layers touched:** [UI / API / DB / Other — minimum viable per layer]

**Thin implementation plan:**
- What is built: [core]
- What is stubbed: [mocked/simplified]
- What is deferred: [for later slices]

**Validation gate:** [specific checks for done]

**Next slice dependency:** [VS-[n+1] needs this: Implemented / Validated-only / Independent]
```

### Atomic Change Plan
```markdown
---
type: atomic-change-plan
status: draft
slug: [slug]-atomic-changes
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# Atomic Change Plan: [Milestone]

| # | Type | Scope | Safe Alone | Tests | Reviewer |
|---|------|-------|------------|-------|----------|
| 1 | [Schema / Service / API / UI / Config / Test] | [what] | Yes/No | [ref] | [name] |

**Order rationale:** [why this sequence]

**Rules:** Each change does one thing, each has own tests, reviewable under 30min, main stays deployable after every merge, feature hidden behind flag if incomplete.
```

### Test Scenarios
```markdown
---
type: test-scenarios
status: draft
slug: [slug]-test-scenarios
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# Test Scenarios: [Requirement]

## [REQ-001] [Name]

### Level: Unit / Integration / E2E

**Scenario 1 — Happy Path**
GIVEN [condition]
WHEN [action]
THEN [outcome]

**Scenario 2 — Edge Case**
Condition: [what]
Expected: [result]

**Scenario 3 — Failure Case**
What fails: [component]
Expected error: [error]

**Regression check:** [existing behavior that must not change]
```

### Progress Log
```markdown
---
type: progress
status: in-progress
slug: [slug]-progress
created: YYYY-MM-DD
owner: user
upstream:
downstream:
---

# Progress: [Milestone]

| Date | Change | Status | Notes |
|------|--------|--------|-------|
| YYYY-MM-DD | [atomic change ref] | 🚧 In Progress / ✅ Done / ⏸ Blocked | [notes] |

**Blockers:** [current list]

**Next up:** [next atomic change]
```

### Sign-off Log
```markdown
---
type: sign-off-log
slug: [milestone-slug]-sign-off
created: YYYY-MM-DD
owner: user
---

# Sign-off Log: [Milestone]

| Version | Date | Change | Signed by |
|---------|------|--------|-----------|
| v1.0 | YYYY-MM-DD | Initial confirmation | [PM], [Eng Lead] |
```

### Definition of Done Checklist
```markdown
# Definition of Done: [Milestone]

## Code
- [ ] All atomic changes merged
- [ ] All tests passing
- [ ] Code reviewed
- [ ] No regressions
- [ ] Feature flag configured

## Documentation
- [ ] TDD updated for design changes
- [ ] API contract updated if endpoint changed
- [ ] ERD updated if schema changed
- [ ] ADR filed for new decisions
- [ ] Feature Index created/updated
- [ ] Current State Map updated
- [ ] Inline code comments for non-obvious logic
- [ ] README updated

## Product
- [ ] AC verified (manual or E2E)
- [ ] PM sign-off on user-facing behavior
- [ ] Release notes entry written
- [ ] Evolution Timeline updated
```

### Release Note Entry
```markdown
**Version:** [version]
**Date:** YYYY-MM-DD
**Type:** [New Feature / Improvement / Fix / Deprecation]
**Feature:** [name]
**What users can now do:** [one sentence]
**Why it matters / how to access:** [optional]
```

### Retro Note
```markdown
## Retro Note

**Shipped date:** YYYY-MM-DD
**Scope:** [Delivered as planned / Descoped]

**What worked well:** [list]

**What to improve:** [list]

**Surprises:** [list]

**Outcome vs metric:** [result]
```

## On Request
When the owner says "generate a template for [type]":

1. Confirm the slug and context
2. Generate the template with Layer 1-4 structure pre-filled
3. Add cross-references to related docs if they exist
4. Write it to the correct path per workspace conventions (`references/workspace-rules.md` — Artifact Types and Paths table)
5. Update the state tracker

## Memory Integration
Check if a similar artifact already exists. Offer to reference it rather than duplicate. Check BOND.md for any formatting preferences the owner has expressed.

## After the Session
Note in the session log what templates were generated and for what items. Update Workflow State if phases changed.
