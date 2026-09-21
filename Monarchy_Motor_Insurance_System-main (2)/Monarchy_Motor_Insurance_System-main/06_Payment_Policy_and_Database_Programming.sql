/*
=============================================================
Project  : Monarchy Motor Insurance System
File     : 06_Payment_Policy_and_Database_Programming.sql
Module   : Payment, Policy & Database Programming
Author   : K.R Iyyappan
Database : MySQL

Description:
This file implements the final stage of the Motor
Insurance System. It handles payment processing,
policy generation, policy schedule creation,
credit/debit notes, stored procedures, functions,
transactions, and policy reports.

Tables Included:
1. MMI_PAYMENT
2. MMI_POLICY
3. MMI_POLICY_SCHEDULE
4. MMI_CREDIT_NOTE
5. MMI_DEBIT_NOTE

Topics Covered:
- CREATE TABLE
- INSERT
- Stored Procedure
- Function
- START TRANSACTION
- COMMIT
- ROLLBACK
- INNER JOIN
=============================================================
*/

USE monarchy_motor_insurance;

-- Creating the Payment Table --
CREATE TABLE MMI_PAYMENT
(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    quote_id INT NOT NULL,
    payment_date DATE,
    payment_mode VARCHAR(50),
    amount DECIMAL(12,2),
    payment_status VARCHAR(30),
    transaction_reference VARCHAR(100),
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_PAYMENT_QUOTE
    FOREIGN KEY (quote_id)
    REFERENCES MMI_QUOTE(quote_id)
);
-- Insertiing the Records --
INSERT INTO MMI_PAYMENT
(quote_id,payment_date,payment_mode,amount,payment_status,transaction_reference)
VALUES(1,CURDATE(),'UPI',14160,'SUCCESS','TXN100001');

-- Creating the Policy Table --
CREATE TABLE MMI_POLICY(
    policy_id INT PRIMARY KEY AUTO_INCREMENT,
    quote_id INT,
    payment_id INT,
    policy_number VARCHAR(50) UNIQUE,
    issue_date DATE,
    start_date DATE,
    end_date DATE,
    policy_status VARCHAR(30),
    total_premium DECIMAL(12,2),
    CONSTRAINT FK_POLICY_QUOTE
    FOREIGN KEY(quote_id)
    REFERENCES MMI_QUOTE(quote_id),
    CONSTRAINT FK_POLICY_PAYMENT
    FOREIGN KEY(payment_id)
    REFERENCES MMI_PAYMENT(payment_id)
);
-- Inserting the Records --
INSERT INTO MMI_POLICY
(quote_id,payment_id,policy_number,issue_date,start_date,end_date,policy_status,total_premium)
VALUES(1,1,'POL202600001',CURDATE(),CURDATE(),DATE_ADD(CURDATE(),INTERVAL 1 YEAR),'ACTIVE',14160);

SELECT * FROM MMI_POLICY;

-- Creating the Policy Schedule Table --
CREATE TABLE MMI_POLICY_SCHEDULE(
schedule_id INT PRIMARY KEY AUTO_INCREMENT,
policy_id INT,
schedule_description VARCHAR(300),
generated_date DATE,

CONSTRAINT FK_POLICY_SCHEDULE
FOREIGN KEY(policy_id)
REFERENCES MMI_POLICY(policy_id)
);
-- Inserting the Records of Policy Schedule Table --
INSERT INTO MMI_POLICY_SCHEDULE
(policy_id,schedule_description,generated_date)
VALUES(1,'Private Car Insurance Schedule Generated Successfully',CURDATE());
SELECT * FROM MMI_POLICY_SCHEDULE;

-- Creating the Credit Note Table --
CREATE TABLE MMI_CREDIT_NOTE(
credit_note_id INT PRIMARY KEY AUTO_INCREMENT,
policy_id INT,
credit_amount DECIMAL(12,2),
reason VARCHAR(200),
credit_date DATE,

FOREIGN KEY(policy_id)
REFERENCES MMI_POLICY(policy_id)
); 

-- Inserting the Records of the Credit note Table --
INSERT INTO MMI_CREDIT_NOTE
(policy_id,credit_amount,reason,credit_date)
VALUES
(1,500,'Excess Premium Refund',CURDATE());

SELECT * FROM MMI_CREDIT_NOTE ;

-- Creating the Debit Note Table --
CREATE TABLE MMI_DEBIT_NOTE
(
debit_note_id INT PRIMARY KEY AUTO_INCREMENT,
policy_id INT,
debit_amount DECIMAL(12,2),
reason VARCHAR(200),
debit_date DATE,
FOREIGN KEY(policy_id)
REFERENCES MMI_POLICY(policy_id)
);

-- Inserting the Records of Debit Note Table --
INSERT INTO MMI_DEBIT_NOTE(policy_id,debit_amount,reason,debit_date)
VALUES
(1,1000,'Additional Coverage Added',CURDATE());

SELECT * FROM MMI_DEBIT_NOTE ;

-- Stored Procedure
DELIMITER $$

CREATE PROCEDURE GET_ALL_POLICIES()
BEGIN
SELECT
policy_number,
issue_date,
total_premium,
policy_status
FROM MMI_POLICY;
END $$

DELIMITER ;

CALL GET_ALL_POLICIES();

-- Function 
DELIMITER $$

CREATE FUNCTION CALCULATE_GST
(premium DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN premium*0.18;
END $$

DELIMITER ;

SELECT
CALCULATE_GST(14160);


-- START TRANSACTION --
START TRANSACTION;

INSERT INTO MMI_PAYMENT(quote_id,payment_date,payment_mode,amount,payment_status,transaction_reference)
VALUES(1,CURDATE(),'CARD',14160,'SUCCESS','TXN100002');

COMMIT;

START TRANSACTION;

INSERT INTO MMI_PAYMENT(quote_id,payment_date,payment_mode,amount,payment_status,transaction_reference)
VALUES
(1,CURDATE(),'NET BANKING',14160,'SUCCESS','TXN100003');

ROLLBACK;





SELECT
p.policy_number,
CONCAT(c.first_name,' ',c.last_name) AS Customer_Name,
v.registration_no,
pay.payment_mode,
pay.amount,
p.policy_status
FROM MMI_POLICY p
INNER JOIN MMI_QUOTE q
ON p.quote_id=q.quote_id

INNER JOIN MMI_CUSTOMER c
ON q.customer_id=c.customer_id

INNER JOIN MMI_VEHICLE v
ON q.vehicle_id=v.vehicle_id

INNER JOIN MMI_PAYMENT pay
ON p.payment_id=pay.payment_id;
