CREATE DATABASE IF NOT EXISTS beauty_agency;

USE beauty_agency;

CREATE TABLE IF NOT EXISTS businesses
(
    id           bigint NOT NULL AUTO_INCREMENT,
    name         varchar(255),
    service_name varchar(255) UNIQUE,
    password     varchar(128),
    field        varchar(10),

    PRIMARY KEY (id)
);

ALTER TABLE businesses
    COMMENT = 'Table to store business information';

ALTER TABLE businesses
    MODIFY COLUMN ID BIGINT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN name VARCHAR(255) COMMENT 'Name of a business',
    MODIFY COLUMN service_name VARCHAR(255) COMMENT 'List of services',
    MODIFY COLUMN password VARCHAR(128) COMMENT 'Password of a business user',
    MODIFY COLUMN field varchar(10) COMMENT 'field of a business';


CREATE TABLE IF NOT EXISTS cities
(
    id                 bigint NOT NULL AUTO_INCREMENT,
    city_name          varchar(50),

    PRIMARY KEY (id)
);

ALTER TABLE cities
    COMMENT = 'Table to store cities';

ALTER TABLE cities
    MODIFY COLUMN ID BIGINT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN city_name VARCHAR(50) COMMENT 'City name';


CREATE TABLE IF NOT EXISTS customers
(
    id                 bigint NOT NULL AUTO_INCREMENT,
    email              varchar(255),
    phone              varchar(20),
    password           varchar(128),
    age                smallint,
    city               varchar(50),

    PRIMARY KEY (id),
    FOREIGN KEY (city) REFERENCES cities (city_name) ON DELETE CASCADE
);

ALTER TABLE customers
    COMMENT = 'Table to store customer information and credentials';

ALTER TABLE customers
    MODIFY COLUMN ID BIGINT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN email VARCHAR(255) COMMENT 'Email of a customer',
    MODIFY COLUMN phone VARCHAR(20) COMMENT 'Phone of a customer',
    MODIFY COLUMN password VARCHAR(128) COMMENT 'Password of a customer',
    MODIFY COLUMN age smallint COMMENT 'Age of a customer',
    MODIFY COLUMN city VARCHAR(50) COMMENT 'City of a customer';


CREATE TABLE IF NOT EXISTS services
(
    id    bigint NOT NULL AUTO_INCREMENT,
    name  varchar(255),
    price decimal(10, 2),
    city  varchar(50),
    id_customer bigint,

    PRIMARY KEY (id),

    FOREIGN KEY (name) REFERENCES businesses (service_name)
    ON DELETE CASCADE,
    FOREIGN KEY (city) REFERENCES cities (city_name)
    ON DELETE CASCADE
);

ALTER TABLE services
    COMMENT = 'Table to store services information';

ALTER TABLE services
    MODIFY COLUMN ID BIGINT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN id_customer BIGINT COMMENT 'Unique identifier for each customer',
    MODIFY COLUMN name VARCHAR(255) COMMENT '   Title of a service',
    MODIFY COLUMN price decimal(10, 2) COMMENT 'Price of a service',
    MODIFY COLUMN city VARCHAR(50) COMMENT 'City of a service';


CREATE TABLE IF NOT EXISTS orders
(
    id           bigint NOT NULL AUTO_INCREMENT,
    customer_id  bigint,
    service_id   bigint,
    price        decimal(10, 2),
    order_number char(5),
    order_date   date,

    PRIMARY KEY (id),

    FOREIGN KEY (customer_id) REFERENCES customers (id)
        ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services (id)
        ON DELETE CASCADE
);

ALTER TABLE orders
    COMMENT = 'Table to store orders information';

ALTER TABLE orders
    MODIFY COLUMN ID BIGINT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN customer_id BIGINT COMMENT 'Foreign key for customer',
    MODIFY COLUMN service_id BIGINT COMMENT 'Foreign key for a service',
    MODIFY COLUMN price DECIMAL(10, 2) COMMENT 'Price of the order',
    MODIFY COLUMN order_number CHAR(5) COMMENT 'Number of the order',
    MODIFY COLUMN order_date DATE COMMENT 'Date of the order accepting';


CREATE TABLE IF NOT EXISTS specialist
(
    id                 bigint NOT NULL AUTO_INCREMENT,
    first_name         varchar(50),
    last_name          varchar(50),
    email              varchar(255),
    phone              varchar(20),
    password           varchar(128),
    age                smallint,
    city               varchar(50),
    specialization     varchar(100),
    years_of_experience smallint,
    services_id bigint,
    business_id bigint,

    PRIMARY KEY (id),

    FOREIGN KEY (city) REFERENCES cities (city_name)
    ON DELETE CASCADE,
    CONSTRAINT fk_business_specialist FOREIGN KEY (business_id) REFERENCES businesses(id)
);

ALTER TABLE specialist
    COMMENT = 'Table to store specialist information';

ALTER TABLE specialist
    MODIFY COLUMN ID BIGINT COMMENT 'Unique identifier for each entry',
    MODIFY COLUMN first_name varchar(50) COMMENT 'First_name of a specialist',
    MODIFY COLUMN last_name varchar(50) COMMENT 'Last_name of a specialist',
    MODIFY COLUMN email varchar(255) COMMENT 'Email of a specialist',
    MODIFY COLUMN phone varchar(20) COMMENT 'Phone of a specialist',
    MODIFY COLUMN password varchar(128) COMMENT 'Password of a specialist',
    MODIFY COLUMN age smallint COMMENT 'Age of a specialist',
    MODIFY COLUMN city varchar(50) COMMENT 'City of a specialist',
    MODIFY COLUMN specialization varchar(100) COMMENT 'Specialization of a specialist',
    MODIFY COLUMN years_of_experience smallint COMMENT 'Years of an experience of a specialist',
    MODIFY COLUMN services_id BIGINT COMMENT 'Unique identifier for services',
    MODIFY COLUMN business_id BIGINT COMMENT 'Unique identifier for a business';
