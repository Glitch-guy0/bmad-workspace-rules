# Research Backlog

Process open research topics from the research index.

## Priority Tiers

| Tier | Topics | Resolution Path |
|------|--------|-----------------|
| **P0** | R-01, R-07, R-08 | Skill anatomy + skeleton + ADRs |
| **P1** | R-02, R-03, R-04, R-09 | Data layer, testing, frontend, docs |
| **P2** | R-05, R-06, R-10, R-11, R-12 | Governance, UX polish |

## Processing Steps

1. Read `research-index.md` for priority and dependencies
2. Open the relevant `R-XX-*.md` brief before implementation
3. Record findings in the brief
4. Promote stable decisions to `docs/decisions/` or Appendix A via ADR
5. Update status in brief frontmatter and `pending_from_braindump`

## Status States

- `open` → Research in progress
- `in_progress` → Active investigation
- `closed` → Findings documented, ADR filed if needed

## Closing Criteria

- [ ] Research questions answered or explicitly deferred with trigger
- [ ] Findings section filled with evidence (links, snippets, directory trees)
- [ ] Recommended implementation captured (paths, file names, checklist)
- [ ] Consolidated brainstorm Part 2 row updated