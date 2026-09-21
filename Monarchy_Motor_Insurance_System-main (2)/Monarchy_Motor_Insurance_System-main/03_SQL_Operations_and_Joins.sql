/*
=============================================================
Project  : Monarchy Motor Insurance System
File     : 03_SQL_Operations_and_Joins.sql
Module   : SQL Operations & Data Retrieval
Author   : K.R Iyyappan
Database : MySQL

Description:
This file demonstrates SQL operations performed on the
Motor Insurance database. It includes schema changes,
data manipulation, aggregate functions, grouping,
filtering, and different types of JOIN operations.

Topics Covered:
1. ALTER TABLE
2. UPDATE
3. DELETE
4. Aggregate Functions
5. GROUP BY
6. HAVING
7. INNER JOIN
8. LEFT JOIN
9. RIGHT JOIN
=============================================================
*/

-- adding a new column using ALTER TABLE --
ALTER TABLE MMI_CUSTOMER
ADD occupation VARCHAR(50);

DESC MMI_CUSTOMER;

-- Modifying the Coloumn using the ALTER TABLE 
ALTER TABLE MMI_CUSTOMER
MODIFY occupation VARCHAR(100);

-- rename a column using the Alter Table 
ALTER TABLE MMI_CUSTOMER
RENAME COLUMN occupation TO profession;

-- To Delete a Column --
ALTER TABLE MMI_CUSTOMER
DROP COLUMN profession;

-- Update a Column using the Update Keyword 
UPDATE MMI_CUSTOMER
SET mobile='9999999999'
WHERE customer_id=1;

SELECT * FROM MMI_CUSTOMER
WHERE customer_id=1;

-- Update the Multiple Column 
UPDATE MMI_CUSTOMER
SET
email='newmail@gmail.com',
mobile='8888888888'
WHERE customer_id=2;

-- To DELETE the Particular Column 
DELETE FROM MMI_CUSTOMER
WHERE customer_id=5;

-- To delete the Entire  Table 
DELETE FROM MMI_CUSTOMER;


-- To Count the Total Customer --
SELECT COUNT(*) AS Total_Customers
FROM MMI_CUSTOMER;

-- Count customers city-wise --
SELECT
city_id,
COUNT(*) AS Total_Customers
FROM MMI_CUSTOMER
GROUP BY city_id;

-- To Find the Average Manufacture Year --
SELECT AVG(manufacture_year)
FROM MMI_VEHICLE;

-- maximum manufactur year and the minimum Manufacture YEAR
SELECT MAX(manufacture_year)
FROM MMI_VEHICLE;
SELECT MIN(manufacture_year)
FROM MMI_VEHICLE;

-- Group BY 
SELECT
gender,
COUNT(*) AS Total
FROM MMI_CUSTOMER
GROUP BY gender;

-- HAVING
SELECT
gender,
COUNT(*) AS Total
FROM MMI_CUSTOMER
GROUP BY gender
HAVING COUNT(*)>2;

SELECT * FROM MMI_CUSTOMER;

-- INNER JOIN
SELECT
c.customer_id,
c.first_name,
v.registration_no
FROM MMI_CUSTOMER c
INNER JOIN MMI_VEHICLE v
ON c.customer_id=v.customer_id;
-- LEFT JOIN 
SELECT
c.customer_id,
c.first_name,
v.registration_no
FROM MMI_CUSTOMER c
LEFT JOIN MMI_VEHICLE v
ON c.customer_id=v.customer_id;

-- RIGHT JOIN
SELECT
c.customer_id,
c.first_name,
v.registration_no
FROM MMI_CUSTOMER c
RIGHT JOIN MMI_VEHICLE v
ON c.customer_id=v.customer_id;

-- Display Customer Name with Vehicle Make --
SELECT
c.first_name,
m.make_desc
FROM MMI_CUSTOMER c
INNER JOIN MMI_VEHICLE v
ON c.customer_id=v.customer_id
INNER JOIN MMI_MAKE m
ON v.make_id=m.make_id;
