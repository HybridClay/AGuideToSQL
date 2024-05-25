/*
NOTE: Postgre doesn't do: USE Solmaris;
Instead, you could go to a different Database on the left hand side and right click to select Query Tool option from the
drop down menu. You now have the PgAdmin window with the active database and role name on it.

NOTE: Postgre uses the SERIAL to auto_increment 

NOTE: To Describe a table, do(Postgre is Case-sensitive so make sure to write the table name exactly as it is on the left side of Object Explorer): 
SELECT *
FROM information_schema.COLUMNS
WHERE table_name = '';

NOTE: To just Describe the important parts:
SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
   table_name = '';


NOTE: To alter the table to a different parameter data type:ex.
	ALTER TABLE SERVICE_CATEGORY
	ALTER COLUMN Category_Description TYPE VARCHAR(30);
NOTE: We can also write it out like this:
	ALTER TABLE SERVICE_CATEGORY
	ALTER COLUMN Category_Description SET DATA TYPE VARCHAR(35);
*/


CREATE TABLE LOCATION (
Location_Num SERIAL PRIMARY KEY,
Location_Name VARCHAR(25),
Address VARCHAR(25),
City VARCHAR(20),
State CHAR(2),
Postal_Code CHAR(5));

INSERT INTO LOCATION (Location_Name, Address, City, State, Postal_Code)
VALUES
('Solmaris Ocean','100 Ocean Ave.','Bowton','FL','31313'),
('Solmaris Bayside','405 Bayside Blvd','Glander Bay','FL','31044');

UPDATE LOCATION
SET Address = '405 Bayside Blvd.'
WHERE Location_num = 2;


CREATE TABLE OWNER (
Owner_Num CHAR(5) PRIMARY KEY,
Last_Name VARCHAR(25),
First_Name VARCHAR(25),
Address VARCHAR(25),
City VARCHAR(25),
State CHAR(2),
Postal_Code CHAR(5));

INSERT INTO OWNER
VALUES
('AD057','Adney','Bruce and Jean','100 Ocean Ave.','Bowton','FL','31313'),
('AN175','Anderson','Bill','18 Wilcox St.','Brunswick','GA','31522'),
('BL720','Blake','Jack','2672 Condor St.','Mills','SC','29707'),
('EL025','Elend','Bill and Sandy','100 Ocean Ave.','Bowton','FL','31313'),
('FE182','Feenstra','Daniel','7822 Coventry Dr.','Rivard','FL','31062'),
('JU092','Juarez','Maria','892 Oak St.','Kaleva','FL','31521'),
('KE122','Kelly','Alyssa','527 Waters St.','Norton','MI','49441'),
('NO225','Norton','Peter and Caitlin','281 Lakewood Ave.','Lawndale','PA','19111'),
('RO123','Robinson','Mike and Jane','900 Spring Lake Dr.','Springs','MI','49456'),
('SM072','Smeltz','Jim and Cathy','922 Garland Dr.','Lewiston','FL','32765'),
('TR222','Trent','Michael','405 Bayside Blvd.','Glander Bay','FL','31044'),
('WS032','Wilson','Henry and Karen','25 Nicholas St.','Lewiston','FL','32765');


CREATE TABLE CONDO_UNIT (
Condo_ID SERIAL PRIMARY KEY,
Location_Num INT,
Unit_Num CHAR(3),
SQR_FT INT,
BDRMS CHAR(1),
Baths CHAR(1),
Condo_Fee DECIMAL(3,0),
Owner_Num CHAR(5),
FOREIGN KEY (Location_Num) REFERENCES LOCATION(Location_Num),
FOREIGN KEY (Owner_Num) REFERENCES OWNER(Owner_Num));

INSERT INTO CONDO_UNIT (Location_Num, Unit_Num, SQR_FT, BDRMS, Baths, Condo_Fee, Owner_Num)
VALUES
(1,'102',675,'1','1',475,'AD057'),
(1,'201',1030,'2','1',550,'EL025'),
(1,'306',1575,'3','2',625,'AN175'),
(1,'204',1164,'2','2',575,'BL720'),
(1,'405',1575,'3','2',625,'FE182'),
(1,'401',1030,'2','2',550,'KE122'),
(1,'502',745,'1','1',490,'JU092'),
(1,'503',1680,'3','3',670,'RO123'),
(2,'A03',725,'1','1',190,'TR222'),
(2,'A01',1084,'2','1',235,'NO225'),
(2,'B01',1084,'2','2',250,'SM072'),
(2,'C01',750,'1','1',190,'AN175'),
(2,'C02',1245,'2','2',250,'WS032'),
(2,'C06',1540,'3','1',300,'RO123');


CREATE TABLE SERVICE_CATEGORY (
Category_Num SERIAL PRIMARY KEY,
Category_Description VARCHAR(20));

ALTER TABLE SERVICE_CATEGORY
ALTER COLUMN Category_Description TYPE VARCHAR(30);

INSERT INTO SERVICE_CATEGORY (Category_Description)
VALUES
('Plumbing'),
('Heating/Air Conditioning'),
('Painting'),
('Electrical Systems'),
('Carpentry'),
('Janitorial');


CREATE TABLE SERVICE_REQUEST (
Service_ID SERIAL PRIMARY KEY, 
Condo_ID INT,
Category_Num INT,
Description VARCHAR(50),
Status VARCHAR(50),
EST_Hours SMALLINT,
Spent_Hours SMALLINT,
Next_Service_Date DATE,
FOREIGN KEY (Condo_ID) REFERENCES CONDO_UNIT(Condo_ID),
FOREIGN KEY (Category_Num) REFERENCES SERVICE_CATEGORY(Category_Num));


ALTER TABLE SERVICE_REQUEST
ALTER COLUMN Description TYPE VARCHAR(100);

ALTER TABLE SERVICE_REQUEST
ALTER COLUMN Status TYPE VARCHAR(100);

INSERT INTO SERVICE_REQUEST (Condo_ID, Category_Num, Description, Status, EST_Hours, Spent_Hours, Next_Service_Date)
VALUES
(2,1,'Back wall in pantry has mold indicating water seepage. Diagnose and repair.','Service rep has verified the problem. Plumbing contractor has been called',4,2,'2015-10-12'),
(5,2,'Air conditioning doesn''t cool.','Service rep has verified problem. Air conditioning contractor has been called.',3,1,'2015-10-12'),
(4,6,'Hardwood floors must be refinished.','Service call has been scheduled',8,0,'2015-10-16'),
(1,4,'Switches in kitchen and adjoining dining room are reversed','Open',1,0,'2015-10-13'),
(2,5,'Molding in pantry must be replaced','Cannot schedule until water leak is corrected',2,0,NULL),
(14,3,'Unit needs to be repainted due to previous tenant damage.','Scheduled',7,0,'2015-10-19'),
(11,4,'Tenant complained that using microwave caused short circuits on two ocacasions.','Service rep unable to duplicate problem. Tenant to notify condo management if problem recurs.',1,1,NULL),
(9,3,'Kitchen must be repainted. Walls discolored due to kitchen fire','Scheduled',5,0,'2015-10-16'),
(7,6,'Shampoo all carpets.','Open',5,0,'2015-10-19'),
(9,5,'Repair window sills.','Scheduled',4,0,'2015-10-20');




