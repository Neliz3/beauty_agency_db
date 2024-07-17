USE beauty_agency;

/* view for a manager*/
CREATE OR REPLACE VIEW manager_view AS
SELECT
  services.name,
  count(orders.ID)
FROM services
JOIN orders ON orders.service_id = services.ID
GROUP BY services.name
;
