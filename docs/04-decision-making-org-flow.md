# Decision-Making Phases & Organizational Flow

Decision-making symmetry (PDR as product-level ADR), three-tier organizational hierarchy (VP/PM/Senior Dev), handoff documents, feedback loops, and strategic layer file structure.

## Decision-Making Phases

### Two Parallel Tracks

- Product planning: Complex question → Product Research Doc → PDR → Stress Test validates → Milestone Confirmation
- Implementation planning: Technical unknown → Spike Doc → ADR → Design Review validates → TDD approved
- PDR (Product Decision Record) fills the product-level gap equivalent to ADR on the technical side

### Product Research Doc

- Needed when: is user behavior unknown?, do users actually want this?, is competitive analysis needed?, which segment to prioritize?, what problem are we really solving?
- Frontmatter: slug=research-[slug], type=product-research, status (🔍 in-progress/✓ complete), owner, created/updated, upstream, downstream (pdrs/PDR-[n]-[title])
- Body: Time-box, Feeds into PDR/milestone, Question (one sentence), Method (user interviews/data analysis/competitor review/support ticket analysis/desk research), Findings (structured, not prose dump), Implications, Recommendation (what research suggests, not yet a decision)
- File location: milestones/active/[milestone-slug]/research/research-[slug].md

### PDR — Product Decision Record

- Product-level equivalent of ADR. For decisions shaping requirements but not requirements themselves
- Examples: build export as feature or standalone product?, onboarding wizard vs blank-state?, power users vs casual first?, build vs integrate payment?, one milestone or split?
- Frontmatter: slug=PDR-[n]-[title], type=pdr, status (📝 proposed/✅ accepted/→ superseded by PDR-[n]), owner, created/updated, upstream (research/research-[slug] or ideas/[slug]), downstream (milestones/active/[slug]/milestone.md)
- Body: Raised by, Affects (milestone slug or product area), Linked research, Question (one sentence), Context (situation making decision necessary, constraints/goals), Options considered (Option A/B: What/Pros/Cons), Decision (chosen + core reason), Trade-offs accepted (explicit), Outcome (filled after milestone ships)
- Numbering: sequential per repo (PDR-001, PDR-002). Never reuse. Format same as ADRs
- File location: milestones/active/[milestone-slug]/pdrs/PDR-[n]-[title].md; research/ for Product Research Docs

## Three-Tier Organizational Flow

Three roles, each with independent research domain and specific decision type.

### VP (What bets should we make?)

- Researches: market sizing, competitive landscape, business model, strategic constraints
- Decides: strategic direction and priorities
- Outputs: Strategic Directive → PM
- Research domain: Market & opportunity (sizing/segment/timing), Competitive landscape (gaps/win conditions/timeline), Business model (revenue/build-vs-buy-vs-partner/investment-vs-return), Strategic constraints (sustainable execution/debt limiting options/dependencies)
- VP produces SDRs (Strategic Decision Records) and Strategic Directives

### PM (What should we build within that direction?)

- Researches: user behavior, product data, competitive features, scope options
- Decides: what goes into milestones
- Outputs: Milestone Confirmation → Senior Dev
- Research domain: User understanding (job-to-be-done/current failures/good definition), Product analysis (usage data/support tickets/prior milestone lessons), Competitive detail (specific features/UX gaps), Scope decisions (smallest thing delivering VP intent/milestone boundaries/risks)
- PM produces Product Research Docs and PDRs. Stress Test validates with user

### Senior Developer (How should we build it?)

- Researches: architecture options, algorithm trade-offs, technical constraints, system risks
- Decides: how the system is built
- Outputs: Implementation Report → PM
- Research domain: Architecture exploration (system fit/change-vs-reuse/options and trade-offs), Algorithm & approach evaluation (efficiency/patterns-vs-novel/complexity-performance-maintainability), Risk investigation (unknowns/spikes/integration risks), Constraint analysis (data model allowances/API consumer dependencies/tech debt impact)
- Senior Dev produces Spike Docs and ADRs. TDD is the synthesis

### Three Handoff Documents

- VP → PM: Strategic Directive (bet, target segment, success definition, hard constraints, open questions for PM). Starts all PM work on strategic horizon
- PM → Senior Dev: Milestone Confirmation File (Q5). Starts all Senior Dev work on a milestone
- Senior Dev → PM: Implementation Report (DTO 2). Closes milestone, triggers product doc updates

### Feedback Loops

- Senior Dev → PM: Implementation Report, NFR Proposals, Tech Debt notifications, ADRs
- PM → VP: Milestone outcomes, User response post-ship, Escalations (technical constraints hitting strategy), Revised scope signals (research reveals VP assumption wrong)
- VP → PM (reactive): Strategic re-prioritization, New constraints

## Decision Guardrails (YOLO Safety Interlock)

Before executing destructive or large-scale operations:

- Constitution missing → refuse
- >N files to change → refuse with recommendation to split
- Destructive operation → dry-run first (unified diff)
- Brownfield + no project-context.md → suggest generate-project-context
- YOLO keyword → skip Q&A with file cap + undo note
- Pre-flight quiz: max 2 architecture questions, verify constitution path, check git context
- Dry-run: unified diff + undo block in session log (git checkout + rm commands)

## Strategic Layer File Structure

```
product-repo/strategy/          ← VP tier
  _index.md                     Master strategy index
  research/
    _index.md
    [strategic-research-slug].md  Market, competitive, business research
  sdrs/
    _index.md
    SDR-[n]-[title].md            Strategic Decision Records
  directives/
    _index.md
    [directive-slug].md           Strategic Directives issued to PM
```

### Strategic Directive File

- Frontmatter: slug=directive-[slug], type=strategic-directive, status (📝 draft/✅ issued/✓ closed), owner (@vp-name), created/updated, upstream (sdrs/SDR-[n]-[title]), downstream (milestones/active/[slug]/milestone.md)
- Body: Issued by, Horizon (quarter/half/year), Status (Issued/Active/Closed), Strategic bet (commitment + why now), Context for PM (target segment/success looks like/hard constraints/out of bounds), Linked research, Open questions for PM, Outcome (filled after horizon closes)

### SDR — Strategic Decision Record

- Frontmatter: slug=SDR-[n]-[title], type=sdr, status (📝 proposed/✅ accepted/→ superseded by SDR-[n]), owner, created/updated, upstream (research/[slug]), downstream (directives/[directive-slug])
- Body: Raised by, Affects (strategic area), Linked research, Question, Context (market/business situation forcing decision), Options considered (Option A/B with Pros/Cons), Decision, Trade-offs accepted, Outcome (filled after horizon closes)

### Updated Document Map — All Three Tiers

- Strategy tier: Strategic Research Doc (VP → SDR), SDR (VP → Strategic Directive), Strategic Directive (VP → PM milestone work)
- Product tier: Product Research Doc (PM → PDR), PDR (PM → Milestone doc), Milestone doc (PM → Milestone Confirmation), Stress Test (PM+User → Milestone Confirmation), Milestone Confirmation (DTO 1, PM→Senior Dev → TDD/planning)
- Technical tier: Spike Doc (Senior Dev → ADR), ADR (Senior Dev → TDD/Report), TDD (Senior Dev → Implementation), Implementation Report (DTO 2, Senior Dev→PM → Product doc updates), NFR Proposal (DTO 3, Senior Dev→PM → NFR milestone entry)
