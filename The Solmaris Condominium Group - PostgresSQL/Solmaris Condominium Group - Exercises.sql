/*
NOTE: To DESCRIBE the table:
SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
   table_name = 'condo_unit';

NOTE: To alter the table to a different parameter data type:ex.
	ALTER TABLE CONDO_UNIT
	ALTER COLUMN bdrms TYPE DECIMAL(2,0);
NOTE: We can also write it out like this:
	ALTER TABLE CONDO_UNIT
	ALTER COLUMN bdrms SET DATA TYPE DECIMAL(2,0);

NOTE: To change the datatype of a column from character to numeric:
ALTER TABLE presales ALTER COLUMN code TYPE numeric(10,0) USING code::numeric;
-- Or if you prefer standard casting...
alter table presales alter column code type numeric(10,0) using cast(code as numeric);

This will fail if you have anything in code that cannot be cast to numeric; if the USING fails, you'll have to clean up the non-numeric data by hand before changing the column type.

NOTE: To change a tables column to reject NULLS, do:
	ALTER TABLE LARGE_CONDO
	ALTER COLUMN Condo_Fee SET NOT NULL;
*/

-- Ch.1

-- 1) 
SELECT Owner_Num, Last_Name, First_Name
FROM OWNER;

-- 2) 
SELECT Last_Name, First_Name
FROM OWNER
WHERE City = 'Bowton';

-- 3) 
SELECT Condo_ID
FROM CONDO_UNIT
WHERE SQR_FT < 1084;

--4)
SELECT CONDO_UNIT.Owner_Num,Last_Name, First_Name, City
FROM OWNER, CONDO_UNIT
WHERE OWNER.Owner_Num = CONDO_UNIT.Owner_Num
ORDER BY Owner_Num;
/*
NOTE: The Question asks us for every owner who owns more than one condo. So we woud have to add this part:
	SELECT COUNT(Owner_Num)
	FROM CONDO_UNIT
	GROUP BY Owner_Num
	HAVING COUNT(CONDO_UNIT.Owner_Num)>1;

NOTE: So together the query would look like this:
	SELECT COUNT(CONDO_UNIT.Owner_Num),Last_Name, First_Name, City
	FROM OWNER, CONDO_UNIT
	WHERE OWNER.Owner_Num = CONDO_UNIT.Owner_Num
	GROUP BY CONDO_UNIT.Owner_Num, Last_Name, First_Name, City
	HAVING COUNT(CONDO_UNIT.Owner_Num)>1
	ORDER BY CONDO_UNIT.Owner_Num;

NOTE: Better to take out the COUNT in the SELECT part and the ORDER BY, so have it like this:
	SELECT Last_Name, First_Name, City
	FROM OWNER, CONDO_UNIT
	WHERE OWNER.Owner_Num = CONDO_UNIT.Owner_Num
	GROUP BY CONDO_UNIT.Owner_Num, Last_Name, First_Name, City
	HAVING COUNT(CONDO_UNIT.Owner_Num)>1;
*/

-- 5) 
SELECT Last_Name, First_Name, City
FROM OWNER, CONDO_UNIT
WHERE OWNER.Owner_Num = CONDO_UNIT.Owner_Num
AND Condo_Fee < 250;

-- 6) 
SELECT Unit_Num
FROM CONDO_UNIT
WHERE Location_Num = 1;
/*
NOTE: We know from looking at the table that Solomaris Ocean is Location_Num 1. But if we didn't, we would have to join to also show the Location_Name and the from there we can add the Location_Num 1 because Solomaris Ocean is in Location_Num 1. 
	SELECT Unit_Num, l.Location_Num, Location_Name
	FROM CONDO_UNIT cu, Location l
	WHERE cu.Location_Num = l.Location_Num
	AND cu.Location_Num = 1;
*/

-- 7) 
SELECT COUNT(Condo_ID)
FROM CONDO_UNIT
WHERE BDRMS = '2' AND BATHS = '2';

-- 8) 
SELECT COUNT(Owner_Num)
FROM OWNER
WHERE STATE IN ('FL','GA','SC');
-- *NOTE: How can we represent the Number of Owners in each State by their own column?

-- 9) 
SELECT Last_Name, First_Name, Unit_Num
FROM OWNER o, CONDO_UNIT cu, SERVICE_REQUEST sr
WHERE o.Owner_Num = cu.Owner_Num
AND cu.Condo_ID = sr.Condo_ID
AND Status IN('Scheduled', 'Open');

-- 10) 
SELECT cu.Condo_ID, SQR_FT
FROM Condo_Unit cu
INNER JOIN Service_Request sr ON cu.Condo_ID = sr.Condo_ID
INNER JOIN Service_Category sc ON sc.Category_Num = sr.Category_Num
WHERE sr.Category_Num = 6;
-- NOTE: The above query was performed to try a different way of doing the JOIN's instead of the WHERE AND. 

-- 11) 
SELECT sr.Condo_ID, Location_Name 
FROM LOCATION l, CONDO_UNIT cu, SERVICE_REQUEST sr
WHERE l.Location_Num = cu.Location_Num
AND cu.Condo_ID = sr.Condo_ID
AND EST_Hours > 5;

-- 12) 
SELECT AVG(Condo_Fee) AS AVG_CondoFee_3BDRMS
FROM CONDO_UNIT
WHERE BDRMS = '3';
/*
NOTE: This gives us a result of a long decial numebr with many zeros. To round it do:
	SELECT ROUND(AVG(Condo_Fee)) AS AVG_CondoFee_3BDRMS
	FROM CONDO_UNIT
	WHERE BDRMS = '3';

NOTE: If you want to keep it at 2 decimal places do this:
	SELECT ROUND(AVG(Condo_Fee),2) AS AVG_CondoFee_3BDRMS
	FROM CONDO_UNIT
	WHERE BDRMS = '3';
*/



-- Ch4.

-- 1) 
SELECT Owner_Num, Last_Name, First_Name
FROM OWNER;

-- 2) 
SELECT *
FROM LOCATION;

-- 3) 
SELECT Last_Name, First_Name
FROM OWNER
WHERE City = 'Bowton';

-- 4)
SELECT Last_Name, First_Name
FROM OWNER
WHERE City != 'Bowton';
/*
NOTE: Could also do this:
	SELECT Last_Name, First_Name
	FROM OWNER
	WHERE NOT (City = 'Bowton');
*/

-- 5) 
SELECT Location_Num, Unit_Num
FROM CONDO_UNIT
WHERE SQR_FT <= 1200;

-- 6)
SELECT Location_Num, Unit_Num
FROM CONDO_UNIT
WHERE BDRMS ='3';

-- 7) 
SELECT Unit_Num
FROM CONDO_UNIT
WHERE BDRMS = '2' AND Location_Num = 2;

-- 8) 
SELECT CONDO_ID
FROM CONDO_UNIT
WHERE Condo_Fee BETWEEN 550 AND 650;

-- 9) 
SELECT Unit_Num
FROM CONDO_UNIT
WHERE Location_Num = 1 AND Condo_Fee < 500;

-- 10) 
SELECT Condo_ID, Category_Num, EST_Hours, (EST_Hours * 35)  AS ESTIMATED_COST
FROM SERVICE_REQUEST;

-- 11) 
SELECT Owner_Num, Last_Name
FROM OWNER
WHERE State IN ('FL','GA','SC');

-- 12) 
SELECT Location_Num, Unit_Num, SQR_FT, Condo_Fee
FROM CONDO_UNIT
ORDER BY Condo_Fee, SQR_FT;

-- 13) 
SELECT DISTINCT(Location_Num), COUNT(BDRMS) 
FROM Condo_Unit
WHERE BDRMS = '1'
GROUP BY Location_Num;
-- NOTE: Remember that DISTINCT comes first.

-- 14) 
SELECT SUM(Condo_Fee) AS Total_Condo_Fees
FROM Condo_UNIT;
/*
NOTE: To give it 2 Decimal Places use the ROUND function:
	SELECT ROUND(SUM(Condo_Fee),2) AS Total_Condo_Fees
	FROM Condo_UNIT;
*/

-- 15) 
SELECT Owner_Num, Last_Name
FROM OWNER
WHERE State = 'FL' OR State = 'GA' OR State = 'SC';

-- 16) 
SELECT Description
FROM Service_Request
WHERE Description LIKE '%pantry%';



-- ch.5

-- 1) 
SELECT o.Owner_Num, First_Name, Last_Name, Location_Num, Unit_Num, Condo_Fee
FROM OWNER o, Condo_UNIT cu
WHERE o.Owner_Num = cu.Owner_Num;

-- 2)
SELECT Condo_ID, Description, Status
FROM Service_Request sr
INNER JOIN Service_Category sc ON sc.category_Num = sr.Category_Num
WHERE sr.Category_Num = 6;

-- 3) 
SELECT sr.Condo_ID, Location_Num, Unit_Num, EST_Hours, Spent_Hours, o.Owner_Num, Last_Name
FROM Service_Request sr
INNER JOIN Service_Category sc ON sc.category_Num = sr.Category_Num
INNER JOIN CONDO_UNIT cu ON cu.Condo_ID = sr.Condo_ID
INNER JOIN OWNER o ON o.Owner_Num = cu.Owner_Num
WHERE sr.Category_Num = 6;

-- 4) 
SELECT First_Name, Last_Name
FROM OWNER
WHERE Owner_Num IN (
SELECT OWNER_NUM
FROM CONDO_UNIT
WHERE BDRMS = '3'
);

-- 5) 
SELECT First_Name, Last_Name
FROM OWNER
WHERE EXISTS (
SELECT OWNER_NUM
FROM CONDO_UNIT
WHERE OWNER.Owner_Num = CONDO_UNIT.Owner_Num 
AND BDRMS = '3'
);

-- 6)
SELECT c1.Unit_Num, c2.Unit_Num, c1.SQR_FT 
FROM CONDO_UNIT c1, CONDO_UNIT c2
WHERE c1.SQR_FT = c2.SQR_FT
AND c1.Unit_Num <> c2.Unit_Num
ORDER BY c1.SQR_FT;

-- 7) 
SELECT SQR_FT, Owner.Owner_Num, Last_Name, First_Name
FROM CONDO_UNIT, OWNER
WHERE CONDO_UNIT.Owner_num = OWNER.Owner_Num
AND Location_Num = 1;

-- 8) 
SELECT SQR_FT, Owner.Owner_Num, Last_Name, First_Name
FROM CONDO_UNIT, OWNER
WHERE CONDO_UNIT.Owner_num = OWNER.Owner_Num
AND Location_Num = 1
AND BDRMS = '3';

-- 9) 
SELECT Location_Num, Unit_num, Condo_Fee
FROM CONDO_UNIT cu
JOIN OWNER o ON o.Owner_num = cu.Owner_Num
WHERE City = 'Bowton' OR BDRMS = '1';

-- 10) 
SELECT Location_Num, Unit_num, Condo_Fee
FROM CONDO_UNIT cu
JOIN OWNER o ON o.Owner_num = cu.Owner_Num
WHERE City = 'Bowton' AND BDRMS = '1';

-- 11) 
SELECT Location_Num, Unit_num, Condo_Fee
FROM CONDO_UNIT cu
JOIN OWNER o ON o.Owner_num = cu.Owner_Num
WHERE City = 'Bowton' AND BDRMS != '1';

-- 12) 
SELECT Service_ID, Condo_ID 
FROM Service_Request
WHERE EST_Hours > ANY (
SELECT EST_Hours
FROM Service_Request
WHERE Category_Num = 5
);

-- 13)
SELECT Service_ID, Condo_ID 
FROM Service_Request
WHERE EST_Hours > ALL (
SELECT EST_Hours
FROM Service_Request
WHERE Category_Num = 5
);

-- 14)
SELECT cu.Condo_ID, SQR_FT, cu.Owner_Num, Service_ID, EST_Hours, Spent_Hours
FROM CONDO_UNIT cu, SERVICE_REQUEST sr
WHERE cu.Condo_ID = sr.Condo_ID
AND sr.Category_Num = 4;

-- 15) 
SELECT cu.Condo_ID, SQR_FT, cu.Owner_Num, Service_ID, EST_Hours, Spent_Hours
FROM CONDO_UNIT cu, SERVICE_REQUEST sr
WHERE cu.Condo_ID = sr.Condo_ID
ORDER BY Service_ID;



-- Ch.6

SELECT *
FROM LARGE_CONDO;

-- 1) 
CREATE TABLE LARGE_CONDO (
Location_Num DECIMAL(2,0) NOT NULL,
Unit_Num CHAR(3),
BDRMS DECIMAL(2,0),
Baths DECIMAL (2,0),
Condo_Fee DECIMAL (6,2),
Owner_Num CHAR(5),
PRIMARY KEY (Location_Num, Unit_Num));
--Primary Key must be entered in this format when it consist of more than one column.
--The combination of Location_Num and Unit_Num is the primary key.

-- 2) Note: The datatype we have for the BDRMS and Baths in Table CONDO_UNIT is CHAR we have to change it to DECIMAL before we can run this query, so we will do this:
ALTER TABLE CONDO_UNIT
ALTER COLUMN bdrms TYPE DECIMAL(2,0) USING bdrms::decimal;

ALTER TABLE CONDO_UNIT
ALTER COLUMN baths TYPE DECIMAL(2,0) USING baths::decimal;
-- Then we can now do this:
INSERT INTO LARGE_CONDO
SELECT Location_Num, Unit_Num, BDRMS, Baths, Condo_Fee, Owner_num
FROM CONDO_UNIT
WHERE SQR_FT > 1500;

-- 3) 
UPDATE LARGE_CONDO
SET Condo_Fee = Condo_Fee + 150;

-- 4) 
UPDATE LARGE_CONDO
SET Condo_Fee = Condo_Fee - 0.01
WHERE Condo_Fee > 750;

-- 5) 
INSERT INTO LARGE_CONDO
VALUES 
(1, '605', 3, 3, 775, 'FE182');

-- 6)
DELETE
FROM LARGE_CONDO
WHERE Owner_Num = 'AN175';

-- 7) 
UPDATE LARGE_CONDO
SET BDRMS = NULL
WHERE Location_Num = 1 AND Unit_Num='503';

-- 8) 
ALTER TABLE LARGE_CONDO
ADD OCCUPIED CHAR(1);

UPDATE LARGE_CONDO
SET OCCUPIED = 'Y';

-- 9) 
UPDATE LARGE_CONDO
SET OCCUPIED = 'N'
WHERE Unit_Num = 'C06';

-- 10)
ALTER TABLE LARGE_CONDO
ALTER COLUMN Condo_Fee SET NOT NULL;
/*
NOTE: In mysql or Oracle you would be able to do it like this ex:
	ALTER TABLE LEVEL1_CUSTOMER
	MODIFY CREDIT_LIMIT NOT NULL;
*/

-- 11)
DROP TABLE LARGE_CONDO;




