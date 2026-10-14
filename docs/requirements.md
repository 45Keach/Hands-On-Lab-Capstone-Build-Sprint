# Requirements Summary — Multi-Tenant Commerce Orders

## Objective
Build a production-minded order-management database for multiple merchants. PostgreSQL is the source of truth for tenants, customers, catalog, orders, line items and audit history. Redis is optional short-lived cart/cache storage and is never authoritative for paid orders.

## Users and workflows
- Merchant staff manage their own catalog and orders.
- Customers browse active products, maintain a cart and place orders.
- Staff update order status; operators manage migrations, backups and audit review.

## Functional requirements
1. Isolate tenant records with tenant IDs and PostgreSQL row-level security (RLS).
2. Enforce non-negative prices and inventory quantities.
3. Record orders and line items, snapshotting unit price at checkout.
4. Support pending, paid, fulfilled and cancelled statuses.
5. Audit inserts, updates and deletes on products and orders.
6. Provide tenant order-history and revenue queries.
7. Build an empty database through ordered Flyway migrations.
8. Use Redis only for ephemeral cart/cache state with TTL and invalidation.
9. Back up the database and verify a restore.

## Quality constraints
UUID identifiers, timestamptz timestamps and numeric(12,2) money. Email and SKU are unique per tenant. App SQL must be parameterized; secrets are never committed. Tenant context is transaction-local and must come from authenticated application claims, not untrusted browser input. Performance claims require saved EXPLAIN (ANALYZE, BUFFERS) output from the target environment.

## Out of scope
Payment processing, tax/shipping integrations, production identity provider and web UI.

## Acceptance criteria
- Flyway clean migrate succeeds on a disposable empty database.
- All five migrations are ordered and tracked.
- Demo data and analytical queries work.
- Tenant isolation and audit behavior are tested.
- Before/after plans, backup output and restore verification are documented.
- A short architecture walkthrough is ready.

## Design review checkpoint — before SQL
Review docs/er-diagram.dbml in dbdiagram.io before approving the schema. Record reviewer, date, decisions and follow-up changes here or in a pull request.

| Reviewer | Date | Feedback |
|---|---|---|
| Pending | Pending | Obtain feedback before schema approval. |
