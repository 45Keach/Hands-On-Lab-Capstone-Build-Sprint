CREATE INDEX idx_orders_tenant_created ON orders(tenant_id, created_at DESC);
CREATE INDEX idx_orders_tenant_status_created ON orders(tenant_id, status, created_at DESC);
CREATE INDEX idx_order_items_tenant_order ON order_items(tenant_id, order_id);
CREATE INDEX idx_order_items_tenant_product ON order_items(tenant_id, product_id);
CREATE INDEX idx_products_tenant_active_name ON products(tenant_id, active, name);
CREATE INDEX idx_audit_tenant_changed ON audit_log(tenant_id, changed_at DESC);
