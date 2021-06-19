#01-Employees with Salary Above 35000
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
DETERMINISTIC
BEGIN
   SELECT `first_name`, `last_name` FROM employees
   WHERE salary > 35000
   ORDER BY first_name, last_name, employee_id;
END $$

CALL usp_get_employees_salary_above_35000();

#02-Employees with Salary Above Number
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(min_salary DECIMAL(10,4))
DETERMINISTIC
BEGIN
   SELECT `first_name`, `last_name` FROM employees
   WHERE salary >= min_salary
   ORDER BY first_name, last_name, employee_id;
END $$

CALL usp_get_employees_salary_above(49200);

#03-Town Names Starting With
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(name_start VARCHAR(20))
DETERMINISTIC
BEGIN
   SELECT `name` AS 'town_name' FROM towns
   WHERE `name` LIKE concat(name_start, '%')
   ORDER BY `town_name`;
END $$

CALL usp_get_towns_starting_with('b');

create procedure usp_get_towns_starting_with(Letter varchar(10))
begin
select t.name from towns as t
where locate(Letter, t.name) = 1

#04-Employees from Town
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(20))
DETERMINISTIC
BEGIN
     SELECT e.first_name, e.last_name FROM employees AS `e`
     JOIN addresses AS `a`ON e.address_id = a.address_id
     JOIN towns AS `t` ON a.town_id = t.town_id
     WHERE t.`name` = town_name
     ORDER BY first_name, last_name, employee_id;
END $$

#05-Salary Level Function
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(e_salary DECIMAL(19,4))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
   RETURN (
   CASE
     WHEN e_salary < 30000 THEN 'Low'
     WHEN e_salary BETWEEN 30000 AND 50000 THEN 'Average'
	 ELSE 'High'
     END
     );
END
DELIMITER $$

SELECT ufn_get_salary_level(1000) AS 'salary_Level';

#06-Employees by Salary Level


#07-Define Function
DETIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
DETERMINISTIC
RETURN word REGEXP (concat('^[', set_of_letters, ']+$'));

SELECT ufn_is_word_comprised('oistmiahf', 'Sofia');
SELECT ufn_is_word_comprised('oistmiahf', 'halves');
SELECT ufn_is_word_comprised('bobr', 'Rob');
SELECT ufn_is_word_comprised('pppp', 'Guy');

#08-Find Full Name
DROP PROCEDURE IF EXISTS usp_get_holders_full_name;

DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT_WS(' ', first_name, last_name) AS full_name
    FROM account_holders
    ORDER BY full_name, id;
END $$
DELIMITER ;

CALL usp_get_holders_full_name();

#09-People with Balance Higher Than
DROP PROCEDURE IF EXISTS usp_get_holders_with_balance_higher_than;

DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(IN salary_level DECIMAL(19, 4))
BEGIN
	SELECT ah.first_name, ah.last_name FROM account_holders AS ah
    JOIN accounts AS a
    ON a.account_holder_id = ah.id
    GROUP BY a.account_holder_id
    HAVING SUM(a.balance) > salary_level
    ORDER BY ah.id;
END $$
DELIMITER ;

CALL usp_get_holders_with_balance_higher_than(7000);

#10-Future Value Function
DROP FUNCTION IF EXISTS ufn_calculate_future_value;

DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(initial_sum DECIMAL(19,4), interest_rate DOUBLE, years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	DECLARE result DECIMAL(19,4); -- declare variable
    SET result :=
		initial_sum * POW((1 + interest_rate), years);
	RETURN result;
END $$
DELIMITER ;

SELECT ufn_calculate_future_value(1000, 0.5, 5);

#11-Calculating Interest
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(10,4), yearly_interest_rate DECIMAL(10,4), number_of_years INT)
RETURNS DECIMAL(10,4)
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(10,4);
    SET result := sum * (pow((yearly_interest_rate  + 1),  number_of_years));
	RETURN result;
END;

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest DECIMAL(10,4))
BEGIN
   SELECT a.id, ah.first_name, ah.last_name, a.balance,
     (ufn_calculate_future_value(a.balance,interest,5))as balance_in_5_years
 FROM accounts as a
 JOIN account_holders as ah ON a.account_holder_id = ah.id
 where a.id = account_id;
 END;

CALL usp_calculate_future_value_for_account(1, 0.1);

#12-Deposit Money
DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(10,4))
BEGIN
   UPDATE  accounts as a
   JOIN `account_holders` as ah ON a.`account_holder_id` = ah.id
   SET a.balance = if(money_amount>0, ROUND(a.balance + money_amount,4), a.balance)
   WHERE a.id = account_id;
   END;

#13-Withdraw Money
DELIMITER $$
     CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(20,4))
BEGIN
   UPDATE  accounts as a
   JOIN `account_holders` as ah ON a.`account_holder_id` = ah.id
   SET a.balance = if((money_amount>0 and a.balance >= money_amount), ROUND(a.balance - money_amount,4), a.balance)
   WHERE a.id = account_id;
   END;

#14-Money Transfer
DROP PROCEDURE IF EXISTS usp_transfer_money;

DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF(from_account_id = to_account_id) OR
		(SELECT id FROM accounts WHERE id = to_account_id) IS NULL OR
        (SELECT id FROM accounts WHERE id = from_account_id) IS NULL OR
        (SELECT balance FROM accounts WHERE id = from_account_id) < amount OR
		(amount <= 0)
		THEN ROLLBACK;
    ELSE
		UPDATE accounts
        SET balance = balance - amount
        WHERE id = from_account_id;
        UPDATE accounts
        SET balance = balance + amount
        WHERE id = to_account_id;
        END IF;
        COMMIT;
END $$
DELIMITER ;

CALL usp_transfer_money(1, 2, 10);

#15-Log Accounts Trigger
DELIMITER $$
CREATE table `logs`(
log_id INT PRIMARY KEY AUTO_INCREMENT,
account_id INT,
old_sum  DECIMAL(20,4),
new_sum DECIMAL(20,4));

CREATE TRIGGER account_logs
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (account_id, old_sum, new_sum)
	VALUES(NEW.id, OLD.balance, NEW.balance);
END;

#16-Emails Trigger
CREATE table `logs`(
log_id INT PRIMARY KEY AUTO_INCREMENT,
account_id INT,
old_sum  DECIMAL(20,4),
new_sum DECIMAL(20,4));
CREATE TRIGGER account_logs
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (account_id, old_sum, new_sum)
	VALUES(NEW.id, OLD.balance, NEW.balance);
END;
CREATE TABLE notification_emails (
    id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT,
    subject VARCHAR(200),
    body VARCHAR(200)
);


CREATE TRIGGER new_email_for_each_log
AFTER UPDATE
ON `logs`
FOR EACH ROW
BEGIN
    INSERT INTO notification_emails(recipient, subject, body)
    VALUES(NEW.account_id, concat('Balance change for account: ','', NEW.account_id),
    concat_ws(' ','On',NOW(), 'your balance was changed from', NEW.old_sum, NEW.new_sum));
END;