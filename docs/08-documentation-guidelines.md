This section covers Documentation Guidelines — types of documentation, general guidelines, contribution docs philosophy, and research output map. Part 5 of 5 from documentation.md (59 lines).

## Two Types of Documentation
- Product Brief (Features & Workflow): from user's perspective in the abstract; describes what the product does and how users interact with it
- Architecture Documentation: how code is written, infrastructure layout, service communication patterns, each service's functionality; data flow (DB architecture, storage, manipulation, transactions); connecting user stories to DB manipulation
- Architecture docs also cover: infra structure, service communication and failure handling, coding philosophy

## Data Flow Documentation
- DB architecture: storage, data manipulation, transactions
- Connect user story with DB manipulation — trace how a user action maps to database operations

## General Guidelines (TypeScript)
- CONTRIBUTION.md per repo: rules for coding sessions — how to structure and write code, what to document after code is written
- Each repo has its own CONTRIBUTION.md explaining scope and rules for that project

## Workflow Principles
- Brain Dump → Project Milestones → Brainstorming workflow
- Maintain a brainstorming file; consider Linear for tracking

## Architectural Decisions Planning
- Architecture decisions should be explained with context and rationale

## Docs Folder Structure Guidance
- Each file is atomic: contains rules on one specific thing
- Abstract folders: create folders with multiple related files; folders serve as indexes to actual files
- Language-agnostic rules: each file can have rules for different languages but the rules are the same; focus on outcome implementation rather than language-specific packages
- Package selection: stable, well-known, developer-preferred packages; implementation rules remain same across languages (e.g., logging packages differ between TypeScript and Python but implementation rules are identical)

