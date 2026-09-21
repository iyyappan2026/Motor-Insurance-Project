/*
=============================================================
Project  : Monarchy Motor Insurance System
File     : 04_Product_Coverage_and_Premium_Management.sql
Module   : Product, Coverage & Premium Configuration
Author   : K.R Iyyappan
Database : MySQL

Description:
This file creates the insurance product module, coverage
details, and premium rate configuration. It also inserts
sample data and demonstrates JOIN queries to display
product-wise coverage and premium information.

Tables Included:
1. MMI_PRODUCT
2. MMI_COVERAGE
3. MMI_PREMIUM_RATE

Topics Covered:
- CREATE TABLE
- INSERT
- FOREIGN KEY
- INNER JOIN
=============================================================
*/

-- Creating the Product Table --
CREATE TABLE MMI_PRODUCT
(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    product_code VARCHAR(20) UNIQUE,
    description VARCHAR(200),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100)
);

-- Inserting the Records 
INSERT INTO MMI_PRODUCT
(product_name,product_code,description,added_by)
VALUES
('Private Car Insurance','PCI','Insurance for private cars','ADMIN'),
('Commercial Vehicle Insurance','CVI','Insurance for commercial vehicles','ADMIN'),
('Taxi Insurance','TXI','Insurance for taxis','ADMIN'),
('Motorcycle Insurance','MCI','Insurance for motorcycles','ADMIN'),
('Third Party Insurance','TPI','Mandatory third party insurance','ADMIN');

DESC MMI_PRODUCT;
SELECT * FROM MMI_PRODUCT;

-- Creating the Coverage Tbale --
CREATE TABLE MMI_COVERAGE (
    coverage_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    coverage_name VARCHAR(100),
    description VARCHAR(200),
    coverage_amount DECIMAL(12,2),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_PRODUCT_COVERAGE
    FOREIGN KEY(product_id)
    REFERENCES MMI_PRODUCT(product_id)
);

-- Inserting the Records --
INSERT INTO MMI_COVERAGE
(product_id,coverage_name,description,coverage_amount)
VALUES
(1,'Own Damage','Damage to insured vehicle',500000),
(1,'Third Party','Third party liability',300000),
(2,'Commercial Cover','Commercial vehicle protection',800000),
(3,'Taxi Cover','Taxi insurance protection',700000),
(4,'Bike Cover','Motorcycle protection',200000);

-- Creating the Premium Rate --
CREATE TABLE MMI_PREMIUM_RATE (
    rate_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    category_id INT,
    base_rate DECIMAL(10,2),
    gst_percent DECIMAL(5,2),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    
    CONSTRAINT FK_RATE_PRODUCT
    FOREIGN KEY(product_id)
    REFERENCES MMI_PRODUCT(product_id),

    CONSTRAINT FK_RATE_CATEGORY
    FOREIGN KEY(category_id)
    REFERENCES MMI_CATEGORY(category_id)
);

-- Inserting the Records --
INSERT INTO MMI_PREMIUM_RATE
(product_id,category_id,base_rate,gst_percent)
VALUES
(1,1,12000,18),
(2,2,18000,18),
(3,3,15000,18),
(4,4,5000,18),
(5,1,3500,18);

-- Displaying Product with Coverage
SELECT
p.product_name,
c.coverage_name,
c.coverage_amount
FROM MMI_PRODUCT p
INNER JOIN MMI_COVERAGE c
ON p.product_id=c.product_id;

-- Displaying Premium Rate Details
SELECT
p.product_name,
ca.category_desc,
pr.base_rate,
pr.gst_percent
FROM MMI_PREMIUM_RATE pr
INNER JOIN MMI_PRODUCT p
ON pr.product_id=p.product_id
INNER JOIN MMI_CATEGORY ca
ON pr.category_id=ca.category_id;



