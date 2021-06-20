#05-Cars
SELECT `make`,`model`,`condition`
FROM `cars`
ORDER BY `id`;

#06-Drivers and Cars
SELECT `first_name`, `last_name`, c.make, c.model, c.mileage
FROM `drivers` AS d
	JOIN `cars_drivers` AS cd ON cd.driver_id = d.id
	JOIN `cars` AS c ON c.id = cd.car_id
WHERE c.mileage IS NOT NULL
ORDER BY c.mileage DESC , d.first_name;

#07-Number of courses for each car
SELECT c.`id` AS 'car_id', c.`make`,c.`mileage`,COUNT(co.`id`) AS 'count_of_courses', ROUND(AVG(co.`bill`),2) AS 'avg_bill'
FROM cars AS c
LEFT JOIN courses AS co ON c.`id`=co.`car_id`
GROUP BY c.`id`
HAVING count_of_courses<> 2
ORDER BY count_of_courses DESC, c.`id`;
    
#08-Regular clients
SELECT cl.`full_name`,COUNT(crs.`id`) AS `count_of_cars`,SUM(cou.`bill`) AS `total_sum` FROM
`clients` AS `cl` JOIN `courses` AS `cou` ON cl.`id` = cou.`client_id`
JOIN `cars` AS `crs` ON cou.`car_id` = crs.`id`
WHERE `full_name` LIKE '_a%'
GROUP BY cl.`full_name`
HAVING `count_of_cars` > 1
ORDER BY cl.`full_name`;
 
#09-Full information of courses
SELECT `add`.`name`,
CASE
WHEN SUBSTRING(TIME(c.`start`),1,2) BETWEEN 6 AND 20 THEN "Day"
ELSE "Night"
END AS `day_time`,
c.`bill`,
cl.`full_name`,
cars.`make`,
cars.`model`,
cat.`name`
FROM `courses` AS `c` 
JOIN `addresses` AS `add` ON c.`from_address_id` = `add`.`id`
JOIN `clients` AS `cl` ON c.`client_id` = cl.`id`
JOIN `cars` ON c.`car_id` = cars.`id`
JOIN `categories` AS `cat` ON cars.`category_id` = cat.`id`
ORDER BY c.`id`;