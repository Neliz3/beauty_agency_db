USE beauty_agency;

CREATE TABLE IF NOT EXISTS `businesses`
(
    `id`           int PRIMARY KEY AUTO_INCREMENT,
    `name`         varchar(255),
    `service_name` varchar(255) UNIQUE,
    `password`     varchar(128),
    `field`        varchar(10)
);

ALTER TABLE businesses
    COMMENT = 'Table to store business information';

ALTER TABLE businesses
    MODIFY COLUMN ID INT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN name VARCHAR(255) COMMENT 'Name of a business',
    MODIFY COLUMN service_name VARCHAR(255) COMMENT 'List of services',
    MODIFY COLUMN password VARCHAR(128) COMMENT 'Password of a business user',
    MODIFY COLUMN field varchar(10) COMMENT 'field of a business';


CREATE TABLE IF NOT EXISTS `customers`
(
    `id`                 int PRIMARY KEY AUTO_INCREMENT,
    `email`              varchar(255),
    `phone`              varchar(20),
    `password`           varchar(128),
    `age`                smallint,
    `preference_service` int UNIQUE
);

ALTER TABLE customers
    COMMENT = 'Table to store customer information and credentials';

ALTER TABLE customers
    MODIFY COLUMN ID INT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN email VARCHAR(255) COMMENT 'Email of a customer',
    MODIFY COLUMN phone VARCHAR(20) COMMENT 'Phone of a customer',
    MODIFY COLUMN password VARCHAR(128) COMMENT 'Password of a customer',
    MODIFY COLUMN age smallint COMMENT 'Age of a customer',
    MODIFY COLUMN preference_service INT COMMENT 'Foreign key for services_id';


CREATE TABLE IF NOT EXISTS `services`
(
    `id`    int PRIMARY KEY AUTO_INCREMENT,
    `name`  varchar(255),
    `price` decimal(10, 2),

    FOREIGN KEY (`name`) REFERENCES `businesses` (`service_name`)
        ON DELETE CASCADE
);

ALTER TABLE services
    COMMENT = 'Table to store services information';

ALTER TABLE services
    MODIFY COLUMN ID INT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN name VARCHAR(255) COMMENT '   Title of a service',
    MODIFY COLUMN price decimal(10, 2) COMMENT 'Price of a service';


CREATE TABLE IF NOT EXISTS `orders`
(
    `id`           int PRIMARY KEY AUTO_INCREMENT,
    `customer_id`  int,
    `service_id`   int,
    `price`        decimal(10, 2),
    `order_number` char(5),

    FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
        ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
        ON DELETE CASCADE
);

ALTER TABLE orders
    COMMENT = 'Table to store orders information';

ALTER TABLE orders
    MODIFY COLUMN ID INT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN customer_id int COMMENT 'Foreign key for customer',
    MODIFY COLUMN service_id int COMMENT 'Foreign key for a service',
    MODIFY COLUMN price decimal(10, 2) COMMENT 'Price of the order',
    MODIFY COLUMN order_number char(5) COMMENT 'Number of the order';


# Table to store many-to-many customers-services relationships
CREATE TABLE IF NOT EXISTS `customers_services`
(
    `customers_services_id` int PRIMARY KEY AUTO_INCREMENT,
    `services_id`                  int,
    `preference_service`           int,

    FOREIGN KEY (`preference_service`) REFERENCES `customers` (`preference_service`),
    FOREIGN KEY (`services_id`) REFERENCES `services` (`id`)
);

ALTER TABLE customers_services
    COMMENT = 'Table to store many-to-many customers-services relationships';

ALTER TABLE customers_services
    MODIFY COLUMN customers_services_id INT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN services_id INT COMMENT 'Identifier for services table',
    MODIFY COLUMN preference_service INT COMMENT 'Identifier for customer preferences';
