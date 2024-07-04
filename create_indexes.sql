CREATE INDEX `price_index` ON services (price);

CREATE INDEX `name_index` ON services (name);

CREATE INDEX `city_index` ON services (city);

CREATE INDEX `price_order_index` ON orders (price);

CREATE INDEX `type_index` ON businesses (field);

CREATE INDEX `city_name_index` ON cities (city_name);

CREATE INDEX `city_specialist_index` ON specialist (city);

CREATE INDEX `city_customer_index` ON customers (city);
