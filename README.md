# Hands-On Lab Capstone Build Sprint

Track: Multi-tenant commerce order management using PostgreSQL, Flyway and Redis.

## Contents
- docs/requirements.md: requirements summary and design-review checkpoint
- docs/er-diagram.dbml: ER diagram source for dbdiagram.io
- flyway/sql/V1__core_tables.sql through V5__seed_demo_data.sql: ordered schema migrations
- sql/analytics.sql: analytical queries
- docs/performance.md: measurement protocol and before/after template
- docs/nosql.md: Redis design rationale
- docs/security-and-operations.md: roles, RLS, audit, backup and restore
- docs/presentation.md: short walkthrough deck outline
- scripts/backup_restore_check.sh: backup and restore smoke test

## Local setup
1. Install Docker Compose, PostgreSQL client tools and Flyway.
2. Copy .env.example to .env and replace every placeholder.
3. Start local dependencies with docker compose up -d.
4. Create separate migration and application roles using docs/security-and-operations.md.
5. Review the ER model and collect design feedback before approving the schema.
6. On a disposable database only, run flyway -configFiles=flyway/conf/flyway.conf clean migrate.
7. Run sql/analytics.sql and capture real EXPLAIN (ANALYZE, BUFFERS) evidence as described in docs/performance.md.
8. Run scripts/backup_restore_check.sh with valid PostgreSQL credentials.

## Caveats
This repository contains implementation artifacts, not claims that migrations, benchmarks, RLS tests or restore tests have already been executed. Benchmark fields must be filled with actual results; no performance numbers are fabricated. Never run Flyway clean against production. Compose passwords are local-learning defaults only and must be replaced. PostgreSQL remains the durable source of truth; Redis is disposable cart/cache state.
