USE beauty_agency;

-- view for analyzing customer preferences
CREATE OR REPLACE VIEW PREFERENCES
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
