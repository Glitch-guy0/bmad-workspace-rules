---
id: R-03
status: open
priority: P1
brainstorm_ref: 'Part 2 R-03; Cat #17; constitution: MUST use k6'
---

# R-03 — k6 per-layer load/performance grid

## Goal

Design `testing/load/{frontend,backend,microservices}/` so HTTP/load and perf testing match constitution requirements without one undifferentiated script folder.

## Research questions

| # | Question |
|---|----------|
| 1 | Protocol-only vs browser (k6 browser) per layer? |
| 2 | Shared thresholds and stages conventions? |
| 3 | How to run against local docker-compose vs staging? |
| 4 | CI integration — smoke vs full load gates? |
| 5 | Relationship to Jest/Playwright (unit/E2E) — no overlap confusion? |

## Findings (starter)

### Layer strategy

| Layer | Primary k6 mode | Measures | Example target |
|-------|-----------------|----------|----------------|
| **backend** | Protocol (HTTP) | API latency, throughput, error rate | `POST /api/auth/login` |
| **microservices** | Protocol | Service SLOs, dependency timeouts | Image-processing HTTP |
| **frontend** | Browser module (Chromium CDP) | Web vitals, render, critical flows | Login → dashboard |

**Hybrid pattern:** Protocol scripts for bulk load; browser scripts for UX-critical paths at lower VU count (Grafana k6 guidance).

### Proposed directory layout

```
testing/load/
├── README.md
├── shared/
│   ├── config.js           # base URLs per env
│   └── thresholds.js       # reusable threshold sets
├── backend/
│   └── auth-load.js
├── microservices/
│   └── image-processing-load.js
└── frontend/
    └── auth-flow.browser.js
```

### Frontend browser test sketch

```javascript
import { browser } from 'k6/browser';

export const options = {
  scenarios: {
    ui: {
      executor: 'shared-iterations',
      options: { browser: { type: 'chromium' } },
    },
  },
};

export default async function () {
  const page = await browser.newPage();
  await page.goto(__ENV.BASE_URL);
  // …interactions…
}
```

### Testing stack alignment (constitution)

| Level | Tool | Location |
|-------|------|----------|
| Unit | Jest | co-located `*.test.ts` |
| E2E | Playwright | `frontend/e2e/` |
| Load/Perf | k6 | `testing/load/**` |

## Spike plan

1. Port existing `auth-load.js` pattern from Appendix A into `testing/load/backend/`
2. Add minimal browser script under `frontend/` against local Next.js
3. Document env vars: `BASE_URL`, `API_URL`
4. Add npm scripts: `load:backend`, `load:frontend`, `load:all`

## Acceptance criteria

- [ ] Three layer folders exist with at least one sample script each
- [ ] README explains when to use protocol vs browser
- [ ] Thresholds documented (e.g. p95 &lt; 500ms for API)
- [ ] Constitution checklist item "k6 scaffolded" satisfied

## References

- [k6 browser tests](https://grafana.com/docs/k6/latest/using-k6-browser/running-browser-tests/)
- [Load testing websites guide](https://grafana.com/docs/k6/latest/testing-guides/load-testing-websites)
- Brainstorm Cat #17 k6 Perimeter Grid
