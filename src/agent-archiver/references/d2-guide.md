---
name: d2-guide
description: Quick reference for authoring D2 diagrams in documentation
---

# D2 Diagramming Guide

Quick reference for writing `.d2` files. Render to SVG via `d2 input.d2 output.svg` or use the playground at https://play.d2lang.com.

## Core Syntax

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
| Direction (layout) | `direction: right` / `up` / `down` (default) / `left` |

## Shape Types

`rectangle` (default), `square`, `circle`, `oval`, `diamond`, `hexagon`, `parallelogram`, `cylinder`, `queue`, `page`, `package`, `step`, `callout`, `cloud`, `text`, `code`, `class`, `sql_table`, `sequence_diagram`, `stored_data`, `person`, `image`

## Connection Arrowheads

`triangle` (default), `arrow`, `diamond`, `circle`, `cf-one`, `cf-many`, `cf-one-required`, `cf-many-required`

## Containers

```d2
service: API Gateway {
  style.fill: "#e1f5fe"

  routes: Routes {
    shape: rectangle
  }

  middleware: Middleware {
    shape: rectangle
  }
}
```

## Sequence Diagrams

```d2
sequence: {
  shape: sequence_diagram

  client
  server
  db

  client -> server: POST /upload
  server -> db: INSERT
  db -> server: OK
  server -> client: 201 Created
}
```

## SQL Tables

```d2
users: {
  shape: sql_table
  id: int {constraint: primary_key}
  email: varchar(255) {constraint: unique}
  name: varchar(100)
  created_at: timestamp
}

posts: {
  shape: sql_table
  id: int {constraint: primary_key}
  user_id: int {constraint: foreign_key}
  title: varchar(200)
  body: text
}

users.posts -> posts.user_id
```

## Styling

```d2
shape: {
  style: {
    fill: blue
    stroke: "#333"
    stroke-width: 2
    stroke-dash: 4
    opacity: 0.9
    font-size: 16
    font-color: white
    bold: true
    italic: false
    border-radius: 5
    shadow: true
  }
}
```

## Layout Engines

- **dagre** — fast, hierarchical, bundled (default)
- **ELK** — directed graph, bundled, more layout options
- **TALA** — software-architecture specific, separate binary

## When to Use in Documentation

| Document Type | Suggested Diagram |
|---------------|-------------------|
| TDD | System context with new component highlighted |
| Milestone | User flow, state transitions |
| ADR | Architecture comparison, before/after |
| ERD | Entity relationships (sql_table shapes) |
| API Contract | Request/response flow |
| NFR Proposal | System boundary and affected components |
| Implementation Report | Deployment topology, data flow |

## Render Conventions

- Source `.d2` file checked into repo alongside the `.md` doc
- Rendered SVG committed at the same path
- Markdown embed: `![diagram](path/to/diagram.svg)`
- Watch mode during authoring: `d2 --watch diagram.d2 diagram.svg`
