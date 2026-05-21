---
title: k6 Load Testing Grid
status: draft
source: _bmad-output/research/R-03-k6-perimeter-grid.md
---

# k6 Load Testing Grid

k6 per-layer load/performance testing setup.

## Layer Strategy

| Layer | Primary k6 mode | Measures |
|-------|-----------------|----------|
| **backend** | Protocol (HTTP) | API latency, throughput, error rate |
| **microservices** | Protocol | Service SLOs, dependency timeouts |
| **frontend** | Browser module | Web vitals, render, critical flows |

## Directory Layout

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

## Backend Protocol Test

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 20 },
    { duration: '1m', target: 20 },
    { duration: '10s', target: 0 },
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],
  },
};

export default function () {
  const res = http.post(`${__ENV.API_URL}/auth/login`, {
    email: 'test@example.com',
    password: 'password123',
  });
  check(res, { 'status is 200': (r) => r.status === 200 });
  sleep(1);
}
```

## Frontend Browser Test

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
  // interactions...
}
```

## NPM Scripts

```json
{
  "scripts": {
    "load:backend": "k6 run testing/load/backend/*.js",
    "load:frontend": "k6 run testing/load/frontend/*.js",
    "load:all": "npm run load:backend && npm run load:frontend"
  }
}
```

## Thresholds

- API: p95 < 500ms
- Frontend: LCP < 2.5s