# This section covers NFR, Tech Debt & File Indexing (Part 4). Part 4 of 6 from final-plan.md.

## NFR — Non-Functional Requirements

### Differences From Functional Requirements
| Aspect | Functional | NFR |
|---|---|---|
| Source | User feedback, PM, product thinking | Senior developer, technical observation |
| Language | "User can do X" | "System must perform Y under Z conditions" |
| Validation | User stress test | Engineering review |
| AC | User journey outcome | Measurable technical threshold |
| Milestone origin | Always tied to user story | Standalone or attached to existing milestone |

### Three NFR Patterns
- Pattern A (Cross-cutting): affects whole system. Example: "All API endpoints must respond under 200ms at p95" → standalone NFR milestone
- Pattern B (Feature-attached): belongs alongside planned milestone. Example: "Upload feature must handle 1000 concurrent uploads" → attaches as NFR entry
- Pattern C (Debt-driven): fixing something degrading. Example: "Auth service has no rate limiting" → standalone NFR milestone, urgent

### NFR Flow
- Senior dev observes technical need → creates nfr-proposals/[slug].md in dev repo → crosses to product repo (DTO 3) → product agent + PM review → decision: standalone milestone OR attach to existing milestone
- If standalone: milestones/active/nfr-[slug]/; engineering review replaces user stress test; PM acknowledges, engineering lead signs off
- If attached: milestones/active/[existing-slug]/requirements/nfr-[slug].md; parent milestone flagged as containing NFR

### NFR Proposal File (dev→product)
- Frontmatter: slug, type=nfr, status (📝 proposed), owner, created/updated, upstream, downstream
- Body: Raised by, Date, Category (Performance/Security/Scalability/Reliability/Maintainability/Observability/Compliance), What (one line), Why now, Current state (measurable gap), Target threshold (specific measurable), Impact if not addressed, Affected systems, Milestone preference (standalone/attach to [slug]/attach to next milestone that touches [system]), Rough effort (Small days/Medium 1-2 weeks/Large sprint+)

### NFR Entry in Milestone
- Frontmatter: slug=nfr-[slug], type=nfr, status (📝 proposed), owner, upstream (nfr-proposals/[slug]), downstream
- Body: NFR name, Category, Raised by + date, Priority (MoSCoW), What, Acceptance Criteria (threshold/measured by/baseline), Scope (systems affected, milestone attachment), Engineering Review Notes, Sign-off (engineering lead + PM)

### NFR Repo Additions
- Product repo: nfr-proposals/ (_index.md, [nfr-slug].md); milestones/active/[slug]/requirements/nfr-[slug].md
- Dev repo: nfr-proposals/ (_index.md, [nfr-slug].md)

## Tech Debt

### NFR vs Tech Debt
| | NFR | Tech Debt |
|---|---|---|
| What | System property that doesn't exist yet | Something that exists but is suboptimal |
| Origin | "We need the system to do X" | "This works but is wrong/risky/fragile" |
| Nature | Proactive | Reactive awareness |

### Two Types
- Accepted debt: conscious documented decision to live with suboptimal. Always links to an ADR. Deliberate trade-off with known cost + documented exit conditions
- Postponed debt: will be fixed but not now. Has trigger condition or milestone target. When trigger hit → converts to NFR proposal

### Key Rule: Accepted Debt Is an ADR
- Accepted debt without documentation = forgotten debt. Accepted debt with ADR = conscious debt with exit conditions

### Accepted Debt File
- Frontmatter: slug, type=tech-debt, status (✅ accepted), owner, created/updated, upstream, downstream (adrs/ADR-[n])
- Body: What, Why it exists (how debt was created), Known cost/risk, Why accepted (trade-off reasoning), Exit conditions (what triggers revisiting; or "accept permanently")

### Postponed Debt File
- Frontmatter: slug, type=tech-debt, status (⏸ postponed), owner, upstream, downstream (nfr-proposals/[slug] when trigger hit)
- Body: What, Why it exists, Current impact (specific), Why postponed, Resolution plan (trigger condition OR target milestone + effort estimate), Escalation condition (what forces above threshold)

### Tech Debt Flow
- Engineer spots debt → creates entry in dev-repo/tech-debt/ → decision: Accepted (ADR filed immediately, product repo notified, stays in tech-debt/accepted/) OR Postponed (linked to future milestone/trigger, product repo notified, monthly debt review monitors, when trigger hit → converts to NFR proposal)

### Tech Debt Repo Additions
- Dev repo: tech-debt/ (_index.md — master debt register, review cadence: Monthly, tables for Postponed (name/category/raised/target-trigger/risk/file) and Accepted (name/category/accepted/exit-condition/ADR/file)), accepted/[debt-slug].md, postponed/[debt-slug].md

## Part 4 — File Indexing System

### Core Model
- Layer 1: Repo _index.md ("What exists in entire repo?")
- Layer 2: Folder _index.md ("What exists in this folder?")
- Layer 3: File header block ("What is this file at a glance?")
- Layer 4: File content (actual detail)
- Agent or human navigates top-down. Layers 1-3 readable without opening anything

### File Header Standard
- Every file opens with YAML frontmatter before any content
- Fields: slug (unique kebab-case id), type (idea/requirement/nfr/tech-debt/milestone/feature/adr/tdd/api-contract/spike/stress-test/report/implementation-brainstorm/atomic-change-plan/test-scenarios/progress), status (valid per type table), owner (@name), created (YYYY-MM-DD), updated (YYYY-MM-DD), upstream (path to creating file, — if origin), downstream (path(s) file feeds into, — if terminal)

### Status Values Per Type
- idea: 💡 raw / 🔍 exploring / ✅ validated / ⏸ parked / ❌ rejected
- milestone: 📋 planning / ✅ confirmed / 🚀 in-progress / ✓ complete / ⏸ paused
- requirement: 📝 draft / ✅ confirmed / ❌ descoped
- nfr: 📝 proposed / 🔍 reviewing / ✅ confirmed / ❌ rejected
- tech-debt: ⏸ postponed / ✅ accepted / 🔨 resolving / ✓ resolved
- feature: 🔬 experimental / 🔶 beta / ✅ live / ❌ deprecated
- adr: 📝 proposed / ✅ accepted / → superseded by ADR-[n]
- tdd: 📝 draft / 🔍 in-review / ✅ approved / ✓ implemented
- spike: 🔍 in-progress / ✓ complete
- report: 📝 draft / ✅ sent
- stress-test: 🔍 in-progress / ⚠️ open-items / ✓ complete
- progress: 🔨 in-progress / ⏸ blocked / ✓ complete

### Folder _index.md Standard
- One-line description, Last updated date, Status-grouped tables (active work first)
- Columns per table: Name, Status, One-liner, Updated, File

### Repo-Level _index.md Templates
- Product repo: Active milestones count, Open ideas count, Pending NFRs count. Sections: Milestones (name/status/target/requirements/file), Ideas (name/status/category/raised/file), Features (name/status/owner/updated/file), NFR Proposals (name/status/category/preference/file), Tech Debt (name/type/risk/trigger/file), DTOs (file/direction/status/date)
- Developer repo: Active milestones count, Open ADRs count, Postponed debt count. Sections: Active Planning (milestone/status/TDD/ADRs/Test Scenarios/file), Implementation (milestone/status/progress/blocked/file), ADR Log (number/title/status/date/file), Tech Debt (name/type/risk/trigger-ADR/file), NFR Proposals (name/status/sent/product-response/file), Archive (milestone/shipped/report/file), DTOs (file/direction/status/date)

### The Link Chain
- Every file knows upstream (where it came from) and downstream (what it produces). Agent traces any chain forwards or backwards without reading content
- Example chain: ideas/bulk-export.md → milestones/active/bulk-export/milestone.md → requirements/csv-export.md → milestones/confirmed/bulk-export/milestone-confirmed.md → dto/outgoing/bulk-export-confirmed.md → [crosses to dev] dto/incoming/bulk-export-confirmed.md → planning/bulk-export/tdd.md → planning/bulk-export/adrs/ADR-007-csv-streaming.md → reports/bulk-export-report.md → dto/outgoing/bulk-export-report.md

### Agent Navigation Modes
- Mode 1 (Top-down discovery): Read repo _index.md → pick section → read folder _index.md → open specific file
- Mode 2 (Chain traversal): Read file's upstream/downstream → trace origin backwards or impact forwards
- Mode 3 (Status scan): Scan _index.md files for specific status across repo

### Updated File Structures With Indexing
- Product repo: 43+ files including _index.md at root and every subfolder. Milestone subfolders each have _index.md
- Developer repo: 40+ files including _index.md at root and every subfolder. Planning, implementation, archive all indexed

### Complete Naming Conventions
- Slugs: kebab-case for all names. nfr slug prefix: nfr-. Tech debt slug prefix: debt-. Feature slug: same as idea slug pattern
- Index files: always _index.md (underscore prefix sorts to top)
- Versioning: inside file header only. Version increments logged in sign-off-log.md
- Status: never in filename. Communicated by folder location (active/confirmed/completed; postponed/nfr-proposals/planning)
