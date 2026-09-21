/*
=============================================================
Project  : Monarchy Motor Insurance System
File     : 05_Quote_Management.sql
Module   : Quote Management
Author   : K.R Iyyappan
Database : MySQL

Description:
This file creates the Quote and Quote Detail tables,
stores insurance quote information, and demonstrates
quote reports using JOINs, Subqueries, and CASE
statements for premium categorization.

Tables Included:
1. MMI_QUOTE
2. MMI_QUOTE_DETAIL

Topics Covered:
- CREATE TABLE
- INSERT
- FOREIGN KEY
- INNER JOIN
- SUBQUERY
- CASE Statement
=============================================================
*/

USE monarchy_motor_insurance;
-- Creating the QUOTE Table 
CREATE TABLE MMI_QUOTE(
    quote_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    product_id INT NOT NULL,
    quote_date DATE,
    quote_status VARCHAR(30) DEFAULT 'PENDING',
    total_premium DECIMAL(12,2),
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_QUOTE_CUSTOMER
    FOREIGN KEY(customer_id)
    REFERENCES MMI_CUSTOMER(customer_id),
    CONSTRAINT FK_QUOTE_VEHICLE
    FOREIGN KEY(vehicle_id)
    REFERENCES MMI_VEHICLE(vehicle_id),

    CONSTRAINT FK_QUOTE_PRODUCT
    FOREIGN KEY(product_id)
    REFERENCES MMI_PRODUCT(product_id)
);

-- Inserting the Values 
INSERT INTO MMI_QUOTE(
    customer_id,
    vehicle_id,
    product_id,
    quote_date,
    quote_status,
    total_premium
)
VALUES(1,1,1,CURDATE(),'PENDING',14160);

-- Creating the  QUote Details TABle --
CREATE TABLE MMI_QUOTE_DETAIL(
    quote_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    quote_id INT,
    coverage_id INT,
    coverage_amount DECIMAL(12,2),
    premium DECIMAL(12,2),

    CONSTRAINT FK_QUOTEDETAIL_QUOTE
    FOREIGN KEY(quote_id)
    REFERENCES MMI_QUOTE(quote_id),

    CONSTRAINT FK_QUOTEDETAIL_COVERAGE
    FOREIGN KEY(coverage_id)
    REFERENCES MMI_COVERAGE(coverage_id)
); 

-- Insert the Values 
INSERT INTO MMI_QUOTE_DETAIL
(quote_id,
coverage_id,
coverage_amount,
premium)
VALUES
(1,1,500000,9000),
(1,2,300000,3000);

-- Displaying the Complete QUOTE information 
SELECT
q.quote_id,
CONCAT(c.first_name,' ',c.last_name) AS Customer,
p.product_name,
v.registration_no,
q.quote_status,
q.total_premium
FROM MMI_QUOTE q
INNER JOIN MMI_CUSTOMER c
ON q.customer_id=c.customer_id
INNER JOIN MMI_PRODUCT p
ON q.product_id=p.product_id
INNER JOIN MMI_VEHICLE v
ON q.vehicle_id=v.vehicle_id;

-- Display Customers whose Premium is greater than the Average Premium by using Subquery
SELECT 
    quote_id, customer_id, total_premium
FROM
    MMI_QUOTE
WHERE
    total_premium > (SELECT 
            AVG(total_premium)
        FROM
            MMI_QUOTE);
 
 -- Customers who selected Private Car Insurance
SELECT 
    customer_id, first_name, last_name
FROM
    MMI_CUSTOMER
WHERE
    customer_id IN (SELECT 
            customer_id
        FROM
            MMI_QUOTE
        WHERE
            product_id = (SELECT 
                    product_id
                FROM
                    MMI_PRODUCT
                WHERE
                    product_name = 'Private Car Insurance'));  
   
   
	SELECT 
    quote_id,
    total_premium,
    CASE
        WHEN total_premium < 5000 THEN 'LOW PREMIUM'
        WHEN total_premium BETWEEN 5000 AND 15000 THEN 'MEDIUM PREMIUM'
        ELSE 'HIGH PREMIUM'
    END AS Premium_Category
FROM
    MMI_QUOTE;

