-- Script MYSQL
-- Création des Tables et données
-- -- Livrable 2 by SAVALLE Florian, DEHURTEVENT Hugo, GUEROULT Antoine, DELATOUR Alexandre


-- create database Projet_BDD;
-- use Projet_BDD;

-- ------------------------------------------------------------------------------------------------------------------

-- Table creation Address :
create table if not exists `Address` (
id_address INT NOT NULL AUTO_INCREMENT,
Lane_Number INT NOT NULL,
Street_Name VARCHAR(50),
Name_Residence VARCHAR(50),
Building_Name VARCHAR(50),
Floor VARCHAR(5),
Postal_Code VARCHAR(10),
City VARCHAR(50),
Type_Address VARCHAR(50),
PRIMARY KEY (id_address)
);

-- Insert data into the table Address :
INSERT INTO Address (Lane_Number, Street_Name, Name_Residence, Building_Name, Floor, Postal_Code, City, Type_Address) 
	VALUES
		  (4,'Boulevard de Gimenez', '' , '' , '0' ,  '75680', 'Paris' , 'Personal'),
 		  (22, 'Rue Du Haut des Cours', '', '', '0', '13348', 'Marseille', 'Personal'),
 		  (730, 'Rue Blanchâtre', '', '', '2', '76000', 'Rouen', 'Personal'), 
 		  (42, 'Avenue Charlot', '', '', '1', '59800', 'Lille', 'Personal'),
 		  (55, 'Chemin Grés Froid', 'Immeuble des Flôts Bleus', 'C5', '5', '75680', 'Paris', 'Personal'), 
 		  (238, 'Rue Du Lève-Tôt', '', '', '0', '13348', 'Marseille', 'Personal'),
 		  (13, 'Avenue Malchance', '', '', '1', '44321', 'Nantes', 'Personal'),
 		  (145, 'Rue des Olives', 'Résidence du Rouvray', '', '2', '33800', 'Bordeaux', 'Personal'),
 		  (481, 'Route du Croissant', '', '', '0', '75680', 'Paris', 'Personal'),
 		  (90, 'Boulevard du Noyer', '', '', '1', '13348', 'Marseille', 'Personal'),
 		  (49, 'Rue de Mémoire', 'Appartements Mesa', 'H2', '4', '33800', 'Bordeaux', 'Billing'),
 		  (26, 'Chemin des Peupliers', '', '', '3', '75680', 'Paris', 'Billing'),
 		  (58, 'Route de la Baie', 'Tour Niquet', 'BR1', '9', '76000', 'Rouen', 'Billing'),
 		  (232, "Boulevard d'Héritage", 'Maison Palma', 'A','1','21000', 'Dijon', 'Billing'),
 		  (850, 'Voie des Biches', '', '', '2', '13348', 'Marseille', 'Billing'),
 		  (192, "Rue de l'Usine", '', 'C5', '5', '20167', 'Ajaccio', 'Billing'), 
 		  (91, 'Route de Diamant', 'Appartements Monroe', '', '6', '69009', 'Lyon', 'Billing'), 
 		  (233, 'Rue de Clarté', 'Résidence Fleuroe', '', '1', '75680', 'Paris', 'Billing'), 
 		  (251, 'Chemin de la lune', '', '', '1', '44321', 'Nantes', 'Billing'),
 		  (476, 'Boulevard des Balais', 'Maison Brossard', '', '2', '75680', 'Paris', 'Billing'),
 		  (16, 'Rue des Séquoias', '', '', '0', '13348', 'Malchance', 'Delivery'),
 		  (317, 'Rue des Castors', '', '', '0', '69009', 'Lyon', 'Delivery'),
 		  (31, 'Boulevard des Vergers', '', '', '0', '13348', 'Marseille', 'Delivery'),
 		  (89, 'Voie du Colonel', 'Résidence Leclerc', '7', '2', '75680', 'Paris', 'Delivery'),
 		  (3, 'Boulevard des Quais', '', '', '1', '75680', 'Paris', 'Delivery'),
 		  (32, 'Rue du Pont', '', '', '0', '33800', 'Bordeaux', 'Delivery'),
 		  (61, 'Rue des Maçons', 'Résidence des Canidés', 'K9', '3', '13348', 'Marseille', 'Delivery'),
 		  (26, 'Rue de la Rive', '', '', '0', '21000', 'Dijon', 'Delivery'),
 		  (11, 'Boulevard des Génévriers', '', '', '1', '75680', 'Paris', 'Delivery'),
 		  (53, 'Rue du Forgeron', '', 'BO5', '2', '76000', 'Rouen', 'Delivery');

Select * from Address;



-- ---------------------------------------------------------------------------------------------

-- Table creation Staff :
create table if not exists `Staff` (
id_Staff INT NOT NULL AUTO_INCREMENT,
Name VARCHAR(30),
First_Name VARCHAR(30),
Phone_Number VARCHAR(18),
Company_Mail VARCHAR(50),
Hiring_Date DATE NOT NULL,
Birth_Date DATE NOT NULL,
id_address INT NOT NULL,
FOREIGN KEY (id_address) REFERENCES Address(id_address),
PRIMARY KEY (id_Staff)
);

-- Insert data into the table Staff :
INSERT INTO Staff (Name, First_Name, Phone_Number, Company_Mail, Hiring_Date, Birth_Date, id_address)
	VALUES
		  ('Valentine', 'Devaux', '0175359917', 'valentine.devaux@viacesi.fr', '2018-01-10', '1999-02-20', 1),
		  ('Valentin', 'Migel', '0635214895', 'valentin.migel@viacesi.fr', '2002-02-12', '1980-12-30', 2),
		  ('Suzanne', 'Robert', '0673382381', 'suzanne.robert@viacesi.fr','2017-10-05', '1990-10-13', 3),
		  ('Agathe', 'Vidal', '0683172299', 'agathe.vidal@viacesi.fr', '2006-04-14', '1983-06-03', 4),
		  ('David', 'Regnier', '0753958289', 'david.regnier@viacesi.fr', '2017-09-06', '1991-05-19', 5),
		  ('Matthieu', 'Pâter', '0649260994', 'matthieu.pater@viacesi.fr', '2015-06-06', '1980-03-30', 6),
		  ('Antoinette', 'Ledoux', '0506153913', 'antoinette.ledoux@viacesi.fr', '1996-05-15', '1969-11-29', 7),
		  ('Valérie', 'Carre', '0676063808', 'valerie.carre@viacesi.fr', '1998-04-29', '1970-12-29', 8),
		  ('Grégoire', 'Croix', '0165481276', 'gregoire.croix@viacesi.fr', '2000-09-14', '1986-07-15', 9),
		  ('Roland', 'Barre', '0680122632', 'roland.barre@viacesi.fr', '2000-02-18', '1976-10-19', 10);

Select * from Staff;



-- -----------------------------------------------------------------------------------------------------

-- Table creation Mileage :
create table if not exists `Mileage` (
id_Mileage INT NOT NULL AUTO_INCREMENT,
Pass FLOAT NOT NULL,
Total_Kilometers FLOAT NOT NULL,
PRIMARY KEY (id_Mileage)
);

-- Insert data into the table Mileage :
INSERT INTO Mileage (Pass, Total_Kilometers)
	VALUES
		  ('10.00', '433'),
		  ('15.00', '825'),
		  ('0.00', '207'),
		  ('0.00', '353'),
		  ('0.00', '266'),
		  ('20.00', '0');

Select * from Mileage;



-- -----------------------------------------------------------------------------------------------------

-- Table creation Means_Transport :
create table if not exists `Means_Transport` (
id_Means_Transport INT NOT NULL AUTO_INCREMENT,
Average_Type VARCHAR(50),
`Price/km` FLOAT NOT NULL,
PRIMARY KEY (id_Means_Transport)
);

-- Insert data into the table Means_Transport :
INSERT INTO Means_Transport (Average_Type, `Price/km`)
	VALUES
		  ('Train', '0.18'),
		  ('Bateau', '0.80'),
		  ('Bus', '0.50'),
		  ('Avion', '0.22');

Select * from Means_Transport;



-- -------------------------------------------------------------------------------------------------

-- Table creation City :
create table if not exists `City` (
id_City INT NOT NULL AUTO_INCREMENT,
Name VARCHAR(50),
Transport_Accessibility VARCHAR(50),
Country_City VARCHAR(50),
Department_Number VARCHAR(2),
Postal_Code VARCHAR(10),
PRIMARY KEY (id_City)
);

-- Insert data into the table City :
INSERT INTO City (Name, Transport_Accessibility, Country_City, Department_Number, Postal_Code)
	VALUES
		  ('Paris', 'Bus, Train, Avion', 'France', '75', '75680'),
		  ('Marseille', 'Bus, Train, Avion, Bateau', 'France', '13', '13348'),
		  ('Lyon', 'Bus, Train, Avion', 'France', '69', '69009'),
		  ('Rouen', 'Bus, Train', 'France', '76', '76000'),
		  ('Le Havre', 'Bus, Train', 'France', '76', '76310'),
		  ('Dijon', 'Bus, Train', 'France', '21','21000'),
		  ('Toulon', 'Bus, Train, Bateau', 'France', '83', '83000'),
		  ('Ajaccio', 'Avion, Bateau', 'France', '20', '20167'),
		  ('Lille', 'Bus, Train', 'France', '59', '59800'),
		  ('Bordeaux', 'Bus, Train, Avion', 'France', '33', '33800'),
		  ('Nantes', 'Bus, Train, Avion', 'France', '44', '44321');

Select * from City;



-- ------------------------------------------------------------------------------------------------

-- Table creation Step :
create table if not exists `Step` (
id_Step INT NOT NULL AUTO_INCREMENT,
Progress VARCHAR(4),
Date_Departure DATE NOT NULL,
Time_Departure TIME NOT NULL,
Date_Arrival DATE NOT NULL,
Time_Arrival TIME NOT NULL,
City_Departure VARCHAR(40),
id_City_Departure INT NOT NULL,
City_Arrival VARCHAR(40),
id_City_Arrival INT NOT NULL,
Kilometers_Step FLOAT NOT NULL,
FOREIGN KEY (id_City_Departure) REFERENCES City(id_City),
FOREIGN KEY (id_City_Arrival) REFERENCES City(id_City),
PRIMARY KEY (id_Step)
);

-- Insert data into the table Step :
INSERT INTO Step (Progress, Date_Departure, Time_Departure, Date_Arrival, Time_Arrival, City_Departure, id_City_Departure, City_Arrival,id_City_Arrival, Kilometers_Step)
	VALUES 
          ('0:2', '2020-09-15', '12:30:00', '2020-09-15', '14:30:00', 'Lyon', 3 , 'Dijon', 6 , 174),
          ('1:2', '2020-09-15', '14:35:00', '2020-09-15', '15:00:00', 'Dijon', 6, 'Dijon', 6, 7 ),
          ('2:2', '2020-09-15', '15:00:00', '2020-09-15', '18:40:00', 'Dijon', 6, 'Paris', 1, 259),
          ('0:1', '2021-04-09', '23:20:00', '2020-04-10', '00:00:00', 'Marseille', 2 , 'Lille', 9 ,825),
          ('1:1', '2021-04-10', '00:20:00', '2020-04-10', '00:55:00', 'Lille', 9 , 'Lille', 9, 11),
          ('0:1', '2021-01-02', '09:30:00', '2021-01-02', '10:50:00', 'Le Havre', 5 , 'Rouen', 4 , 70),
          ('1:1', '2021-01-02', '12:10:00', '2021-01-02', '14:50:00', 'Rouen', 4, 'Paris', 1, 137),
          ('0:0', '2020-11-26', '10:00:00', '2020-11-26', '16:22:00', 'Toulon', 7 , 'Ajaccio', 8 , 266),
          ('0:0', '2021-03-28', '21:40:00', '2021-03-29', '00:25:00', 'Bordeaux', 10 , 'Nantes', 11 , 266), 
          ('0:0', '2021-05-17', '10:00:00', '2021-05-17', '11:10:00', 'Paris', 1, 'Paris', 1 , 26);

Select * from Step;



-- --------------------------------------------------------------------------------------------

-- Table creation Own :
create table if not exists `Own` (
id_City INT NOT NULL,
id_Means_Transport INT NOT NULL,
FOREIGN KEY (id_City) REFERENCES City(id_City),
FOREIGN KEY (id_Means_Transport) REFERENCES Means_Transport(id_Means_Transport),
PRIMARY KEY (id_City, id_Means_Transport)
);

-- Insert data into the table Own :
INSERT INTO Own (id_City, id_Means_Transport)
	VALUES
          (1,3),
          (1,1),
          (1,4),
          (2,1),
          (2,2),
          (2,3),
          (2,4),
          (3,1),
          (3,3),
          (3,4),
          (4,1),
          (4,3),
          (5,1),
          (5,3),
          (6,1),
          (6,3),
          (7,1),
          (7,2),
          (7,3),
          (8,2),
          (8,4),
          (9,1),
          (9,3),
          (10,1),
          (10,3),
          (10,4),
          (11,1),
          (11,3),
          (11,4);

Select * from Own;



-- -----------------------------------------------------------------------------------------------------

-- Table creation Move :
create table if not exists `Move` (
id_Step INT NOT NULL,
id_Means_Transport INT NOT NULL,
FOREIGN KEY (id_Step) REFERENCES Step(id_Step),
FOREIGN KEY (id_Means_Transport) REFERENCES Means_Transport(id_Means_Transport),
PRIMARY KEY (id_Step, id_Means_Transport)
);

-- Insert data into the table Move :
INSERT INTO Move (id_Step, id_Means_Transport)
	VALUES
          (1,1),
          (2,3),
          (3,3),
          (4,4),
          (5,3),
          (6,1),
          (7,3),
          (8,2),
          (9,3),
          (10,1);

Select * from Move;



-- ------------------------------------------------------------------------------------------------------

-- Table creation Travel :
create table if not exists `Travel` (
id_Travel INT NOT NULL AUTO_INCREMENT,
Name VARCHAR(50),
Date_Departure DATE NOT NULL,
Departure_Time TIME NOT NULL,
Date_Arrived DATE NOT NULL,
Time_Arrived TIME NOT NULL,
City_Departure VARCHAR(40),
id_City_Departure INT NOT NULL,
City_Arrival VARCHAR(40),
id_City_Arrive INT NOT NULL,
Number_Steps INT NOT NULL,
id_Mileage INT NOT NULL,
FOREIGN KEY (id_City_Departure) REFERENCES City(id_City),
FOREIGN KEY (id_Mileage) REFERENCES Mileage(id_Mileage),
FOREIGN KEY (id_City_Arrive) REFERENCES City(id_City),
PRIMARY KEY (id_Travel)
);

-- Insert data into the table Travel :
INSERT INTO Travel (Name, Date_Departure, Departure_Time, Date_Arrived, Time_Arrived, City_Departure, id_City_Departure, City_Arrival, id_City_Arrive, Number_Steps, id_Mileage)
	VALUES
          ('Lyon-Paris', '2020-09-15', '12:30:00', '2020-09-15', '18:40:00', 'Lyon', 3, 'Paris', 1, '3', 1),
          ('Marseille-Lille', '2021-04-09', '23:20:00', '2021-04-10', '00:55:00', 'Marseille', 2, 'Lille', 9, 2 ,2),
          ('Le Havre-Paris', '2021-01-02', '09:30:00', '2021-01-02', '14:50:00', 'Le Havre', 5, 'Paris', 1, 2, 3),
          ('Bordeaux-Nantes', '2021-03-28', '21:40:00', '2021-03-09', '00:25:00', 'Bordeaux', 10, 'Nantes', 11, 1, 4),
          ('Toulon-Ajaccio', '2020-11-26', '10:00:00', '2020-11-26', '16:22:00', 'Toulon', 7, 'Ajaccio', 8, 1, 5),
          ('Paris-Paris', '2021-05-17','10:00:00', '2021-05-17', '11:10:00', 'Paris', 1, 'Paris', 1, 1, 6);

Select * from Travel;



-- ---------------------------------------------------------------------------------------------

-- Table creation Use :
create table if not exists `Use` (
id_Travel INT NOT NULL,
id_Means_Transport INT NOT NULL,
FOREIGN KEY (id_Travel) REFERENCES Travel(id_Travel),
FOREIGN KEY (id_Means_Transport) REFERENCES Means_Transport(id_Means_Transport),
PRIMARY KEY (id_Travel, id_Means_Transport)
);

-- Insert data into the table Use :
INSERT INTO `Use`(id_Travel, id_Means_Transport)
	VALUES
          (1,1),
          (1,3),
          (2,4),
          (2,3),
          (3,1),
          (3,3),
          (4,2),
          (5,3),
          (6,1);

Select * from `Use`;



-- ---------------------------------------------------------------------------------------------------

-- Table creation Stop :
create table if not exists `Stop` (
id_Travel INT NOT NULL,
id_Step INT NOT NULL,
FOREIGN KEY (id_Travel) REFERENCES Travel(id_Travel),
FOREIGN KEY (id_Step) REFERENCES Step(id_Step),
PRIMARY KEY (id_Travel, id_Step)
);

-- Insert data into the table Stop :
INSERT INTO Stop(id_Travel, id_Step)
	VALUES 
          (1,1),
          (1,2),
          (1,3),
          (2,4),
          (2,5),
          (3,6),
          (3,7),
          (4,8),
          (5,9),
          (6,10);

Select * from Stop;



-- ---------------------------------------------------------------------------------

-- Table creation Reservation :
create table if not exists `Reservation` (
id_Reservation INT NOT NULL AUTO_INCREMENT,
`Date` DATE NOT NULL,
Number_Place INT NOT NULL,
Number_Children_M int not null, 
Number_Children_F int not null, 
Number_Adults_M int not null,
Number_Adults_F int not null,  
Number_Senior_M int not null, 
Number_Senior_F int not null, 
id_Travel INT NOT NULL,
FOREIGN KEY (id_Travel) REFERENCES Travel(id_Travel),
PRIMARY KEY (id_Reservation)
);

-- Insert data into the table Reservation :
INSERT INTO Reservation (`Date`, Number_Place, Number_Children_M, Number_Children_F, Number_Adults_M, Number_Adults_F, Number_Senior_M, Number_Senior_F, id_Travel)
     VALUES
          ('2020-09-08', 4, 1, 0, 1, 1, 1, 0, 1),
          ('2021-02-01', 2, 0, 0, 0, 1, 1, 0, 2),
          ('2020-12-12', 6, 0, 2, 1, 1, 0, 2, 3),
          ('2021-03-13', 3, 0, 0, 2, 1, 0, 0, 4),
          ('2021-09-10', 3, 1, 0, 0, 0, 1, 1, 5),
          ('2021-01-10', 4, 2, 1, 1, 0, 0, 0, 6),
          ('2021-01-12', 4, 1, 1, 1, 1, 0, 0, 6),
          ('2021-03-11', 4, 0, 1, 1, 0, 1, 1, 4),
          ('2021-01-14', 3, 1, 0, 0, 0, 1, 1, 2),
          ('2020-06-26', 1, 0, 0, 0, 0, 1, 0, 1);

Select * from Reservation;



-- -------------------------------------------------------------------------------------------

-- Table creation Customer :
create table if not exists `Customer` (
id_Customer INT NOT NULL AUTO_INCREMENT,
Name VARCHAR(30),
First_Name VARCHAR(30),
Phone_Number VARCHAR(18),
Email VARCHAR(50),
Birth_Date DATE NOT NULL,
Gender VARCHAR(2),
id_address_billing INT NOT NULL,
id_address_delivery INT NOT NULL,
id_Staff INT NOT NULL,
FOREIGN KEY (id_address_billing) REFERENCES Address(id_address),
FOREIGN KEY (id_address_delivery) REFERENCES Address(id_address),
FOREIGN KEY (id_Staff) REFERENCES Staff(id_Staff),
PRIMARY KEY (id_Customer)
);

-- Insert data into the table Customer :
INSERT INTO Customer (Name, First_Name, Phone_Number, Email, Birth_Date, Gender, id_address_billing, id_address_delivery, id_Staff)
	VALUES
		  ('Olivier', 'Texier', '0788777235', 'olivier.texier@morin.com', '1990-07-13', 'M', 11, 21, 1),
		  ('Victoire', 'Foucher', '0106584911', 'victoire.foucher@yahoo.fr', '1995-01-15','F', 12, 22, 2),
		  ('Denis', 'Michel', '0602945433', 'denis.michel@clement.com', '1960-02-29', 'M', 13, 23, 3),
		  ('Claudine', 'Huet', '0375841399', 'claudine.huet@royer.fr', '1992-07-01', 'F', 14, 24, 4),
		  ('Bernadette', 'Menard', '0936876639', 'bernadette.menard@gmail.com', '2006-08-23', 'F', 15, 25, 5),
		  ('Pierre', 'Marchand', '0178956639', 'pierre.marchand@yahoo.fr', '1985-06-12', 'M', 16, 26, 6),
		  ('David', 'Marchant', '0295496215', 'david.marchant@hotmail.fr', '1950-01-21', 'M', 17, 27, 7),
		  ('Dorothée', 'Blondel', '0412032673', 'dorothée.blondel@orange.fr', '2013-05-23', 'F', 18, 28, 8),
		  ('Victoire', 'Carlier', '0104419532', 'victoire.carlier@dbmail.com', '1956-01-23', 'F', 19, 29, 9),
		  ('Henri', 'Martinn', '0318245448', 'henri.martinn@noos.fr', '1995-12-28', 'M', 20, 30, 3);

Select * from Customer;



-- ------------------------------------------------------------------------------------------------

-- Table creation Payment :
create table if not exists `Payment` (
id_Reservation INT NOT NULL,
id_Customer INT NOT NULL,
Number_Payments INT NOT NULL,
Payment_Method VARCHAR(15),
Payment_Date DATE NOT NULL,
Payment_Amount FLOAT NOT NULL,
FOREIGN KEY (id_Reservation) REFERENCES Reservation(id_Reservation),
FOREIGN KEY (id_Customer) REFERENCES Customer(id_Customer),
PRIMARY KEY (id_Reservation, id_Customer)
);

-- Insert data into the table Payment :
INSERT INTO Payment(id_Reservation, id_Customer, Number_Payments, Payment_Method, Payment_Date, Payment_Amount)
	VALUES
          (1, 1, 1, 'CB', '2020-09-08', 683.28),
          (2, 2, 1, 'Cheque', '2021-02-01', 162.20),
          (3, 3, 1, 'Paypal', '2020-12-12', 1059.00),
          (4,4,3, 'Espèce', '2021-03-13', 60.00),
          (5,5,2, 'CB', '2021-09-10', 638.40),
          (6,6,1, 'CB', '2021-01-10', 341.64),
          (7,7,1, 'Paypal', '2021-01-12', 341.64),
          (8,8,1, 'Cheque', '2021-03-11', 80.00),
          (9,9,2, 'Paypal', '2021-01-14', 243.30),
          (10,10,1, 'CB', '2020-06-26', 170.82);

Select * from Payment;