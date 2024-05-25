-- Ch1. 

-- 1)
SELECT CUSTOMER_NAME
FROM CUSTOMER
WHERE CREDIT_LIMIT>=7500;

-- 2) 
SELECT ORDER_NUM
FROM ORDERS
WHERE CUSTOMER_NUM = 586
AND ORDER_DATE = '2015-10-15'; 

-- 3) 
SELECT ITEM_NUM, ITEM_DESCRIPTION, (ON_HAND * PRICE) AS ON_HAND_VALUE
FROM ITEM
WHERE CATEGORY = 'TOY';

-- 4) 
SELECT ITEM_NUM, ITEM_DESCRIPTION
FROM ITEM 
WHERE CATEGORY = 'PZL';

-- 5) 
SELECT COUNT(*)
FROM CUSTOMER
WHERE BALANCE>CREDIT_LIMIT;

-- 6) 
SELECT ITEM_NUM, ITEM_DESCRIPTION, PRICE
FROM ITEM
WHERE price = (SELECT MIN(price) FROM item);

-- 7) 
SELECT o.order_num, o.order_date, o.customer_num, c.customer_name
FROM orders o
JOIN customer c ON c.CUSTOMER_NUM=o.CUSTOMER_NUM;

-- NOTE: This is done in oracle but it can also work in MySQL too:
   SELECT ORDER_NUM, ORDER_DATE, CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME
   FROM ORDERS, CUSTOMER
   WHERE ORDERS.CUSTOMER_NUM = CUSTOMER.CUSTOMER_NUM;

-- 8) 
SELECT o.order_num, o.order_date, o.customer_num, c.customer_name
FROM  orders o
JOIN customer c ON  o.customer_num = c.customer_num
AND order_date = '2015-10-13';

-- NOTE: This can also work in MySQL too:
   SELECT ORDER_NUM, CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME
   FROM ORDERS, CUSTOMER
   WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
   AND ORDER_DATE = '2015-10-13';

-- 9) 
SELECT r.rep_num, r.last_name, r.first_name
FROM REP r
JOIN customer c ON c.rep_num = r.rep_num
AND credit_limit = 10000;

-- NOTE: This is done in oracle but it can also work in MySQL too:
   SELECT REP.REP_NUM, LAST_NAME, FIRST_NAME
   FROM REP, CUSTOMER
   WHERE REP.REP_NUM = CUSTOMER.REP_NUM
   AND CREDIT_LIMIT = 10000; 

-- 10) 
SELECT o.order_num, i.item_num, i.item_description, i.category
FROM item i
JOIN order_line ol ON ol.item_num = i.item_num
JOIN orders o ON o.order_num = ol.order_num   
AND order_date = '2015-10-12';

-- NOTE: You could also do this with the customers name showing who ordered it:
   SELECT o.order_num, i.item_num, i.item_description, i.category, c.customer_name
   FROM item i, orders o, order_line ol, customer c
   WHERE ol.item_num = i.item_num
   AND o.order_num = ol.order_num   
   AND c.customer_num = o.CUSTOMER_NUM
   AND order_date = '2015-10-12';



-- Ch4.

-- 1) 
SELECT item_num, item_description, price
FROM item; 

-- 2) 
SELECT *
FROM orders;

-- 3) 
SELECT customer_name, credit_limit
FROM customer
WHERE credit_limit >= 10000;

-- 4) 
SELECT order_num
FROM orders
WHERE customer_num = '126'
AND order_date = 2015-10-15;

-- 5) 
SELECT customer_num, customer_name
FROM customer
WHERE rep_num IN (30, 45);

-- 6) 
SELECT item_num, item_description
FROM item
WHERE NOT (category = 'PZL');

-- 7) 
SELECT item_num, item_description, on_hand
FROM item
WHERE on_hand BETWEEN 20 AND 40;
-- NOTE:can also do it this way:
   SELECT item_num, item_description, on_hand
   FROM item
   WHERE on_hand <= 40 
   AND on_hand >= 20;
-- NOTE: for both of these ways, we can add a last line of: 	ORDER BY on_hand desc;

-- 8) 
SELECT item_num, item_description, (on_hand * price) AS on_hand_value
FROM item
WHERE category = 'TOY' ; 

-- 9) 
SELECT item_num, item_description, (on_hand * price) AS on_hand_value
FROM item
WHERE (on_hand * price) >= 1500 ; 

-- 10) 
SELECT item_num, item_description
FROM item
WHERE category IN ('GME', 'PZL');

-- 11) 
SELECT customer_num, customer_name
FROM customer
WHERE customer_name LIKE 'C%';

-- 12) 
SELECT *
FROM item
ORDER BY item_description;   

-- 13) 
SELECT *
FROM item 
ORDER BY storehouse, item_num;

-- 14) 
SELECT COUNT(*)
FROM customer
WHERE balance > credit_limit;

-- 15) 
SELECT SUM(balance)
FROM customer
WHERE rep_num = 15
AND balance < credit_limit;

-- 16) 
SELECT item_num, item_description, on_hand
FROM item
WHERE on_hand >
(SELECT AVG(on_hand)
FROM item);

-- 17) 
SELECT MIN(price) 
FROM item;

-- 18) 
SELECT item_num, item_description, price
FROM item 
WHERE price = 
(SELECT MIN(price) 
FROM item);  

-- 19) 
SELECT rep_num, SUM(balance)
FROM customer
GROUP BY rep_num
ORDER BY rep_num; 

-- 20) 
SELECT rep_num, SUM(BALANCE)
FROM customer
GROUP BY rep_num
HAVING SUM(balance) > 5000
ORDER BY rep_num;

-- 21) 
SELECT item_num
FROM item 
WHERE item_description = 'unknown';

-- 22) 
SELECT item_num, item_description, category 
FROM item
WHERE (category ='PZL' OR category = 'TOY')
AND item_description LIKE '%SET%';

-- 23) 
SELECT item_num, item_description, price, (price - (price * 0.10) )  AS Discounted_price
FROM item;



-- Ch5.

-- 1) 
SELECT order_num, order_date, customer_name, customer.customer_num
FROM orders, customer
WHERE orders.customer_num = customer.customer_num;

-- 2) 
SELECT order_num, customer_name, customer.customer_num
FROM orders, customer
WHERE orders.customer_num = customer.customer_num 
AND order_date = '2015-10-15'; 

-- 3) 
SELECT orders.order_num, order_date, item_num, num_ordered, quoted_price
FROM orders, order_line
WHERE orders.order_num = order_line.order_num;

-- 4) 
SELECT customer.customer_num, customer_name
FROM customer, orders
WHERE customer.customer_num = orders.customer_num
AND order_date = '2015-10-15';
-- NOTE: The above will show us each order made but for this question problem we will use the IN function to only know the customers who had placed an order:
	SELECT customer.customer_num, customer_name
	FROM customer
	WHERE customer_num IN 
	(SELECT customer_num 
	FROM orders
	WHERE order_date = '2015-10-15');

-- 5) 
SELECT customer.customer_num, customer_name
FROM customer
WHERE EXISTS 
(SELECT * 
FROM orders
WHERE customer.customer_num = orders.customer_num
AND order_date = '2015-10-15');

-- 6) 
SELECT customer_num, customer_name
FROM customer
WHERE customer_num NOT IN 
(SELECT customer_num
FROM orders
WHERE order_date = '2015-10-15');

-- 7) 
Select orders.order_num, order_date, item.item_num, item_description, category
FROM orders, order_line, item
WHERE orders.order_num = order_line.order_num
AND item.item_num = order_line.item_num;

-- 8) 
Select orders.order_num, order_date, item.item_num, item_description, category
FROM orders, order_line, item
WHERE orders.order_num = order_line.order_num
AND item.item_num = order_line.item_num
ORDER BY category, orders.order_num;

-- 9) 
SELECT rep_num, last_name, first_name
FROM rep
WHERE rep_num IN
(SELECT rep_num
FROM customer
WHERE credit_limit IN 
(SELECT credit_limit
FROM customer
WHERE credit_limit = 10000));

-- 10) 
SELECT customer.rep_num, last_name, first_name, credit_limit
FROM customer, rep
WHERE rep.rep_num = customer.rep_num
AND credit_limit = 10000; 
 
-- 11) 
SELECT customer.customer_num, customer_name
FROM customer, item, orders, order_line
WHERE customer.customer_num = orders.customer_num
AND orders.order_num = order_line.order_num
AND order_line.item_num = item.item_num
AND item_description = 'Rocking Horse';

-- 12) 
SELECT F.ITEM_NUM, F.item_description, S.ITEM_NUM, S.item_description, S.CATEGORY
FROM ITEM F, ITEM S
WHERE F.CATEGORY = S.CATEGORY
AND F.ITEM_NUM <> S.ITEM_NUM
ORDER BY F.CATEGORY;

-- 13) 
SELECT order_num, order_date, customer_name
FROM orders, customer
WHERE orders.customer_num = customer.customer_num
AND customer_name = 'Johnson''s Department Store';

-- 14) 
SELECT orders.order_num, order_date
FROM orders, item, order_line
WHERE orders.order_num = order_line.order_num 
AND order_line.item_num = item.item_num
AND item_description = 'Fire Engine'; 

-- 16) 
SELECT orders.order_date, order_line.order_num
FROM order_line, orders
WHERE order_line.item_num = 'TW35' AND
orders.customer_num = '586'
AND orders.order_num = order_line.order_num;

-- 17) 
SELECT orders.order_date, order_line.order_num
FROM order_line, orders
WHERE orders.order_num = order_line.order_num
AND orders.customer_num = '586'
AND NOT(order_line.item_num = 'TW35');

-- 18) 
SELECT item_num, item_description, price, category
FROM item
WHERE price > ALL
(SELECT price
FROM item
WHERE category = 'GME'); 

-- 20) 
SELECT item_num, item_description, price, category
FROM item
WHERE price > ANY
(SELECT price
FROM item
WHERE category = 'GME'); 



-- Ch.6

-- 1) 
Create Table NONGAME
(ITEM_NUM CHAR(4) PRIMARY KEY,
DESCRIPTION CHAR(30),
ON_HAND DECIMAL(4,0),
CATEGORY CHAR (3),
PRICE DECIMAL (6,2) );


-- 2) 
INSERT INTO NONGAME 
SELECT ITEM_NUM, ITEM_DESCRIPTION, ON_HAND, CATEGORY, PRICE
FROM ITEM
WHERE NOT (CATEGORY = 'GME') ;


-- 3) 
UPDATE NONGAME
SET DESCRIPTION = 'Classic Train Set'
WHERE ITEM_NUM = 'DL51';


-- 4) 
UPDATE NONGAME
SET PRICE = (PRICE * 1.02)
WHERE CATEGORY = 'TOY';

-- 5) 
INSERT INTO NONGAME
VALUES
('TL92','Dump Truck', 10,'TOY', 59.95);

-- 6) 
DELETE 
FROM NONGAME
WHERE CATEGORY = 'PZL';

-- 7) 
UPDATE NONGAME 
SET CATEGORY = ''
WHERE ITEM_NUM = 'FD11';


-- 8) 
ALTER table NONGAME 
ADD ON_HAND_VALUE DECIMAL(7,2);

-- 9) 
UPDATE NONGAME
SET ON_HAND_VALUE = (ON_HAND * PRICE);


-- 10) 
ALTER table NONGAME
MODIFY DESCRIPTION CHAR(40); 

DROP TABLE NONGAME;
