---
id: R-02
status: closed
priority: P1
brainstorm_ref: 'Part 2 R-02; Cat #14; pending: Prisma shards'
---

# R-02 — Prisma multi-file schema + generator client

## Goal

Define how to split monolithic `schema.prisma` into maintainable fragments compatible with migrations and `prisma generate`.

## Research questions

| # | Question |
|---|----------|
| 1 | Minimum Prisma version for GA multi-file support? |
| 2 | Where must `generator` and `datasource` blocks live? |
| 3 | Folder layout: `prisma/schema/` vs `prisma/models/*.prisma`? |
| 4 | How do migrations paths resolve with sharded schema? |
| 5 | CI command changes (`--schema` flag, `package.json` prisma key)? |

## Findings (starter)

**GA status:** Multi-file schemas are GA in Prisma **v6.7.0+** (was preview `prismaSchemaFolder` in 5.15+).

**Recommended layout (align with Cat #14 + repository triad):**

```
backend/prisma/
├── schema.prisma          # generator + datasource only
├── models/
│   ├── user.prisma
│   ├── auth.prisma
│   └── ...
└── migrations/
```

**Configuration (pick one):**

```json
// package.json
"prisma": { "schema": "./prisma" }
```

```bash
npx prisma migrate dev --schema ./prisma
```

```ts
// prisma.config.ts (v7+ recommended)
export default { schema: './prisma' }
```

**Rules:**

- `schema.prisma` (with `generator`) and `migrations/` must sit at the configured schema root level
- Do not split `datasource` across files without verifying Prisma version behavior
- Map `repository/schemas/*.ts` to Prisma models deliberately — avoid duplicate definitions

## Spike plan

1. Create branch `spike/prisma-shards`
2. Split one domain (e.g. `User`) from monolith into `models/user.prisma`
3. Run `prisma validate`, `prisma generate`, `prisma migrate dev`
4. Document commands in `docs/engineering/prisma-multi-file-schema.md`

## Acceptance criteria

- [ ] Spike passes validate + generate + migrate on clean DB
- [ ] Engineering doc lists version pin and CI steps
- [ ] `pending_from_braindump` Prisma item closed in consolidated brainstorm
- [ ] `bmad-workspace-rules` greenfield scaffold includes sharded layout

## References

- [Prisma multi-file schema blog](https://www.prisma.io/blog/organize-your-prisma-schema-with-multi-file-support)
- [Prisma schema location docs](https://www.prisma.io/docs/orm/prisma-schema/overview/location)
- Brainstorm Cat #14 Prisma Shard Composer
