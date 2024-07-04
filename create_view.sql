USE beauty_agency;

-- view for a customer
CREATE OR REPLACE VIEW
AS
EXPLAIN ANALYZE SELECT
  services.name,
  customers.age,
  count(orders.ID)
FROM customers
JOIN services
  ON services.id = customers.preference_service
JOIN orders
  ON orders.service_id = services.ID
;
