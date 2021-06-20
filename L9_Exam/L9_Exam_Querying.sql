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
SELECT `full_name`, COUNT(cars.id) AS `count_of_cars`, SUM(courses.bill) AS `total_sum`
FROM `clients`;
 