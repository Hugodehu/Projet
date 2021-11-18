-- Script MYSQL
-- Création du compte Admin et des comptes utilisateurs (Sécurité)
-- Livrable 2 by SAVALLE Florian, DEHURTEVENT Hugo, GUEROULT Antoine, DELATOUR Alexandre


-- use projet_bdd;

-- ---------------------------------------------------------------------------------
-- Account creation 'Admin':
CREATE USER 'Admin'@'localhost' IDENTIFIED BY 'adminpassword';
GRANT GRANT OPTION ON *.* TO 'Admin'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'Admin'@'localhost';



-- ---------------------------------------------------------------------------------
-- Account creation 'Customer Management': 
CREATE USER 'Customer Management'@'localhost' IDENTIFIED BY 'customermanagementpassword';
GRANT UPDATE, INSERT, DELETE, SELECT ON Customer TO 'Customer Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Address TO 'Customer Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Staff TO 'Customer Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Reservation TO 'Customer Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Payment TO 'Customer Management'@'localhost';



-- ---------------------------------------------------------------------------------
-- Account creation 'Travel Management':
CREATE USER 'Travel Management'@'localhost' IDENTIFIED BY 'travelmanagementpassword';
GRANT UPDATE, INSERT, DELETE, SELECT ON Means_Transport TO 'Travel Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON City TO 'Travel Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Travel TO 'Travel Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Mileage TO 'Travel Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Step TO 'Travel Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON `use` TO 'Travel Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON `Stop` TO 'Travel Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Own TO 'Travel Management'@'localhost';
GRANT UPDATE, INSERT, DELETE, SELECT ON Move TO 'Travel Management'@'localhost';



-- ---------------------------------------------------------------------------------
-- Account creation 'Accounting':
CREATE USER 'Accounting'@'localhost' IDENTIFIED BY 'accountingpassword';
GRANT SELECT, CREATE VIEW, SHOW VIEW ON Payment TO 'Accounting'@'localhost';
GRANT SELECT, CREATE VIEW, SHOW VIEW ON Travel TO 'Accounting'@'localhost';
GRANT SELECT, CREATE VIEW, SHOW VIEW ON Reservation TO 'Accounting'@'localhost';
GRANT SELECT, CREATE VIEW, SHOW VIEW ON Customer TO 'Accounting'@'localhost';



-- ---------------------------------------------------------------------------------
-- Refreshing privileges:
FLUSH PRIVILEGES;


SELECT *
FROM mysql.user;