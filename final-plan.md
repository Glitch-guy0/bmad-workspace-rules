# Product Documentation Framework
> How living products stay documented, navigable, and sane — from MVP to year five and beyond

---

## How to Read This Document

This document itself follows the framework it describes.

| If you want to... | Go to... |
|---|---|
| Understand the big idea quickly | [The Core Problem](#the-core-problem) |
| See the full layered model | [The Layered Model](#the-layered-model) |
| Understand how a product evolves over 5 years | [The 5-Year Arc](#the-5-year-arc) |
| Learn how Google and big orgs handle this | [How Big Orgs Do It](#how-big-orgs-do-it) |
| See the full end-to-end flow | [The Master Flow](#the-master-flow) |
| **Capture a new unvalidated idea** | [Q1 — New Requirement Ideas](#q1--new-requirement-ideas) |
| **Add requirements to a milestone** | [Q2 — Adding to a Milestone](#q2--adding-requirements-to-a-milestone) |
| **Understand how milestones are structured** | [Q3 — Milestone Structure](#q3--how-milestones-are-structured) |
| **Plan a requirement against what already exists** | [Q4 — Planning Against Existing Work](#q4--planning-against-what-already-exists) |
| **Know the final confirmed milestone doc** | [Q5 — The Milestone Confirmation File](#q5--the-milestone-confirmation-file) |
| **Understand all technical documents** | [Q6 — Technical Document Stack](#q6--the-technical-document-stack) |
| **Validate milestone and architecture docs** | [Q7 — Validation & Sign-Off](#q7--validation--sign-off) |
| **Plan and document implementation** | [Q8 — Implementation Planning](#q8--implementation-planning) |
| **Break into tests and atomic changes** | [Q9 — Testing and Atomic Changes](#q9--testing-scenarios--atomic-code-changes) |
| **Handle implementation and live doc updates** | [Q10 — Implementation and Documentation Updates](#q10--implementation--documentation-updates) |
| Fix existing documentation debt | [Tackling Documentation Debt](#tackling-documentation-debt) |
| **Understand the two-repo system** | [Repo Architecture](#repo-architecture) |
| **See the product repo file structure** | [Product Repo](#product-repo-file-structure) |
| **See the developer repo file structure** | [Developer Repo](#developer-repo-file-structure) |
| **Understand DTO files and handoffs** | [DTO — File Handoffs](#dto--file-handoffs) |
| **See how the agent flow works** | [Agent Flow](#agent-flow) |
| **Handle non-functional requirements** | [NFR — Non-Functional Requirements](#nfr--non-functional-requirements) |
| **Handle accepted and postponed tech debt** | [Tech Debt](#tech-debt) |
| **Understand the file indexing system** | [Part 4 — File Indexing System](#part-4--file-indexing-system) |
| **See the file header standard** | [File Header Standard](#file-header-standard) |
| **See the folder index standard** | [Folder Index Standard](#folder-index-standard) |
| **Understand the link chain** | [The Link Chain](#the-link-chain) |
| **See the two decision-making phases** | [Part 5 — Decision-Making Phases](#part-5--decision-making-phases) |
| **Understand PDR and Product Research Doc** | [Product Planning Decisions](#product-planning-phase-decisions) |
| **Understand the three-tier org flow** | [Three-Tier Org Flow](#three-tier-organizational-flow) |
| **See VP / PM / Senior Dev research** | [Research Per Role](#research-per-role) |
| **See the strategic layer file structure** | [Strategy Layer](#strategy-layer-file-structure) |
| **Understand the BMAD skill** | [Part 6 — BMAD Skill & Project Setup](#part-6--bmad-skill--project-setup) |
| **See the skill internal structure** | [Skill Structure](#skill-internal-structure) |
| **Understand initial project setup** | [Initial Project Setup](#initial-project-setup) |
| **Choose submodule vs git workflow** | [Two Repo Options](#two-repo-options) |
| **See the end-state folder layout** | [End State Structure](#end-state-structure) |
| **Understand decision sync** | [Sync — Decision Layer](#sync--decision-layer) |
| **Understand vertical slice planning** | [Vertical Slice Plan](#vertical-slice-plan) |

---

## The Core Problem

After a product runs for a few years, documentation doesn't fail because nobody wrote things down. It fails because **there is no information hierarchy.**

Everything is at the same depth. A one-liner description sits next to a 40-page spec. A feature deprecated two years ago looks identical to a live one. A new engineer can't tell what matters from what doesn't.

The result: nobody reads anything.

> **The fix is not more documentation. It is layered documentation with the right document at the right stage.**

---

## The Layered Model

Every piece of information should exist at the right depth — no deeper than needed, no shallower than useful.

```
Layer 1 — One-liner
  "What is this?"
  One sentence. Always up to date.

Layer 2 — Summary
  "What does it do, who uses it, what state is it in?"
  A short paragraph. Enough for a newcomer to orient.

Layer 3 — Brief Flow
  "How does it work end to end?"
  A diagram or short walkthrough. Skimmable in two minutes.

Layer 4 — Detailed Spec
  "Everything someone needs to build or debug this."
  Full depth. Only read when actually needed.
```

This principle is called **progressive disclosure** — the same concept used in good UI design. Show the shape first, reveal detail on demand.

---

## The 5-Year Arc

What actually happens to a product's documentation over time:

```
Month 1–2     MVP ships. Everyone knows everything. No docs needed.

Month 3–6     "We'll document later." Nothing is written.

Year 1–2      Tribal knowledge accumulates. 3–4 people "hold" the system
              in their heads. Onboarding means sitting next to someone.

Year 3        A key person leaves. Panic. A documentation sprint happens.
              The result: a Confluence graveyard nobody maintains.

Year 4–5      The system works but nobody knows why certain decisions
              were made. New engineers work around things they don't
              understand. Tech debt and doc debt compound together.
```

This is not a failure of discipline. It is a failure of **structure**.

---

## How Big Orgs Do It

### Google — Design Doc Culture
One document per significant feature or system. Format is strict. Owner is always named. Status is always visible at the top. Every non-obvious decision has a written justification — not for auditing, but because writing it reveals whether the decision actually makes sense.

### Amazon — The Six-Pager
No slide decks for product proposals. Every major product discussion starts with a written narrative, read in silence at the start of the meeting. Forces clarity — you cannot hide vague thinking in a bullet when you must write full sentences.

### Stripe — RFC Process
Every significant change gets an RFC (Request for Comments): what is proposed, why, and what alternatives were considered. These become a permanent record. A year later, you can read exactly why the system works the way it does.

### The Common Thread
- **One owner per document** — always someone responsible for keeping it current
- **Status is always visible** — live, experimental, deprecated — never ambiguous
- **The "why" is recorded** — not just what was built, but why that decision was made

---

## The Master Flow

How information moves from a raw idea all the way to living documentation:

```
BUSINESS / PRODUCT LEVEL
─────────────────────────────────────────────────────
Raw idea (unvalidated)
  ↓  [Q1]
Idea Capture Doc → Discovery Backlog
  ↓  [Q2]
Validated → Added to Milestone List
  ↓  [Q3]
Milestone Structured (Epic → Stories → Acceptance Criteria)
  ↓  [Q4]
Dependency check against existing implementation
  ↓  [Q5]
Milestone Confirmation File ← THE HANDOFF DOCUMENT
─────────────────────────────────────────────────────

TECHNICAL / STRUCTURAL LEVEL
─────────────────────────────────────────────────────
  ↓  [Q6]
Technical Document Stack created (TDD, ADR, API contracts)
  ↓  [Q7]
Milestone + Architecture validated and signed off
  ↓  [Q8]
Implementation Planning (options, brainstorm, timeline)
  ↓  [Q9]
Test scenarios + atomic code change plan
  ↓  [Q10]
Implementation → code, docs, and living documents updated
─────────────────────────────────────────────────────
```

---

---

# PART 1 — Business & Product Level

*Questions 1 through 7. This is the product thinking layer — what to build and why, before a single line of code is written.*

---

## Q1 — New Requirement Ideas

### What
A new requirement idea is any unvalidated thought about what the product should do differently or additionally. At this stage it is a hypothesis, not a decision. It needs a home that is clearly separate from confirmed work.

### Why
If ideas go directly into the backlog or a milestone, two things break. First, unvalidated ideas pollute the actual work queue and create noise for engineers. Second, good ideas get lost in Slack threads or someone's notes and never get revisited. The idea needs to be captured in a structured but low-commitment format.

### How

Every new idea gets a single entry in an **Idea Capture Log** — a flat list or database, not nested, not prioritized yet.

```
IDEA CAPTURE ENTRY
──────────────────────────────────────────
Name          → [Short descriptive name]
Captured by   → @person  |  Date: [date]
Source        → User feedback / Internal / Data signal / Competitor
Status        → 💡 Raw idea

One-liner     → [What is this in one sentence]
Hypothesis    → We believe [user type] needs [thing] because [reason]
Signal        → [What triggered this — quote, metric, observation]
Open questions → [What we don't know yet before this can be validated]
Rough size    → Unknown / Small / Medium / Large
──────────────────────────────────────────
```

**Status progression for an idea:**

```
💡 Raw idea      → Just captured, no evaluation yet
🔍 Exploring     → Being researched or discussed
✅ Validated     → Evidence exists, moves to milestone planning
⏸  Parked       → Good idea, wrong time — revisit later
❌ Rejected      → Evaluated and deliberately not pursuing
```

> **Rule:** Validated ideas leave this log. Unvalidated ideas never enter a milestone. This boundary is the most important discipline in the process.

---

## Q2 — Adding Requirements to a Milestone

### What
Once an idea is validated — meaning there is evidence it solves a real problem worth solving — it gets formally written as a requirement and assigned to a milestone. A requirement at this stage is user-facing: it describes what the user will be able to do, not how the system will do it.

### Why
Milestones are commitments. Requirements that enter a milestone have been through some level of validation. Mixing raw ideas with confirmed requirements creates confusion about what is actually being built and makes estimation impossible.

### How

**Step 1 — Write the requirement as a user story:**
```
AS A     [type of user]
I WANT   [to do something]
SO THAT  [I get this outcome or value]
```

**Step 2 — Write acceptance criteria:**
These are the specific, testable conditions that confirm the requirement is met. Written as "Given / When / Then":
```
GIVEN    [a starting condition]
WHEN     [a user action or system event]
THEN     [the expected outcome]
```

**Step 3 — Assign to milestone:**
```
Requirement Name  → [name]
User Story        → [as a / I want / so that]
Acceptance Criteria → [given / when / then list]
Priority          → Must Have / Should Have / Nice to Have
Milestone         → [milestone name and target date]
Dependencies      → [what must exist before this can be built]
Linked Idea       → [link back to original idea capture entry]
```

**Priority framework (MoSCoW):**

| Label | Meaning |
|---|---|
| Must Have | Without this the milestone fails |
| Should Have | Important but milestone ships without it |
| Nice to Have | Included only if capacity allows |
| Won't Have | Explicitly out of scope for this milestone |

---

## Q3 — How Milestones Are Structured

### What
A milestone is a meaningful, shippable unit of product progress. It is not a sprint (too granular) and not a quarter goal (too vague). A milestone answers: "What meaningful thing will users be able to do when this is done?"

### Why
Without milestone structure, work either becomes a never-ending backlog or a rigid project plan. Milestones give shape to work — a clear start, a clear definition of done, and a clear user-facing outcome. They also create natural checkpoints for reflection before moving forward.

### How

**Milestone structure:**

```
MILESTONE: [Name]
──────────────────────────────────────────────────────
One-liner       → What users can do when this ships
Target date     → [date]
Status          → Planning | In Progress | Complete | Blocked
Owner           → @person

Goal            → The user outcome this milestone achieves
Out of scope    → Explicitly what is NOT in this milestone
Success metric  → How we know this milestone succeeded

REQUIREMENTS
  Must Have
    → [Requirement 1 — link to full requirement]
    → [Requirement 2]
  Should Have
    → [Requirement 3]
  Nice to Have
    → [Requirement 4]

DEPENDENCIES
  Blocked by    → [other milestone or external dependency]
  Blocks        → [what this enables next]

RISKS
  → [Known risk and mitigation]

HISTORY
  [Date] Created
  [Date] Scope change — [what changed and why]
  [Date] Shipped
──────────────────────────────────────────────────────
```

**How milestones relate to each other:**

```
Epic (big outcome, months of work)
  └── Milestone 1 (shippable chunk, weeks)
        └── Story 1 (single requirement)
              └── Task 1 (atomic unit of work, hours)
              └── Task 2
        └── Story 2
  └── Milestone 2
  └── Milestone 3
```

An **Epic** is the large user outcome — "Users can collaborate in real time."
A **Milestone** is a shippable step toward it — "Users can see each other's cursors."
A **Story** is the requirement — "As a user, I see a labeled cursor for each collaborator."
A **Task** is the atomic work — "Implement cursor broadcast via WebSocket."

---

## Q4 — Planning Against What Already Exists

### What
Before any new requirement is designed or architected, it must be mapped against the current state of the product. What already exists? What does this requirement change, extend, or depend on? Where might it conflict?

### Why
New requirements don't land on a blank slate. They land on top of years of decisions, existing data models, user flows, and technical choices. Planning without understanding the existing system leads to duplicate work, broken flows, and architecture that fights itself.

### How

**The dependency check — run this for every requirement before it enters technical design:**

```
DEPENDENCY CHECK FOR: [Requirement Name]
──────────────────────────────────────────
Existing features it touches   → [list]
Existing data it reads/writes  → [list]
Existing user flows it affects → [list]
What changes for existing users → [describe impact]
What must NOT break            → [list — regression risk]
What could be reused           → [existing components, logic, APIs]
What must be built new         → [net new work]
──────────────────────────────────────────
```

**The planning principle — "from already implemented":**

Always describe the new requirement as a delta from the current state, not as if starting fresh.

```
CURRENT STATE:  Users can upload a single profile photo.
NEW REQUIREMENT: Users can upload multiple photos and set a primary.
DELTA:          Extend upload to accept multiple files.
                Add primary selection UI.
                Update profile display to use primary photo.
                Migrate existing single photos as "primary."
```

This forces explicit thinking about what changes — not just what is added.

---

## Q5 — The Milestone Confirmation File

### What
The Milestone Confirmation File is the final, approved document that represents everything agreed upon at the product level before work enters the technical design phase. It is the handoff document — the point where "what and why" is settled, and "how" can begin.

### Why
Without a clear handoff document, the boundary between product and engineering is fuzzy. Engineers make product decisions they shouldn't have to make. Product managers make architecture assumptions that break reality. The Milestone Confirmation File makes this boundary explicit and saves both sides from rework.

### How

This is a real, signed-off document — not a Jira board, not a Slack summary. It contains:

```
MILESTONE CONFIRMATION FILE
══════════════════════════════════════════════════════
Milestone      → [Name]
Version        → [1.0 — increment on scope changes]
Status         → CONFIRMED ✅
Confirmed by   → [PM name] + [Engineering lead name]
Confirmed date → [date]
Target ship    → [date]
══════════════════════════════════════════════════════

GOAL
[One paragraph — what user outcome this achieves and why now]

USER FLOWS
[For each requirement: the user journey from start to finish]
  Flow 1: [Name]
    Step 1 → User does X
    Step 2 → System does Y
    Step 3 → User sees Z
    Edge case: [what happens if something fails]

REQUIREMENTS (CONFIRMED SCOPE)
  ✅ [Requirement 1] — Must Have
     Acceptance criteria: [given/when/then]
  ✅ [Requirement 2] — Should Have
     Acceptance criteria: [given/when/then]

OUT OF SCOPE (EXPLICIT)
  ❌ [Thing deliberately excluded] — Reason: [why]
  ❌ [Thing deliberately excluded] — Reason: [why]

SUCCESS METRICS
  → [How we measure if this milestone succeeded]
  → [What number / behavior indicates success]

OPEN QUESTIONS (resolved before technical design begins)
  → [Question] — Answer: [answer] — Decided by: @person

DEPENDENCIES (confirmed)
  → [What must be true before this can be built]

RISKS (acknowledged)
  → [Risk] — Mitigation: [plan]

LINKED DOCUMENTS
  → Original milestone doc: [link]
  → Requirement entries: [links]
  → Idea capture entries: [links]
══════════════════════════════════════════════════════
```

> This document does not change once confirmed. If scope changes, a new version is issued (v1.1, v2.0) with a changelog entry explaining what changed and why. The original is preserved.

---

---

# PART 2 — Technical & Structural Level

*Questions 6 through 10. This is the engineering layer — how to design, validate, plan, and implement the confirmed work.*

---

## Q6 — The Technical Document Stack

### What
Once the Milestone Confirmation File is signed off, the technical phase begins. This phase has its own set of documents — each serving a specific purpose for a specific reader. These documents answer "how" — the product docs answered "what" and "why."

### Why
Without distinct technical documents, design decisions, API contracts, and algorithmic choices get mixed into tickets or Slack. They become invisible, undiscoverable, and impossible to revisit. Separate documents give each type of decision a permanent, findable home.

### How

**The full technical document stack:**

---

### TDD — Technical Design Document

**What:** How the system will be built to meet the confirmed requirements.
**When:** Written after Milestone Confirmation, before implementation begins.
**Who writes it:** The lead engineer for the milestone.

```
TDD: [Feature / Milestone Name]
──────────────────────────────────────────
Status       → Draft | In Review | Approved | Superseded
Author       → @name
Reviewed by  → @name, @name
Date         → [date]
Linked to    → [Milestone Confirmation File]

OVERVIEW
  What this document covers and what it does not.

SYSTEM CONTEXT
  Where this fits in the existing architecture.
  [Diagram: current system with new component highlighted]

APPROACH
  How the requirement will be implemented at a high level.
  Why this approach over alternatives (brief — full comparison in ADR).

DATA MODEL
  New tables / fields / schema changes.
  [Before and after if modifying existing]

API DESIGN
  New endpoints or changes to existing ones.
  Request / response shape for each.

COMPONENT / SERVICE DESIGN
  New services, classes, or modules.
  Responsibilities and boundaries.

EDGE CASES AND FAILURE MODES
  What happens when things go wrong.
  How errors are handled and surfaced.

PERFORMANCE CONSIDERATIONS
  Expected load, query complexity, caching strategy.

SECURITY CONSIDERATIONS
  Auth, permissions, data sensitivity.

OPEN QUESTIONS
  Technical unknowns that need resolution before or during implementation.
──────────────────────────────────────────
```

---

### ADR — Architecture Decision Record

**What:** A permanent record of every significant non-obvious technical decision.
**When:** Written at the moment a decision is made.
**Who writes it:** The engineer or architect who made or led the decision.

```
ADR-[number]: [Decision Title]
──────────────────────────────
Status    → Proposed | Accepted | Deprecated | Superseded by ADR-[n]
Date      → [date]
Author    → @name

CONTEXT
  What situation or constraint forced this decision.

OPTIONS CONSIDERED
  Option A: [name] — [what it is] — Pros: / Cons:
  Option B: [name] — [what it is] — Pros: / Cons:
  Option C: [name] — [what it is] — Pros: / Cons:

DECISION
  [What was chosen and the core reason]

TRADE-OFFS ACCEPTED
  [What was given up or made harder by this choice]

OUTCOME
  [Filled in after implementation — what actually happened]
──────────────────────────────
```

---

### API Contract

**What:** The source of truth for what any API accepts and returns.
**When:** Written as part of TDD, updated whenever the API changes.
**Who writes it:** Backend engineer. Consumed by frontend, mobile, partners.

```
Endpoint     POST /api/v1/photos/upload
Status       → Live | Draft | Deprecated
Auth         → Required — Bearer token
Rate limit   → 10 requests/minute per user

REQUEST
  Content-Type: multipart/form-data
  Fields:
    files[]     File[]    Required  Up to 5 files, max 5MB each
    primary     integer   Optional  Index of primary photo (default: 0)

RESPONSE 200
  {
    photos: [{ id, url, isPrimary, uploadedAt }],
    count: integer
  }

ERRORS
  400  Invalid file type or size
  401  Unauthenticated
  422  Validation failure — [field: reason]
  500  Upload service error
```

---

### ERD — Entity Relationship Diagram

**What:** Visual map of data models and their relationships.
**When:** Created or updated whenever the data model changes.
**Who writes it:** Backend/data engineer.

Not a document format — a diagram. Tools: dbdiagram.io, Mermaid, Lucidchart. The key rule: the ERD must reflect the **current** state of the database, not the intended state. Update it when schema changes ship, not when they are planned.

---

### Spike / Research Doc

**What:** A time-boxed investigation into something technically unknown.
**When:** Before committing to an approach in the TDD when a key question is unresolved.
**Who writes it:** The engineer who ran the investigation.

```
SPIKE: [Question being investigated]
──────────────────────────────────────
Time-box   → [how long was spent]
Question   → [what specifically was being figured out]
Approach   → [what was tried]
Finding    → [what was learned]
Recommendation → [what this means for the TDD decision]
──────────────────────────────────────
```

---

### Document Summary Table

| Document | Answers | Written when | Lives in |
|---|---|---|---|
| Milestone Confirmation | What + why (confirmed) | After product sign-off | Product docs |
| TDD | How it will be built | Before implementation | Technical docs |
| ADR | Why this technical choice | When decision is made | Technical docs |
| API Contract | What the API accepts/returns | During TDD | Technical docs |
| ERD | How data is structured | When schema changes | Technical docs |
| Spike Doc | Answer to unknown question | During discovery | Technical docs |

---

## Q7 — Validation & Sign-Off

### What
Before implementation begins, both the Milestone Confirmation File and the Technical Design Document must go through a review and sign-off process. This is not a formality — it is the point where errors are cheapest to fix.

### Why
A bug caught in a design document costs 15 minutes to fix. The same bug caught after implementation costs days. Validation at this stage answers: Does the product doc match reality? Does the technical doc correctly solve the product requirement? Are there gaps, conflicts, or risks nobody has spotted yet?

### How

**Two separate review gates:**

---

**Gate 1 — Milestone Confirmation Review**
*Product-level. Happens before technical design begins.*

Reviewers: PM, a senior engineer, a stakeholder from the affected area.

Checklist:
```
□ Goal is clear and user-facing (not technical)
□ Every requirement has testable acceptance criteria
□ Out-of-scope items are explicitly listed
□ Dependencies are identified and confirmed available
□ Success metrics are defined and measurable
□ All open questions are answered
□ Scope is achievable in the target timeline (sanity check)
□ No requirement contradicts an existing live feature
```

Output: **Confirmed** (proceed to TDD) or **Revise** (specific issues logged with owner and deadline).

---

**Gate 2 — Technical Design Review**
*Engineering-level. Happens after TDD is drafted, before implementation begins.*

Reviewers: Engineering lead, at least one senior engineer not on the implementing team.

Checklist:
```
□ TDD fully addresses every requirement in the Milestone Confirmation
□ Data model changes are backward compatible or migration is planned
□ API design follows existing conventions
□ Edge cases and failure modes are accounted for
□ Performance implications are understood
□ Security review passed (auth, permissions, data exposure)
□ No conflicts with other in-flight work
□ ADRs filed for every non-obvious decision
□ Implementation is breakable into independent, shippable pieces
```

Output: **Approved** (proceed to implementation planning) or **Revise** (specific comments logged).

---

**The sign-off record:**

Both gates produce a brief sign-off entry attached to the document:

```
SIGN-OFF
Gate 1 — Product   Confirmed by: @pm, @eng-lead  |  Date: [date]
Gate 2 — Technical Approved by: @eng-lead, @reviewer  |  Date: [date]
Notes: [any conditions or follow-up items]
```

---

---

## Q8 — Implementation Planning

### What
Implementation planning translates an approved TDD into an actual plan for building — breaking work into ordered pieces, understanding options and trade-offs at the code level, and creating a realistic timeline. This is where the technical brainstorming happens.

### Why
An approved TDD says *what* to build and *how* at a design level. It does not say in what order, which parts carry the most risk, what the team should try first, or how long each piece realistically takes. Without this planning step, teams either start from the hardest part and get blocked, or start from the easiest and discover the hard part too late.

### How

**Implementation planning has three layers:**

---

### Layer 1 — Options and Brainstorm Doc

Before committing to an implementation path, capture the options.

```
IMPLEMENTATION BRAINSTORM: [Feature / Milestone]
─────────────────────────────────────────────────
Date: [date]  |  Participants: @name, @name

PROBLEM STATEMENT
  What exactly needs to be built. (Restated from TDD in implementation terms.)

OPTIONS CONSIDERED

  Option A: [Name]
  ─────────────────
  Approach:   [How this would work at code/system level]
  Pros:       [What this makes easy]
  Cons:       [What this makes hard or risky]
  Unknowns:   [What we don't know yet]
  Effort est: [rough hours or days]

  Option B: [Name]
  ─────────────────
  Approach:   ...
  Pros:       ...
  Cons:       ...
  Unknowns:   ...
  Effort est: ...

RECOMMENDATION
  [Which option and the core reason]
  [What convinced the team]

RISKS IDENTIFIED
  → [Risk] — Mitigation: [plan]
─────────────────────────────────────────────────
```

---

### Layer 2 — Implementation Breakdown

Once the approach is chosen, break it into ordered, independently shippable pieces.

**Principle:** Each piece should be mergeable to main without breaking anything, even if the feature is not yet user-visible (use feature flags). This is what "atomic" means at the implementation level.

```
IMPLEMENTATION BREAKDOWN: [Feature]
─────────────────────────────────────────
Piece 1: [Name]
  What:    [What this piece does]
  Why now: [Why this must come first]
  Risk:    Low / Medium / High
  Est:     [hours]
  Done when: [specific condition — not "when code is written"]

Piece 2: [Name]
  Depends on: Piece 1
  What:    ...
  ...

Piece 3: [Name]
  Depends on: Piece 1, 2
  ...
─────────────────────────────────────────
Order rationale: [Why this sequence — highest risk first, or foundation first, etc.]
```

---

### Layer 3 — Timeline

Not a Gantt chart. A realistic, buffer-aware week-by-week view.

```
IMPLEMENTATION TIMELINE: [Milestone Name]
─────────────────────────────────────────
Target ship date: [date]
Working days available: [n]
Buffer held back: 20% (for unknowns and review cycles)

Week 1  → Piece 1 + Piece 2 (foundation)
Week 2  → Piece 3 + Piece 4 (core logic)
Week 3  → Piece 5 (integration) + internal testing
Week 4  → Bug fixes from review + documentation updates
─────────────────────────────────────────
Confidence: High / Medium / Low
Assumption: [what must be true for this timeline to hold]
```

---

## Q9 — Testing Scenarios & Atomic Code Changes

### What
Before writing code, define what "correct" looks like — in testable, specific terms. Then plan each code change as the smallest unit that can be implemented, reviewed, and merged independently.

### Why
Testing scenarios written before implementation define the target. Testing scenarios written after implementation rationalize what was built. They serve completely different purposes. Writing tests first catches design problems before they are expensive. Atomic code changes keep the codebase stable, make reviews manageable, and make bugs easier to locate.

### How

---

### Testing Scenarios

For each acceptance criterion from the Milestone Confirmation File, write explicit test scenarios — at three levels:

```
SCENARIO: [Name — describes what is being tested]
─────────────────────────────────────────────────
Level: Unit / Integration / End-to-End
Linked to: [Acceptance criterion from milestone doc]

HAPPY PATH
  Given: [starting state]
  When:  [action or event]
  Then:  [expected outcome]

EDGE CASES
  → [Condition]: Expected result: [result]
  → [Condition]: Expected result: [result]

FAILURE CASES
  → [What fails]: Expected error: [error type/message]
  → [What fails]: Expected error: [error type/message]

REGRESSION CHECK
  → [Existing behavior that must not change]
─────────────────────────────────────────────────
```

**Example:**

```
SCENARIO: Multiple photo upload — happy path
Linked to: AC-3 "Users can upload up to 5 photos"

HAPPY PATH
  Given: Authenticated user on profile edit page
  When:  User selects 3 valid JPEG files and submits
  Then:  All 3 photos upload successfully
         First photo is marked as primary by default
         User sees all 3 photos in their gallery

EDGE CASES
  → User uploads exactly 5 photos:  All 5 accepted
  → User uploads 1 photo:           Accepted, marked primary automatically
  → User re-orders and sets primary: New primary persists on page reload

FAILURE CASES
  → User uploads 6 photos:    Error: "Maximum 5 photos allowed"
  → File exceeds 5MB:         Error: "File too large" with filename
  → Non-image file selected:  Error: "Only JPEG, PNG, and WEBP supported"
  → Upload fails mid-way:     Partial success handled; user told which failed
```

---

### Atomic Code Change Plan

Each piece from the Implementation Breakdown maps to one or more atomic changes (PRs/commits).

```
ATOMIC CHANGE PLAN: [Feature]
─────────────────────────────────────────────────
Change 1: [Name]
  Type:      Schema migration / New service / API endpoint /
             UI component / Config change / Test suite
  Scope:     [What files / systems are touched]
  Safe to merge alone: Yes / No (if No — must merge with Change N)
  Tests:     [What tests cover this change]
  Review:    [Who should review — domain expert]

Change 2: [Name]
  Depends on: Change 1
  ...
─────────────────────────────────────────────────
```

**Rules for atomicity:**

```
✅ Each change does one thing
✅ Each change has its own tests
✅ Each change is reviewable in under 30 minutes
✅ Main branch stays deployable after every merge
✅ Feature is hidden behind a flag if not yet complete

❌ "Catch-all" PRs that touch unrelated files
❌ Schema migration bundled with business logic
❌ Tests added only in the final PR
```

---

## Q10 — Implementation & Documentation Updates

### What
As implementation proceeds, code gets written, reviewed, and merged. Simultaneously, all relevant documentation must be updated to reflect the new reality. Documentation written before or after implementation without concurrent updates becomes stale immediately.

### Why
Documentation written at the end of a project is always incomplete and often wrong. The person who built something has context at implementation time that they will not have three weeks later. The habit of updating docs as part of the definition of done — not after it — is what separates living documentation from archaeology.

### How

---

### The Definition of Done

A piece of work is not done when the code is merged. It is done when all of these are true:

```
CODE
  □ All atomic changes merged to main
  □ All tests passing (unit, integration, E2E)
  □ Code reviewed and approved
  □ No regressions in existing test suite
  □ Feature flag configured correctly (if used)

DOCUMENTATION
  □ TDD updated to reflect any design changes made during implementation
  □ API contract updated if endpoint changed
  □ ERD updated if schema changed
  □ ADR filed for any new decisions made during implementation
  □ Feature Index entry created or updated
  □ Current State Map status updated
  □ Inline code comments for non-obvious logic
  □ README updated if setup or behavior changed

PRODUCT
  □ Acceptance criteria verified (manually or by E2E tests)
  □ PM sign-off on the user-facing behavior
  □ Release notes entry written
  □ Evolution Timeline updated (if this was a significant change)
```

---

### What Gets Updated and When

| Document | Updated when | Who |
|---|---|---|
| TDD | Design changed during implementation | Implementing engineer |
| API Contract | Endpoint added, changed, or removed | Backend engineer |
| ERD | Schema migration runs | Backend/data engineer |
| ADR | A new non-obvious decision is made | Engineer who made it |
| Feature Index | Feature ships to any users | PM or engineer |
| Current State Map | Status changes (beta → live, etc.) | PM |
| Evolution Timeline | Significant capability added | PM |
| Release Notes | Any user-facing change ships | PM |
| Inline code comments | Non-obvious logic is written | Implementing engineer |

---

### The Release Note Entry

For every user-facing change, a release note entry is written at ship time:

```
RELEASE NOTE
─────────────────────────────────
Version / Date: [version or date]
Type: New Feature / Improvement / Fix / Deprecation

[Feature name]
[One sentence: what users can now do]
[Optional: why this matters or how to access it]
─────────────────────────────────
Example:

Photo Gallery — Multiple photo upload
Users can now upload up to 5 photos to their profile and choose
which one appears as their primary photo. Access this from
Profile Settings → Photos.
```

---

### Post-Implementation Retro Note

After a milestone ships, a short retro note is added to the milestone document:

```
RETRO NOTE (added post-ship)
──────────────────────────────────────────────────────
Shipped:    [date]
Scope:      [delivered as planned / descoped items and why]
What worked well:     [1-2 things to repeat]
What to improve:      [1-2 things to change next time]
Surprises:            [anything unexpected during implementation]
Outcome vs metric:    [what the success metric showed after shipping]
──────────────────────────────────────────────────────
```

This closes the loop. The milestone has a clear end: a signed-off document, a shipped feature, and a recorded reflection.

---

---

## The Full Document Map

Every document in the system, its purpose, and where it lives:

```
PRODUCT / BUSINESS LAYER
────────────────────────────────────────────────────────────
Idea Capture Log         Unvalidated ideas                  Product docs
Milestone List           Validated requirements, scoped      Product docs
Milestone Doc            Structured milestone with stories   Product docs
Milestone Confirmation   Signed-off handoff document         Product docs → handoff
Evolution Timeline       History of product decisions        Product docs
Current State Map        What is live right now              Product docs
Feature Index            One entry per live feature          Product docs
Direction Doc            Future thinking, unconfirmed        Product docs

TECHNICAL LAYER
────────────────────────────────────────────────────────────
TDD                      How it will be built                Technical docs
ADR                      Why this technical decision          Technical docs
API Contract             What APIs accept and return          Technical docs
ERD                      How data is structured               Technical docs
Spike Doc                Answer to technical unknown          Technical docs
Implementation Brainstorm Options and approach decision       Technical docs
Atomic Change Plan       PRs mapped to implementation pieces  Technical docs
Test Scenario Doc        What correct behavior looks like     Technical docs

SHIPPING LAYER
────────────────────────────────────────────────────────────
Release Notes            User-facing changelog                Public / in-product
Retro Note               Post-ship reflection                 Milestone doc (appended)
```

---

## Tackling Documentation Debt

After years of accumulated work, you do not rewrite everything. You layer in coverage based on value:

```
Phase 1 — Headers everywhere           [1–2 days]
  Write Layer 1 and Layer 2 for every feature that exists.
  Just a header, status, owner, and one-liner. No detail.

Phase 2 — Flow diagrams for the 20%   [1–2 weeks]
  The 20% of features responsible for 80% of questions,
  bugs, and onboarding confusion get a user flow diagram.

Phase 3 — Deep docs on demand         [ongoing]
  Write Layer 4 only when:
  → Something is actively being changed
  → A new engineer keeps getting confused by it
  → A bug revealed nobody understood the edge cases

Never
  Do not document stable things nobody touches.
  Dead docs mislead more than no docs.
```

---

## Format That Works

Structure matters as much as content. A document nobody reads has zero value.

**Lead with status and ownership.** Every doc header: is this live? who owns it? when was it last touched?

**Collapse detail by default.** The skeleton is readable without expanding anything. Depth is available, not mandatory.

**Diagrams before prose.** A flow diagram communicates structure in 10 seconds. Prose explains nuance. Never lead with prose.

**Use tables for comparisons.** Comparing options, states, or features — always a table, never a paragraph.

**Short sentences. Active voice.** Documentation is not a paper. Every sentence does one job.

---

---

---

# PART 3 — Repository & Agent File Structure

*This section covers how the documentation system is organized across two repositories managed by LLM agents. The document planning structure from Parts 1 and 2 remains unchanged — this section defines where those documents live, how they are named, and how they move between systems.*

---

## Repo Architecture

The system runs across two repositories. Each repo has a single responsibility.

```
┌─────────────────────────────────────────────────────┐
│              PRODUCT REPO                           │
│                                                     │
│  Owned by: Product Agent + single user              │
│  Purpose:  Capture → Validate → Confirm             │
│                                                     │
│  Generates: Milestone Confirmation File (DTO OUT)   │
│  Receives:  Implementation Report      (DTO IN)     │
└────────────────────┬────────────────────────────────┘
                     │
          dto/outgoing/[milestone]-confirmed.md
                     │ (handoff to dev repo)
                     ▼
┌─────────────────────────────────────────────────────┐
│              DEVELOPER REPO                         │
│                                                     │
│  Owned by: Senior Developer Agent                   │
│  Purpose:  Plan → Implement → Report                │
│                                                     │
│  Receives:  Milestone Confirmation File (DTO IN)    │
│  Generates: Implementation Report      (DTO OUT)    │
└─────────────────────────────────────────────────────┘
                     │
          dto/outgoing/[milestone]-report.md
                     │ (report back to product repo)
                     ▼
              Product repo updated
```

**Why two repos, not one?**

Product-level thinking and engineering-level thinking operate on different cadences, with different audiences, and different failure modes. Keeping them in separate repos enforces the boundary deliberately. The product repo never contains implementation code. The developer repo never contains unvalidated ideas. The only thing that crosses the boundary is a well-defined DTO file.

---

## DTO — File Handoffs

A DTO (Data Transfer Object) in this system is a markdown file with a fixed schema that moves between the two repos. There are exactly two DTOs:

---

### DTO 1 — Milestone Confirmation File
**Direction:** Product repo → Developer repo
**Trigger:** User stress test passed + PM + engineering lead sign-off complete
**File name:** `[milestone-slug]-confirmed.md`

This is the Milestone Confirmation File described in Q5. It is placed in:
- `product-repo/dto/outgoing/[milestone-slug]-confirmed.md` (product side, read-only after confirmation)
- `dev-repo/dto/incoming/[milestone-slug]-confirmed.md` (dev side, the starting point for all technical work)

The file schema does not change. The developer agent reads this file to begin all planning. Nothing in the developer repo is started until this file exists in `dto/incoming/`.

---

### DTO 2 — Implementation Report
**Direction:** Developer repo → Product repo
**Trigger:** Implementation complete, all Definition of Done items checked
**File name:** `[milestone-slug]-report.md`

This report tells the product repo exactly what shipped, what changed, and what documentation needs updating. It is placed in:
- `dev-repo/dto/outgoing/[milestone-slug]-report.md` (dev side)
- `product-repo/dto/incoming/[milestone-slug]-report.md` (product side, triggers doc update agent)

**Implementation Report schema:**

```
IMPLEMENTATION REPORT
══════════════════════════════════════════════════════
Milestone       → [name]
Milestone slug  → [slug]
Report version  → 1.0
Status          → Complete / Partial / Blocked
Generated by    → Developer Agent
Date            → [date]
Linked DTO in   → dto/incoming/[milestone-slug]-confirmed.md
══════════════════════════════════════════════════════

WHAT SHIPPED
  [List of requirements delivered — matched to acceptance criteria]
  ✅ [Requirement 1] — delivered as specified
  ✅ [Requirement 2] — delivered as specified
  ⚠️  [Requirement 3] — delivered with deviation: [explain]
  ❌ [Requirement 4] — not delivered: [reason, what happens next]

DEVIATIONS FROM CONFIRMED SCOPE
  [Anything that differs from the Milestone Confirmation File]
  → [What changed] — Reason: [why] — Impact: [what it affects]

NEW DECISIONS MADE DURING IMPLEMENTATION
  [ADRs filed during implementation that product should know about]
  → ADR-[n]: [title] — Summary: [one line]

PRODUCT DOCUMENTATION UPDATES REQUIRED
  → current-state-map.md        [which features, what status change]
  → feature-index/[name].md     [create / update]
  → evolution-timeline.md       [entry to add — content provided below]
  → direction.md                [ideas surfaced during implementation]

EVOLUTION TIMELINE ENTRY (ready to paste)
  [Date] [Milestone name]
         Shipped: [what users can now do]
         Key decisions: [1-2 notable choices]
         Outcome: [fill in after metric data available]

FEATURE INDEX ENTRIES (ready to paste)
  ## [Feature Name]
  Status       → Live
  Owner        → @[name]
  Last updated → [date]
  What it does → [one sentence]
  Who uses it  → [segment]
  Links        → TDD: [path] | ADR: [path]

RETRO NOTE
  Shipped on time:  Yes / No — [if no: reason]
  Scope delivered:  Full / Partial — [if partial: what was deferred]
  What worked well: [1-2 things]
  What to improve:  [1-2 things]
  Surprises:        [anything unexpected]
══════════════════════════════════════════════════════
```

---

## Product Repo File Structure

```
product-repo/
│
│  README.md                        # What this repo is, how to navigate it
│  AGENT-INSTRUCTIONS.md            # How the product agent operates this repo
│
├── dto/                            # Data Transfer — files crossing repo boundaries
│   ├── incoming/                   # Implementation reports received from dev repo
│   │   └── [milestone-slug]-report.md
│   └── outgoing/                   # Confirmed milestones sent to dev repo
│       └── [milestone-slug]-confirmed.md
│
├── product/                        # Core product documents (long-lived, rarely replaced)
│   ├── product-brief.md            # What the product is, who it's for, north star
│   ├── evolution-timeline.md       # History of every significant product decision
│   ├── current-state-map.md        # Live feature inventory with status
│   └── direction.md                # Unconfirmed future ideas and hypotheses
│
├── feature-index/                  # One file per live feature
│   ├── _index.md                   # Master list with links and one-liners
│   └── [feature-slug].md           # Individual feature detail doc
│
├── ideas/                          # Unvalidated ideas — never touch milestones
│   ├── _index.md                   # Idea capture log — all ideas, all statuses
│   └── [idea-slug].md              # Individual idea capture entry
│
├── milestones/                     # All milestone work lives here
│   ├── _index.md                   # Master milestone list with status and dates
│   │
│   ├── active/                     # Milestones currently being shaped
│   │   └── [milestone-slug]/
│   │       ├── milestone.md        # Milestone doc (Epic → Stories → AC)
│   │       ├── requirements/
│   │       │   └── [req-slug].md   # Individual requirement entry
│   │       └── stress-test/
│   │           └── session-[date].md   # User stress test session log
│   │
│   ├── confirmed/                  # Signed-off, passed to dev repo — READ ONLY
│   │   └── [milestone-slug]/
│   │       ├── milestone-confirmed.md  # The DTO out file (copy of dto/outgoing/)
│   │       └── sign-off-log.md         # Who confirmed, when, any conditions
│   │
│   └── completed/                  # Shipped milestones — historical record
│       └── [milestone-slug]/
│           ├── milestone-confirmed.md  # Original confirmed file, untouched
│           ├── sign-off-log.md
│           └── retro-note.md           # Post-ship reflection (from dev report)
│
└── reports/                        # Archive of all received implementation reports
    └── [milestone-slug]-report.md
```

---

### Product Repo — File Descriptions

| File / Folder | What it is | When it changes |
|---|---|---|
| `README.md` | Orientation doc for anyone entering the repo | Rarely |
| `AGENT-INSTRUCTIONS.md` | How the product agent should behave and use this repo | When agent behavior changes |
| `dto/incoming/` | Reports arriving from the dev repo after implementation | Each completed milestone |
| `dto/outgoing/` | Confirmed milestone files ready for the dev repo | Each confirmed milestone |
| `product/product-brief.md` | North star — what the product is and isn't | Rarely; only on major pivots |
| `product/evolution-timeline.md` | Append-only decision log | After every significant release |
| `product/current-state-map.md` | Live feature inventory | Any time feature status changes |
| `product/direction.md` | Future ideas and hypotheses | Ongoing; ideas added and pruned |
| `feature-index/_index.md` | Master feature list | When features ship or are deprecated |
| `feature-index/[feature].md` | Individual feature detail | When feature behavior changes |
| `ideas/_index.md` | All ideas and their current status | Ongoing |
| `ideas/[idea].md` | Single idea capture entry | When idea is updated or closed |
| `milestones/_index.md` | All milestones, status, dates | When milestones are created or close |
| `milestones/active/[slug]/milestone.md` | Working milestone doc | During planning phase |
| `milestones/active/[slug]/requirements/` | Individual requirement entries | During planning phase |
| `milestones/active/[slug]/stress-test/` | User stress test sessions | During validation phase |
| `milestones/confirmed/[slug]/` | Locked after sign-off — never edited | Never (read-only) |
| `milestones/completed/[slug]/` | Archived after dev repo reports back | After implementation ships |
| `reports/[slug]-report.md` | Archived incoming dev reports | After each milestone ships |

---

### Key Rules — Product Repo

```
RULE 1 — Ideas never enter milestones/active/ until validated
RULE 2 — milestones/confirmed/ is read-only once a file lands there
RULE 3 — dto/outgoing/ files are never edited after being sent
RULE 4 — current-state-map.md and feature-index/ are updated
          only from incoming DTO reports — never manually mid-milestone
RULE 5 — stress-test/session-[date].md is created fresh for each
          validation session; old sessions are not overwritten
```

---

## Developer Repo File Structure

```
dev-repo/
│
│  README.md                        # What this repo is, how to navigate it
│  AGENT-INSTRUCTIONS.md            # How the senior dev agent operates this repo
│
├── dto/                            # Data Transfer — files crossing repo boundaries
│   ├── incoming/                   # Confirmed milestone files from product repo
│   │   └── [milestone-slug]-confirmed.md
│   └── outgoing/                   # Implementation reports sent back to product repo
│       └── [milestone-slug]-report.md
│
├── planning/                       # All pre-implementation technical work
│   └── [milestone-slug]/
│       │
│       ├── tdd.md                  # Technical Design Document
│       ├── erd.md                  # Entity Relationship Diagram (if schema changes)
│       │
│       ├── adrs/                   # Architecture Decision Records
│       │   └── ADR-[n]-[title].md  # One file per decision
│       │
│       ├── api-contracts/          # API contracts for new or changed endpoints
│       │   └── [endpoint-slug].md
│       │
│       ├── spikes/                 # Time-boxed research docs
│       │   └── [spike-slug].md
│       │
│       ├── implementation-brainstorm.md   # Options analysis and approach decision
│       ├── atomic-change-plan.md          # PRs mapped to implementation pieces
│       └── test-scenarios.md              # All test scenarios across all requirements
│
├── implementation/                 # Progress tracking during implementation
│   └── [milestone-slug]/
│       ├── progress.md             # Running log of what is done and what is next
│       └── decisions-log.md        # Decisions made during impl (feeds ADRs and report)
│
├── reports/                        # Generated implementation reports — outgoing DTOs
│   └── [milestone-slug]-report.md  # Copy of dto/outgoing/ for archive
│
└── archive/                        # Completed milestones — historical record
    └── [milestone-slug]/
        ├── [all planning files]    # Preserved exactly as they were
        └── report.md               # The report that closed this milestone
```

---

### Developer Repo — File Descriptions

| File / Folder | What it is | When it changes |
|---|---|---|
| `README.md` | Orientation for the dev repo | Rarely |
| `AGENT-INSTRUCTIONS.md` | How the dev agent reads, plans, and reports | When agent behavior changes |
| `dto/incoming/[slug]-confirmed.md` | The starting point — product's handoff | Once, on receipt. Never edited. |
| `dto/outgoing/[slug]-report.md` | The closing point — report back to product | Once, on completion |
| `planning/[slug]/tdd.md` | How the system will be built | During planning; updated if design changes during impl |
| `planning/[slug]/erd.md` | Data model diagram | When schema changes |
| `planning/[slug]/adrs/ADR-[n].md` | One decision, permanently recorded | At the moment of decision |
| `planning/[slug]/api-contracts/` | API shape for each endpoint | During TDD; updated if API changes |
| `planning/[slug]/spikes/` | Investigation docs | When a technical unknown is explored |
| `planning/[slug]/implementation-brainstorm.md` | Options considered, approach chosen | During planning phase only |
| `planning/[slug]/atomic-change-plan.md` | Ordered PR/commit breakdown | During planning; updated as impl proceeds |
| `planning/[slug]/test-scenarios.md` | All test scenarios from all requirements | Before implementation starts |
| `implementation/[slug]/progress.md` | Running log — what's done, what's next, what's blocked | Daily during implementation |
| `implementation/[slug]/decisions-log.md` | Decisions made during impl — not yet formalized into ADRs | During implementation |
| `reports/[slug]-report.md` | Final report archive | Once, on milestone completion |
| `archive/[slug]/` | All files from a completed milestone | Never — read-only |

---

### Key Rules — Developer Repo

```
RULE 1 — No planning file is created until dto/incoming/ contains
          the confirmed milestone file for that slug
RULE 2 — dto/incoming/ files are never edited — they are the source of truth
RULE 3 — ADRs are filed at the moment a decision is made, not at the end
RULE 4 — implementation/[slug]/decisions-log.md is promoted to ADRs
          before the report is generated
RULE 5 — archive/ is append-only — completed milestones are never modified
RULE 6 — The report is not generated until all Definition of Done
          items in the atomic-change-plan are checked off
```

---

## Agent Flow

How the two agents operate across the full lifecycle of one milestone:

```
PRODUCT AGENT — operates on product-repo
══════════════════════════════════════════════════════════════

[1] IDEA PHASE
    User submits an idea →
    Agent creates: ideas/[idea-slug].md
    Agent updates: ideas/_index.md

[2] VALIDATION PHASE
    Agent and user explore the idea →
    If validated: idea status → ✅ Validated
    Agent creates: milestones/active/[slug]/milestone.md
    Agent creates: milestones/active/[slug]/requirements/[req].md
    Agent updates: milestones/_index.md

[3] STRESS TEST PHASE
    Agent runs structured Q&A with user to pressure-test requirements →
    Agent creates: milestones/active/[slug]/stress-test/session-[date].md
    Agent refines requirements based on session output
    Repeat until: all open questions resolved, AC complete, scope locked

[4] SIGN-OFF PHASE
    Agent presents final milestone doc for PM + engineering lead approval →
    Agent creates: milestones/confirmed/[slug]/milestone-confirmed.md
    Agent creates: milestones/confirmed/[slug]/sign-off-log.md
    Agent copies confirmed file → dto/outgoing/[slug]-confirmed.md
    STATUS: Handoff ready

[5] WAITING PHASE
    Product agent is idle for this milestone →
    Monitors dto/incoming/ for the implementation report

[6] UPDATE PHASE (triggered by incoming report)
    Agent reads: dto/incoming/[slug]-report.md
    Agent updates: product/current-state-map.md
    Agent updates: product/evolution-timeline.md
    Agent creates/updates: feature-index/[feature].md
    Agent updates: feature-index/_index.md
    Agent moves milestone → milestones/completed/[slug]/
    Agent appends retro note → milestones/completed/[slug]/retro-note.md
    Agent archives: reports/[slug]-report.md

══════════════════════════════════════════════════════════════
DEVELOPER AGENT — operates on dev-repo
══════════════════════════════════════════════════════════════

[1] RECEIPT PHASE
    Agent detects: dto/incoming/[slug]-confirmed.md →
    Agent reads confirmed file fully
    Agent creates: planning/[slug]/ directory

[2] TECHNICAL DESIGN PHASE
    Agent creates: planning/[slug]/tdd.md
    Agent creates: planning/[slug]/erd.md (if schema changes)
    Agent creates: planning/[slug]/api-contracts/[endpoint].md
    Agent creates: planning/[slug]/spikes/[spike].md (if unknowns exist)
    Agent creates: planning/[slug]/adrs/ADR-[n]-[title].md
                   (for every non-obvious decision during design)

[3] VALIDATION PHASE (Gate 2)
    Agent self-checks TDD against confirmed milestone file →
    Checklist from Q7 Gate 2 verified
    Agent flags any gaps found for human review before proceeding

[4] IMPLEMENTATION PLANNING PHASE
    Agent creates: planning/[slug]/implementation-brainstorm.md
    Agent creates: planning/[slug]/test-scenarios.md
    Agent creates: planning/[slug]/atomic-change-plan.md
    Agent creates: implementation/[slug]/progress.md

[5] IMPLEMENTATION PHASE
    Agent updates: implementation/[slug]/progress.md (per atomic change)
    Agent updates: implementation/[slug]/decisions-log.md
    Agent creates new ADRs as decisions emerge
    Agent checks off items in atomic-change-plan.md

[6] REPORT PHASE
    Agent promotes decisions-log → remaining ADRs
    Agent generates: reports/[slug]-report.md
    Agent copies report → dto/outgoing/[slug]-report.md
    Agent moves all planning + implementation files → archive/[slug]/
    STATUS: Report sent, milestone closed

══════════════════════════════════════════════════════════════
```

---

## Stress Test — What It Is and How It Works

The stress test is the validation gate between a draft milestone and a confirmed one. It is run by the product agent with the single user before any technical work begins.

**Why it exists:** A confirmed milestone is a commitment — engineering time, architecture decisions, and implementation effort will follow. An unclear requirement discovered after sign-off is expensive. A stress test surfaces these before they cost anything.

**How the product agent runs it:**

```
STRESS TEST SESSION STRUCTURE
──────────────────────────────────────────────────────────
For each requirement in the milestone, the agent asks:

  CLARITY CHECK
  → "Who specifically does this? Can you describe a real scenario?"
  → "What does 'success' look like for the user here — be specific."

  EDGE CASE PRESSURE
  → "What happens if [failure scenario]?"
  → "What does the user see/do if [unusual input or condition]?"

  SCOPE BOUNDARY TEST
  → "Does this requirement touch [adjacent feature]?"
  → "Does this change anything for existing users who already use [X]?"

  CONFLICT DETECTION
  → "Does this contradict anything in the current state map?"
  → "Could this break [existing behavior]?"

  DEPENDENCY REVEAL
  → "What must be true before this requirement can work?"
  → "Is [dependency] confirmed as available?"
──────────────────────────────────────────────────────────
```

**Session log format** (`stress-test/session-[date].md`):

```
STRESS TEST SESSION
──────────────────────────────────────────────────────────
Date:     [date]
Session:  [n of n planned]
Agent:    Product Agent
User:     [name]

REQUIREMENTS REVIEWED THIS SESSION
  → [Req 1], [Req 2]

FINDINGS
  Req 1:
    Issue found: [describe]
    Resolution: [what was decided]
    AC updated: Yes / No

  Req 2:
    No issues. Confirmed as specified.

OPEN ITEMS AFTER THIS SESSION
  → [Item] — Owner: [user/agent] — Must resolve before sign-off

NEXT SESSION NEEDED: Yes / No
──────────────────────────────────────────────────────────
```

Sign-off cannot proceed until all open items across all sessions are resolved.

---

## File Naming Conventions

Consistent naming is what makes automated agent navigation reliable.

```
SLUGS
  All file and folder names use kebab-case
  Milestone slug = short descriptive name: multi-photo-upload
  Idea slug      = same pattern:            bulk-export-feature
  Feature slug   = same pattern:            auth-system

DATES
  Always ISO 8601: YYYY-MM-DD
  Session files:   stress-test/session-2026-05-21.md
  Report files:    [milestone-slug]-report.md (no date — one per milestone)

ADR NUMBERING
  Padded integers, sequential per repo:  ADR-001-jwt-over-sessions.md
  Never reuse a number, even if an ADR is superseded

VERSIONING
  Confirmed milestone file: milestone-confirmed.md (no version in name)
  Version is tracked inside the file header (v1.0, v1.1, v2.0)
  Each version increment creates a new entry in sign-off-log.md

STATUS IN FILENAMES
  Never encode status in a filename — status lives inside the file
  Move files between folders (active/ → confirmed/ → completed/)
  to communicate lifecycle state
```

---

## Complete Cross-Repo Document Map

Every document in the system, which repo it lives in, and its role:

| Document | Repo | Layer | DTO? |
|---|---|---|---|
| `product-brief.md` | Product | Business | No |
| `evolution-timeline.md` | Product | Business | No |
| `current-state-map.md` | Product | Business | No |
| `direction.md` | Product | Business | No |
| `feature-index/[slug].md` | Product | Business | No |
| `ideas/[slug].md` | Product | Business | No |
| `milestones/active/[slug]/milestone.md` | Product | Business | No |
| `milestones/active/[slug]/requirements/` | Product | Business | No |
| `milestones/active/[slug]/stress-test/` | Product | Business | No |
| `milestones/confirmed/[slug]/milestone-confirmed.md` | Product | **DTO OUT** | ✅ |
| `dto/outgoing/[slug]-confirmed.md` | Product | **DTO OUT** | ✅ |
| `dto/incoming/[slug]-confirmed.md` | Developer | **DTO IN** | ✅ |
| `planning/[slug]/tdd.md` | Developer | Technical | No |
| `planning/[slug]/adrs/` | Developer | Technical | No |
| `planning/[slug]/api-contracts/` | Developer | Technical | No |
| `planning/[slug]/erd.md` | Developer | Technical | No |
| `planning/[slug]/spikes/` | Developer | Technical | No |
| `planning/[slug]/implementation-brainstorm.md` | Developer | Technical | No |
| `planning/[slug]/atomic-change-plan.md` | Developer | Technical | No |
| `planning/[slug]/test-scenarios.md` | Developer | Technical | No |
| `implementation/[slug]/progress.md` | Developer | Technical | No |
| `implementation/[slug]/decisions-log.md` | Developer | Technical | No |
| `reports/[slug]-report.md` | Developer | **DTO OUT** | ✅ |
| `dto/outgoing/[slug]-report.md` | Developer | **DTO OUT** | ✅ |
| `dto/incoming/[slug]-report.md` | Product | **DTO IN** | ✅ |

---

---

# PART 4 — Non-Functional Requirements, Tech Debt & File Indexing

*This section adds three missing subsystems to the repository structure from Part 3. Nothing in Parts 1–3 changes. NFRs, tech debt, and file indexing extend the existing structure.*

---

## NFR — Non-Functional Requirements

### What Makes NFRs Different

| Aspect | Functional Requirement | Non-Functional Requirement |
|---|---|---|
| Source | User feedback, PM, product thinking | Senior developer, technical observation |
| Language | "User can do X" | "System must perform Y under Z conditions" |
| Validation | User stress test | Engineering review |
| Acceptance criteria | User journey outcome | Measurable technical threshold |
| Milestone origin | Always tied to a user story | Standalone or attached to existing milestone |

### Three NFR Patterns

```
Pattern A — Cross-cutting
  Affects the whole system, not one feature
  Example: "All API endpoints must respond under 200ms at p95"
  → Standalone NFR milestone

Pattern B — Feature-attached
  Naturally belongs alongside a planned milestone
  Example: "The upload feature must handle 1000 concurrent uploads"
  → Attaches to upload milestone as an NFR entry

Pattern C — Debt-driven
  Fixing something that exists and is degrading
  Example: "Auth service has no rate limiting — needs it before Q3"
  → Standalone NFR milestone, urgent priority
```

### NFR Flow

```
DEVELOPER REPO
Senior dev observes a technical need →
Creates: nfr-proposals/[slug].md
         ↓ (DTO 3 — NFR Proposal crosses to product repo)

PRODUCT REPO
Product agent + PM review →
Decision: Standalone milestone OR attach to existing milestone

  If standalone →
    milestones/active/nfr-[slug]/
    Engineering review replaces user stress test
    PM acknowledges but engineering lead signs off

  If attached →
    milestones/active/[existing-slug]/requirements/nfr-[slug].md
    Parent milestone flagged as containing NFR requirements

→ Confirmed → passes to dev repo via standard DTO 1 flow
```

### NFR Proposal File (Dev Repo → Product Repo)

```
---
slug:       [nfr-slug]
type:       nfr
status:     📝 proposed
owner:      @senior-dev
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   —
downstream: milestones/active/[slug]/requirements/nfr-[slug].md
---

NFR PROPOSAL
──────────────────────────────────────────────────────
Raised by:   @senior-dev
Date:        [date]
Category:    Performance | Security | Scalability |
             Reliability | Maintainability | Observability | Compliance

What (one line)
  [The system property that must exist or improve]

Why now
  [What triggered this — observed degradation, upcoming scale,
  compliance deadline, security audit, new architecture decision]

Current state
  [How it works now — the measurable gap]

Target threshold
  [Specific and measurable — "p95 < 200ms", "99.9% uptime", "zero PII in logs"]

Impact if not addressed
  [What degrades or breaks — risk and timeline]

Affected systems
  [What parts of the codebase or services this touches]

Milestone preference
  → Standalone NFR milestone
  → Attach to [milestone-slug]
  → Attach to next milestone that touches [system/area]

Rough effort
  Small (days) / Medium (1-2 weeks) / Large (sprint+)
──────────────────────────────────────────────────────
```

### NFR Entry in Milestone

```
---
slug:       nfr-[slug]
type:       nfr
status:     📝 proposed
owner:      @senior-dev
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   nfr-proposals/[slug].md
downstream: milestones/confirmed/[slug]/milestone-confirmed.md
---

NFR: [Name]
──────────────────────────────────────────────────────
Category:     Performance | Security | Scalability | etc.
Raised by:    @senior-dev  |  Date: [date]
Priority:     Must Have | Should Have | Nice to Have

What
  [System property in plain language]

Acceptance Criteria
  Threshold:   [specific measurable number or condition]
  Measured by: [how — load test, audit tool, monitoring alert]
  Baseline:    [current state — starting number]

Scope
  Systems affected:     [list]
  Milestone attachment: Standalone | Attached to [slug]

Engineering Review Notes
  [Findings from the engineering review session]

Sign-off
  Engineering lead:  @name | Date: [date]
  PM acknowledged:   @name | Date: [date]
──────────────────────────────────────────────────────
```

### NFR Repo Additions

```
product-repo/
├── nfr-proposals/               ← NEW — incoming NFR proposals from dev repo
│   ├── _index.md
│   └── [nfr-slug].md
└── milestones/
    └── active/
        └── [milestone-slug]/
            └── requirements/
                └── nfr-[slug].md   ← attached NFR entry

dev-repo/
└── nfr-proposals/               ← NEW — where senior dev raises NFRs
    ├── _index.md
    └── [nfr-slug].md
```

---

## Tech Debt

### How Tech Debt Differs From NFRs

| | NFR | Tech Debt |
|---|---|---|
| What it is | A system property that doesn't exist yet | Something that exists but is known to be suboptimal |
| Origin | "We need the system to do X" | "This works but is wrong, risky, or fragile" |
| Example | "API must respond under 200ms" | "Auth has no retry logic — works now, fails under load" |
| Nature | Proactive | Reactive awareness |

### Two Types

**Accepted debt** — a conscious, documented decision to live with something suboptimal. Not laziness. A deliberate trade-off with a known cost and documented exit conditions. Accepted debt is itself an architectural decision and always links to an ADR.

**Postponed debt** — will be fixed, but not now. Has a trigger condition or milestone target. When the trigger is hit, it converts to an NFR proposal and follows that flow.

### Key Rule — Accepted Debt Is an ADR

```
Accepted debt without documentation  =  forgotten debt
Accepted debt with an ADR            =  conscious debt with exit conditions
```

Every accepted debt entry requires a linked ADR. The ADR records the reasoning, trade-off, and conditions that would change the decision.

### Accepted Debt File

```
---
slug:       [debt-slug]
type:       tech-debt
status:     ✅ accepted
owner:      @eng-lead
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   implementation/[slug]/decisions-log.md
downstream: adrs/ADR-[n]-[title].md
---

ACCEPTED TECH DEBT: [Name]
──────────────────────────────────────────────────────
Raised by:   @senior-dev  |  Date: [date]
Accepted by: @eng-lead    |  Date: [date]
Linked ADR:  ADR-[n]-[title].md  ← required

What
  [What the suboptimal thing is, in plain terms]

Why it exists
  [How the debt was created — shortcut, outdated dependency,
  outgrown design, inherited decision]

Known cost / risk
  [What degrades, what is harder, what could break and under what conditions]

Why accepted (not fixed now)
  [The trade-off reasoning — cost of fixing vs cost of keeping]

Exit conditions
  [What would trigger revisiting this]
  Example: "Revisit when daily uploads exceed 500"
  Example: "Must fix before adding a second payment provider"
  Example: "Accept permanently — cost of fix exceeds risk"
──────────────────────────────────────────────────────
```

### Postponed Debt File

```
---
slug:       [debt-slug]
type:       tech-debt
status:     ⏸ postponed
owner:      @eng-lead
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   implementation/[slug]/decisions-log.md
downstream: nfr-proposals/[slug].md  ← when trigger is hit
---

POSTPONED TECH DEBT: [Name]
──────────────────────────────────────────────────────
Raised by:   @senior-dev  |  Date: [date]
Reviewed by: @eng-lead    |  Date: [date]

What
  [What needs to be fixed]

Why it exists
  [How the debt was created]

Current impact
  [What is degrading or at risk right now — specific]

Why postponed (not fixed now)
  [Why now is not the right time]

Resolution plan
  Trigger condition: [what must happen before this is addressed]
  OR
  Target milestone:  [milestone-slug where this will be picked up]
  Effort estimate:   [rough size when it is addressed]

Escalation condition
  [What would force this above the trigger threshold —
  if impact worsens beyond this point it cannot stay postponed]
──────────────────────────────────────────────────────
```

### Tech Debt Flow

```
Engineer spots debt during implementation
  ↓
Creates entry in dev-repo/tech-debt/
  ↓
  ┌─────────────────────────────────────────┐
  │  Accepted                               │
  │  → ADR filed immediately                │
  │  → Product repo notified (awareness)    │
  │  → Stays in tech-debt/accepted/         │
  └─────────────────────────────────────────┘
  ┌─────────────────────────────────────────┐
  │  Postponed                              │
  │  → Linked to future milestone/trigger   │
  │  → Product repo notified (lightweight)  │
  │  → Monthly debt review monitors it      │
  │       ↓ when trigger is hit             │
  │  → Converts to NFR proposal             │
  │  → Follows NFR flow from that point     │
  └─────────────────────────────────────────┘
```

### Tech Debt Repo Additions

```
dev-repo/
└── tech-debt/                   ← NEW
    ├── _index.md                ← Master debt register
    ├── accepted/
    │   └── [debt-slug].md
    └── postponed/
        └── [debt-slug].md
```

### Tech Debt Register — `_index.md`

```
# Tech Debt Register
Last reviewed: YYYY-MM-DD  |  Review cadence: Monthly

## Postponed — Active Obligations
| Name | Category | Raised | Target / Trigger | Risk | File |
|---|---|---|---|---|---|
| session-mgmt | Architecture | 2024-01 | Auth milestone Q3 | Medium | [link] |
| retry-logic | Reliability | 2025-03 | Scale > 1k req/hr | High ⚠️ | [link] |

## Accepted — Conscious Decisions
| Name | Category | Accepted | Exit Condition | ADR | File |
|---|---|---|---|---|---|
| upload-mono | Architecture | 2023-06 | >500 uploads/day | ADR-012 | [link] |
| legacy-parser | Data | 2022-11 | Permanent | ADR-008 | [link] |
```

---

---

## Part 4 — File Indexing System

*Indexing is not a new layer of documentation. It is applied to the file system itself — the same progressive disclosure model used in documents, now applied to how files are found and navigated.*

---

### The Core Model

```
Layer 1 → Repo _index.md        "What exists in this entire repo?"
Layer 2 → Folder _index.md      "What exists in this folder?"
Layer 3 → File header block      "What is this file at a glance?"
Layer 4 → File content           "The actual detail"
```

An agent or human navigates top-down. Layer 1–3 are always readable without opening anything. Layer 4 is opened only when needed.

---

### File Header Standard

Every file in both repos opens with the same header block regardless of type. It is the first thing in every file, before any content.

```
---
slug:       [unique-kebab-case-id]
type:       idea | requirement | nfr | tech-debt | milestone |
            feature | adr | tdd | api-contract | spike |
            stress-test | report | implementation-brainstorm |
            atomic-change-plan | test-scenarios | progress
status:     [see status values table]
owner:      @name
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   [path to file that created this | — if origin]
downstream: [path(s) to files this feeds into | — if terminal]
---
```

**upstream** — where this file came from. One value. An idea has no upstream (`—`). A TDD's upstream is the milestone confirmation file.

**downstream** — what this file produces or feeds into. Can be multiple paths separated by newlines. A milestone confirmation feeds into both the product repo confirmed folder and the dev repo incoming DTO.

---

### Status Values Per Type

Only valid statuses for each type. No other values are permitted.

| Type | Valid Statuses |
|---|---|
| `idea` | `💡 raw` · `🔍 exploring` · `✅ validated` · `⏸ parked` · `❌ rejected` |
| `milestone` | `📋 planning` · `✅ confirmed` · `🚀 in-progress` · `✓ complete` · `⏸ paused` |
| `requirement` | `📝 draft` · `✅ confirmed` · `❌ descoped` |
| `nfr` | `📝 proposed` · `🔍 reviewing` · `✅ confirmed` · `❌ rejected` |
| `tech-debt` | `⏸ postponed` · `✅ accepted` · `🔨 resolving` · `✓ resolved` |
| `feature` | `🔬 experimental` · `🔶 beta` · `✅ live` · `❌ deprecated` |
| `adr` | `📝 proposed` · `✅ accepted` · `→ superseded by ADR-[n]` |
| `tdd` | `📝 draft` · `🔍 in-review` · `✅ approved` · `✓ implemented` |
| `spike` | `🔍 in-progress` · `✓ complete` |
| `report` | `📝 draft` · `✅ sent` |
| `stress-test` | `🔍 in-progress` · `⚠️ open-items` · `✓ complete` |
| `progress` | `🔨 in-progress` · `⏸ blocked` · `✓ complete` |

---

### Folder `_index.md` Standard

Every folder has an `_index.md`. Format varies by folder but the skeleton is always the same: a one-line description, a last-updated date, then status-grouped tables. Active work appears first, archived or completed last.

```
---
slug:       [folder-name]-index
type:       index
updated:    YYYY-MM-DD
---

# [Folder Name]
> [One line — what this folder holds]

Last updated: YYYY-MM-DD

## [Status Group — active first]
| Name | Status | One-liner | Updated | File |
|---|---|---|---|---|
| [name] | [status] | [one-liner] | YYYY-MM-DD | [link] |

## [Next Status Group]
...
```

---

### Repo-Level `_index.md`

The root `_index.md` in each repo is the full map — one section per document type. This is what an agent reads first when entering a repo.

**Product Repo — `_index.md`**

```
---
slug:       product-repo-index
type:       index
updated:    YYYY-MM-DD
---

# Product Repo — Master Index
> Navigation for all product documentation

Last updated: YYYY-MM-DD
Active milestones: [n]  |  Open ideas: [n]  |  Pending NFRs: [n]

## Milestones
| Name | Status | Target | Requirements | File |
|---|---|---|---|---|

## Ideas
| Name | Status | Category | Raised | File |
|---|---|---|---|---|

## Features (Current State)
| Name | Status | Owner | Updated | File |
|---|---|---|---|---|

## NFR Proposals (Inbox)
| Name | Status | Category | Preference | File |
|---|---|---|---|---|

## Tech Debt (Awareness)
| Name | Type | Risk | Trigger | File |
|---|---|---|---|---|

## DTOs
| File | Direction | Status | Date |
|---|---|---|---|
| [slug]-confirmed.md | OUT → Dev | ✅ sent | YYYY-MM-DD |
| [slug]-report.md | IN ← Dev | ✅ received | YYYY-MM-DD |
```

**Developer Repo — `_index.md`**

```
---
slug:       dev-repo-index
type:       index
updated:    YYYY-MM-DD
---

# Developer Repo — Master Index
> Navigation for all technical planning and implementation

Last updated: YYYY-MM-DD
Active milestones: [n]  |  Open ADRs: [n]  |  Postponed debt: [n]

## Active Planning
| Milestone | Status | TDD | ADRs | Test Scenarios | File |
|---|---|---|---|---|---|

## Implementation
| Milestone | Status | Progress | Blocked? | File |
|---|---|---|---|---|

## ADR Log (All)
| Number | Title | Status | Date | File |
|---|---|---|---|---|

## Tech Debt
| Name | Type | Risk | Trigger / ADR | File |
|---|---|---|---|---|

## NFR Proposals (Outbox)
| Name | Status | Sent? | Product Response | File |
|---|---|---|---|---|

## Archive
| Milestone | Shipped | Report | File |
|---|---|---|---|

## DTOs
| File | Direction | Status | Date |
|---|---|---|---|
| [slug]-confirmed.md | IN ← Product | ✅ received | YYYY-MM-DD |
| [slug]-report.md | OUT → Product | ✅ sent | YYYY-MM-DD |
```

---

### The Link Chain

Every file knows where it came from (`upstream`) and what it produces (`downstream`). An agent can trace any chain forwards or backwards without reading file content.

```
ideas/bulk-export.md
  upstream:   —
  downstream: milestones/active/bulk-export/milestone.md

milestones/active/bulk-export/milestone.md
  upstream:   ideas/bulk-export.md
  downstream: requirements/csv-export.md
              requirements/pdf-export.md
              milestones/confirmed/bulk-export/milestone-confirmed.md

requirements/csv-export.md
  upstream:   milestones/active/bulk-export/milestone.md
  downstream: milestones/confirmed/bulk-export/milestone-confirmed.md

milestones/confirmed/bulk-export/milestone-confirmed.md
  upstream:   milestones/active/bulk-export/milestone.md
              requirements/csv-export.md
              requirements/pdf-export.md
  downstream: dto/outgoing/bulk-export-confirmed.md

── crosses to dev repo ──

dto/incoming/bulk-export-confirmed.md
  upstream:   [product-repo] dto/outgoing/bulk-export-confirmed.md
  downstream: planning/bulk-export/tdd.md
              planning/bulk-export/test-scenarios.md

planning/bulk-export/tdd.md
  upstream:   dto/incoming/bulk-export-confirmed.md
  downstream: planning/bulk-export/atomic-change-plan.md
              planning/bulk-export/adrs/ADR-007-csv-streaming.md

planning/bulk-export/adrs/ADR-007-csv-streaming.md
  upstream:   planning/bulk-export/tdd.md
  downstream: reports/bulk-export-report.md

reports/bulk-export-report.md
  upstream:   planning/bulk-export/tdd.md
              planning/bulk-export/adrs/
              implementation/bulk-export/progress.md
  downstream: dto/outgoing/bulk-export-report.md
```

---

### Agent Navigation Modes

The indexing system gives agents three navigation modes without reading any file content:

```
MODE 1 — Top-down discovery
  Read repo _index.md
    → pick section (milestones, ideas, features)
    → read folder _index.md
    → open specific file
  Used for: "What is the current state of milestone X?"
            "What ideas are currently validated but unscheduled?"

MODE 2 — Chain traversal
  Read a file's upstream/downstream fields
    → trace origin backwards or impact forwards
  Used for: "Where did this requirement come from?"
            "What will be affected if this requirement changes?"
            "What did this idea become?"

MODE 3 — Status scan
  Scan _index.md files for a specific status across the repo
  Used for: "What ADRs were filed this month?"
            "Which features are in beta right now?"
            "Are there any postponed debt items past their trigger?"
```

---

### Updated File Structure With Indexing Applied

Every folder now has an explicit `_index.md`. Existing folders carried forward from Part 3 — additions marked NEW.

```
product-repo/
├── _index.md                        ← NEW — repo master index
│
├── dto/
│   ├── _index.md                    ← NEW
│   ├── incoming/
│   │   ├── _index.md                ← NEW
│   │   └── [slug]-report.md
│   └── outgoing/
│       ├── _index.md                ← NEW
│       └── [slug]-confirmed.md
│
├── product/
│   ├── _index.md                    ← NEW
│   ├── product-brief.md
│   ├── evolution-timeline.md
│   ├── current-state-map.md
│   └── direction.md
│
├── feature-index/
│   ├── _index.md                    ← EXISTS — format standardised
│   └── [feature-slug].md
│
├── ideas/
│   ├── _index.md                    ← EXISTS — format standardised
│   └── [idea-slug].md
│
├── nfr-proposals/                   ← NEW (from NFR section)
│   ├── _index.md                    ← NEW
│   └── [nfr-slug].md
│
├── milestones/
│   ├── _index.md                    ← EXISTS — format standardised
│   ├── active/
│   │   ├── _index.md                ← NEW
│   │   └── [milestone-slug]/
│   │       ├── _index.md            ← NEW — lists contents of this milestone
│   │       ├── milestone.md
│   │       ├── requirements/
│   │       │   ├── _index.md        ← NEW
│   │       │   ├── [req-slug].md
│   │       │   └── nfr-[slug].md
│   │       └── stress-test/
│   │           ├── _index.md        ← NEW
│   │           └── session-YYYY-MM-DD.md
│   ├── confirmed/
│   │   ├── _index.md                ← NEW
│   │   └── [milestone-slug]/
│   │       ├── _index.md            ← NEW
│   │       ├── milestone-confirmed.md
│   │       └── sign-off-log.md
│   └── completed/
│       ├── _index.md                ← NEW
│       └── [milestone-slug]/
│           ├── _index.md            ← NEW
│           ├── milestone-confirmed.md
│           ├── sign-off-log.md
│           └── retro-note.md
│
└── reports/
    ├── _index.md                    ← NEW
    └── [slug]-report.md
```

```
dev-repo/
├── _index.md                        ← NEW — repo master index
│
├── dto/
│   ├── _index.md                    ← NEW
│   ├── incoming/
│   │   ├── _index.md                ← NEW
│   │   └── [slug]-confirmed.md
│   └── outgoing/
│       ├── _index.md                ← NEW
│       └── [slug]-report.md
│
├── nfr-proposals/                   ← NEW (from NFR section)
│   ├── _index.md                    ← NEW
│   └── [nfr-slug].md
│
├── tech-debt/                       ← NEW (from Tech Debt section)
│   ├── _index.md                    ← NEW — master debt register
│   ├── accepted/
│   │   ├── _index.md                ← NEW
│   │   └── [debt-slug].md
│   └── postponed/
│       ├── _index.md                ← NEW
│       └── [debt-slug].md
│
├── planning/
│   ├── _index.md                    ← NEW
│   └── [milestone-slug]/
│       ├── _index.md                ← NEW — lists all planning docs for milestone
│       ├── tdd.md
│       ├── erd.md
│       ├── implementation-brainstorm.md
│       ├── atomic-change-plan.md
│       ├── test-scenarios.md
│       ├── adrs/
│       │   ├── _index.md            ← NEW
│       │   └── ADR-[n]-[title].md
│       ├── api-contracts/
│       │   ├── _index.md            ← NEW
│       │   └── [endpoint-slug].md
│       └── spikes/
│           ├── _index.md            ← NEW
│           └── [spike-slug].md
│
├── implementation/
│   ├── _index.md                    ← NEW
│   └── [milestone-slug]/
│       ├── _index.md                ← NEW
│       ├── progress.md
│       └── decisions-log.md
│
├── reports/
│   ├── _index.md                    ← NEW
│   └── [slug]-report.md
│
└── archive/
    ├── _index.md                    ← NEW — historical record index
    └── [milestone-slug]/
        ├── _index.md                ← NEW
        └── [all planning and implementation files]
```

---

### File Naming Conventions — Complete Reference

```
SLUGS
  All file and folder names: kebab-case
  Milestone slug:    bulk-export
  Idea slug:         bulk-export-feature
  NFR slug:          nfr-upload-concurrency
  Tech debt slug:    debt-session-management
  Feature slug:      photo-gallery

DATES
  Always ISO 8601:   YYYY-MM-DD
  Stress test files: session-2026-05-21.md
  Report files:      [milestone-slug]-report.md

ADR NUMBERING
  Padded integers, sequential per repo: ADR-001, ADR-002
  Never reuse a number even if superseded
  Superseded ADR links to replacement: status → superseded by ADR-[n]

INDEX FILES
  Always named:      _index.md
  Underscore prefix keeps it sorted to the top of every folder listing

VERSIONING
  Inside the confirmed file header: version field (1.0, 1.1, 2.0)
  Never encode version in the filename
  Version increments are logged in sign-off-log.md

STATUS IN FILENAMES
  Never encode status in a filename
  Status lives in the file header
  Lifecycle state is communicated by which folder a file is in:
    active/ → confirmed/ → completed/
    postponed/ → (converts to nfr-proposals/) → planning/
```

---

### Complete Cross-Repo Document Map — Updated

| Document | Repo | Layer | DTO? | Indexed in |
|---|---|---|---|---|
| `product-brief.md` | Product | Business | No | `product/_index.md` |
| `evolution-timeline.md` | Product | Business | No | `product/_index.md` |
| `current-state-map.md` | Product | Business | No | `product/_index.md` |
| `direction.md` | Product | Business | No | `product/_index.md` |
| `feature-index/[slug].md` | Product | Business | No | `feature-index/_index.md` |
| `ideas/[slug].md` | Product | Business | No | `ideas/_index.md` |
| `nfr-proposals/[slug].md` | Product | Business | No | `nfr-proposals/_index.md` |
| `milestones/active/[slug]/milestone.md` | Product | Business | No | `milestones/_index.md` |
| `milestones/active/[slug]/requirements/` | Product | Business | No | `requirements/_index.md` |
| `milestones/active/[slug]/stress-test/` | Product | Business | No | `stress-test/_index.md` |
| `milestones/confirmed/[slug]/milestone-confirmed.md` | Product | **DTO OUT** | ✅ | `milestones/_index.md` |
| `dto/outgoing/[slug]-confirmed.md` | Product | **DTO OUT** | ✅ | `dto/_index.md` |
| `dto/incoming/[slug]-confirmed.md` | Developer | **DTO IN** | ✅ | `dto/_index.md` |
| `nfr-proposals/[slug].md` | Developer | NFR | No | `nfr-proposals/_index.md` |
| `tech-debt/accepted/[slug].md` | Developer | Tech Debt | No | `tech-debt/_index.md` |
| `tech-debt/postponed/[slug].md` | Developer | Tech Debt | No | `tech-debt/_index.md` |
| `planning/[slug]/tdd.md` | Developer | Technical | No | `planning/[slug]/_index.md` |
| `planning/[slug]/adrs/ADR-[n].md` | Developer | Technical | No | `adrs/_index.md` |
| `planning/[slug]/api-contracts/` | Developer | Technical | No | `api-contracts/_index.md` |
| `planning/[slug]/erd.md` | Developer | Technical | No | `planning/[slug]/_index.md` |
| `planning/[slug]/spikes/` | Developer | Technical | No | `spikes/_index.md` |
| `planning/[slug]/implementation-brainstorm.md` | Developer | Technical | No | `planning/[slug]/_index.md` |
| `planning/[slug]/atomic-change-plan.md` | Developer | Technical | No | `planning/[slug]/_index.md` |
| `planning/[slug]/test-scenarios.md` | Developer | Technical | No | `planning/[slug]/_index.md` |
| `implementation/[slug]/progress.md` | Developer | Technical | No | `implementation/[slug]/_index.md` |
| `implementation/[slug]/decisions-log.md` | Developer | Technical | No | `implementation/[slug]/_index.md` |
| `reports/[slug]-report.md` | Developer | **DTO OUT** | ✅ | `reports/_index.md` |
| `dto/outgoing/[slug]-report.md` | Developer | **DTO OUT** | ✅ | `dto/_index.md` |
| `dto/incoming/[slug]-report.md` | Product | **DTO IN** | ✅ | `dto/_index.md` |

---

---

# PART 5 — Decision-Making Phases & Organizational Flow

*This section covers two things: (1) the parallel research and decision tracks that exist inside both the product planning and implementation planning phases, and (2) the full three-tier organizational flow from VP through PM to Senior Developer — including what each role researches independently and how information moves between them. Nothing in Parts 1–4 changes.*

---

## Part 5 — Decision-Making Phases

Every phase in this system involves research before a decision is made. Currently the system records decisions (ADRs) and validates requirements (stress test) — but the process of *arriving* at a decision is undocumented at the product level.

### The Symmetry Problem

```
IMPLEMENTATION PLANNING PHASE     PRODUCT PLANNING PHASE
─────────────────────────────     ──────────────────────────
Spike Doc          ✅ exists       Product Research Doc   ❌ missing
ADR                ✅ exists       PDR                    ❌ missing
Design Review      ✅ exists       Stress Test            ✅ exists
```

Product planning has no equivalent to the spike or ADR. Decisions made during product planning — *"should this be one feature or two?", "which user segment first?", "build vs integrate?"* — currently have no home. They end up buried in the milestone doc or exist only in someone's memory.

### The Two Parallel Tracks

```
PRODUCT PLANNING PHASE              IMPLEMENTATION PLANNING PHASE
────────────────────────────────    ────────────────────────────────
Complex question identified         Technical unknown identified
  ↓                                   ↓
Product Research Doc                Spike Doc (exists)
  ↓                                   ↓
PDR — Product Decision Record       ADR — Architecture Decision Record
  ↓                                   ↓
Stress Test validates               Design Review validates
  ↓                                   ↓
Milestone Confirmation              TDD approved
```

---

### Product Research Doc

For situations where the product question is too complex to decide without dedicated exploration. Feeds into a PDR the same way a spike feeds into an ADR.

**When it is needed:**

```
Spike needed when:                  Product Research Doc needed when:
  Technical unknown                   User behaviour unknown
  "Can this be built this way?"       "Do users actually want this?"
  Performance question                Competitive gap analysis
  Library evaluation                  Segment prioritisation question
  Algorithm feasibility               "What problem are we really solving?"
```

**File:**

```
---
slug:       research-[slug]
type:       product-research
status:     🔍 in-progress | ✓ complete
owner:      @pm-name
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   ideas/[slug].md | directives/[slug].md
downstream: pdrs/PDR-[n]-[title].md
---

PRODUCT RESEARCH: [Question Being Explored]
──────────────────────────────────────────────────────
Time-box:   [how long was allocated]
Feeds into: PDR-[n] | milestone/[slug]

QUESTION
  [What specifically was being explored — one sentence]

METHOD
  [How research was done — user interviews, data analysis,
  competitor review, support ticket analysis, desk research]

FINDINGS
  [What was learned — structured, not a prose dump]
  Finding 1: [clear statement]
  Finding 2: [clear statement]

IMPLICATIONS
  [What this means for the decision or milestone]

RECOMMENDATION
  [What the research suggests — not yet a decision]
──────────────────────────────────────────────────────
```

---

### PDR — Product Decision Record

The product-level equivalent of an ADR. For decisions that shape requirements but are not requirements themselves.

**Examples of decisions that need a PDR:**

```
"Should we build export as a feature or a standalone product?"
"Should onboarding be a wizard or a blank-state experience?"
"Do we target power users or casual users first for this milestone?"
"Build payment processing in-house or integrate a third party?"
"One milestone or split into two?"
"Which user segment does this milestone serve first?"
```

**File:**

```
---
slug:       PDR-[n]-[title]
type:       pdr
status:     📝 proposed | ✅ accepted | → superseded by PDR-[n]
owner:      @pm-name
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   research/research-[slug].md | ideas/[slug].md
downstream: milestones/active/[slug]/milestone.md
---

PDR-[n]: [Decision Title]
──────────────────────────────────────────────────────
Raised by:  @name
Affects:    [milestone-slug or product area]
Linked research: research/[slug].md

QUESTION
  [The specific decision that needed to be made — one sentence]

CONTEXT
  [What situation made this decision necessary]
  [What constraints or goals are in play]

OPTIONS CONSIDERED
  Option A: [name]
    What:  [description]
    Pros:  [benefits]
    Cons:  [costs or risks]

  Option B: [name]
    What:  [description]
    Pros:  [benefits]
    Cons:  [costs or risks]

DECISION
  [What was chosen and the core reason in one paragraph]

TRADE-OFFS ACCEPTED
  [What was given up — be explicit]

OUTCOME
  [Filled in after the milestone ships — was this the right call?]
──────────────────────────────────────────────────────
```

### PDR Numbering

PDRs are numbered sequentially per product repo, the same way ADRs are numbered per dev repo. Format: `PDR-001`, `PDR-002`. Never reuse a number.

---

### File Locations — Product Planning Decisions

```
product-repo/
└── milestones/
    └── active/[milestone-slug]/
        ├── research/                  ← NEW
        │   ├── _index.md
        │   └── research-[slug].md     Product Research Docs
        └── pdrs/                      ← NEW
            ├── _index.md
            └── PDR-[n]-[title].md     Product Decision Records
```

---

---

## Three-Tier Organizational Flow

The full system spans three roles. Each has its own research domain, its own decision type, and a specific output that feeds the next level.

### The Flow

```
┌──────────────────────────────────────────────────────────┐
│  VP                                                      │
│  "What bets should we make?"                             │
│                                                          │
│  Researches: market, competitive landscape,              │
│              business model, strategic constraints       │
│  Decides:    strategic direction and priorities          │
│  Outputs:    Strategic Directive → PM                    │
└────────────────────────┬─────────────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────────────┐
│  PM                                                      │
│  "What should we build within that direction?"           │
│                                                          │
│  Researches: user behaviour, product data,               │
│              competitive features, scope options         │
│  Decides:    what goes into milestones                   │
│  Outputs:    Milestone Confirmation → Senior Dev         │
└────────────────────────┬─────────────────────────────────┘
                         ↓
┌──────────────────────────────────────────────────────────┐
│  SENIOR DEVELOPER                                        │
│  "How should we build it?"                               │
│                                                          │
│  Researches: architecture options, algorithm trade-offs, │
│              technical constraints, system risks         │
│  Decides:    how the system is built                     │
│  Outputs:    Implementation Report → PM                  │
└──────────────────────────────────────────────────────────┘
```

Each level does independent, complex research in its own domain before producing its output. The output of one level is the input of the next.

---

### Research Per Role

#### VP Research Domain

```
MARKET & OPPORTUNITY
  Market sizing — is this worth building at all?
  Segment analysis — which customer type to focus on
  Timing — why now vs later or never?

COMPETITIVE LANDSCAPE
  Where are the gaps competitors haven't filled?
  What would it take to win in this space?
  What does the competitive timeline look like?

BUSINESS MODEL
  Revenue implications of this direction
  Build vs buy vs partner decisions
  Investment required vs expected return

STRATEGIC CONSTRAINTS
  What the team can sustainably execute
  Technical debt that limits strategic options
  Dependencies on other teams or external factors
```

VP research produces **SDRs (Strategic Decision Records)** — the VP-level equivalent of PDRs and ADRs — and a **Strategic Directive** that frames all PM work on a given horizon.

---

#### PM Research Domain

```
USER UNDERSTANDING
  What job is the user trying to do?
  Where does the current product fail them?
  What does "good" look like from their perspective?

PRODUCT ANALYSIS
  What does usage data say about current behaviour?
  What are support tickets and feedback revealing?
  What have previous milestones taught us?

COMPETITIVE DETAIL
  What specific features do competitors have?
  Where are the UX gaps worth exploiting?

SCOPE DECISIONS
  What is the smallest thing that delivers the VP's intent?
  What must be in this milestone vs deferred?
  Where are the risks in the requirements?
```

PM research produces **Product Research Docs** and **PDRs**, which shape the milestone. The stress test then validates those decisions with the actual user.

---

#### Senior Developer Research Domain

```
ARCHITECTURE EXPLORATION
  How does this fit into the existing system?
  What needs to change vs what can be reused?
  What are the architectural options and their trade-offs?

ALGORITHM & APPROACH EVALUATION
  What is the most efficient way to solve this problem?
  Are there known patterns or is this novel territory?
  Complexity, performance, and maintainability trade-offs?

RISK INVESTIGATION
  What are the unknowns that could blow up the estimate?
  What needs a spike before we commit to an approach?
  Where are the integration risks with existing systems?

CONSTRAINT ANALYSIS
  What does the existing data model allow or prevent?
  What do current API consumers depend on?
  What does the current tech debt make harder?
```

Senior Developer research produces **Spike Docs** (for specific unknowns) and **ADRs** (for decisions made). The TDD is the synthesis — the full picture of how the system will be built.

---

### The Three Handoff Documents

One clean handoff between each level. These are the DTOs of the organizational flow.

```
VP → PM
  STRATEGIC DIRECTIVE
  Contains: the bet, target segment, success definition,
            hard constraints, open questions for PM to resolve
  Trigger:  starts all PM work on a strategic horizon

PM → SENIOR DEV
  MILESTONE CONFIRMATION FILE (exists — Q5)
  Contains: confirmed requirements, user flows, AC,
            explicit out of scope, success metrics
  Trigger:  starts all Senior Dev work on a milestone

SENIOR DEV → PM
  IMPLEMENTATION REPORT (exists — DTO 2)
  Contains: what shipped, deviations, doc updates needed,
            retro note, NFR and tech debt notifications
  Trigger:  closes the milestone, triggers product doc updates
```

---

### The Feedback Loops

The flow is not one-way. Each level sends information back up.

```
SENIOR DEV → PM
  Implementation Report       what shipped, what changed
  NFR Proposals               technical needs PM must schedule
  Tech Debt notifications     constraints on future work
  ADRs                        technical decisions PM should know

PM → VP
  Milestone outcomes          did we hit the success metric?
  User response post-ship     data and feedback after shipping
  Escalations                 when technical constraints hit strategy
  Revised scope signals       when research reveals a VP assumption is wrong

VP → PM (reactive)
  Strategic re-prioritisation when market or business context changes
  New constraints             competitive moves, resourcing changes
```

---

### Strategic Layer File Structure

The VP tier needs its own document home. This sits above the product-repo, either as a separate strategy-repo or as a top-level folder inside product-repo.

```
product-repo/
└── strategy/                          ← NEW — VP tier
    ├── _index.md                      Master strategy index
    ├── research/
    │   ├── _index.md
    │   └── [strategic-research-slug].md   Market, competitive, business research
    ├── sdrs/
    │   ├── _index.md
    │   └── SDR-[n]-[title].md             Strategic Decision Records
    └── directives/
        ├── _index.md
        └── [directive-slug].md            Strategic Directives issued to PM
```

**Strategic Directive file:**

```
---
slug:       directive-[slug]
type:       strategic-directive
status:     📝 draft | ✅ issued | ✓ closed
owner:      @vp-name
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   sdrs/SDR-[n]-[title].md
downstream: milestones/active/[slug]/milestone.md
---

STRATEGIC DIRECTIVE: [Name]
──────────────────────────────────────────────────────
Issued by:  @vp-name
Horizon:    [quarter / half / year]
Status:     Issued | Active | Closed

STRATEGIC BET
  [What we are committing to and why now — one paragraph]

CONTEXT FOR PM
  Target segment:       [who specifically]
  Success looks like:   [business outcome, not a feature]
  Hard constraints:     [what cannot be compromised]
  Out of bounds:        [what we are deliberately not doing]

LINKED RESEARCH
  → [Strategic Research Doc links]
  → [SDR links]

OPEN QUESTIONS FOR PM
  → [What the VP needs the PM to resolve at product level]

OUTCOME (filled in after horizon closes)
  → [How this directive performed against the bet]
──────────────────────────────────────────────────────
```

**SDR — Strategic Decision Record:**

```
---
slug:       SDR-[n]-[title]
type:       sdr
status:     📝 proposed | ✅ accepted | → superseded by SDR-[n]
owner:      @vp-name
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   research/[strategic-research-slug].md
downstream: directives/[directive-slug].md
---

SDR-[n]: [Decision Title]
──────────────────────────────────────────────────────
Raised by:   @vp-name
Affects:     [strategic area or product line]
Linked research: research/[slug].md

QUESTION
  [The strategic decision that needed to be made]

CONTEXT
  [Market or business situation that forced this decision]

OPTIONS CONSIDERED
  Option A: [name] — Pros: / Cons:
  Option B: [name] — Pros: / Cons:

DECISION
  [What was chosen and why]

TRADE-OFFS ACCEPTED
  [What was given up]

OUTCOME
  [Filled in after the horizon closes]
──────────────────────────────────────────────────────
```

---

### Updated Document Map — All Three Tiers

| Document | Tier | Role | Feeds Into |
|---|---|---|---|
| Strategic Research Doc | Strategy | VP | SDR |
| SDR | Strategy | VP | Strategic Directive |
| Strategic Directive | Strategy | VP | PM milestone work |
| Product Research Doc | Product | PM | PDR |
| PDR | Product | PM | Milestone doc |
| Milestone doc | Product | PM | Milestone Confirmation |
| Stress Test session | Product | PM + User | Milestone Confirmation |
| Milestone Confirmation | **DTO 1** | PM → Senior Dev | TDD, planning |
| Spike Doc | Technical | Senior Dev | ADR |
| ADR | Technical | Senior Dev | TDD, Report |
| TDD | Technical | Senior Dev | Implementation |
| Implementation Report | **DTO 2** | Senior Dev → PM | Product doc updates |
| NFR Proposal | **DTO 3** | Senior Dev → PM | NFR milestone entry |

---

---

# PART 6 — BMAD Skill, Project Setup & Vertical Slice

*This section defines the BMAD skill that runs this entire framework, the initial project setup flow (the missing piece from Part 3), an updated SYNC operation that includes bidirectional decision syncing, and the enforced Vertical Slice Plan for all implementation work. Nothing in Parts 1–5 changes.*

---

## The BMAD Skill

The workflow tooling is not a separate repository. It lives inside the **bmad-method official skills** folder as one large skill — a collection of sub-agents, steps, scripts, tracking tables, and templates that together manage the full lifecycle.

### What a Skill Can Contain

```
A BMAD skill is a folder. It can hold:

  Sub-agents      Personal agents each focused on one responsibility.
                  Each has its own instructions and scope.

  Steps           Ordered instructions for a process.
                  Written as numbered steps an agent follows exactly.

  Scripts         Executable logic — file generation, validation checks,
                  sync operations. Written as agent-readable instructions
                  or actual runnable scripts.

  Tracking CSVs   "If X then Y" tables. Machine-readable rules that
                  govern agent behaviour without hardcoding into prompts.
                  Example: if milestone.status = confirmed then
                           create dto/outgoing/[slug]-confirmed.md

  Templates       Pre-filled markdown files for every document type.
                  INIT uses these to generate placeholder files.
                  Every template includes the full header block
                  with placeholder values ready to fill in.
```

---

### Skill Internal Structure

```
bmad-method/
└── skills/
    └── product-workflow/
        │
        ├── SKILL.md                      Entry point — what this skill is,
        │                                 when to invoke it, which sub-agent
        │                                 to call for which task
        │
        ├── agents/
        │   ├── planning-agent.md         Handles all product planning phase work
        │   │                             (ideas → milestones → PDRs → stress test)
        │   ├── validation-agent.md       Runs milestone validation and VALIDATE op
        │   │                             (checks AC, open questions, sign-off gate)
        │   ├── sync-agent.md             Runs SYNC — keeps planning and
        │   │                             implementation in sync bidirectionally
        │   └── handoff-agent.md          Manages all DTO transfers between repos
        │                                 (confirmed files, reports, NFR proposals)
        │
        ├── steps/
        │   ├── init-steps.md             Full ordered steps for INIT operation
        │   ├── milestone-steps.md        How to take an idea through to confirmed
        │   ├── sync-steps.md             Full ordered steps for SYNC operation
        │   └── validate-steps.md         Full ordered steps for VALIDATE operation
        │
        ├── scripts/
        │   ├── generate-structure.md     Instructions for creating full folder tree
        │   │                             with placeholder files from templates
        │   ├── validate-milestone.md     Checklist runner — pass/fail per item
        │   ├── sync-decisions.md         Decision sync logic — both directions
        │   └── update-indexes.md         Scans all folders, rebuilds _index.md files
        │
        ├── tracking/
        │   └── workflow-rules.csv        If/then rules table governing agent
        │                                 behaviour across all operations
        │
        └── templates/
            ├── _index.md                 Generic folder index template
            ├── idea.md                   Idea capture entry
            ├── milestone.md              Milestone document
            ├── requirement.md            Individual requirement entry
            ├── nfr.md                    NFR entry (attached to milestone)
            ├── nfr-proposal.md           NFR proposal (dev → product)
            ├── pdr.md                    Product Decision Record
            ├── product-research.md       Product Research Doc
            ├── sdr.md                    Strategic Decision Record
            ├── directive.md              Strategic Directive
            ├── stress-test-session.md    Stress test session log
            ├── milestone-confirmed.md    Milestone Confirmation File (DTO 1)
            ├── tech-debt-accepted.md     Accepted tech debt entry
            ├── tech-debt-postponed.md    Postponed tech debt entry
            ├── tdd.md                    Technical Design Document
            ├── adr.md                    Architecture Decision Record
            ├── api-contract.md           API contract
            ├── spike.md                  Spike / research doc
            ├── vertical-slice.md         Vertical Slice Plan
            ├── atomic-change-plan.md     Atomic change breakdown
            ├── test-scenarios.md         Test scenarios document
            ├── progress.md               Implementation progress log
            └── implementation-report.md  Implementation Report (DTO 2)
```

### workflow-rules.csv — Structure

The tracking CSV encodes the agent's decision logic as data, not prose. Format:

```
trigger_type, trigger_condition, action, target_path, notes
status_change, idea.status = validated, create, milestones/active/[slug]/milestone.md, use milestone template
status_change, milestone.status = confirmed, create, dto/outgoing/[slug]-confirmed.md, copy confirmed file
status_change, milestone.status = confirmed, create, milestones/confirmed/[slug]/sign-off-log.md, use signoff template
file_received, dto/incoming/[slug]-confirmed.md, create, planning/[slug]/, scaffold planning folder
file_received, dto/incoming/[slug]-report.md, run, sync-agent, trigger full sync
adr_filed, planning/[slug]/adrs/ADR-[n].md, sync, planning/decisions/arch-[slug].md, bidirectional
pdr_filed, milestones/active/[slug]/pdrs/PDR-[n].md, sync, implementation/context/pdr-[slug].md, bidirectional
stress_test, session.open_items > 0, block, milestone confirmation, unresolved items
vertical_slice, vs.status = planned AND next_vs_depends = false, allow, next vertical slice planning, ahead planning enabled
```

Agents read this CSV before acting. New rules can be added without changing agent prompts.

---

## Initial Project Setup

The missing piece. A user begins with **one repo**. The skill's INIT operation sets everything up and then prompts for how implementation will be connected.

### INIT — Step by Step

```
STEP 1 — Single Repo Created
  User creates one repo: [product-name]-planning
  This is the planning repo by default.
  No implementation code lives here yet.

STEP 2 — INIT Invoked
  User invokes the product-workflow skill: INIT
  Agent reads: init-steps.md

STEP 3 — Product Brief Prompt
  Agent asks four questions:
    → What is your product name?
    → One sentence: what does it do?
    → Who is the primary user?
    → Do you have a codebase yet? (Yes / Not yet)

STEP 4 — Full Structure Generated
  Agent creates entire planning folder tree
  Every folder gets an _index.md (from template, prefilled)
  Key files created with placeholder content:
    → planning/product/product-brief.md   (prefilled with prompt answers)
    → planning/product/evolution-timeline.md
    → planning/product/current-state-map.md
    → planning/product/direction.md
    → planning/feature-index/_index.md
    → planning/ideas/_index.md
    → planning/milestones/_index.md
    → planning/strategy/directives/_index.md
    → planning/strategy/sdrs/_index.md
    → planning/dto/incoming/_index.md
    → planning/dto/outgoing/_index.md

STEP 5 — Implementation Setup Prompt
  Agent asks:
    "How do you want to connect your implementation codebase?"

    Option A → Submodule
      "I'll create a separate implementation repo and
       link it here as a git submodule"

    Option B → Git Workflow (single repo)
      "I'll keep planning and implementation in
       one repo with separate top-level folders"

  → User selects one. Agent follows the path for that option.

STEP 6 — End State Reached
  Both options result in the same logical layout:
  planning/ and implementation/ at the same level.
  (Physical layout differs — see Two Repo Options below.)
```

---

## Two Repo Options

### Option A — Submodule

```
[product-name]-planning/          ← the git repo (planning)
├── planning/                     ← full planning framework
│   ├── product/
│   ├── ideas/
│   ├── milestones/
│   ├── feature-index/
│   ├── strategy/
│   ├── nfr-proposals/
│   ├── dto/
│   └── reports/
└── implementation/               ← git submodule → [product-name] repo
    └── [actual codebase]
```

**When to choose:** Teams want separate access control. Senior devs work in implementation repo without needing planning repo access. PM works in planning repo without touching the codebase. Clean separation enforced by git.

**INIT creates:**
- `.gitmodules` with implementation repo path
- `implementation/` as the submodule mount point
- Agent instructions note: DTOs are written to `planning/dto/` — the submodule's `dev-repo/dto/` is the other side

---

### Option B — Git Workflow (Single Repo)

```
[product-name]/                   ← single git repo
├── planning/                     ← full planning framework
│   ├── product/
│   ├── ideas/
│   ├── milestones/
│   ├── feature-index/
│   ├── strategy/
│   ├── nfr-proposals/
│   ├── dto/
│   └── reports/
└── implementation/               ← actual codebase
    ├── src/
    ├── tests/
    └── dev-planning/             ← dev repo planning docs live here
        ├── planning/             (TDDs, ADRs, spikes, etc.)
        └── tech-debt/
```

**When to choose:** Solo developer or small team. Simpler — no submodule management. Branch strategy separates planning work from implementation work.

**INIT creates:**
- Both `planning/` and `implementation/` at root level
- `implementation/dev-planning/` for all dev-side docs
- `.planning-config.md` at root linking both sides

---

## End State Structure

Regardless of option chosen, the logical layout is always:

```
[root]
├── planning/              PRODUCT PLANNING LAYER
│   ├── strategy/            VP tier (directives, SDRs, research)
│   ├── product/             Core product docs (brief, timeline, state)
│   ├── ideas/               Idea capture log
│   ├── milestones/          Active → confirmed → completed
│   ├── feature-index/       Live feature inventory
│   ├── nfr-proposals/       Incoming NFR proposals
│   ├── dto/                 In/out transfer files
│   └── reports/             Archived implementation reports
│
└── implementation/        TECHNICAL LAYER
    ├── [source code]
    └── dev-planning/
        ├── planning/        TDDs, ADRs, spikes, contracts, slices
        ├── tech-debt/       Accepted and postponed debt
        ├── nfr-proposals/   Outgoing NFR proposals
        ├── dto/             In/out transfer files
        └── reports/         Generated implementation reports
```

---

## Sync — Decision Layer

The SYNC operation previously covered keeping `_index.md` files current and checking headers. This update adds **bidirectional decision syncing** — architectural and infrastructure decisions flow both ways so each side always has the full decision context.

### What Decisions Get Synced

```
IMPLEMENTATION → PLANNING (push)
  ADRs filed during implementation
  Infrastructure decisions (hosting, CI, tooling changes)
  Schema decisions not covered in the original TDD
  Any decision that affects what the product can or cannot do

PLANNING → IMPLEMENTATION (push)
  PDRs — product decisions that shape how engineers build
  Strategic Directives — the "why" behind feature priorities
  Scope changes to confirmed milestones
  New NFR confirmations that add constraints
```

### The Decisions Registry

A new folder in both repos that acts as the receiving end of synced decisions:

```
planning/
└── decisions/                 ← NEW — receives decisions from implementation
    ├── _index.md              All synced decisions, dated, categorised
    └── arch-[slug].md         Reference copy of an ADR from dev side

implementation/dev-planning/
└── context/                   ← NEW — receives decisions from planning
    ├── _index.md              All synced planning decisions
    └── pdr-[slug].md          Reference copy of a PDR from planning side
```

These are **reference copies**, not the source of truth. The source always stays in the repo that filed it. The reference copy carries:

```
---
slug:       ref-[original-slug]
type:       decision-reference
source:     [path in originating repo]
synced:     YYYY-MM-DD
---

DECISION REFERENCE: [Title]
This is a synced reference. The source document lives at:
[full path in originating repo]

SUMMARY FOR THIS SIDE
  [One paragraph — what this decision means for readers on this side]
  Written from the perspective of the receiving team, not the filing team.

IMPACT ON THIS SIDE
  [What this changes, constrains, or enables for this repo's work]
```

### Updated SYNC — Full Operation

```
SYNC runs when:
  → Milestone ships (triggered by implementation report)
  → New ADR filed in dev-planning
  → New PDR filed in planning
  → Infrastructure or architecture change is recorded
  → Manual invocation by either agent

SYNC steps (sync-agent follows sync-steps.md):

  1. SCAN both repos for new decisions since last sync date
     Read: planning/decisions/_index.md (last synced date)
     Read: implementation/dev-planning/context/_index.md (last synced date)

  2. PUSH implementation decisions → planning
     For each new ADR or infra decision:
       Create: planning/decisions/arch-[slug].md (reference copy)
       Update: planning/decisions/_index.md
       Check:  does this affect evolution-timeline.md?
       Check:  does this affect current-state-map.md?
       Update those files if yes.

  3. PUSH planning decisions → implementation
     For each new PDR or directive:
       Create: implementation/dev-planning/context/pdr-[slug].md (reference copy)
       Update: implementation/dev-planning/context/_index.md

  4. REBUILD all _index.md files
     Scan every folder in both repos.
     Update status counts and last-updated dates.

  5. VALIDATE headers
     Check every file has required header fields.
     Flag files missing upstream/downstream links.
     Output: sync-report.md (list of issues, if any)

  6. UPDATE sync timestamp
     Write last sync date to both _index.md root files.
```

---

## Vertical Slice Plan

Every milestone in the dev repo requires a Vertical Slice Plan before full implementation begins. This is enforced — not optional.

### What a Vertical Slice Is

A vertical slice is the **thinnest complete cut through all system layers** that proves the design works and validates the TDD in reality before the full feature is built.

```
NOT a horizontal slice (all the UI first, then all the API, then DB)

A VERTICAL SLICE:
  One specific user action, fully working, end-to-end
  UI → API → DB → response in one connected path
  Minimum viable implementation of that one path
  Proves the architecture holds before committing to full build
```

### One Milestone, Multiple Slices

A milestone confirmation may contain multiple requirements. Each requirement or group of related requirements becomes one vertical slice. The slices are planned and ordered before any implementation starts.

```
Milestone: Bulk Export
  VS-1: User requests CSV export → job queued → confirmation shown
  VS-2: Job processes → file generated → user notified
  VS-3: User downloads file → file valid → job marked complete
```

### Ahead Planning — Slice N+1 Without Waiting

If Slice N+1 does not depend on Slice N being **implemented** (only on it being **validated as a plan**), the Senior Developer can begin planning Slice N+1 immediately. This prevents planning bottlenecks while implementation is in progress.

```
VS-1 PLANNED + VALIDATED
  → VS-1 implementation starts
  → If VS-2 depends only on VS-1's validated design (not its code):
       VS-2 planning begins in parallel
  → If VS-2 depends on VS-1's actual running code:
       VS-2 planning waits until VS-1 is implemented and verified
```

Combining slices is also permitted — if two slices are small and tightly coupled, they can be merged into one plan. The user (or Senior Dev) declares the combination explicitly in the plan.

### Vertical Slice Plan — File

```
---
slug:       vs-[n]-[milestone-slug]
type:       vertical-slice
status:     📝 planned | 🔨 in-progress | ✓ validated | ✓ implemented
            | → combined with vs-[n]
owner:      @senior-dev
created:    YYYY-MM-DD
updated:    YYYY-MM-DD
upstream:   dto/incoming/[milestone-slug]-confirmed.md
downstream: planning/[milestone-slug]/atomic-change-plan.md
---

VERTICAL SLICE PLAN: VS-[n] — [Name]
══════════════════════════════════════════════════════
Milestone:      [milestone-slug]
Slice number:   VS-[n] of [total planned]
Combined with:  VS-[n] | — (if standalone)
Ahead planning: Enabled | Blocked (depends on VS-[n-1] implementation)
══════════════════════════════════════════════════════

WHAT THIS SLICE PROVES
  [The specific design question or risk this slice validates]
  Example: "Proves the job queue architecture handles async export"

USER ACTION COVERED
  [One specific user action, start to finish]
  Example: "User clicks Export → selects CSV → sees confirmation message"

LAYERS TOUCHED
  UI layer:   [minimum UI required — no polish, just functional]
  API layer:  [one endpoint or mutation — minimum viable]
  DB layer:   [minimum schema — no indexes optimised yet]
  Other:      [queue, cache, external service — if touched]

THIN IMPLEMENTATION PLAN
  What is built:      [exactly what gets coded — no more, no less]
  What is stubbed:    [what is faked or hardcoded for now]
  What is deferred:   [what this slice deliberately does not cover]

VALIDATION GATE
  This slice is done when:
  → [Specific check 1 — user action works end to end]
  → [Specific check 2 — no existing tests broken]
  → [Specific check 3 — TDD assumptions held in practice]

NEXT SLICE DEPENDENCY
  VS-[n+1] needs this:    Implemented | Validated-only | Independent
  Ahead planning allowed: Yes | No

COMBINATION NOTE (if combined)
  Combined with:  VS-[n]
  Reason:         [why these were merged — size, coupling]
══════════════════════════════════════════════════════
```

### Where Vertical Slices Live

```
implementation/dev-planning/
└── planning/
    └── [milestone-slug]/
        ├── _index.md
        ├── tdd.md
        ├── vertical-slices/            ← NEW — required folder
        │   ├── _index.md               Lists all slices, order, status
        │   ├── vs-1-[name].md
        │   ├── vs-2-[name].md
        │   └── vs-3-[name].md
        ├── atomic-change-plan.md       Generated after slices are planned
        └── test-scenarios.md
```

The `vertical-slices/_index.md` shows the full slice map for a milestone:

```
# Vertical Slices — [Milestone Name]

| # | Name | Status | Ahead Plan OK | Combined | File |
|---|---|---|---|---|---|
| VS-1 | [name] | ✓ implemented | — | — | [link] |
| VS-2 | [name] | 🔨 in-progress | Yes | — | [link] |
| VS-3 | [name] | 📝 planned | No | — | [link] |
```

### The Full Implementation Sequence With Slices

```
Milestone Confirmation received
  ↓
TDD written (full design)
  ↓
Vertical Slices planned and ordered (ALL slices before ANY implementation)
  ↓
  VS-1 implementation → validated
      ↓ (if VS-2 ahead-plan allowed)
      VS-2 planning runs in parallel →
  VS-2 implementation → validated
      ↓
      VS-3 planning (if not already done) →
  VS-3 implementation → validated
      ↓
All slices done → atomic-change-plan reviewed → full test suite
      ↓
Implementation Report generated
```

---

## The Three Operations — Final Definition

```
INIT
  When:     First time setup of a new product
  Who runs: User invokes the skill once
  Does:
    1. Asks four product brief questions
    2. Generates full planning/ folder tree with prefilled placeholders
    3. Asks: submodule or single repo?
    4. Creates implementation/ connection based on choice
    5. Writes .planning-config.md at root
    6. Outputs: checklist of what was created + first suggested action

VALIDATE
  When:     Before any milestone is confirmed
  Who runs: Planning agent (automated) + human sign-off
  Does:
    1. Checks all requirements have acceptance criteria
    2. Checks all PDRs are in accepted state
    3. Checks all stress test sessions have zero open items
    4. Checks all open questions in milestone are resolved
    5. Checks scope is marked complete (no "TBD" in Must Have items)
    6. Outputs: pass/fail report per check — blocks confirmation if any fail

SYNC
  When:     After any milestone ships, after any ADR or PDR is filed,
            or on manual invocation
  Who runs: Sync agent (automated trigger or manual)
  Does:
    1. Scans both repos for new decisions since last sync
    2. Pushes ADRs and infra decisions → planning/decisions/
    3. Pushes PDRs and directives → implementation/dev-planning/context/
    4. Rebuilds all _index.md files
    5. Validates all file headers
    6. Updates evolution-timeline.md and current-state-map.md if affected
    7. Writes sync-report.md with any issues found
    8. Updates last-sync timestamp
```

---

*Last updated: 2026 · Owner: [your name] · Status: Living document*