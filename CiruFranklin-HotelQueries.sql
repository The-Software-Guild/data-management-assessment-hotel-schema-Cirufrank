-- Cirũ Franklin (she/they), Software Engineer 11/09/2022
-- Assessment: Hotel Schema
-- Data query script

USE cirufranklinhoteldb;

-- 1. Write a query that returns a list of reservations that end in July 2023, 
-- including the name of the guest, the room number(s), and the reservation dates.

SET @rangeStartDate = '2023-07-01';
SET @rangeEndDate = '2023-07-31';

SELECT 
	CONCAT(firstName, " ", lastName) guestName,
    GROUP_CONCAT(roomNumber SEPARATOR ", ") roomNumbers,
    GROUP_CONCAT(CONCAT(startDate, " to ", endDate) SEPARATOR " | ") reservationDates
FROM guest
INNER JOIN guestreservation USING(guestId)
INNER JOIN reservation USING(reservationId)
INNER JOIN room USING(roomId)
WHERE endDate BETWEEN  @rangeStartDate AND @rangeEndDate
GROUP BY guestId;

-- 4 rows returned

-- 2. Write a query that returns a list of all reservations for rooms with a jacuzzi, 
-- displaying the guest's name, the room number, and the dates of the reservation.

SET @amenityName = "Jacuzzi";

SELECT 
	CONCAT(firstName, " ", lastName) guestName,
    GROUP_CONCAT(roomNumber SEPARATOR ", ") roomsWithJacuzzi,
    GROUP_CONCAT(
		CONCAT(startDate, " to ", endDate) SEPARATOR " | ") reservationDates
FROM guest
INNER JOIN guestReservation USING(guestId)
INNER JOIN reservation USING(reservationId)
INNER JOIN room USING(roomId)
INNER JOIN roomAmenity ON roomAmenity.roomId = room.roomId 
	AND amenityId = (
		SELECT amenityId FROM amenity WHERE name LIKE @amenityName)
GROUP BY guestId;

-- 7 rows returned

-- 3. Write a query that returns all the rooms reserved for a specific guest, 
-- including the guest's name, the room(s) reserved, the starting date of the reservation, 
-- and how many people were included in the reservation. (Choose a guest's name from the 
-- existing data.)

SET @guestFirstName = "Cirũ";
SET @guestLastName = "Franklin";

SELECT
	CONCAT(firstName, " ", lastName) guestName,
    GROUP_CONCAT(roomNumber SEPARATOR ", ") roomsReserved,
    GROUP_CONCAT(startDate SEPARATOR " | ") reservationStartDates,
    GROUP_CONCAT(
		CONCAT("Adults: ", adults, " | Children: ", children, " | Total Guests: ", adults + children) SEPARATOR "  ||  ") totalGuestsIncluded
FROM guest
INNER JOIN guestReservation USING(guestId)
INNER JOIN reservation USING(reservationId)
INNER JOIN room USING(roomId)
WHERE firstName = @guestFirstName
AND lastName = @guestLastName;

-- 1 row returned
    
-- 4. Write a query that returns a list of rooms, reservation ID, and per-room 
-- cost for each reservation. The results should include all rooms, whether 
-- or not there is a reservation associated with the room.

SELECT
	roomNumber,
    reservationId,
    CONCAT("$",
		DATEDIFF(endDate, startDate) *
			CASE 
				WHEN (adults) <= standardOccupancy
					THEN basePrice
				ELSE 
					 (basePrice + (((adults) - standardOccupancy) * pricePerAdditionalPerson))
			END) reservationCost
FROM room
LEFT JOIN reservation USING(roomId);

-- 27 rows returned

-- 5. Write a query that returns all rooms with a capacity of three or more and that are 
-- reserved on any date in April 2023.

SET @rangeStartDate = '2023-04-01';
SET @rangeEndDate = '2023-04-30';
SET @threeGuests = 3;

SELECT 
	roomId,
    roomNumber,
    roomType.name roomType,
    IF(adaAccessible = 1, "YES","NO") adaAccessible,
    standardOccupancy,
    maxOccupancy,
    basePrice,
    pricePerAdditionalPerson
FROM room
INNER JOIN reservation USING(roomId)
INNER JOIN roomType USING(typeId)
WHERE maxOccupancy >= @threeGuests
AND (startDate BETWEEN @rangeStartDate AND @rangeEndDate OR endDate BETWEEN @rangeStartDate AND @rangeEndDate)
GROUP BY roomId;

-- 2 rows returned

-- Write a query that returns a list of all guest names and the number of reservations 
-- per guest, sorted starting with the guest with the most reservations and then by 
-- the guest's last name.

SELECT 
	CONCAT(lastName, ", ", firstName) guestName,
    COUNT(reservationId) totalReservations,
    startDate
FROM guest
INNER JOIN guestReservation USING(guestId)
INNER JOIN reservation USING(reservationId)
GROUP BY guestId
ORDER BY totalReservations DESC, lastName ASC;

-- 11 rows returned (12 when Jeremiah Pendergrass' reservation 
-- and information deletion script is not ran)

-- 7. Write a query that displays the name, address, and phone number of a guest 
-- based on their phone number. (Choose a phone number from the existing data.)

SET @phoneNumber = "%(123) 456-7890%";

SELECT
	CONCAT(firstName, " ", lastName) guestName,
    CONCAT(address, ", ", city, ", ", stateAbbr, ", ", zip) address,
    phoneNumber
FROM guest
WHERE phoneNumber LIKE @phoneNumber;

-- 1 row returned
