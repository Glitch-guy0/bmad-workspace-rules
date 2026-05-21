# Mirror Docs Rules

How to structure and update docs/ based on Cat #3 (Mirror Docs Architecture).

## Layout Pattern

```
docs/
├── index.md                   # Hub linking to all docs
├── backend/
│   ├── index.md              # Service-specific docs
│   └── openapi.yaml          # Living OpenAPI spec
├── frontend/
│   └── index.md
├── [service]/
│   └── index.md
└── engineering/
    ├── index.md
    ├── coding-standards.md
    ├── testing-strategy.md
    ├── architecture.md
    └── deferred-decisions.md
```

## Mirror Update Rules

1. **Post-commit** (`git diff HEAD~1`): Only update docs for changed paths
2. **Surgical-strike** (brownfield): Diff-only, no full tree walk
3. **Re-baseline** (constitution changed): Re-align all mirror docs to new Appendix A

## Deviation Detection

When implementation diverges from Appendix A:
1. Flag the deviation with reference to constitution section
2. Create ADR in `docs/decisions/` for resolution
3. Update mirror docs to reflect resolved state

## File Naming

- Use kebab-case for markdown files
- `index.md` at each level as hub
- ADRs numbered: `001-subject.md`, `002-subject.md`