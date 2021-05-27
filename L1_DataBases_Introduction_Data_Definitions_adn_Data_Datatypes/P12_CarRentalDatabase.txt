CREATE DATABASE `car_rental`;
USE `car_rental`;

  
CREATE TABLE categories
(
  id INT AUTO_INCREMENT NOT NULL,
  category VARCHAR(50),
  daily_rate DOUBLE(7, 2) NOT NULL,
  weekly_rate DOUBLE(7, 2) NOT NULL,
  monthly_rate DOUBLE(7, 2) NOT NULL,
  weekend_rate DOUBLE(7, 2) NOT NULL,
  CONSTRAINT pk_categories PRIMARY KEY (id)
);

INSERT INTO categories VALUES (1, 'High class', 60, 180, 600, 60),
                              (2, 'Limo', 80, 240, 800, 80),
                              (3, 'JEEP', 120, 360, 1200, 120);
                              
                              
CREATE TABLE cars
(
  id INT AUTO_INCREMENT NOT NULL,
  plate_number INT,
  make VARCHAR(30),
  model VARCHAR(50),
  car_year DATE,
  category_id INT NOT NULL,
  doors VARCHAR(50),
  pictures BLOB,
  car_conditions VARCHAR(50),
  available ENUM('Yes', 'No'),
  CONSTRAINT pk_cars PRIMARY KEY (id)
);

INSERT INTO cars VALUES (1, 7845, '10/100', 'Mercedes Benz', '2005-02-14', 1, 'Four', NULL, 'Exellent', 'Yes'),
						(2, 6532, '12/100', 'Volvo', '2003-03-18', 2, 'Four', NULL, 'Good', 'Yes'),
                        (3, 3216, '18/100', 'BMW 4x4', '2010-05-21', 3, 'Four', NULL, 'Perfect', 'Yes');
                        
                   
CREATE TABLE employees
(
  id INT AUTO_INCREMENT NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  title VARCHAR(50),
  notes TEXT,
  CONSTRAINT pk_employees PRIMARY KEY (id)
);

INSERT INTO employees VALUES (1, 'Ivan', 'Ivanov', 'Rental Agent', ''),
                             (2, 'Georgi', 'Georgiev', 'Rental Agent', ''),
                             (3, 'Stavri', 'Stavriev', 'Manager', '');
                             
                             
CREATE TABLE customers
(
  id INT AUTO_INCREMENT NOT NULL,
  driver_licence_number INT,
  full_name VARCHAR(50) NOT NULL,
  address VARCHAR(150),
  city VARCHAR(50),
  zip_code INT,
  notes TEXT,
  CONSTRAINT pk_customers PRIMARY KEY (id)
);

INSERT INTO customers VALUES (1, 456987, 'Gergana Yankova', 'Шарена Черга, №15', 'Sofia', 1618, ''),
                             (2, 7412563, 'Dimitar Chergov', 'Позитано №20', 'Gorna Oryahovica', 1412, ''),
                             (3, 123654, 'Blagoi Bojanov', 'Vitosha 18', 'Sofia', 1000, '');
                             
                             
CREATE TABLE rental_orders
(
  id INT AUTO_INCREMENT NOT NULL,
  employee_id INT NOT NULL,
  customer_id INT NOT NULL,
  car_id INT NOT NULL,
  car_condition VARCHAR(50),
  tank_level DOUBLE(5, 2),
  kilometrage_start INT,
  kilometrage_end INT,
  total_kilometrage INT,
  start_date DATE,
  end_date DATE,
  total_days INT,
  rate_applied DOUBLE(7, 2),
  tax_rate DOUBLE(7, 2),
  order_status ENUM('confurmed', 'unconfirmed'),
  notes TEXT,
  CONSTRAINT pk_rental_orders PRIMARY KEY (id)
);

INSERT INTO rental_orders
VALUES(1, 5, 82, 56, 'Good', 29.18, 2182, 3002, 820, '2017-05-25', '2017-05-27', 2, 120, 8.22, 'confurmed', ''),
	  (2, 3, 123, 20, 'Good', 25.45, 10023, 12354, 2331, '2017-04-20', '2017-05-15', 25, 1500, 22.13, 'confurmed', ''),
      (3, 3, 29, 34, 'Good', 8.63, 22145, 22541, 396, '2017-05-26', '2017-05-27', 1, 80, 2.65, 'confurmed', '');