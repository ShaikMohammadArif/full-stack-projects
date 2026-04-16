CREATE DATABASE IF NOT EXISTS payment_db;
USE payment_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    balance DECIMAL(10,2)
);

CREATE TABLE merchants (
    merchant_id INT PRIMARY KEY,
    merchant_name VARCHAR(100),
    balance DECIMAL(10,2)
);

INSERT INTO users VALUES (1, 'Arif', 5000.00);
INSERT INTO merchants VALUES (101, 'Amazon Store', 10000.00);

START TRANSACTION;

UPDATE users
SET balance = balance - 1000
WHERE user_id = 1;

UPDATE merchants
SET balance = balance + 1000
WHERE merchant_id = 101;

COMMIT;
Now check:
SELECT * FROM users;
SELECT * FROM merchants;

DELIMITER //

CREATE PROCEDURE transfer_payment(
    IN p_user INT,
    IN p_merchant INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE user_balance DECIMAL(10,2);

    START TRANSACTION;

    SELECT balance INTO user_balance
    FROM users
    WHERE user_id = p_user;

    IF user_balance >= p_amount THEN
        
        UPDATE users
        SET balance = balance - p_amount
        WHERE user_id = p_user;

        UPDATE merchants
        SET balance = balance + p_amount
        WHERE merchant_id = p_merchant;

        COMMIT;
    ELSE
        ROLLBACK;
    END IF;

END //

DELIMITER ;
