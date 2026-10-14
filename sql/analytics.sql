BEGIN;
SELECT set_config('app.tenant_id', '11111111-1111-4111-8111-111111111111', true);
SELECT id,status,total_amount,created_at FROM orders WHERE tenant_id='11111111-1111-4111-8111-111111111111' ORDER BY created_at DESC LIMIT 50;
SELECT date_trunc('day',created_at)::date AS order_day,status,count(*) AS order_count,sum(total_amount) AS gross_total FROM orders WHERE tenant_id='11111111-1111-4111-8111-111111111111' AND created_at >= now()-interval '30 days' GROUP BY 1,2 ORDER BY 1 DESC,2;
SELECT p.sku,p.name,sum(oi.quantity) AS units_sold,sum(oi.quantity*oi.unit_price) AS sales_value FROM order_items oi JOIN products p ON p.id=oi.product_id AND p.tenant_id=oi.tenant_id JOIN orders o ON o.id=oi.order_id AND o.tenant_id=oi.tenant_id WHERE oi.tenant_id='11111111-1111-4111-8111-111111111111' AND o.status IN ('paid','fulfilled') GROUP BY p.sku,p.name ORDER BY sales_value DESC;
COMMIT;
