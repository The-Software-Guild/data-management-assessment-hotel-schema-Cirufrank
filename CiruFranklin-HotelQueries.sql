-- Cirũ Franklin (she/they), Software Engineer 11/09/2022
-- Assessment: Hotel Schema
-- Data query script

USE cirufranklinhoteldb;

-- Write a query that returns a list of reservations that end in July 2023, including the name of the guest, the room number(s), and the reservation dates.

SELECT 
	CONCAT(firstName, " ", lastName) guestName,
    GROUP_CONCAT(roomNumber SEPARATOR ", ") roomNumbers,
    GROUP_CONCAT(CONCAT(startDate, " to ", endDate) SEPARATOR " | ") reservationDates
FROM guest
INNER JOIN guestreservation USING(guestId)
INNER JOIN reservation USING(reservationId)
INNER JOIN room USING(roomId)
WHERE endDate BETWEEN '2023-07-01' AND '2023-07-31'
GROUP BY guestId;

-- 4 rows returned