---
title: Prisma Multi-file Schema
status: draft
source: _bmad-output/research/R-02-prisma-schema-shards.md
---

# Prisma Multi-file Schema

Split monolithic `schema.prisma` into maintainable fragments compatible with migrations and `prisma generate`.

## Requirements

- Prisma v6.7.0+ for GA multi-file support
- `generator` and `datasource` blocks at schema root
- Migrations path resolution maintained

## Recommended Layout

```
backend/prisma/
├── schema.prisma          # generator + datasource only
├── models/
│   ├── user.prisma
│   ├── auth.prisma
│   └── ...
└── migrations/
```

## Configuration

**package.json:**
```json
{
  "prisma": { "schema": "./prisma" }
}
```

**prisma.config.ts (v7+):**
```ts
export default { schema: './prisma' }
```

## Commands

```bash
# Validate
npx prisma validate

# Generate
npx prisma generate

# Migrate
npx prisma migrate dev --schema ./prisma
```

## Rules

- `schema.prisma` (with `generator`) must sit at configured schema root
- Do not split `datasource` without verifying Prisma version behavior
- Map `repository/schemas/*.ts` deliberately — avoid duplicate definitions

## References

- Prisma multi-file schema blog
- Prisma schema location docs