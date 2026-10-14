# NoSQL Decision — Redis

Redis is selected for optional shopping-cart state and short-lived product cache because frequent key-based updates and TTL expiry fit an in-memory key/value store. Example key namespace: cart:{tenant_id}:{customer_id}. Product cache keys must also include tenant identity.

PostgreSQL remains authoritative for products, inventory, orders and payment state. At checkout, re-read current prices and stock in a PostgreSQL transaction, validate cart contents, calculate totals server-side and persist order plus items atomically. Redis contents are untrusted and may expire or disappear. Invalidate or expire product cache after writes; use authentication, TLS, memory limits and monitoring in production.

MongoDB is not included because the current model is relational and benefits from foreign keys and transactions; no document-ingestion workload currently justifies a second durable store.
