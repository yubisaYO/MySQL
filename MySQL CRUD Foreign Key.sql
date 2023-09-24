-- 1
USE `onlineshop`;


-- 2
SELECT 
    th.transaction_id, 
    c.customer_name,
    c.customer_gender,
    th.transaction_date
FROM transaction_header AS th 
JOIN customers AS c ON th.customer_id = c.customer_id
WHERE YEAR(th.transaction_date) = 2021;

--3

SELECT 
	td.transaction_id,
    DATE_FORMAT(th.transaction_date, '%M, %d %Y'),
    c.customer_name,
    p.product_name,
   	(p.product_price * td.quantity) AS `Total Price`
FROM transaction_header AS th
JOIN transaction_detail AS td ON th.transaction_id = td.transaction_id
JOIN products AS p ON td.product_id = p.product_id
JOIN customers AS c ON th.customer_id = c.customer_id;

--4
SELECT LOWER(p.product_name) AS `Name of Product`,
	p.product_price AS `Product Price`,
    CONCAT('Discount ',FLOOR((RAND() * 30) + 1), '%') AS `Product Discount`
FROM `products` AS p
WHERE p.product_name LIKE 'laptop %'

UNION
SELECT 
	LOWER(p.product_name) AS `Name of Product`,
	p.product_price AS `Product Price`,
    CONCAT('Discount ',FLOOR((RAND() * 30) + 1), '%') AS `Product Discount`
FROM products AS p
WHERE p.product_price > 2000000;


--5

SELECT 
    s.staff_id AS ID,
    s.staff_name AS Name,
    s.staff_gender AS Gender
FROM `staffs` AS s
WHERE s.staff_id IN ('ST001', 'ST002', 'ST003')

UNION
SELECT
    c.customer_id,
    c.customer_name,
    c.customer_gender
FROM `customers` AS c
WHERE c.customer_id IN ('CU004', 'CU005', 'CU006');


--6

SELECT 
    th.transaction_id,
    th.transaction_date,
    c.customer_id,
    c.customer_name,
    c.customer_gender
FROM `transaction_header` AS th
JOIN customers AS c ON th.customer_id = c.customer_id
WHERE YEAR(th.transaction_date) = 2022 && c.customer_gender =  'Male'
ORDER BY C.customer_name DESC;

--7
ALTER TABLE products 
ADD product_type VARCHAR(8) NULL,
ADD CONSTRAINT v_product_type CHECK(product_type IN ('Laptop', 'Keyboard', 'Mouse', 'Phone', 'Headset'));




--8 

CREATE VIEW StaffWillRetire
AS 
SELECT
    s.staff_id,
    s.staff_name,  
    DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE, s.staff_dob)), '%y')
FROM `staffs` AS s
WHERE DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE, s.staff_dob)), '%y') > 50;



--9
CREATE VIEW BestSeller
AS
SELECT
	p.product_id,
    p.product_name,
    p.product_price,
   	COUNT(td.product_id) AS 'product_sold'
FROM products AS p
JOIN transaction_detail AS td ON td.product_id = p.product_id
GROUP BY td.product_id
HAVING COUNT(td.product_id) >= 2;

--10
START TRANSACTION;

DELETE FROM customers
WHERE YEAR(customer_dob) > 2002;

COMMIT;

























