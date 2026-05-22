You’re basically asking for a **modern backend engineering standards map** 🧠
Not “what libraries exist”, but:

> “What categories are considered normal/expected in a serious modern backend stack?”

That’s a very good framing.

Here’s a structured breakdown of the **current industry-standard concerns/patterns/components** for modern backend systems (2025–2026 era). I’ll separate them by domain so you can later attach your own architecture/coding rules.

---

# 🌐 Core Application Layer

## HTTP Server / Backend Framework

### Minimal server libs

* Express.js
* Fastify
* Hono
* Koa

### Opinionated frameworks

* NestJS
* AdonisJS

### Full-stack/meta frameworks

* Next.js
* Nuxt

---

# 🔌 API Communication Standards

## REST

Still dominant for:

* public APIs
* mobile backends
* integrations
* admin panels

Standards:

* OpenAPI / Swagger
* versioning
* pagination
* filtering
* idempotency
* rate limiting

---

## GraphQL

* GraphQL
* Apollo
* Mercurius
* Yoga

Common standards:

* schema-first
* federation
* persisted queries
* dataloader
* complexity limits

---

## Type-safe RPC

* tRPC

Modern startup-heavy ecosystem standard.

Usually:

* monorepo
* end-to-end TS inference
* React Query/TanStack Query

---

## gRPC

* gRPC
* Protocol Buffers
* internal services
* low latency systems

Mostly:

* microservices
* infra-heavy systems
* polyglot architecture

---

## Realtime

* WebSockets
* Server-Sent Events (SSE)
* WebRTC
* Socket.IO

Patterns:

* event-driven
* pub/sub
* presence systems

---

# 🗄️ Database Standards

## ORM

* Prisma
* TypeORM
* Drizzle ORM
* Sequelize

---

## ODM

* Mongoose

---

## Query Builders

* Kysely
* Knex
* SQLC
* Zapatos

Trend:

> teams moving toward “SQL-first” instead of magic ORM abstraction.

---

## Migration Standards

Expected:

* schema migrations
* seeders
* rollback support
* reproducible DB state
* migration CI validation

---

# 🧾 Validation / Serialization

## Validation

* Zod
* Joi
* Valibot
* Yup
* class-validator

Modern trend:

> shared runtime + type validation

Especially:

* request validation
* env validation
* DTO validation

---

## Serialization / Transformation

* class-transformer
* superjson
* protobuf
* msgpack

---

# 🔐 Authentication & Security

## Auth Standards

* JWT
* PASETO
* OAuth2
* OIDC
* session auth
* API keys

---

## Identity Providers

* Auth0
* Clerk
* Supabase
* Firebase
* Keycloak

---

## Security Standards

Expected now:

* RBAC
* ABAC
* CSRF protection
* CORS policy
* Helmet
* secret rotation
* rate limiting
* audit logging
* input sanitization
* dependency scanning
* SAST/DAST
* OWASP alignment

---

# 📜 Logging / Observability

## Logging

* Pino
* Winston

Modern standards:

* structured logs
* JSON logs
* correlation IDs
* request tracing

---

## Telemetry / Observability

* OpenTelemetry
* OTLP exporters

---

## Monitoring

* Prometheus
* Grafana
* Datadog
* New Relic

---

## Error Tracking

* Sentry
* Bugsnag

---

# ⚡ Async & Event Systems

## Queues

* BullMQ
* RabbitMQ
* SQS
* Kafka

---

## Event Streaming

* Apache Kafka
* Redpanda
* NATS

Patterns:

* event sourcing
* CQRS
* saga orchestration

---

# 🧠 Caching Standards

## Cache Systems

* Redis
* Memcached

Patterns:

* cache-aside
* write-through
* distributed cache
* request deduplication

---

# 🧪 Testing Standards

## Unit Testing

* Jest
* Vitest

---

## Integration Testing

* testcontainers
* supertest

---

## E2E Testing

* Playwright
* Cypress

---

## Contract Testing

* Pact
* schema validation
* OpenAPI validation

---

# 🏗️ Architecture Standards

## Common Architectural Patterns

You mentioned MVC already.

Modern patterns:

* MVC
* Clean Architecture
* Hexagonal Architecture
* Onion Architecture
* DDD
* Vertical Slice Architecture
* Modular Monolith
* Microservices
* Event-Driven Architecture

---

# 📦 Monorepo / Workspace Standards

## Monorepo Tooling

* Turborepo
* Nx
* pnpm workspaces

---

# 🚀 Deployment & Infrastructure

## Containers

* Docker

---

## Orchestration

* Kubernetes

---

## IaC

* Terraform
* Pulumi

---

## Serverless

* AWS Lambda
* Cloudflare Workers
* Vercel Functions

---

# 🔄 CI/CD Standards

## CI/CD

* GitHub Actions
* GitLab CI
* Jenkins

Standards:

* lint
* typecheck
* test gates
* security scan
* preview deploys
* semantic releases

---

# 🧹 Code Quality Standards

## Formatting / Linting

* ESLint
* Prettier
* Biome

---

## Git Standards

* conventional commits
* semantic versioning
* squash merge
* trunk-based development

---

## Hooks

* Husky
* lint-staged
* commitlint

---

# 📚 API Documentation Standards

## Docs

* Swagger/OpenAPI
* Redoc
* Scalar
* GraphQL Playground

---

# 🧩 Configuration Standards

## Config Management

Expected now:

* env validation
* typed config
* secrets manager
* layered config
* feature flags

Tools:

* dotenvx
* infisical
* vault

---

# ☁️ Cloud & Platform Standards

## Cloud Providers

* Amazon Web Services
* Google Cloud
* Microsoft Azure

---

# 📈 Emerging “Now Becoming Standard” Things

These are rapidly becoming expected in serious systems:

## AI/LLM Integration

* embeddings
* vector DBs
* RAG
* agent workflows
* AI observability
* prompt versioning

Tools:

* LangChain
* Mastra
* OpenAI SDK
* AI Gateway

---

## Platform Engineering

Internal developer platforms:

* Backstage
* golden paths
* templates
* self-service infra

---

## Supply Chain Security

* SBOM
* Sigstore
* provenance
* dependency pinning

---

# 🧭 What Mature Teams Usually Standardize

The actual “engineering standards” document usually defines:

| Area            | Example             |
| --------------- | ------------------- |
| Framework       | NestJS              |
| API style       | REST + OpenAPI      |
| Validation      | Zod                 |
| ORM             | Prisma              |
| Logging         | Pino + OTEL         |
| Testing         | Vitest + Playwright |
| Auth            | JWT/PASETO          |
| Queue           | BullMQ              |
| Infra           | Docker + K8s        |
| CI              | GitHub Actions      |
| Architecture    | Modular monolith    |
| Package manager | pnpm                |
| Monorepo        | Turborepo           |
| Formatting      | Biome               |
| Runtime         | Node.js/Bun         |

---

# 🔥 The Important Realization

A lot of juniors think:

> “standards = libraries”

But mature engineering teams define standards at **4 levels**:

| Level       | Example            |
| ----------- | ------------------ |
| Technology  | Prisma             |
| Pattern     | Repository Pattern |
| Process     | PR review rules    |
| Operational | observability/SLOs |

That distinction matters a lot when you later write your engineering handbook 👌
