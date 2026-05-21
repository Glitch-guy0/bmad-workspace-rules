---
title: Utility Taxonomy
status: published
source: _bmad-output/research/R-05-utility-taxonomy.md
---

# Utility Taxonomy

Standardize when to use atomic helper functions vs static utility classes.

## Rules

| Rule | Detail |
|------|--------|
| Start atomic | One function per file until 3+ functions share a topic |
| Promote at ≥3 | Group into `TopicUtils` static class or `topic/` folder |
| Domain over generic | Prefer `auth/password.utils.ts` over mega `StringUtils` |
| No business logic | Utils are pure transforms; services own workflows |
| Max class size | < 150 lines; split by sub-topic if larger |

## Directory Layout

```
src/utils/
├── datetime/
│   ├── formatIso.ts
│   ├── parseSafe.ts
│   └── DateTimeUtils.ts    # after 3rd related helper
├── auth/
│   └── password.utils.ts
└── README.md
```

## Naming

- Atomic: `formatIso.ts`, `parseSafe.ts`
- Grouped: `DateTimeUtils.ts`, `AuthUtils.ts`
- Domain: `auth/password.utils.ts` over generic `StringUtils`

## Test Placement

- Co-located `*.test.ts` per utility file
- One test file per function/class