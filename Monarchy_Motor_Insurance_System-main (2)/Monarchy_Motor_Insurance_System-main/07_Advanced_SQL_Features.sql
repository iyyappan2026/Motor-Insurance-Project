/*
=============================================================
Project  : Monarchy Motor Insurance System
File     : 07_Advanced_SQL_Features.sql
Module   : Advanced SQL Features
Author   : K.R Iyyappan
Database : MySQL

Description:
This file demonstrates advanced MySQL features used in
the Motor Insurance System, including triggers, audit
tables, event scheduler, indexes, user creation, and
database privilege management.

Tables Included:
1. MMI_POLICY_AUDIT

Topics Covered:
- Audit Table
- Trigger
- Event Scheduler
- Index
- CREATE USER
- GRANT
- REVOKE
=============================================================
*/

CREATE TABLE MMI_POLICY_AUDIT
(
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    policy_id INT,
    policy_number VARCHAR(50),
    action_performed VARCHAR(100),
    action_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- TRIGGERS 
DELIMITER $$

CREATE TRIGGER TRG_POLICY_INSERT
AFTER INSERT
ON MMI_POLICY
FOR EACH ROW
BEGIN
    INSERT INTO MMI_POLICY_AUDIT
    (
        policy_id,
        policy_number,
        action_performed
    )
    VALUES
    (
        NEW.policy_id,
        NEW.policy_number,
        'NEW POLICY CREATED'
    );
END $$

DELIMITER ;

-- Test the Trigger
INSERT INTO MMI_POLICY
(
quote_id,
payment_id,
policy_number,
issue_date,
start_date,
end_date,
policy_status,
total_premium
)
VALUES
(
1,
1,
'POL202600002',
CURDATE(),
CURDATE(),
DATE_ADD(CURDATE(), INTERVAL 1 YEAR),
'ACTIVE',
14160
);

SELECT * FROM MMI_POLICY_AUDIT;

-- Event Scheduler
SET GLOBAL event_scheduler = ON;
SHOW VARIABLES LIKE 'event_scheduler';

CREATE EVENT DELETE_PENDING_QUOTES
ON SCHEDULE EVERY 1 DAY
DO
DELETE FROM MMI_QUOTE
WHERE quote_status='PENDING'
AND quote_date < CURDATE()-INTERVAL 30 DAY;

-- Index 
CREATE INDEX IDX_POLICY_NUMBER
ON MMI_POLICY(policy_number);

SHOW INDEX
FROM MMI_POLICY;

-- Create USer
CREATE USER 'broker1'
IDENTIFIED BY 'broker@123';
SELECT user
FROM mysql.user;

-- Grant 
GRANT
SELECT,
INSERT,
UPDATE
ON monarchy_motor.*
TO 'broker1';


-- Revoke 
REVOKE
UPDATE
ON monarchy_motor.*
FROM 'broker1';
