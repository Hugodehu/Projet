-- Script MYSQL
-- Création des Requêtes
-- -- Livrable 2 by SAVALLE Florian, DEHURTEVENT Hugo, GUEROULT Antoine, DELATOUR Alexandre


-- WARNING : Il faut exécuter le code des création des tables et des données avant d'effectuer ce code pour les requêtes.
-- use projet_bdd;

-- ---------------------------------------------------------------------------------

-- Querie creation SF_GSTS_01 - Connaitre le nombre de clients :
SELECT COUNT(Name) AS Nbr_Customer
FROM Customer;



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_02 - Connaitre le nombre de clients par villes :
SELECT City, COUNT(Name) AS Nbr_Customer
FROM
    (SELECT Customer.Name, Customer.First_Name, Address.City
     FROM Customer
     INNER JOIN Address ON Customer.id_address_billing = Address.id_address) AS NomsParVille
GROUP BY City;



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_03 - Connaitre le coût moyen des voyages :
SELECT Name AS Name_Travel, id_Travel AS Number_Travel, ROUND(AVG(Payment_Amount)) AS Average_Price
FROM
    (SELECT Payment_Amount, Name, id_Travel
     FROM
        (SELECT Travel.Name, Reservation.id_Reservation, Travel.id_travel
		 FROM Travel
		 INNER JOIN Reservation ON Travel.id_Travel = Reservation.id_Travel) AS Inter
     INNER JOIN PAYMENT ON Inter.id_Reservation = Payment.id_Reservation) AS Last
GROUP BY id_travel;



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_04 - Connaitre les villes les plus prisées :
SELECT *
FROM
	(SELECT Travel.id_Travel, City_arrival, SUM(Number_Place) AS Number_User
	 FROM Travel
	 INNER JOIN Reservation ON Travel.id_Travel = Reservation.id_Travel
	 GROUP BY City_Arrival) AS P1
ORDER BY P1.Number_User DESC;



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_05 - Connaitre la proportion des voyages intra-villes et inter-villes:
SELECT COUNT(id_Travel) AS Total_Travel, Intra_City_Travel, COUNT(id_Travel)-Intra_City_Travel AS Inter_City_Travel
FROM
	(SELECT COUNT(id_Travel) AS Intra_City_Travel
	 FROM
    	(SELECT Name, id_Travel, Travel_City_Departure, Travel_City_Arrival, Step.City_Departure AS Step_City_Departure, Step.City_Arrival AS Step_City_Arrival
    	 FROM
        	(SELECT Travel.id_Travel, Travel.City_Departure AS Travel_City_Departure, Travel.City_Arrival AS Travel_City_Arrival, Name, id_Step
    		 FROM Travel
    		 INNER JOIN Stop ON Travel.id_Travel = Stop.id_Travel) AS FirstJ
    	 INNER JOIN Step ON FirstJ.id_Step = Step.id_Step) AS SecondJ
	 WHERE Travel_City_Departure = Travel_City_Arrival = Step_City_Departure = Step_City_Arrival) AS CountIntra
CROSS JOIN Travel;



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_06 - Connaitre le nombre de voyage dont le moyen de transport est l’avion :
SELECT COUNT(*) AS Travel
FROM `Use`
WHERE id_Means_Transport = 4;



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_07 - Connaitre le nombre de voyage dont les moyens de transports sont l’avion et le car:
SELECT COUNT(id_Travel) AS Nbr_Travel_With_Plane_And_Bus
FROM
	(SELECT id_Travel,group_concat(id_Means_Transport) AS Concat
	 FROM `use`
	 GROUP BY id_travel) AS ConcatJ
WHERE Concat = '3,4';



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_08 - Connaitre la période de l’année la plus attractive pour les ventes de voyages:
SELECT Month, MAX(Places_Sold) AS Most_Sales
FROM
	(SELECT Month(Date) AS Month, SUM(Number_Place) AS Places_Sold
	 FROM RESERVATION
	 GROUP BY Month
	 ORDER BY Month) AS P1;



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_09 - Connaitre le moyen de transport le plus utilisé sur les 3 derniers mois:
SELECT Date_Travel, MAX(Number_Place) AS Number_Place, Transport_Used
FROM
    (SELECT Date_Departure AS Date_Travel, Number_Place, GROUP_CONCAT(Average_Type) AS Transport_Used
     FROM
        (SELECT SUM(Number_Place) AS Number_Place, Date_Departure, id_Means_Transport
    	 FROM
        	(SELECT Number_Place, Date_Departure, Travel.id_Travel
    		 FROM Reservation
    		 INNER JOIN Travel ON Reservation.id_Travel = Travel.id_Travel) AS FirstJ
    	 INNER JOIN `Use` ON FirstJ.id_Travel = Use.id_Travel
    	 GROUP BY Date_Departure) AS SecondJ
     INNER JOIN Means_Transport ON SecondJ.id_means_transport = means_transport.id_means_transport
     GROUP BY Date_Travel) AS PF
WHERE Date_Travel BETWEEN '2021-02-18' AND '2021-05-18';



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_10 - Connaitre le tarif moyen des billets en fonction du transport:
SELECT ROUND(AVG(Total_Kilometers*0.18)) AS Price_Train, ROUND(AVG(Total_Kilometers*0.80)) AS Price_Boat, ROUND(AVG(Total_Kilometers*0.50)) AS Price_Bus, ROUND(AVG(Total_Kilometers*0.22)) AS Price_Plane
FROM
	(SELECT Total_Kilometers, Travel.id_travel, Name
	 FROM Mileage
	 INNER JOIN Travel ON Mileage.id_mileage = travel.id_mileage) AS FirstJ
WHERE NOT id_travel = 6;



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_11 - Connaitre la moyenne des personnes par sexe qui voyagent les 6 derniers mois:
SELECT (Sum(Number_Children_M+Number_Senior_M+Number_Adults_M)/ count(Number_Children_M+Number_Senior_M+Number_Adults_M+Number_Children_F+Number_Senior_F+Number_Adults_F)) as Male, (Sum(Number_Children_F+Number_Senior_F+Number_Adults_F)/ count(Number_Children_M+Number_Senior_M+Number_Adults_M+Number_Children_F+Number_Senior_F+Number_Adults_F)) AS Female
FROM Reservation
WHERE `Date` BETWEEN '2020-12-18' 
AND '2021-05-18';



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_12 - Connaitre la moyenne des séniors qui voyagent les 6 derniers mois:
SELECT ((SUM(Number_Senior_M) + SUM(Number_Senior_F)) / SUM(Number_Place)) AS Average_Senior
FROM Reservation
WHERE `Date` BETWEEN '2020-12-18'
AND '2021-05-18';



-- ---------------------------------------------------------------------------------
-- Querie creation SF_GSTS_13 - Connaitre le nombre moyen d’enfants qui voyagent les 6 derniers mois:
SELECT ((SUM(Number_Children_M) + SUM(Number_Children_F)) / SUM(Number_Place)) as Average_Children
FROM Reservation
WHERE `Date` Between '2020-12-18'
AND '2021-05-18';



-- -------------------------------------------------------------------------------------------------
-- Querie creation SF_GSTS_14 - Connaitre le mode de paiement préféré des clients depuis « X date »:
SELECT Payment_Method as prefer_mode_payment
FROM Payment
WHERE Payment_Date > 2020-06-12
GROUP BY Payment_Method
ORDER BY count(Payment_Method) desc
LIMIT 1;



-- -------------------------------------------------------------------------------------------------
-- Querie creation SF_GSTS_15 - Connaitre les personnels les plus anciens dans l’agence :
SELECT Name, First_Name, Hiring_Date
FROM Staff
WHERE Hiring_Date= (
			SELECT MIN(Hiring_Date)
			FROM Staff);



-- -------------------------------------------------------------------------------------------------
-- Querie creation SF_GSTS_16 - Connaitre les différentes informations pour un voyage : Numéro de voyage, son prix, date de départ, nombre de villes traversées :
SELECT id_Travel AS Travel_Number, Date_Departure, Number_Steps AS Number_Traversed_Cities, Payment_Amount
FROM
	(SELECT Travel.id_Travel, Date_Departure, Number_Steps, id_Reservation
	 FROM Travel
	 INNER JOIN Reservation ON Travel.id_Travel = Reservation.id_Travel) AS FirstJ
INNER JOIN Payment ON FirstJ.id_Reservation = Payment.id_Reservation;
