#01-Records’ Count
SELECT COUNT(*) AS `count` FROM wizzard_deposits;

#02-Longest Magic Wand
SELECT MAX(`magic_wand_size`) AS 'longest_magic_wand'
FROM `wizzard_deposits`;

#03-Longest Magic Wand per Deposit Groups
SELECT `deposit_group`, MAX(`magic_wand_size`) AS `longest_magic_wand`
FROM wizzard_deposits
GROUP BY `deposit_group`
ORDER BY `longest_magic_wand`, `deposit_group`;

#04-Smallest Deposit Group per Magic Wand Size
SELECT `deposit_group` FROM wizzard_deposits
GROUP BY `deposit_group`
ORDER BY AVG(`magic_wand_size`) LIMIT 1;

#05-Deposits Sum
SELECT `deposit_group`, SUM(`deposit_amount`) AS 'total_sum' FROM wizzard_deposits
GROUP BY `deposit_group`
ORDER BY `total_sum`;

#06-Deposits Sum for Ollivander Family
SELECT `deposit_group`, SUM(`deposit_amount`) AS 'total_sum' FROM wizzard_deposits
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

#07-Deposits Filter
SELECT `deposit_group`, SUM(`deposit_amount`) AS `total_sum` FROM wizzard_deposits
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY total_sum DESC;

#08-Deposit Charge
SELECT `deposit_group`, `magic_wand_creator`, MIN(`deposit_charge`) AS `min_deposit_charge`
FROM wizzard_deposits
GROUP BY `deposit_group`, `magic_wand_creator`
ORDER BY `magic_wand_creator`, `deposit_group`;

#09-Age Groups
SELECT
     (CASE
        WHEN `age` BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN `age` BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN `age` BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN `age` BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN `age` BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN `age` BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
        END) AS 'age_group', count(*) AS 'wizard_count' FROM wizzard_deposits
        GROUP BY `age_group`
        ORDER BY `age_group`;

#10-First Letter
SELECT LEFT(`first_name`, 1) AS 'first_letter' FROM wizzard_deposits
WHERE `deposit_group` = 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;

#11-Average Interest
SELECT `deposit_group`, `is_deposit_expired`, AVG(`deposit_interest`) AS `average_interest` FROM wizzard_deposits
WHERE `deposit_start_date` > '1985-01-01'
GROUP BY `deposit_group`, `is_deposit_expired`
ORDER BY `deposit_group` DESC, `is_deposit_expired`;

#12-Employees Minimum Salaries
SELECT `department_id`, MIN(`salary`) AS 'minimum_salary' FROM employees
WHERE `department_id` IN(2,5,7) AND `hire_date` > '2000-01-01'
GROUP BY `department_id`
ORDER BY `department_id` ASC;

#13-Employees Average Salaries
SELECT
    `department_id`,
    CASE
        WHEN `department_id` = 1 THEN AVG(`salary`) + 5000
        ELSE AVG(`salary`)
    END AS 'avg_salary'
FROM
    `employees`
WHERE
    `salary` > 30000 AND `manager_id` != 42
GROUP BY `department_id`
ORDER BY `department_id`;

#14-Employees Maximum Salaries
SELECT `department_id`,MAX(`salary`) AS `max_salary` FROM `employees`
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 AND 70000
ORDER BY `department_id`;

#15-Employees Count Salaries
SELECT COUNT(*) AS '' FROM employees
WHERE  `manager_id` IS NULL;

#16-3rd Highest Salary
SELECT
    e.`department_id`,
    (SELECT DISTINCT
            e2.`salary`
        FROM
            employees AS e2
        WHERE
            e2.`department_id` = e.`department_id`
        ORDER BY e2.`salary` DESC
        LIMIT 1 OFFSET 2) AS `ths`
FROM
    employees AS e
GROUP BY e.`department_id`
HAVING `ths` IS NOT NULL
ORDER BY e.`department_id`;

#17-Salary Challenge
SELECT e.`first_name`, e.`last_name`, e.`department_id` FROM employees AS e
WHERE `salary` >
(
    SELECT AVG(e2.`salary`) FROM employees AS e2
    WHERE e2.`department_id` = e.`department_id`
    GROUP BY e2.`department_id`
)
ORDER BY e.`department_id`, e.`employee_id`
LIMIT 10;

#18-Departments Total Salaries
SELECT `department_id`, SUM(`salary`) AS 'total_salary' FROM employees
GROUP BY `department_id`
ORDER BY `department_id`;