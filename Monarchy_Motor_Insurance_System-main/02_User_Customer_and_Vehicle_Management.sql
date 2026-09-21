
/*
=============================================================
Project  : Monarchy Motor Insurance System
File     : 02_User_Customer_and_Vehicle_Management.sql
Module   : User, Customer & Vehicle Management
Author   : Sakthivel V
Database : MySQL

Description:
This file creates all user-related, customer-related,
and vehicle-related tables. It also inserts sample data
and establishes relationships using foreign keys.

Tables Included:
1. MMI_USER_ROLE
2. MMI_USER
3. MMI_LOGIN
4. MMI_BROKER
5. MMI_CUSTOMER
6. MMI_VEHICLE
=============================================================
*/
USE monarchy_motor_insurance;
-- creating the User Role table --
CREATE TABLE MMI_USER_ROLE
(
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100)
);

-- Inserting the Recordds --
INSERT INTO MMI_USER_ROLE
(role_name,added_by)
VALUES
('Admin','ADMIN'),
('Underwriter','ADMIN'),
('Operational User','ADMIN'),
('Broker','ADMIN'),
('Sales Agent','ADMIN');

SELECT * FROM MMI_USER_ROLE;

-- Creating the user table 
CREATE TABLE MMI_USER (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    gender VARCHAR(10),
    dob DATE,
    email VARCHAR(100) UNIQUE,
    mobile VARCHAR(15),
    address VARCHAR(200),
    city_id INT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(100),
    
    CONSTRAINT FK_USER_ROLE
    FOREIGN KEY(role_id)
    REFERENCES MMI_USER_ROLE(role_id),
    CONSTRAINT FK_USER_CITY
    FOREIGN KEY(city_id)
    REFERENCES MMI_CITY(city_id)
);

-- Inserting the MMI_user records --
INSERT INTO MMI_USER
(role_id,first_name,last_name,gender,dob,email,mobile,address,city_id,added_by)
VALUES
(1,'Sakthi','Vel','Male','2005-05-30','sakthi@gmail.com','9876543210','Chennai',1,'ADMIN'),
(2,'Arun','Kumar','Male','1995-08-20','arun@gmail.com','9876543211','Madurai',2,'ADMIN'),
(3,'Priya','Devi','Female','1998-02-15','priya@gmail.com','9876543212','Coimbatore',3,'ADMIN'),
(4,'Rahul','Raj','Male','1993-10-25','rahul@gmail.com','9876543213','Salem',4,'ADMIN'),
(5,'Meena','Lakshmi','Female','1999-12-10','meena@gmail.com','9876543214','Trichy',5,'ADMIN');

SELECT * FROM MMI_USER;

DESC MMI_USER;

-- Creating the Login Table 
CREATE TABLE MMI_LOGIN (
    login_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_LOGIN_USER
    FOREIGN KEY(user_id)
    REFERENCES MMI_USER(user_id)
);
DESC MMI_LOGIN;

-- Inserting the Login Records 

INSERT INTO MMI_LOGIN
(user_id,username,password)
VALUES
(1,'admin','admin123'),
(2,'underwriter','uw123'),
(3,'operation','op123'),
(4,'broker1','broker123'),
(5,'sales1','sales123');

SELECT * FROM MMI_LOGIN;

-- Creating the Broker table --
CREATE TABLE MMI_BROKER(
    broker_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    organisation_name VARCHAR(100),
    commission_percent DECIMAL(5,2),
    prepaid_credit DECIMAL(12,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_BROKER_USER
    FOREIGN KEY(user_id)
    REFERENCES MMI_USER(user_id)
);
DESC MMI_BROKER;
-- Inserting the Records of Broker 
INSERT INTO MMI_BROKER
(user_id,organisation_name,commission_percent,prepaid_credit)
VALUES
(4,'ABC Insurance',10.50,50000);
SELECT * FROM MMI_BROKER ;


SELECT * FROM MMI_CATEGORY;
-- Creating the Customer Table

CREATE TABLE MMI_CUSTOMER (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    dob DATE,
    mobile VARCHAR(15),
    email VARCHAR(100),
    national_id VARCHAR(20),
    city_id INT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_CUSTOMER_CITY
    FOREIGN KEY(city_id)
    REFERENCES MMI_CITY(city_id)
);

-- Inserting the Records of MMI_CUSTOMER --

INSERT INTO MMI_CUSTOMER
(first_name,last_name,gender,dob,mobile,email,national_id,city_id)
VALUES
('Ajith','Kumar','Male','1990-04-12','9000000001','ajith@gmail.com','123456789001',1),
('Vijay','Raj','Male','1989-06-15','9000000002','vijay@gmail.com','123456789002',2),
('Anitha','Rani','Female','1995-07-21','9000000003','anitha@gmail.com','123456789003',3),
('Karthik','M','Male','1992-09-17','9000000004','karthik@gmail.com','123456789004',4),
('Divya','S','Female','1996-12-11','9000000005','divya@gmail.com','123456789005',5);

SELECT * FROM MMI_CUSTOMER ;

-- Creating the vehicle Table 
CREATE TABLE MMI_VEHICLE(
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    make_id INT NOT NULL,
    model_id INT NOT NULL,
    color_id INT NOT NULL,
    category_id INT NOT NULL,
    registration_no VARCHAR(20) UNIQUE,
    manufacture_year YEAR,
    chassis_no VARCHAR(50),
    engine_no VARCHAR(50),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_VEHICLE_CUSTOMER
    FOREIGN KEY(customer_id)
    REFERENCES MMI_CUSTOMER(customer_id),
    CONSTRAINT FK_VEHICLE_MAKE
    FOREIGN KEY(make_id)
    REFERENCES MMI_MAKE(make_id),
    CONSTRAINT FK_VEHICLE_MODEL
    FOREIGN KEY(model_id)
    REFERENCES MMI_MODEL(model_id),
    CONSTRAINT FK_VEHICLE_COLOR
    FOREIGN KEY(color_id)
    REFERENCES MMI_COLOR(color_id),
    CONSTRAINT FK_VEHICLE_CATEGORY
    FOREIGN KEY(category_id)
    REFERENCES MMI_CATEGORY(category_id)
);
DESC MMI_VEHICLE;

-- Inserting the Records of Vehicle --
INSERT INTO MMI_VEHICLE
(customer_id,make_id,model_id,color_id,category_id,registration_no,manufacture_year,chassis_no,engine_no)
VALUES
(1,1,1,1,1,'TN01AB1234',2024,'CH1001','EN1001'),
(2,2,3,2,1,'TN02CD5678',2023,'CH1002','EN1002'),
(3,3,5,3,2,'TN03EF9012',2022,'CH1003','EN1003'),
(4,1,2,4,1,'TN04GH3456',2024,'CH1004','EN1004'),
(5,2,4,5,3,'TN05IJ7890',2023,'CH1005','EN1005');
SHOW TABLES;
