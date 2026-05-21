# Constitution Loader

How to read Appendix A precedence from the consolidated brainstorming session.

## Document Precedence (from brainstorming session)

| Order | Section | Role |
|-------|---------|------|
| 1 | **Appendix A** — Project Constitution | Immutable defaults |
| 2 | **Part 4** — Delta queue | Proposed changes |
| 3 | **Appendix B** — Skills Registry | Available operators |
| 4 | **Part 3** — Prior brainstorm | Ideas and action plan |

Conflicts between Appendix A and Part 4 resolve via **ADR** (`docs/decisions/`), never silent merge.

## Loading Steps

1. Read the consolidated brainstorming file frontmatter `pending_from_braindump` for open items
2. Read Appendix A as read-only baseline standards
3. Open items route to research or ADR creation
4. Constitution conflicts → `docs/decisions/` with numbered ADR in MM-subject format

## Constitution Sections (Appendix A)

- Project Structure Philosophy
- Backend Architecture (layered, repository triad)
- Frontend Architecture (Next.js App Router, TanStack)
- Development Standards (async/await default)
- Testing Strategy (k6 for load testing)
- Documentation Strategy

When a file violates constitution, cite the specific appendix section and route to ADR.