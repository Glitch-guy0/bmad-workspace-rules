# Active Milestones

## 1. Enforce d2lang for visual documentation

**Goal:** Mandate [D2 (d2lang.com)](https://d2lang.com) as the standard diagramming language across all docs. Every diagram must be authored as a `.d2` file with a rendered SVG companion, so both coding agents (text) and users (visual) get the same information.

**Why:** Currently mentions "diagrams" generically with no tooling commitment. D2 is declarative, text-based, version-controllable, and generates SVG/PNG/PDF via CLI. It integrates with the existing "diagrams before prose" principle.

**What needs to change:**

### Files to update

| File | Changes |
|------|---------|
| `src/agent-archiver/references/workspace-rules.md` | Line 359: "diagrams before prose" → "d2lang diagrams before prose"; Line 304: "flow diagrams" → "d2lang flow diagrams"; Add Format Rule: "All diagrams use D2 language (`.d2` files rendered to SVG)" |
| `src/agent-archiver/references/template-forge.md` | Line 360: `System context: [diagram or description with new component highlighted]` → `System context: [d2lang diagram with new component highlighted]`; Add d2lang code block example in TDD template |
| `docs/_index.md` | Line 45: "diagrams before prose" → "d2lang diagrams before prose" |
| `docs/01-documentation-framework.md` | Line 59: "(diagram with new component highlighted)" → "(d2lang diagram with new component highlighted)"; Line 168: "flow diagrams" → "d2lang flow diagrams" |
| `docs/06-project-constitution.md` | Add "D2 Diagrams" section under Cross-Cutting Standards with syntax rules |
| New file: `src/agent-archiver/references/d2-guide.md` | D2 quick reference for the agent — shape types, connection operators, containers, sequence diagrams, SQL tables, styling, layout engines |

### D2 Quick Reference

| Concept | Syntax |
|---------|--------|
| Shape | `name` or `name: Label` |
| Directed connection | `a -> b` or `a -> b: label` |
| Bidirectional | `a <-> b` |
| Undirected line | `a -- b` |
| Container (nesting) | `parent: { child1; child2 }` |
| Dot nesting | `parent.child.grandchild` |
| Set shape type | `name.shape: oval` |
| Inline style | `name.style.fill: "#ff0000"` |
| Comment | `# single line comment` |
| Direction (layout) | `direction: right` / `up` / `down` |

**Shape types:** rectangle, square, circle, oval, diamond, hexagon, parallelogram, cylinder, queue, page, package, step, callout, cloud, text, code, class, sql_table, sequence_diagram, stored_data, person

**Layout engines:** dagre (default, bundled), ELK (bundled), TALA (separate binary)

**Output formats:** SVG, PNG, PDF

### Definition of Done

- [ ] All files above updated to reference d2lang explicitly
- [ ] D2 quick reference guide created
- [ ] Workspace-rules.md format section enforces "d2lang before prose"
- [ ] TDD template in template-forge.md uses d2lang code block for system context diagram

---

## 2. Constants as namespace-based abstract layer

**Goal:** Eliminate hardcoded string literals in code by introducing namespace-based constant objects. Access values via `Container.KEY` instead of raw strings.

**Why:** Hardcoded strings (headers, config keys, status values, error codes) are brittle, untraceable, and make refactoring risky. A named constant object provides autocomplete, single-source-of-truth, and grep-ability.

**Pattern:**
```typescript
// Definition — co-located with domain or in a shared constants/ directory
export const HeaderConstants = {
  APIKEY: 'x-api-key',
  TRACE_ID: 'x-trace-id',
  CONTENT_TYPE: 'content-type',
} as const;

// Usage — never raw strings
req.headers[HeaderConstants.APIKEY]  // instead of req.headers['x-api-key']
```

**Files to update:**

| File | Changes |
|------|---------|
| `docs/06-project-constitution.md` | Add "Constants Abstraction Pattern" section under Cross-Cutting Standards; Update AI Agent Coding Rules to require constant abstraction; Reference the pattern in the existing Naming Conventions table |
| `src/agent-archiver/references/workspace-rules.md` | Add Format Rule: "All string constants must be defined as named namespace objects — never inline" |

### Constants Pattern Rules

1. **Group by domain** — one constants file per domain area (`header.constants.ts`, `error.constants.ts`, `config.constants.ts`)
2. **Namespace object pattern** — `export const DomainConstants = { KEY: 'value' } as const;`
3. **`as const` assertion** — ensures literal types, enables autocomplete
4. **Access via bracket notation** — `obj[DomainConstants.KEY]` (for dynamic keys) or `obj.DomainConstants.KEY` (where applicable)
5. **No inline strings** — any string used more than once must be a constant. Any string that represents a protocol value (header name, status code, config key) must be a constant even if used once
6. **Environment variables** — access via `EnvConstants` wrapper, not `process.env` directly

### Definition of Done

- [ ] `docs/06-project-constitution.md` updated with Constants Abstraction Pattern section
- [ ] `src/agent-archiver/references/workspace-rules.md` updated with Format Rule for constants
- [ ] Existing hardcoded strings in agent-archiver scripts cataloged for future migration (non-blocking for this milestone)
- [ ] AI Agent Coding Rules in constitution reference the constant abstraction requirement
