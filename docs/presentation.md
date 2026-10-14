# Capstone Walkthrough — 6-slide outline

1. **Problem:** multi-tenant commerce orders; integrity, tenant isolation, auditability and recovery.
2. **ER model:** tenants, users, products, orders and order items; explain tenant-aware foreign keys and checkout price snapshots.
3. **Architecture:** PostgreSQL durable source of truth; Redis ephemeral cart/cache; Flyway schema history.
4. **Migrations:** V1 core tables, V2 indexes, V3 audit/timestamps, V4 RLS, V5 synthetic seed data. Demonstrate a clean rebuild on a disposable database.
5. **Performance/security:** show actual before/after EXPLAIN output, buffers, data volume, RLS tests and least-privilege roles.
6. **Operations:** backup and restore into separate test DB, verify counts, explain trade-offs and lessons.

Live demo: start services, migrate disposable DB, query demo order, test RLS denial, show audit event, present measured query plans, restore backup.

Evidence note: successful migrations, RLS tests, restore and performance gains must be supported by actual run output; files alone are not proof.
