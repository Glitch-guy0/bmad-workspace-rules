# This section covers Business & Product Level (Q1-Q5). Part 1 of 6 from final-plan.md.

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
