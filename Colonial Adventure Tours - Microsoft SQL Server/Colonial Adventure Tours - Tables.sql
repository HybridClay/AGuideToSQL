/*
NOTE: Date in Microsoft SQL server Management is YYYY-MM-DD
-- You can also convert date strings into appropiate date formats before inserting them into the database example: 
-- SQL Server Example:
INSERT INTO TableName (DateColumn) VALUES (CONVERT(date, 'DD/MM/YYYY', '2021/06/15'));
-- Oracle Example:
INSERT INTO TableName (DateColumn) VALUES (TO_DATE('15-JUN-2021','DD-MON-YYYY'));

NOTE: the INT AUTO_INCREMENT only work in Mysql. The MS SQL Server uses the IDENTITY keyword to perform an auto-increment feature. In the parenthesis (1,1) the starting value for IDENTITY is 1, and it will increment by 1 for each new record.

NOTE:For some databases, you can just explicitly insert a NULL into the auto_increment column. 
	 Even better, use DEFAULT instead of NULL. You want to store the default value, not a NULL that might trigger a default value. Just add the column names, yes you can use Null instead but is is a very bad idea to not use column names in any insert, ever.

NOTE: To insert value with a word that contains an apostrophe, add double single apostraphe''s.

NOTE: To use a DESCRIBE table_name; in SQL Server do(unlike postgre, it isnt case sensitive when typing the table name):
Select * From INFORMATION_SCHEMA.COLUMNS Where TABLE_NAME = 'TABLENAME'

NOTE: To Alter and change/Modify the parameters of a tables column, you do ex:
ALTER TABLE dbo.doc_exy ALTER COLUMN column_a DECIMAL (5, 2);  
NOTE: DECIMAL(p,q) stores a decimal number p digits long with q of these digits being decimal places to the right of the decimal point.
*/

USE ColonialAdventureTours;


CREATE TABLE GUIDE (
Guide_Num CHAR(4) PRIMARY KEY,
Last_Name VARCHAR(20),
First_Name VARCHAR(20),
Address VARCHAR(30),
City VARCHAR(30),
STATE CHAR(2),
Postal_Code CHAR(5),
Phone_Num CHAR(12),
Hire_Date DATE);

INSERT INTO GUIDE
VALUES 
('AM01','Abrams','Miles','54 Quest Ave.','Williamsburg','MA','01096','617-555-6032','2012-06-03'),
('BR01','Boyers','Rita','140 Oakton Rd.','Jaffrey','NH','03452','603-555-2134','2012-03-04'),
('DH01','Devon','Harley','25 Old Ranch Rd.','Sunderland','MA','01375','781-555-7767','2012-01-08'),
('GZ01','Gregory','Zach','7 Moose Head Rd.','Dummer','NH','03588','603-555-8765','2012-11-04'),
('KS01','Kiley','Susan','943 Oakton Rd.','Jaffrey','NH','03452','603-555-1230','2013-04-08'),
('KS02','Kelly','Sam','9 Congaree Ave.','Franconia','NH','03580','603-555-0003','2013-06-10'),
('MR01','Martson','Ray','24 Shenandoah Rd.','Springfield','MA','01101','781-555-2323','2015-09-14'),
('RH01','Rowan','Hal','12 Heather Rd.','Mount Desert','ME','04660','207-555-9009','2014-06-02'),
('SL01','Stevens','Lori','15 Riverton Rd.','Coventry','VT','05825','802-555-3339','2014-09-05'),
('UG01','Unser','Glory','342 Pineview St.','Danbury','CT','06810','203-555-8534','2015-02-02');


CREATE TABLE TRIP (
Trip_id INT IDENTITY (1,1) PRIMARY KEY,
Trip_Name VARCHAR(80),
Start_Location VARCHAR(80),
State CHAR(2),
Distance SMALLINT,
Max_GRP_Size SMALLINT,
Type VARCHAR(50),
Season VARCHAR(50));

INSERT INTO TRIP (Trip_Name,Start_Location,State,Distance,Max_GRP_Size,Type,Season)
VALUES 
('Arethusa Falls','Harts Location','NH',5,10,'Hiking','Summer');

INSERT INTO TRIP (Trip_Name,Start_Location,State,Distance,Max_GRP_Size,Type,Season)
VALUES 
('Mt Ascutney - North Peak','Weathersfield','VT',5,6,'Hiking','Late Spring'),
('Mt Ascutmey - West Peak','Weathersfield','VT',6,10,'Hiking','Early Fall'),
('Bradbury Mountain Ride','Lewiston-Auburn','ME',25,8,'Biking','Early Fall'),
('Baldpate Mountain','North Newry','ME',6,10,'Hiking','Late Spring'),
('Blueberry Mountain','Batchelders Grant','ME',8,8,'Hiking','Early Fall'),
('Bloomfield - Maidstone','Bloomfield','CT',10,6,'Paddling','Late Spring'),
('Black Pond','Lincoln','NH',8,12,'Hiking','Summer'),
('Big Rock Cave','Tamworth','NH',6,10,'Hiking','Summer'),
('Mt. Cardigan - Firescrew','Orange','NH',7,8,'Hiking','Summer'),
('Chocorua Lake Tour','Tamworth','NH',12,15,'Paddling','Summer'),
('Cadillac Mountain Ride','Bar Harbor','ME',8,16,'Biking','Early Fall'),
('Cadillac Mountain','Bar Harbor','ME',7,8,'Hiking','Late Spring'),
('Cannon Mtn','Franconia','NH',6,6,'Hiking','Early Fall'),
('Crawford Path Presidentials Hike','Crawford Noth','NH',16,4,'Hiking','Summer'),
('Cherry Pond','Whitefield','NH',6,16,'Hiking','Spring'),
('Huguenot Head Hike','Bar Harbor','ME',5,10,'Hiking','Early Fall'),
('Low Bald Spot Hike','Pinkam Notch','NH',8,6,'Hiking','Early Fall'),
('Mason''s Farm','North Stratford','CT',12,7,'Paddling','Late Spring'),
('Lake Mephremagog Tour','Newport','VT',8,15,'Paddling','Late Spring'),
('Long Pond','Rutland','MA',8,12,'Hiking','Summer'),
('Long Pond Tour','Greenville','ME',12,10,'Paddling','Summer'),
('Lower Pond Tour','Poland','ME',8,15,'Paddling','Late Spring'),
('Mt Adams','Randolph','NH',9,6,'Hiking','Summer'),
('Mount Battie Ride','Camden','ME',20,8,'Biking','Early Fall'),
('Mount Cardigan Hike','Cardigan','NH',4,16,'Hiking','Late Fall'),
('Mt. Chocourua','Albany','NH',6,10,'Hiking','Spring'),
('Mount Garfield Hike','Woodstock','NH',5,10,'Hiking','Early Fall'),
('Metacomet-Monadnock Trail Hike','Pelham','MA',10,12,'Hiking','Late Spring'),
('McLennan Reservation Hike','Tyringham','MA',6,16,'Hiking','Summer'),
('Missiquoi River - VT','Lowell','VT',12,10,'Paddling','Summer'),
('Northern Forest Canoe Trail','Stark','NH',15,10,'Paddling','Summer'),
('Park Loop Ride','Mount Desert Island','ME',27,8,'Biking','Late Spring'),
('Pontook Reservoir Tour','Dummer','NH',15,14,'Paddling','Late Spring'),
('Pisgah State Park Ride','Northborough','NH',12,10,'Biking','Summer'),
('Pondicherry Trail Ride','White Mountains','NH',15,16,'Biking','Late Spring'),
('Seal Beach Harbor','Bar Habor','ME',5,16,'Hiking','Early Spring'),
('Sawyer River Ride','Mount Carrigain','NH',10,18,'Biking','Early Fall'),
('Welch and Dickey Mountains Hike','Thorton','NH',5,10,'Hiking','Summer'),
('Wachusett Mountain','Princeton','MA',8,8,'Hiking','Early Spring'),
('Westfield River Loop','Fort Fairfield','ME',20,10,'Biking','Late Spring');


CREATE TABLE CUSTOMER (
Customer_Num CHAR(3) PRIMARY KEY,
Last_Name VARCHAR(25),
First_Name VARCHAR(25),
Address VARCHAR(50),
City VARCHAR(25),
State CHAR(2),
Postal_Code CHAR(5),
Phone CHAR(12));

INSERT INTO CUSTOMER
VALUES 
('101','Northfold','Liam','9 Old Mill Rd.','Londonderry','NH','03053','603-555-7563'),
('102','Ocean','Arnold','2332 South St. Apt 3','Springfield','MA','01101','413-555-3212'),
('103','Kasuma','Sujata','132 Main St. #1','East Hartford','CT','06108','860-555-0703'),
('104','Goff','Ryan','164A South Bend Rd.','Lowell','MA','01854','781-555-8423'),
('105','McLean','Kyle','345 Lower Ave.','Wolcott','NY','14590','585-555-5321'),
('106','Morontoia','Joseph','156 Scholar St.','Johnston','RI','02919','401-555-4848'),
('107','Marchand','Quinn','76 Cross Rd.','Bath','NH','03740','603-555-0456'),
('108','Rulf','Uschi','32 Sheep Stop St.','Edinboro','PA','16412','814-555-5521'),
('109','Caron','Jean Luc','10 Greenfield St.','Rome','ME','04963','207-555-9643'),
('110','Bers','Martha','65 Granite St.','York','NY','14592','585-555-0111'),
('112','Jones','Laura','373 Highland Ave.','Somerville','MA','02143','857-555-6258'),
('115','Vaccari','Adam','1282 Ocean Walk','Ocean City','NJ','08226','609-555-5231'),
('116','Murakami','Iris','7 Cherry Blossom St.','Weymouth','MA','02188','617-555-6665'),
('119','Chau','Clement','18 Ark Ledge Ln.','Londonderry','VT','05148','802-555-3096'),
('120','Gernowski','Sadie','24 Stump Rd.','Athens','ME','04912','207-555-4507'),
('121','Bretton-Borak','Siam','10 Old Main St.','Cambridge','VT','05444','802-555-3443'),
('122','Hefferson','Orlauh','132 South St. Apt 27','Manchester','NH','03101','603-555-3476'),
('123','Barnett','Larry','25 Stag Rd.','Fairfield','CT','06824','860-555-9876'),
('124','Busa','Karen','12 Foster St.','South Windsor','CT','06074','857-555-5532'),
('125','Peterson','Becca','51 Fredrick St.','Albion','NY','14411','585-555-0900'),
('126','Brown','Brianne','154 Central St.','Vernon','CT','06066','860-555-3224');


CREATE TABLE RESERVATION (
Reservation_id CHAR(7) PRIMARY KEY,
Trip_id INT,
Trip_Date DATE,
Num_Persons CHAR(2),
Trip_Price DECIMAL(3,2),
Other_Fees DECIMAL(3,2),
Customer_Num CHAR(3),
FOREIGN KEY (Trip_id) REFERENCES TRIP(Trip_id),
FOREIGN KEY (Customer_Num) REFERENCES Customer(Customer_Num));

ALTER TABLE RESERVATION ALTER COLUMN Trip_Price DECIMAL (5, 2);  
ALTER TABLE RESERVATION ALTER COLUMN Other_Fees DECIMAL (5, 2);  

INSERT INTO RESERVATION
VALUES
('1600001',40,'2016-03-26','2',55.00,0.00,'101'),
('1600002',21,'2016-06-08','2',95.00,0.00,'101'),
('1600003',28,'2016-09-12','1',35.00,0.00,'103'),
('1600004',26,'2016-10-16','4',45.00,15.00,'104'),
('1600005',39,'2016-06-25','5',55.00,0.00,'105'),
('1600006',32,'2016-06-18','1',80.00,20.00,'106'),
('1600007',22,'2016-07-09','8',75.00,10.00,'107'),
('1600008',28,'2016-09-12','2',35.00,0.00,'108'),
('1600009',38,'2016-09-11','2',90.00,40.00,'109'),
('1600010',2,'2016-05-14','3',25.00,0.00,'102'),
('1600011',3,'2016-09-15','3',25.00,0.00,'102'),
('1600012',1,'2016-06-12','4',15.00,0.00,'115'),
('1600013',8,'2016-07-09','1',20.00,5.00,'116'),
('1600014',12,'2016-10-01','2',40.00,5.00,'119'),
('1600015',10,'2016-07-23','1',20.00,0.00,'120'),
('1600016',11,'2016-07-23','6',75.00,15.00,'121'),
('1600017',39,'2016-06-18','3',20.00,5.00,'122'),
('1600018',38,'2016-09-18','4',85.00,15.00,'126'),
('1600019',25,'2016-08-29','2',110.00,25.00,'124'),
('1600020',28,'2016-08-27','2',35.00,10.00,'124'),
('1600021',32,'2016-06-11','3',90.00,20.00,'112'),
('1600022',21,'2016-06-08','1',95.00,25.00,'119'),
('1600024',38,'2016-09-11','1',70.00,30.00,'121'),
('1600025',38,'2016-09-11','2',70.00,45.00,'125'),
('1600026',12,'2016-10-01','2',40.00,0.00,'126'),
('1600029',4,'2016-09-19','4',105.00,25.00,'120'),
('1600030',15,'2016-07-25','6',60.00,15.00,'104');

ALTER TABLE RESERVATION ALTER COLUMN Num_Persons SMALLINT;


CREATE TABLE TRIP_GUIDES (
Trip_id INT,
Guide_Num CHAR(4),
PRIMARY KEY (Trip_id, Guide_num),
FOREIGN KEY (Trip_id) REFERENCES TRIP(Trip_id),
FOREIGN KEY (Guide_Num) REFERENCES GUIDE(Guide_Num));

INSERT INTO TRIP_GUIDES
VALUES
(1,'GZ01'),
(1,'RH01'),
(2,'AM01'),
(2,'SL01'),
(3,'SL01'),
(4,'BR01'),
(4,'GZ01'),
(5,'KS01'),
(5,'UG01'),
(6,'RH01'),
(7,'SL01'),
(8,'BR01'),
(9,'BR01'),
(10,'GZ01'),
(11,'DH01'),
(11,'KS01'),
(11,'UG01'),
(12,'BR01'),
(13,'RH01'),
(14,'KS02'),
(15,'GZ01'),
(16,'KS02'),
(17,'RH01'),
(18,'KS02'),
(19,'DH01'),
(20,'SL01'),
(21,'AM01'),
(22,'UG01'),
(23,'DH01'),
(23,'SL01'),
(24,'BR01'),
(25,'BR01'),
(26,'GZ01'),
(27,'GZ01'),
(28,'BR01'),
(29,'DH01'),
(30,'AM01'),
(31,'SL01'),
(32,'KS01'),
(33,'UG01'),
(34,'KS01'),
(35,'GZ01'),
(36,'KS02'),
(37,'GZ01'),
(38,'KS02'),
(39,'BR01'),
(40,'DH01'),
(41,'BR01');