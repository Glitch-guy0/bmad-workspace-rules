---
name: bmad-documentation-builder
description: Build and maintain product documentation following the Product Documentation Framework. Use when user says 'document this feature' or 'create documentation' or 'update docs'.
---

# BMad Documentation Builder

Implements the Product Documentation Framework: layered model, Q1-Q10 master flow, two-repo architecture, NFR and tech-debt tracking, file-indexing system, and three-tier decision-making.

## Contents

- `agents/` — agent personas for the documentation workflow (Product Agent, Developer Agent)
- `templates/` — documentation templates (TDD, ADR, API Contract, Milestone Confirmation, PDR)
- `scripts/` — process descriptions for documentation operations
- `structured_rules.csv` — structural rules for documentation artifacts

## Upstream Dependencies

- Product Documentation Framework (see `final-plan.md`)
- Project Constitution (see `project-plan-source-of-truth/02-project-constitution.md`)
- Tech stack and coding standards (see `tech-stack-standards.md`)
