# Query Optimization Evidence

## Protocol
Use a representative dataset (target at least 100k orders and 500k order items). Record PostgreSQL version, hardware, row counts and cache state. Run each query several times and compare medians. Save literal EXPLAIN (ANALYZE, BUFFERS, SETTINGS) output before and after. Do not claim sample timings as production results.

## Q1: newest 50 orders for a tenant
1. QUERY: tenant order history ordered newest first.
2. BEFORE PLAN: pending measurement; capture with V1 only.
3. CHANGE: V2 adds idx_orders_tenant_created (tenant_id, created_at DESC), supporting equality filter and ordered retrieval.
4. AFTER PLAN: pending measurement after V2.
5. RESULT: enter actual elapsed time, buffers, rows and plan nodes. No timings are fabricated.

Command: EXPLAIN (ANALYZE, BUFFERS, SETTINGS) SELECT id,status,total_amount,created_at FROM orders WHERE tenant_id='11111111-1111-4111-8111-111111111111' ORDER BY created_at DESC LIMIT 50;

## Q2: revenue by day and status
1. QUERY: counts and gross total by day/status over 30 days.
2. BEFORE PLAN: pending.
3. CHANGE: compare baseline with idx_orders_tenant_created; test idx_orders_tenant_status_created only if the real predicate/workload benefits. Aggregation still reads qualifying rows.
4. AFTER PLAN: pending.
5. RESULT: fill using measured output; indexes are hypotheses until measured.

Environment/version: pending. Dataset row counts: demo only, not representative. Before/after output: pending.
