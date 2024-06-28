USE beauty_agency;

-- Administrator permissions
CREATE USER 'administrator'@'localhost' IDENTIFIED WITH mysql_native_password BY 'administrator123';
GRANT ALL PRIVILEGES ON beauty_agency.* TO 'administrator'@'localhost';

-- Support permissions
CREATE USER 'support'@'localhost' IDENTIFIED WITH mysql_native_password BY 'support132';
GRANT INSERT, UPDATE, SELECT, RELOAD ON beauty_agency.* TO 'support'@'localhost';

-- Manager permissions
CREATE USER 'manager'@'localhost' IDENTIFIED WITH mysql_native_password BY 'manager123';
GRANT SELECT ON beauty_agency.* TO 'manager'@'localhost';

-- reload changes
FLUSH PRIVILEGES;
