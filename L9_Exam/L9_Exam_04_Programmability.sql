#10-Find all courses by client’s phone number
DELIMITER $$
CREATE FUNCTION udf_courses_by_client (phone_number VARCHAR (20)) 
RETURNS INT
DETERMINISTIC
BEGIN
RETURN (SELECT count(cour.client_id)
FROM clients AS cl
	JOIN courses cour ON cl.id = cour.client_id
WHERE cl.phone_number = phone_number);
END$$
 
#11-Full info for address
DELIMITER $$
CREATE PROCEDURE udp_courses_by_address (addresses_name VARCHAR(100))
BEGIN
SELECT a.`name`, cl.full_name, ( 
CASE 
	WHEN co.bill <= 20 THEN 'Low'
	WHEN co.bill <= 30 THEN 'Medium'
	ELSE 'High'  END) AS level_of_bill, c.make, c.`condition`,
    ca.name AS cat_name FROM addresses AS a
    JOIN courses AS co ON a.id = co.from_address_id
    JOIN clients AS cl ON co.client_id = cl.id
    JOIN cars AS c ON co.car_id = c.id
    JOIN categories AS ca ON c.category_id = ca.id
    WHERE a.`name` = addresses_name
    ORDER BY c.make, cl.full_name; 
    
END $$