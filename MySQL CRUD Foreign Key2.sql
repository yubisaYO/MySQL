
1. Create new table employee_positions with the following criteria:
employee_position_id CHAR(5), Primary Key, Must be in the format of PSXXX where X is a number between 0-9
employee_position_name VARCHAR(30) NOT NULL

CREATE TABLE `employee_positions`(
	employee_position_id CHAR(5) PRIMARY KEY CHECK(employee_position_id REGEXP 'PS[0-9][0-9][0-9]'),
    employee_position_name VARCHAR(30) NOT NULL                                                 
                                                         
)


2. Insert the following values into the employee_positions table:
PS001 Junior Employee
PS002 Senior Employee
PS003 Cleaning Staff
PS004 Manager

INSERT INTO `employee_positions`
VALUES('PS001', 'Junior Employee'),
('PS002', 'Senior Employee'),
('PS003', 'Junior Employee'),
('PS004', 'Manager')





3. Create new column on baristas with the following criteria:
employee_position_id CHAR(5), FOREIGN KEY that reference table barista_grades, nullable

ALTER TABLE `employees`
ADD COLUMN `employee_position_id` CHAR(5),
ADD FOREIGN KEY(employee_position_id)
	REFERENCES employee_positions(employee_position_id);


4. Create foreign key constraint from transaction_headers to transaction_details

ALTER TABLE `transaction_details`
ADD FOREIGN KEY(transaction_id) 
	REFERENCES transaction_headers(transaction_id);


5. Update the position of the employee that has an employee_id of 'EM001' to 'PS002' and update the salary to 10000000!
UPDATE `employees`
UPDATE `employees`
SET employee_position_id = 'PS003',
employee_salary = 300
WHERE employee_id = 'EM001';




6. Delete employee whose employee_address ends with ‘ Street’ using transaction.
START TRANSACTION;

DELETE FROM `employee`
WHERE employee_address LIKE '% Street';

ROLLBACK; / COMMIT;


7. Display transaction_id, ice_cream_name, Price (obtained from quantity * ice_cream_price * 10000/ice_cream_size_quantity) rounded to 3 place decimal and ‘Rp. ’ added to the start of the price), Transaction Date (obtained from transaction_date like the following format ‘Dec 25, 2022’) for every ice cream that has the size of large. 


SELECT th.transaction_id AS transaction_id,
ic.ice_cream_name AS ice_cream_name,
CONCAT('Rp. ', ROUND((td.quantity * 1000 / iz.ice_cream_size_quantity), 3)) AS PRICE,
DATE_FORMAT(th.transaction_date, '%b %e, %Y') AS 'transaction date'
FROM transaction_headers as th 
JOIN transaction_details AS td ON th.transaction_id = td.transaction_id
JOIN ice_creams AS ic ON td.ice_cream_id = ic.ice_cream_id
JOIN ice_cream_sizes AS iz ON td.ice_cream_size_id = iz.ice_cream_size_id
WHERE iz.ice_cream_size_name = 'Large';


8. Display employee_id, Last Name (get from last name of employee, in uppercase format), all employees that has handled a transaction on December 25, 2021.
ELE

SELECT e.employee_id,
REVERSE(UPPER(SUBSTRING(REVERSE(employee_name), 1, POSITION(' ' IN REVERSE(employee_name))))) 
FROM transaction_headers AS th 
JOIN employees AS e ON th.employee_id = e.employee_id
WHERE YEAR(th.transaction_date) = 2021 AND DAY(th.transaction_date) = 25 AND  MONTH(th.transaction_date) = 12;

SELECT RIGHT(employee_name, POSITION(' ' IN REVERSE(employee_name))) FROM `employees`;






