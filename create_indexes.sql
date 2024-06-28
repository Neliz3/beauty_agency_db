CREATE INDEX `preference_service_index` ON `customers` (`preference_service`);

CREATE INDEX `price_index` ON `services` (`price`);

CREATE INDEX `customer_id_index` ON `orders` (`customer_id`);

CREATE INDEX `price_index` ON `orders` (`price`);

CREATE INDEX `type_index` ON `businesses` (`field`);
