USE beauty_agency;

-- Administrator permissions
CREATE USER 'administrator'@'localhost' IDENTIFIED BY 'administrator123K@';
GRANT ALL PRIVILEGES ON beauty_agency.* TO 'administrator'@'localhost';

-- Support permissions
CREATE USER 'support'@'localhost' IDENTIFIED BY 'support123K@';
GRANT INSERT, UPDATE, SELECT, RELOAD ON beauty_agency.* TO 'support'@'localhost';

-- Manager permissions
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'manager123K@';
GRANT SELECT ON beauty_agency.* TO 'manager'@'localhost';

SHOW GRANTS FOR 'manager'@'localhost';

-- reload changes
FLUSH PRIVILEGES;
