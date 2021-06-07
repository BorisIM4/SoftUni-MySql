# 01-Select Employee Information
SELECT `id`, `first_name`, `last_name`, `job_title` FROM `employees`
ORDER BY `id`;

# 02-Select Employees with Filter
SELECT `id`, concat_ws(' ', `first_name`, `last_name`) AS 'full_name' , `job_title`, `salary`
FROM `employees`
WHERE `salary` > '1000,00'
 ORDER BY `id`;
 
 # 03-Update Employees Salary
 SELECT * FROM `employees`;
 
 UPDATE `employees` 
 SET `salary` = `salary` + '100' 
 WHERE `job_title` = 'Manager';
