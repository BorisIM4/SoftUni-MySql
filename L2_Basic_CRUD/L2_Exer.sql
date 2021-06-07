# 01-Find All Information About Departments 
SELECT * FROM `departments`
ORDER BY `department_id`;

# 02-Find all Department Names 
SELECT `name` FROM `departments`
ORDER BY `DEPARTMENT_ID`;

# 03-Find Salary of Each Employee
SELECT `first_name`, `last_name`, `salary` FROM `employees`
ORDER BY `employee_id` ASC;

# 04-Find Full Name of Each Employee 
SELECT `first_name`, `middle_name`, `last_name` FROM `employees`
ORDER BY `employee_id` ASC;

# 05-Find Email Address of Each Employee
SELECT concat(`first_name`, '.', `last_name`, '@softuni.bg')
AS `full_email_address`
FROM `employees`;

# 06-Find All Different Employee’s Salaries
SELECT DISTINCT `salary` FROM `employees`
ORDER BY `employee_id`;

# 07-Find all Information About Employees
SELECT * FROM `employees`
WHERE `job_title` = 'Sales Representative'
ORDER BY `employee_id`;

# 08-Find Names of All Employees by Salary in Range
SELECT `first_name`, `last_name`, `job_title` FROM `employees`
WHERE `salary` BETWEEN 20000 AND 30000;
-- WHERE `salary` >= 20000 AND `salary` <= 30000;

# 09-Find Names of All Employees
SELECT concat(`first_name`, ' ', `middle_name`, ' ', `last_name`) AS `Full Name`
FROM `employees`
WHERE `salary` in (25000, 14000, 12500, 23600);
-- WHERE `salary` = '25000' OR `salary` =  '14000' OR `salary` =  '12500' OR `salary` =  '23600';

# 10-Find All Employees Without Manager
SELECT * FROM `employees`
WHERE `manager_id` IS NULL;

# 11-Find All Employees with Salary More Than


# 12-Find 5 Best Paid Employees



