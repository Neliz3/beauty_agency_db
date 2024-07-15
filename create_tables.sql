CREATE DATABASE IF NOT EXISTS beauty_agency;

USE beauty_agency;

CREATE TABLE IF NOT EXISTS businesses
(
    id           varchar(36) NOT NULL,
    name         varchar(255),
    service_name varchar(255),
    password     varchar(128),
    field        varchar(10),

    PRIMARY KEY (id)
);

ALTER TABLE businesses
    COMMENT = 'Table to store business information';

ALTER TABLE businesses
    MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN name VARCHAR(255) COMMENT 'Name of a business',
    MODIFY COLUMN service_name VARCHAR(255) COMMENT 'List of services',
    MODIFY COLUMN password VARCHAR(128) COMMENT 'Password of a business user',
    MODIFY COLUMN field varchar(10) COMMENT 'field of a business';


CREATE TABLE IF NOT EXISTS cities
(
    id                 varchar(36) NOT NULL,
    city_name          varchar(50),

    PRIMARY KEY (id)
);

ALTER TABLE cities
    COMMENT = 'Table to store cities';

ALTER TABLE cities
    MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN city_name VARCHAR(50) COMMENT 'City name';


CREATE TABLE IF NOT EXISTS customers
(
    id                 varchar(36) NOT NULL,
    email              varchar(255),
    phone              varchar(20),
    password           varchar(128),
    age                smallint,
    city               varchar(50),

    PRIMARY KEY (id)
);

ALTER TABLE customers
    COMMENT = 'Table to store customer information and credentials';

ALTER TABLE customers
    MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN email VARCHAR(255) COMMENT 'Email of a customer',
    MODIFY COLUMN phone VARCHAR(20) COMMENT 'Phone of a customer',
    MODIFY COLUMN password VARCHAR(128) COMMENT 'Password of a customer',
    MODIFY COLUMN age smallint COMMENT 'Age of a customer',
    MODIFY COLUMN city VARCHAR(50) COMMENT 'City of a customer';

CREATE INDEX `city_name_index` ON cities (city_name);
ALTER TABLE customers ADD FOREIGN KEY (city) REFERENCES cities (city_name) ON DELETE CASCADE;


CREATE TABLE IF NOT EXISTS services
(
    id    varchar(36) NOT NULL,
    name  varchar(255),
    price decimal(10, 2),
    city  varchar(50),
    id_customer varchar(36),

    PRIMARY KEY (id)
);

ALTER TABLE services
    COMMENT = 'Table to store services information';

ALTER TABLE services
    MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN id_customer VARCHAR(36) COMMENT 'Unique identifier for each customer',
    MODIFY COLUMN name VARCHAR(255) COMMENT '   Title of a service',
    MODIFY COLUMN price decimal(10, 2) COMMENT 'Price of a service',
    MODIFY COLUMN city VARCHAR(50) COMMENT 'City of a service';

CREATE TABLE IF NOT EXISTS orders
(
    id           varchar(36) NOT NULL,
    customer_id  varchar(36),
    service_id   varchar(36),
    price        decimal(10, 2),
    order_number char(5),
    order_date   date,

    PRIMARY KEY (id)
);

ALTER TABLE orders
    COMMENT = 'Table to store orders information';

ALTER TABLE orders
    MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN customer_id VARCHAR(36) COMMENT 'Foreign key for customer',
    MODIFY COLUMN service_id VARCHAR(36) COMMENT 'Foreign key for a service',
    MODIFY COLUMN price DECIMAL(10, 2) COMMENT 'Price of the order',
    MODIFY COLUMN order_number CHAR(5) COMMENT 'Number of the order',
    MODIFY COLUMN order_date DATE COMMENT 'Date of the order accepting';

CREATE TABLE IF NOT EXISTS specialist
(
    id                 varchar(36) NOT NULL,
    first_name         varchar(50),
    last_name          varchar(50),
    email              varchar(255),
    phone              varchar(20),
    password           varchar(128),
    age                smallint,
    city               varchar(50),
    specialization     varchar(100),
    years_of_experience smallint,
    services_id varchar(36),
    business_id varchar(36),

    PRIMARY KEY (id)
);

ALTER TABLE specialist
    COMMENT = 'Table to store specialist information';

ALTER TABLE specialist
    MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN first_name varchar(50) COMMENT 'First_name of a specialist',
    MODIFY COLUMN last_name varchar(50) COMMENT 'Last_name of a specialist',
    MODIFY COLUMN email varchar(255) COMMENT 'Email of a specialist',
    MODIFY COLUMN phone varchar(20) COMMENT 'Phone of a specialist',
    MODIFY COLUMN password varchar(128) COMMENT 'Password of a specialist',
    MODIFY COLUMN age smallint COMMENT 'Age of a specialist',
    MODIFY COLUMN city varchar(50) COMMENT 'City of a specialist',
    MODIFY COLUMN specialization varchar(100) COMMENT 'Specialization of a specialist',
    MODIFY COLUMN years_of_experience smallint COMMENT 'Years of an experience of a specialist',
    MODIFY COLUMN services_id VARCHAR(36) COMMENT 'Unique identifier for services',
    MODIFY COLUMN business_id VARCHAR(36) COMMENT 'Unique identifier for a business';


ALTER TABLE specialist ADD FOREIGN KEY (city) REFERENCES cities (city_name) ON DELETE CASCADE;

# Table for many-to-many relationships
CREATE TABLE orders_services (
  orders_service_id varchar(36) NOT NULL,
  services_id varchar(36) NOT NULL,
  PRIMARY KEY (orders_service_id, services_id)
);

ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE;
ALTER TABLE orders ADD FOREIGN KEY (service_id) REFERENCES services (id) ON DELETE CASCADE;

ALTER TABLE orders_services ADD FOREIGN KEY (orders_service_id) REFERENCES orders (service_id);

ALTER TABLE orders_services ADD FOREIGN KEY (services_id) REFERENCES services (id);

CREATE INDEX `service_name_index` ON businesses(service_name);
ALTER TABLE services ADD FOREIGN KEY (name) REFERENCES businesses (service_name) ON DELETE CASCADE;

ALTER TABLE services ADD FOREIGN KEY (city) REFERENCES cities (city_name) ON DELETE CASCADE;


CREATE TABLE customers_services (
  customers_id varchar(36) NOT NULL,
  services_id_customer varchar(36) NOT NULL,
  PRIMARY KEY (customers_id, services_id_customer)
);

ALTER TABLE customers_services ADD FOREIGN KEY (customers_id) REFERENCES customers (id);

CREATE INDEX `id_customer` ON services(id_customer);
ALTER TABLE customers_services ADD FOREIGN KEY (services_id_customer) REFERENCES services (id_customer);

CREATE TABLE services_specialist (
  services_id varchar(36) NOT NULL,
  specialist_service_id varchar(36) NOT NULL,
  PRIMARY KEY (services_id, specialist_service_id)
);

ALTER TABLE services_specialist ADD FOREIGN KEY (services_id) REFERENCES services (id);

CREATE INDEX `services_id_index` ON specialist (services_id);
ALTER TABLE services_specialist ADD FOREIGN KEY (specialist_service_id) REFERENCES specialist (services_id);
