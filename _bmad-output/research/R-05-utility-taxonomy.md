---
id: R-05
status: open
priority: P2
brainstorm_ref: 'Part 2 R-05; Cat #20'
---

# R-05 — Utility / static class taxonomy

## Goal

Standardize when to use atomic helper functions vs static utility classes under `src/utils/`.

## Research questions

| # | Question |
|---|----------|
| 1 | Threshold for promotion (brainstorm: ≥3 related helpers)? |
| 2 | Naming: `DateUtils` vs `date.utils.ts` vs domain-specific modules? |
| 3 | Test placement — co-located `*.test.ts` per class? |
| 4 | Forbidden patterns (god static classes, cross-domain imports)? |

## Proposed rules (draft)

| Rule | Detail |
|------|--------|
| Start atomic | One function per file until 3+ functions share a topic |
| Promote at ≥3 | Group into `TopicUtils` static class or `topic/` folder |
| Domain over generic | Prefer `auth/password.utils.ts` over mega `StringUtils` |
| No business logic | Utils are pure transforms; services own workflows |
| Max class size | &lt; 150 lines; split by sub-topic if larger |

## Example

```
src/utils/datetime/
  formatIso.ts
  parseSafe.ts
  DateTimeUtils.ts    # appears after 3rd related helper
```

## Acceptance criteria

- [ ] `docs/engineering/utility-taxonomy.md` with examples
- [ ] ESLint or review checklist optional (not required for close)
- [ ] Greenfield scaffold creates `src/utils/` with README pointer

## References

- Brainstorm Cat #20 Util Static Class Taxonomy
- Appendix A — `utils/` in backend structure
