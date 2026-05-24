# Product Documentation Framework — Q1-Q10 Lifecycle

Business & Product Level (Q1-Q5) and Technical & Structural Level (Q6-Q10). The complete milestone lifecycle from idea capture through implementation and retrospective.

## Q1 — New Requirement Ideas

- Unvalidated idea = hypothesis, not decision. Must live separately from confirmed work
- Single entry in Idea Capture Log (flat list, not nested, not prioritized)
- Entry fields: Name, Captured by + date, Source (user feedback/internal/data signal/competitor), Status, One-liner, Hypothesis (We believe [user type] needs [thing] because [reason]), Signal, Open questions, Rough size (Unknown/Small/Medium/Large)
- Status progression: 💡 Raw idea → 🔍 Exploring → ✅ Validated → ⏸ Parked → ❌ Rejected
- Rule: Validated ideas leave the log. Unvalidated ideas never enter a milestone. This boundary is the most important discipline

## Q2 — Adding Requirements to a Milestone

- Validated idea (evidence exists it solves a real problem) becomes a requirement assigned to a milestone
- Requirement format: user story (AS A [user] I WANT [action] SO THAT [outcome])
- Acceptance criteria: Given/When/Then format (GIVEN [starting condition] WHEN [action/event] THEN [expected outcome])
- Assignment fields: Requirement Name, User Story, Acceptance Criteria, Priority (MoSCoW), Milestone, Dependencies, Linked Idea
- MoSCoW priorities: Must Have (milestone fails without), Should Have (important but ships without), Nice to Have (only if capacity), Won't Have (explicitly out of scope)

## Q3 — How Milestones Are Structured

- Milestone = meaningful shippable unit of product progress (not a sprint, not a quarter goal)
- Epic (big outcome, months) → Milestone (shippable chunk, weeks) → Story (single requirement) → Task (atomic work, hours)
- Template fields: One-liner, Target date, Status (Planning/In Progress/Complete/Blocked), Owner, Goal, Out of scope, Success metric, Requirements (grouped by MoSCoW), Dependencies (blocked by / blocks), Risks, History (created/scope changes/shipped)

## Q4 — Planning Against What Already Exists

- Every requirement must be mapped against current product state before design begins
- Dependency check: existing features touched, data read/written, user flows affected, impact on existing users, regression risk (what must NOT break), reusable components, net new work
- Delta principle: describe new requirement as change from current state, not as fresh start
- Delta format: CURRENT STATE → NEW REQUIREMENT → DELTA (specific changes)

## Q5 — The Milestone Confirmation File

- Final approved handoff document from product to engineering. Settles "what and why" so "how" can begin
- Real signed-off document, not a Jira board or Slack summary
- Template: Milestone name, Version (increment on scope change), Status (CONFIRMED), Confirmed by (PM + Engineering lead), Confirmed date, Target ship date, Goal, User flows (step-by-step per requirement with edge cases), Requirements (confirmed scope with AC), Out of scope (explicit with reasons), Success metrics, Open questions (resolved before tech design), Dependencies (confirmed), Risks, Linked documents
- Rule: Does not change once confirmed. Scope changes issue new version (v1.1, v2.0) with changelog. Original preserved

## Q6 — Technical Document Stack

Begins after Milestone Confirmation sign-off. Answers "how" (product docs answer "what" and "why").

### Document Summary Table

| Document | Answers | Written when | Lives in |
|---|---|---|---|
| Milestone Confirmation | What + why (confirmed) | After product sign-off | Product docs |
| TDD | How it will be built | Before implementation | Technical docs |
| ADR | Why this technical choice | When decision made | Technical docs |
| API Contract | What API accepts/returns | During TDD | Technical docs |
| ERD | How data is structured | When schema changes | Technical docs |
| Spike Doc | Answer to unknown question | During discovery | Technical docs |

### TDD — Technical Design Document

- Written after Milestone Confirmation, before implementation. Lead engineer owns it
- Template: Status (Draft/In Review/Approved/Superseded), Author, Reviewed by, Date, Linked to Milestone Confirmation, Overview, System context (d2lang diagram with new component highlighted), Approach (high-level + why over alternatives), Data model (tables/fields/schema changes, before/after), API design (endpoints, request/response), Component/service design (responsibilities, boundaries), Edge cases and failure modes, Performance considerations, Security considerations (auth, permissions, data sensitivity), Open questions

### ADR — Architecture Decision Record

- Permanent record of every significant non-obvious technical decision. Written at moment of decision
- Template: Status (Proposed/Accepted/Deprecated/Superseded by ADR-[n]), Date, Author, Context (situation/constraint forcing decision), Options considered (Option A/B/C with pros/cons per option), Decision (chosen + core reason), Trade-offs accepted (what was given up), Outcome (filled after implementation)

### API Contract

- Source of truth for API accepts/returns. Written as part of TDD, updated when API changes
- Template: Endpoint, Status (Live/Draft/Deprecated), Auth, Rate limit, Request (content-type, fields with type/required/constraints), Response (success shape), Errors (status codes per failure)

### ERD — Entity Relationship Diagram

- Visual map of data models and relationships. Must reflect CURRENT state, not intended state. Update when schema changes ship

### Spike / Research Doc

- Time-boxed investigation into technically unknown question. Before committing to TDD approach
- Template: Time-box, Question, Approach, Finding, Recommendation

## Q7 — Validation & Sign-Off

Two separate review gates before implementation begins. Bug caught in design doc = 15 min fix; bug found after implementation = days.

### Gate 1 — Milestone Confirmation Review (product-level, before TDD)

- Reviewers: PM, senior engineer, stakeholder from affected area
- Checklist: goal clear + user-facing, every requirement has testable AC, out-of-scope explicitly listed, dependencies confirmed, success metrics defined, all open questions answered, scope achievable in timeline, no contradiction with existing feature
- Output: Confirmed (proceed to TDD) or Revise (issues logged with owner + deadline)

### Gate 2 — Technical Design Review (engineering-level, after TDD draft)

- Reviewers: Engineering lead, at least one senior engineer not on implementing team
- Checklist: TDD addresses all Milestone Confirmation requirements, data model backward compatible or migration planned, API follows conventions, edge cases accounted for, performance implications understood, security review passed, no conflicts with in-flight work, ADRs filed for non-obvious decisions, implementation breakable into independent shippable pieces
- Output: Approved (proceed to implementation planning) or Revise

### Sign-off Record

- Gate 1: Confirmed by @pm, @eng-lead + date
- Gate 2: Approved by @eng-lead, @reviewer + date

## Q8 — Implementation Planning

Three layers: Options & Brainstorm → Implementation Breakdown → Timeline.

### Layer 1 — Options and Brainstorm

- Template: Problem statement (restated from TDD in implementation terms), Options considered (Approach/Pros/Cons/Unknowns/Effort est per option), Recommendation (which + core reason), Risks identified

### Layer 2 — Implementation Breakdown

- Principle: Each piece mergeable to main without breaking (use feature flags). Atomic at implementation level
- Template per piece: Name, What, Why now, Risk (Low/Medium/High), Est (hours), Done when (specific condition)
- Ordered with depends-on links. Order rationale stated

### Layer 3 — Timeline

- Realistic week-by-week view. 20% buffer for unknowns and review cycles
- Template: Target ship date, Working days available, Buffer (20%), Week-by-week mapping (piece → week), Confidence (High/Medium/Low), Assumptions

## Q9 — Testing Scenarios & Atomic Code Changes

Write tests BEFORE implementation (defines target; tests written after validate what was built).

### Testing Scenarios (3 levels per acceptance criterion)

- Level: Unit / Integration / End-to-End
- Scenario template: Happy path (Given/When/Then), Edge cases (condition → expected result), Failure cases (what fails → expected error), Regression check (existing behavior that must not change)

### Atomic Code Change Plan

- Each piece from Implementation Breakdown → one or more atomic changes (PRs/commits)
- Change template: Type (Schema migration/New service/API endpoint/UI component/Config change/Test suite), Scope, Safe to merge alone (Yes/No), Tests, Reviewer
- Atomicity rules: each change does one thing, each has own tests, reviewable under 30min, main stays deployable after every merge, feature hidden behind flag if incomplete. Prohibited: catch-all PRs, schema migration bundled with business logic, tests only in final PR

## Q10 — Implementation & Documentation Updates

### Definition of Done

- Code: all atomic changes merged, all tests passing, code reviewed, no regressions, feature flag configured
- Documentation: TDD updated for design changes, API contract updated if endpoint changed, ERD updated if schema changed, ADR filed for new decisions, Feature Index created/updated, Current State Map updated, inline code comments for non-obvious logic, README updated
- Product: AC verified (manual or E2E), PM sign-off on user-facing behavior, release notes entry written, Evolution Timeline updated (if significant change)

### Document Update Table

| Document | Updated when | Who |
|---|---|---|
| TDD | Design changed during implementation | Implementing engineer |
| API Contract | Endpoint added/changed/removed | Backend engineer |
| ERD | Schema migration runs | Backend/data engineer |
| ADR | New non-obvious decision made | Engineer who made it |
| Feature Index | Feature ships to any users | PM or engineer |
| Current State Map | Status changes (beta→live etc.) | PM |
| Evolution Timeline | Significant capability added | PM |
| Release Notes | User-facing change ships | PM |
| Inline code comments | Non-obvious logic written | Implementing engineer |

### Release Note Entry

- Format: Version/Date, Type (New Feature/Improvement/Fix/Deprecation), Feature name, One sentence what users can now do, Optional why matters/how to access

### Post-Implementation Retro Note

- Appended to milestone doc after ship: Shipped date, Scope (delivered as planned / descoped), What worked well, What to improve, Surprises, Outcome vs metric

## Documentation Debt

- Phase 1 (1-2 days): headers everywhere — Layer 1+2 for every existing feature
- Phase 2 (1-2 weeks): d2lang flow diagrams for 20% of features causing 80% of questions/bugs
- Phase 3 (ongoing): deep docs on demand — only when actively changing, new engineer confused, bug revealed unknown edge case
- Never: document stable things nobody touches; dead docs mislead more than no docs
