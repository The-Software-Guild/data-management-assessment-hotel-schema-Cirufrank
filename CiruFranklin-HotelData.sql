-- Cirũ Franklin (she/they), Software Engineer 11/09/2022
-- Assessment: Hotel Schema
-- Data re-insertion script

USE cirufranklinhoteldb;

INSERT INTO `roomtype` VALUES (1,'Double'),(2,'Single'),(3,'Suite');

INSERT INTO `room` VALUES (1,201,1,0,2,4,199.99,10.00),(2,202,1,1,2,4,174.99,10.00),(3,203,1,0,2,4,199.99,10.00),(4,204,1,1,2,4,174.99,10.00),(5,205,2,0,2,2,174.99,NULL),(6,206,2,1,2,2,149.99,NULL),(7,207,2,0,2,2,174.99,NULL),(8,208,2,1,2,2,149.99,NULL),(9,301,1,0,2,4,199.99,10.00),(10,302,1,1,2,4,174.99,10.00),(11,303,1,0,2,4,199.99,10.00),(12,304,1,1,2,4,174.99,10.00),(13,305,2,0,2,2,174.99,NULL),(14,306,2,1,2,2,149.99,NULL),(15,307,2,0,2,2,174.99,NULL),(16,308,2,1,2,2,149.99,NULL),(17,401,3,1,3,8,399.99,20.00),(18,402,3,1,3,8,399.99,20.00);

INSERT INTO `amenity` VALUES (1,'Microwave'),(2,'Refrigerator'),(3,'Jacuzzi'),(4,'Oven');

INSERT INTO `roomamenity` VALUES (1,1),(3,1),(5,1),(6,1),(7,1),(8,1),(9,1),(11,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(2,2),(4,2),(5,2),(6,2),(7,2),(8,2),(10,2),(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(1,3),(3,3),(5,3),(7,3),(9,3),(11,3),(13,3),(15,3),(17,4),(18,4);

INSERT INTO `guest` VALUES (1,'Cirũ','Franklin','123 An Address','Test City','CA','123450','(123) 456-7890\r'),(2,'Mack','Simmer','379 Old Shore Street','Council Bluffs','IA','51501','(291) 553-0508\r'),(3,'Bettyann','Seery','750 Wintergreen Dr.','Wasilla','AK','99654','(478) 277-9632\r'),(4,'Duane','Cullison','9662 Foxrun Lane','Harlingen','TX','78552','(308) 494-0198\r'),(5,'Karie','Yang','9378 W. Augusta Ave.','West Deptford','NJ','8096','(214) 730-0298\r'),(6,'Aurore','Lipton','762 Wild Rose Street','Saginaw','MI','48601','(377) 507-0974\r'),(7,'Zachery','Luechtefeld','7 Poplar Dr.','Arvada','CO','80003','(814) 485-2615\r'),(8,'Jeremiah','Pendergrass','70 Oakwood St.','Zion','IL','60099','(279) 491-0960\r'),(9,'Walter','Holaway','7556 Arrowhead St.','Cumberland','RI','2864','(446) 396-6785\r'),(10,'Wilfred','Vise','77 West Surrey Street','Oswego','NY','13126','(834) 727-1001\r'),(11,'Maritza','Tilton','939 Linda Rd.','Burke','VA','22015','(446) 351-6860\r'),(12,'Joleen','Tison','87 Queen St.','Drexel Hill','PA','19026','(231) 893-2755');

INSERT INTO `reservation` VALUES (1,16,1,0,'2023-02-02','2023-02-04'),(2,3,2,1,'2023-02-05','2023-02-10'),(3,13,2,0,'2023-02-22','2023-02-24'),(4,1,2,2,'2023-03-06','2023-03-07'),(5,15,1,1,'2023-03-17','2023-03-20'),(6,10,3,0,'2023-03-18','2023-03-23'),(7,2,2,2,'2023-03-29','2023-03-31'),(8,12,2,0,'2023-03-31','2023-04-05'),(9,9,1,0,'2023-04-09','2023-04-13'),(10,7,1,1,'2023-04-23','2023-04-24'),(11,17,2,4,'2023-05-30','2023-06-02'),(12,6,2,0,'2023-06-10','2023-06-14'),(13,8,1,0,'2023-06-10','2023-06-14'),(14,12,3,0,'2023-06-17','2023-06-18'),(15,5,2,0,'2023-06-28','2023-07-02'),(16,4,3,1,'2023-07-13','2023-07-14'),(17,17,4,2,'2023-07-18','2023-07-21'),(18,11,2,1,'2023-07-28','2023-07-29'),(19,13,1,0,'2023-08-30','2023-09-01'),(20,8,2,0,'2023-09-16','2023-09-17'),(21,3,2,2,'2023-09-13','2023-09-15'),(22,17,2,2,'2023-11-22','2023-11-25'),(23,6,2,0,'2023-11-22','2023-11-25'),(24,9,2,2,'2023-11-22','2023-11-25'),(25,10,2,0,'2023-12-24','2023-12-28');

INSERT INTO `guestreservation` VALUES (2,1),(3,2),(4,3),(5,4),(1,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(12,13),(6,14),(1,15),(9,16),(10,17),(3,18),(3,19),(2,20),(5,21),(4,22),(2,23),(2,24),(11,25);

-- The below portion of the script deletes Jeremiah Pendergrass' reservation and
-- information from the database

-- BEGIN JEREMIAH PENDERGRASS DATA REMOVAL

SET @deletedUserFName = "Jeremiah";
SET @deletedUserLName = "Pendergrass";

-- The below SELECT Statements can be used to ensure the proper data is removed

-- BEGIN SELECT STATEMENTS

-- SELECT * FROM reservation
-- WHERE reservationId = 
-- 	(SELECT 
-- 		reservationId
-- 	FROM reservation
-- 	INNER JOIN guestReservation USING(reservationId)
-- 	INNER JOIN guest USING(guestId) 
-- 	WHERE firstName LIKE @deletedUserFName AND lastName LIKE @deletedUserLName);
--     
-- SELECT reservationId FROM
-- guestReservation
-- WHERE guestId = (
-- 	SELECT 
-- 		guestId
-- 	FROM guest
-- 	WHERE firstName LIKE @deletedUserFName AND lastName LIKE @deletedUserLName);
--     
-- SELECT *
-- 	FROM guest
-- 	WHERE firstName LIKE @deletedUserFName AND lastName LIKE @deletedUserLName;

-- END OF SELECT STATEMENTS


-- Stores the id of the guest reservation to delete

-- BEGIN reservationIdToDelete SESSION VARIABLE STORAGE AND SELECT STATEMENT TEST

SELECT reservationId 
INTO @reservationIdToDelete
FROM
guestReservation
WHERE guestId = (
	SELECT 
		guestId
	FROM guest
	WHERE firstName LIKE @deletedUserFName AND lastName LIKE @deletedUserLName);

-- Select statement to ensure the @reservationIdToDelete session variable was stored;

-- SELECT * 
-- FROM reservation 
-- WHERE reservationId = @reservationIdToDelete;

-- END reservationIdToDelete SESSION VARIABLE STORAGE AND SELECT STATEMENT TEST



-- Delete guest reservation of Jeremiah from the guestReservation table first since 
-- this references both the guest and reservation tables

-- NOTE: In queries where the delete condition is dependent in a subquery, this subquery
-- is nested so MySQL does not throw an error

SET SQL_SAFE_UPDATES=0;

DELETE FROM guestReservation
WHERE reservationId = @reservationIdToDelete;

-- Delete Jeremiah's reservation from the reservation table using the
-- @reservationIdToDelete session variable

DELETE FROM reservation
WHERE reservationId = @reservationIdToDelete;

-- Delete Jeremiah from the guest table, thus finalizing the removal of Jeremiah's
-- reservations and information

DELETE FROM guest
WHERE firstName LIKE @deletedUserFName
AND lastName LIKE @deletedUserLName;

SET SQL_SAFE_UPDATES=1;

-- END JEREMIAH PENDERGRASS DATA REMOVAL

