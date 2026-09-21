
/*
=============================================================
Project  : Monarchy Motor Insurance System
File     : 01_Database_and_Master_Setup.sql
Module   : Database Creation & Master Tables
Author   : Sakthivel V
Database : MySQL

Description:
This file creates the database and all master tables
required for the Motor Insurance System. It also inserts
the initial master data and verifies the data using
SELECT and JOIN queries.

Tables Included:
1. MMI_MAKE
2. MMI_MODEL
3. MMI_BODY
4. MMI_CATEGORY
5. MMI_COLOR
6. MMI_REGION
7. MMI_STATE
8. MMI_CITY
=============================================================
*/
-- MONARCHY MOTOR INSURANCE PROJECT 


-- creating the Monarchy Motor Insurance database --

CREATE DATABASE monarchy_motor_insurance;

-- selecting our database for the project --
USE monarchy_motor_insurance;

-- create the Vehicle Make table --
CREATE TABLE MMI_MAKE (
    make_id INT PRIMARY KEY AUTO_INCREMENT,
    make_desc VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100)
);

-- To check wheather the table is created --
desc MMI_MAKE;
SHOW TABLES;

-- Inserting the records of vehical make 
INSERT INTO MMI_MAKE
(make_desc, status, added_by)
VALUES
('Toyota', 'ACTIVE', 'ADMIN'),
('Honda', 'ACTIVE', 'ADMIN'),
('Hyundai', 'ACTIVE', 'ADMIN'),
('Ford', 'ACTIVE', 'ADMIN'),
('BMW', 'ACTIVE', 'ADMIN'),
('Benz', 'ACTIVE', 'ADMIN'),
('Audi', 'ACTIVE', 'ADMIN'),
('Kia', 'ACTIVE', 'ADMIN'),
('Tata', 'ACTIVE', 'ADMIN'),
('Mahindra', 'ACTIVE', 'ADMIN'),
('Volkswagen', 'ACTIVE', 'ADMIN'),
('Skoda', 'ACTIVE', 'ADMIN'),
('Nissan', 'ACTIVE', 'ADMIN'),
('Renault', 'ACTIVE', 'ADMIN'),
('MG', 'ACTIVE', 'ADMIN'),
('Jeep', 'ACTIVE', 'ADMIN'),
('Volvo', 'ACTIVE', 'ADMIN'),
('Lexus', 'ACTIVE', 'ADMIN'),
('Jaguar', 'ACTIVE', 'ADMIN'),
('Land Rover', 'ACTIVE', 'ADMIN'),
('Porsche', 'ACTIVE', 'ADMIN'),
('Tesla', 'ACTIVE', 'ADMIN'),
('Maruti Suzuki', 'ACTIVE', 'ADMIN'),
('Citroen', 'ACTIVE', 'ADMIN'),
('BYD', 'ACTIVE', 'ADMIN');

-- Checking wheather the data is inserted --
SELECT * FROM MMI_MAKE;

-- To Count the Records Inserted
SELECT COUNT(*) AS total_makes
FROM MMI_MAKE;

-- creating the Vehicle Model table --
CREATE TABLE MMI_MODEL (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_desc VARCHAR(100) NOT NULL,
    make_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100),

    CONSTRAINT fk_model_make
        FOREIGN KEY (make_id)
        REFERENCES MMI_MAKE(make_id)
);
DESC MMI_MODEL;
-- Inserted the Vehicle Model Record --

INSERT INTO MMI_MODEL
(model_desc, make_id, status, added_by)
VALUES
('Innova', 1, 'ACTIVE', 'ADMIN'),
('Fortuner', 1, 'ACTIVE', 'ADMIN'),
('Camry', 1, 'ACTIVE', 'ADMIN'),
('City', 2, 'ACTIVE', 'ADMIN'),
('Civic', 2, 'ACTIVE', 'ADMIN'),
('Creta', 3, 'ACTIVE', 'ADMIN'),
('Verna', 3, 'ACTIVE', 'ADMIN'),
('i20', 3, 'ACTIVE', 'ADMIN'),
('EcoSport', 4, 'ACTIVE', 'ADMIN'),
('Endeavour', 4, 'ACTIVE', 'ADMIN'),
('3 Series', 5, 'ACTIVE', 'ADMIN'),
('5 Series', 5, 'ACTIVE', 'ADMIN'),
('C-Class', 6, 'ACTIVE', 'ADMIN'),
('E-Class', 6, 'ACTIVE', 'ADMIN'),
('A4', 7, 'ACTIVE', 'ADMIN'),
('A6', 7, 'ACTIVE', 'ADMIN'),
('Seltos', 8, 'ACTIVE', 'ADMIN'),
('Nexon', 9, 'ACTIVE', 'ADMIN'),
('Harrier', 9, 'ACTIVE', 'ADMIN'),
('XUV700', 10, 'ACTIVE', 'ADMIN'),
('Scorpio', 10, 'ACTIVE', 'ADMIN'),
('Polo', 11, 'ACTIVE', 'ADMIN'),
('Rapid', 12, 'ACTIVE', 'ADMIN'),
('Kicks', 13, 'ACTIVE', 'ADMIN'),
('Kiger', 14, 'ACTIVE', 'ADMIN');

SELECT * FROM MMI_MODEL;

-- displaying the Make and Model together by using INNER Joints --
SELECT
    m.make_id,
    m.make_desc,
    mo.model_id,
    mo.model_desc
FROM MMI_MAKE m
INNER JOIN MMI_MODEL mo
    ON m.make_id = mo.make_id;
    
-- creating the Vehicle Body table --
CREATE TABLE MMI_BODY (
    body_id INT PRIMARY KEY AUTO_INCREMENT,
    body_desc VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100)
);
-- Inserting the Records -- 
INSERT INTO MMI_BODY
(body_desc, status, added_by)
VALUES
('Sedan', 'ACTIVE', 'ADMIN'),
('Jeep', 'ACTIVE', 'ADMIN'),
('4x4', 'ACTIVE', 'ADMIN'),
('Wagon', 'ACTIVE', 'ADMIN'),
('Hatchback', 'ACTIVE', 'ADMIN'),
('Tanker', 'ACTIVE', 'ADMIN'),
('Truck', 'ACTIVE', 'ADMIN'),
('Van', 'ACTIVE', 'ADMIN'),
('Bus', 'ACTIVE', 'ADMIN');

SELECT * FROM MMI_BODY;

-- Creating the Category Table --
CREATE TABLE MMI_CATEGORY (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_desc VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100)
);

-- Inserting the values in the Body Table --
INSERT INTO MMI_CATEGORY
(category_desc, status, added_by)
VALUES
('Private', 'ACTIVE', 'ADMIN'),
('Commercial', 'ACTIVE', 'ADMIN'),
('Taxi', 'ACTIVE', 'ADMIN'),
('Motorcycle', 'ACTIVE', 'ADMIN'),
('Sports', 'ACTIVE', 'ADMIN');

SELECT * FROM MMI_CATEGORY;
--  Creating the table for Color --
CREATE TABLE MMI_COLOR (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_desc VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100)
);
-- Inserting the Values in the Color Table --
INSERT INTO MMI_COLOR
(color_desc, status, added_by)
VALUES
('White', 'ACTIVE', 'ADMIN'),
('Black', 'ACTIVE', 'ADMIN'),
('Red', 'ACTIVE', 'ADMIN'),
('Blue', 'ACTIVE', 'ADMIN'),
('Silver', 'ACTIVE', 'ADMIN'),
('Grey', 'ACTIVE', 'ADMIN'),
('Green', 'ACTIVE', 'ADMIN'),
('Brown', 'ACTIVE', 'ADMIN'),
('Yellow', 'ACTIVE', 'ADMIN'),
('Orange', 'ACTIVE', 'ADMIN');

SELECT * FROM MMI_COLOR;

-- Creating the Region Table 
CREATE TABLE MMI_REGION (
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    region_name VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100)
);

-- Inserting the values in the Region Table --
INSERT INTO MMI_REGION
(region_name, status, added_by)
VALUES
('South', 'ACTIVE', 'ADMIN'),
('West', 'ACTIVE', 'ADMIN'),
('North', 'ACTIVE', 'ADMIN'),
('East', 'ACTIVE', 'ADMIN'),
('Central', 'ACTIVE', 'ADMIN');

SELECT * FROM MMI_REGION;

-- Creating the State Table --
CREATE TABLE MMI_STATE (
    state_id INT PRIMARY KEY AUTO_INCREMENT,
    state_name VARCHAR(100) NOT NULL UNIQUE,
    region_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100),

    CONSTRAINT fk_state_region
        FOREIGN KEY (region_id)
        REFERENCES MMI_REGION(region_id)
);

-- Inserting the Values in the State Table --
INSERT INTO MMI_STATE
(state_name, region_id, status, added_by)
VALUES
('Tamil Nadu', 1, 'ACTIVE', 'ADMIN'),
('Kerala', 1, 'ACTIVE', 'ADMIN'),
('Karnataka', 1, 'ACTIVE', 'ADMIN'),
('Andhra Pradesh', 1, 'ACTIVE', 'ADMIN'),
('Telangana', 1, 'ACTIVE', 'ADMIN'),
('Maharashtra', 2, 'ACTIVE', 'ADMIN'),
('Gujarat', 2, 'ACTIVE', 'ADMIN'),
('Goa', 2, 'ACTIVE', 'ADMIN'),
('Rajasthan', 3, 'ACTIVE', 'ADMIN'),
('Punjab', 3, 'ACTIVE', 'ADMIN'),
('Haryana', 3, 'ACTIVE', 'ADMIN'),
('Uttar Pradesh', 3, 'ACTIVE', 'ADMIN'),
('West Bengal', 4, 'ACTIVE', 'ADMIN'),
('Odisha', 4, 'ACTIVE', 'ADMIN'),
('Bihar', 4, 'ACTIVE', 'ADMIN'),
('Madhya Pradesh', 5, 'ACTIVE', 'ADMIN'),
('Chhattisgarh', 5, 'ACTIVE', 'ADMIN'),
('Delhi', 3, 'ACTIVE', 'ADMIN'),
('Uttarakhand', 3, 'ACTIVE', 'ADMIN'),
('Jharkhand', 4, 'ACTIVE', 'ADMIN'),
('Assam', 4, 'ACTIVE', 'ADMIN'),
('Himachal Pradesh', 3, 'ACTIVE', 'ADMIN'),
('Jammu and Kashmir', 3, 'ACTIVE', 'ADMIN'),
('Sikkim', 4, 'ACTIVE', 'ADMIN'),
('Manipur', 4, 'ACTIVE', 'ADMIN');

SELECT * FROM MMI_STATE;

-- Creating the table for the City --
CREATE TABLE MMI_CITY (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    state_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100),

    CONSTRAINT fk_city_state
        FOREIGN KEY (state_id)
        REFERENCES MMI_STATE(state_id)
);
-- Insert the records in the City table --
INSERT INTO MMI_CITY
(city_name, state_id, status, added_by)
VALUES
('Chennai', 1, 'ACTIVE', 'ADMIN'),
('Coimbatore', 1, 'ACTIVE', 'ADMIN'),
('Madurai', 1, 'ACTIVE', 'ADMIN'),
('Tiruchirappalli', 1, 'ACTIVE', 'ADMIN'),
('Salem', 1, 'ACTIVE', 'ADMIN'),
('Kochi', 2, 'ACTIVE', 'ADMIN'),
('Thiruvananthapuram', 2, 'ACTIVE', 'ADMIN'),
('Kozhikode', 2, 'ACTIVE', 'ADMIN'),
('Bengaluru', 3, 'ACTIVE', 'ADMIN'),
('Mysuru', 3, 'ACTIVE', 'ADMIN'),
('Mangaluru', 3, 'ACTIVE', 'ADMIN'),
('Hyderabad', 5, 'ACTIVE', 'ADMIN'),
('Mumbai', 6, 'ACTIVE', 'ADMIN'),
('Pune', 6, 'ACTIVE', 'ADMIN'),
('Ahmedabad', 7, 'ACTIVE', 'ADMIN'),
('Surat', 7, 'ACTIVE', 'ADMIN'),
('Jaipur', 9, 'ACTIVE', 'ADMIN'),
('Jodhpur', 9, 'ACTIVE', 'ADMIN'),
('Chandigarh', 10, 'ACTIVE', 'ADMIN'),
('Lucknow', 12, 'ACTIVE', 'ADMIN'),
('Kolkata', 13, 'ACTIVE', 'ADMIN'),
('Bhubaneswar', 14, 'ACTIVE', 'ADMIN'),
('Patna', 15, 'ACTIVE', 'ADMIN'),
('Bhopal', 16, 'ACTIVE', 'ADMIN'),
('Raipur', 17, 'ACTIVE', 'ADMIN');

SELECT *FROM MMI_CITY;

-- display Region, State, and City together by INNER JOIN nad alo using the ORDERBY
SELECT
    r.region_name,
    s.state_name,
    c.city_name
FROM MMI_REGION r
INNER JOIN MMI_STATE s
    ON r.region_id = s.region_id
INNER JOIN MMI_CITY c
    ON s.state_id = c.state_id
ORDER BY
    r.region_name,
    s.state_name,
    c.city_name;

