USE [ColonialAdventureTours];

/*
NOTE: To DESCRIBE in MS SQL Server you have to do this: EXEC sp_help 'dbo.mytable';

NOTE: To ALTER a Table's Column Structure you have to do this ex.:
	ALTER TABLE PADDLING
	ALTER COLUMN Season CHAR(25);

NOTE: To change a tables column to reject NULLS do:
	ALTER TABLE PADDLING
	ALTER COLUMN DIFFICULTY_LEVEL CHAR(3) NOT NULL;
*/

-- Ch1.

-- 1) 
SELECT first_name, last_name
FROM GUIDE
WHERE state = 'ME';

-- 2) 
SELECT trip_name 
FROM TRIP
WHERE MAX_GRP_Size > 16;

-- 3) 
SELECT trip_id, trip_name
FROM TRIP
WHERE Type = 'Paddling';

-- 4) 
SELECT trip_id, trip_name
FROM TRIP
WHERE Type = 'Biking' AND Season = 'Early Fall';

-- 5) 
SELECT trip_id, trip_name
FROM TRIP
WHERE State = 'VT' OR Type = 'Paddling';

-- 6) 
SELECT COUNT(Type)
FROM TRIP
WHERE Type = 'Hiking';

-- 7) 
SELECT trip_name
FROM TRIP, Trip_Guides, Guide
WHERE Guide.Guide_Num = 'RH01' AND
Trip.Trip_ID = Trip_Guides.Trip_ID AND
Guide.Guide_Num = Trip_Guides.Guide_Num;

-- 8) 
SELECT Trip_name
FROM TRIP
WHERE Trip_Name like '%Loop%';

-- 9)
SELECT First_Name, Last_Name
FROM GUIDE
WHERE State IN ('ME','VT','CT');

-- 10) 
SELECT COUNT(Reservation_ID)
FROM RESERVATION
WHERE DATEPART (YYYY, Trip_Date) = '2016' AND
DATEPART (MM, Trip_Date) = '07';

-- *11)
SELECT First_Name, Last_Name, TRIP.Trip_Name, TRIP.Type
FROM CUSTOMER, TRIP, RESERVATION
WHERE RESERVATION.Customer_Num = CUSTOMER.Customer_Num AND
RESERVATION.Trip_ID = TRIP.Trip_ID;
/*
NOTE: The question asks us for customers with more than one reservation and there should be 8 results so we do connecting this to the top query:
    SELECT COUNT(RESERVATION.Customer_Num)
	FROM RESERVATION
	GROUP BY Reservation.Customer_Num
	HAVING COUNT(RESERVATION.Customer_Num)>1
*/

-- 12) 
SELECT Last_Name
FROM CUSTOMER, TRIP, RESERVATION
WHERE RESERVATION.Customer_Num = CUSTOMER.Customer_Num AND
RESERVATION.Trip_ID = TRIP.Trip_ID
AND TRIP.State = 'MA';

-- 13) 
SELECT COUNT(Trip_Price)
FROM RESERVATION
WHERE Trip_Price > 15 AND Trip_Price < 40; 



-- Ch4.

-- 1)
SELECT Last_Name
FROM GUIDE
WHERE State != 'MA';

/*
NOTE:Can also do it like this:
	SELECT Last_Name
	FROM GUIDE
	WHERE NOT(State= 'MA');
*/

-- 2) 
SELECT Trip_Name
FROM TRIP
WHERE TYPE = 'Biking';

-- 3) 
SELECT Trip_Name
FROM TRIP
WHERE Season = 'Summer';

-- 4) 
SELECT Trip_Name, Distance
FROM TRIP
WHERE TYPE = 'Hiking'
AND Distance > 10;

-- 5) 
SELECT Customer_Num, Last_Name, First_Name
FROM  CUSTOMER
WHERE State IN ('NJ','NY','PA');

-- 6) 
SELECT Customer_Num, Last_Name, First_Name
FROM  CUSTOMER
WHERE State IN ('NJ','NY','PA')
ORDER BY State desc, Last_Name asc;

-- 7) 
SELECT COUNT(Trip_ID)
FROM TRIP
WHERE State IN ('ME','MA');

-- 8) 
SELECT DISTINCT(STATE), COUNT(STATE)
FROM TRIP
GROUP BY STATE;

-- 9) 
SELECT COUNT(Trip_ID)
FROM RESERVATION
WHERE Trip_Price > 20 AND Trip_Price < 75;
/*
NOTE:OR do this but, please know that it would include 20 through 75. As if it were Trip_Price >= 20 AND Trip_Price <= 75.
	SELECT COUNT(Trip_ID)
	FROM RESERVATION
	WHERE Trip_Price BETWEEN 20 AND 75;
*/

-- 10) 
SELECT DISTINCT(Type), COUNT(Type) AS Number_of_Trips
FROM TRIP
GROUP BY Type;

-- 11) 
SELECT Reservation_ID, Trip_ID, Customer_Num, ((Trip_Price + Other_Fees) * Num_Persons) AS TOTAL_PRICE
FROM Reservation
WHERE Num_Persons < 4;

-- 12) 
SELECT Trip_Name
FROM TRIP
WHERE Trip_Name LIKE '%Pond%';

-- 13) 
SELECT Last_Name, First_Name
FROM GUIDE
WHERE Hire_Date < '2013-06-10';

-- 14) 
SELECT DISTINCT(Type), AVG(DISTANCE) AS Average_Distance, AVG(Max_GRP_Size) AS Average_Max_GRP_Size
FROM TRIP
GROUP BY Type;
-- NOTE: When doing DISTINCT, make sure to have it first in the SELECT clause.

-- 15) 
SELECT DISTINCT(Season)
FROM TRIP;

-- 16) 
SELECT Reservation_ID 
FROM Reservation 
WHERE Trip_id IN
(SELECT Trip_id
FROM TRIP
WHERE TYPE = 'Paddling');

-- 17) 
SELECT MAX(Distance)
FROM TRIP
WHERE Type = 'Biking';

-- 18) 
Select Trip_ID, Sum(Trip_Price) As Summed_Price
From Reservation
GROUP BY Trip_id
HAVING count(*) > 1;

-- 19) 
SELECT COUNT(Reservation_ID) AS Total_Reservations, SUM(Num_Persons) AS Total_Num_of_Persons
FROM RESERVATION;

-- 20) 
SELECT Reservation_ID, Trip_ID
FROM RESERVATION
WHERE YEAR(Trip_Date) = 2016 AND MONTH(Trip_Date) = 07; 
NOTE:We could have also done it like this:
SELECT Reservation_ID, Trip_ID
FROM RESERVATION
WHERE Trip_Date BETWEEN '2016-07-01' AND '2016-07-31'; 



-- Ch.5

-- 1) 
SELECT reservation_Id, Trip_ID, r.Customer_Num, Last_Name
FROM RESERVATION r, CUSTOMER c
WHERE c.Customer_Num = r.Customer_Num
ORDER BY Last_Name;

-- 2) 
SELECT *
FROM Customer
WHERE First_Name = 'Ryan';
/*
NOTE: After finding the Customer_Num of Ryan Goff, we can now do the query:
	SELECT Reservation_ID, Trip_ID, Num_Persons
	FROM RESERVATION
	WHERE Customer_Num = '104';
*/

-- 3) 
SELECT Trip_Name
FROM TRIP t, GUIDE g, TRIP_GUIDES tg
WHERE t.Trip_ID = tg.Trip_ID
AND g.Guide_num = tg.Guide_Num
AND g.Guide_Num = 'AM01';
/*
NOTE:This query also works:
	Select Trip_Name 
	FROM Trip
	Where Trip_ID IN(
	Select Trip_id
	FROM Trip_Guides
	WHERE Guide_Num IN(
	Select Guide_Num 
	FROM Guide
	WHERE last_name = 'Abrams'))
*/

-- 4) 
SELECT Trip_Name
FROM TRIP
INNER JOIN TRIP_GUIDES ON TRIP_GUIDES.TRIP_ID = TRIP.Trip_ID
INNER JOIN GUIDE ON GUIDE.Guide_Num = TRIP_GUIDES.Guide_Num
AND 
Type = 'Biking' AND GUIDE.Guide_Num = 'BR01';
/*
NOTE: We could have also foud out the Guide_Num of Rita by:
	SELECT *
	FROM GUIDE
	WHERE First_Name = 'Rita';
*/

-- 5) 
SELECT Last_Name, Trip_Name, Start_Location
FROM CUSTOMER c, TRIP t, RESERVATION r
WHERE c.Customer_Num = r.Customer_Num
AND t.Trip_id = r.Trip_id
AND Trip_Date = '2016-07-23';

-- 6) 
SELECT Reservation_ID, t.Trip_ID, Trip_Date
FROM TRIP t
JOIN RESERVATION r ON r.Trip_ID = t.Trip_id
AND STATE IN ('ME');
/*
NOTE: Could do this too:
	SELECT Reservation_ID, t.Trip_ID, Trip_Date
	FROM TRIP t
	JOIN RESERVATION r ON r.Trip_ID = t.Trip_id
	WHERE State  IN ('ME');
*/

-- 7) 
SELECT Reservation_ID, Trip_id, Trip_Date
FROM Reservation r
WHERE EXISTS 
(
SELECT *
FROM TRIP t
WHERE t.Trip_ID = r.Trip_ID
AND State = 'ME'
);

-- 8) 
SELECT Last_Name, First_Name
FROM GUIDE, TRIP, TRIP_GUIDES
WHERE GUIDE.Guide_Num = TRIP_GUIDES.Guide_Num
AND Trip.Trip_ID = TRIP_GUIDES.Trip_id
AND Type = 'paddling'
ORDER BY Last_Name;

-- 9) 
SELECT Last_Name, First_Name
FROM GUIDE g, TRIP t, TRIP_GUIDES tg
WHERE g.Guide_Num = tg.Guide_Num
AND t.Trip_ID = tg.Trip_id
AND Type = 'paddling'
ORDER BY Last_Name;

-- 10) NOTE: For this we would have to do a self join showing like a side by side comparison of the same table with Trip_ID pairs that have the same Start_Location:
SELECT t1.Trip_ID, t1.Trip_Name, t2.Trip_ID, t2.Trip_Name, t2.Start_Location
FROM TRIP t1, TRIP t2
WHERE t1.Start_Location = t2.Start_Location
AND t1.Trip_ID <> t2.Trip_ID
ORDER BY t1.Start_Location;

-- 11) 
SELECT Trip_Name
FROM TRIP
WHERE Type = 'Hiking'
ORDER BY Trip_Name;

-- 12) 
SELECT RESERVATION.Customer_Num, (First_Name + Last_Name) AS Full_Name 
FROM Customer, RESERVATION
WHERE RESERVATION.Customer_Num = CUSTOMER.Customer_Num
OR State = 'NJ'
ORDER BY Customer_Num;
/*
NOTE: You could see in the query below that we show the State and the Reservation _ID to those customers that have a reservation OR in the State of NJ. The last column Counts the total number of Reservations a Customer_Num has.
SELECT RESERVATION.Customer_Num, (First_Name + Last_Name) AS Full_Name, State, Reservation_id, COUNT(*) OVER (PARTITION BY RESERVATION.Customer_Num)
FROM Customer, RESERVATION
WHERE RESERVATION.Customer_Num = CUSTOMER.Customer_Num
OR State = 'NJ'
ORDER BY Customer_Num;
*/

-- 13) 
SELECT RESERVATION.Customer_Num, (First_Name + Last_Name) AS Full_Name 
FROM Customer, RESERVATION
WHERE RESERVATION.Customer_Num = CUSTOMER.Customer_Num
AND State = 'NJ'
ORDER BY Customer_Num;

-- 14) 
SELECT Trip_ID, Trip_Name, Max_GRP_Size
FROM TRIP
WHERE Max_GRP_Size > ALL (
SELECT Max_GRP_Size
FROM TRIP
WHERE TYPE = 'Hiking');

-- 15) 
SELECT Trip_ID, Trip_Name, Max_GRP_Size
FROM TRIP
WHERE Max_GRP_Size > ANY (
SELECT Max_GRP_Size
FROM TRIP
WHERE TYPE = 'Biking');

-- 16) 
SELECT t.Trip_ID, Trip_Name, Reservation_ID
FROM TRIP t
LEFT JOIN Reservation r ON r.Trip_id = t.Trip_id
ORDER BY t.Trip_id;

-- 17) 
SELECT DISTINCT(Last_Name), First_Name
FROM GUIDE g, TRIP t, TRIP_GUIDES tg
WHERE g.Guide_Num = tg.Guide_Num
AND t.Trip_ID = tg.Trip_id
AND Type = 'paddling'
ORDER BY Last_Name;

-- *18) NOTE: You have to list each trip only once part!
SELECT t1.Trip_ID, t1.Trip_Name, t2.Trip_ID, t2.Trip_Name, t2.Start_Location 
FROM TRIP t1, TRIP t2
WHERE t1.Start_Location = t2.Start_Location
AND t1.Trip_ID <> t2.Trip_ID
AND t1.State = 'NH'
ORDER BY t1.Trip_Name desc;




-- Ch.6

-- 1) 
CREATE TABLE PADDLING (
Trip_ID DECIMAL(3,0) NOT NULL PRIMARY KEY,
Trip_Name CHAR(75),
State CHAR(2),
Distance DECIMAL(4,0),
Max_GRP_Size DECIMAL(4,0),
Season CHAR(20));

-- 2) 
INSERT INTO PADDLING
SELECT Trip_ID, Trip_Name, State, Distance, Max_GRP_Size, Season
FROM TRIP
WHERE Type = 'Paddling';

-- 3) 
UPDATE PADDLING
SET Max_GRP_Size = Max_GRP_Size + 2
WHERE State = 'CT';

-- 4) 
INSERT INTO PADDLING
VALUES 
(43, 'Lake Champlain Tour', 'VT', 12, 16, 'Summer');

-- 5) 
DELETE 
FROM PADDLING
WHERE Trip_ID = 23;

-- 6) 
UPDATE PADDLING
SET Distance = 30
WHERE Trip_Name = 'Pontook Reservoir Tour';


-- 7) 
ALTER TABLE PADDLING
ADD DIFFICULTY_LEVEL CHAR(3);

UPDATE PADDLING
SET DIFFICULTY_LEVEL ='MOD';

-- 8) 
UPDATE PADDLING
SET DIFFICULTY_LEVEL = 'HRD'
WHERE Trip_Name = 'Lake Champlain Tour';

-- 9) 
ALTER TABLE PADDLING
ALTER COLUMN Season CHAR(25);
/*
NOTE: In MySQL this one would work, but not in MS SQL Server:
ALTER TABLE PADDLING
MODIFY Season CHAR(25);
*/

-- 10) 
ALTER TABLE PADDLING
ALTER COLUMN DIFFICULTY_LEVEL CHAR(3) NOT NULL;

-- 11) 
DROP TABLE PADDLING;

