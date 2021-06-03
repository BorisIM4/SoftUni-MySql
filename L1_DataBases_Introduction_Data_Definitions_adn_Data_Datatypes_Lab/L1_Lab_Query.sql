CREATE DATABASE `gamebar`;

USE `gamebar`;

CREATE TABLE `employees`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL
);

CREATE TABLE `categories`(
	`id`INT PRIMARY KEY AUTO_INCREMENT,
    `NAME` VARCHAR(40) NOT NULL
);

CREATE TABLE `products` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    `category_id` INT NOT NULL
);

INSERT INTO `employees` 
VALUES
(1, 'pesho', 'Peshov'),
(2, 'Ivan', 'Ivanon'),
(3, 'Gosho', 'Goshev');

SELECT * FROM `employees`;

USE `GAMEBAR`;

ALtER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(20);

ALTER TABLE `products`
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (`category_id`)
REFERENCES `categories` (`id`);

ALTER TABLE `gamebar`.`employees` 
CHANGE COLUMN `MIDDLE_NAME` `middle_name` VARCHAR(100) NULL DEFAULT NULL ;

ALTER TABLE `gamebar`.`employees` 
CHANGE COLUMN `SECOND_name` `last_name` VARCHAR(50) NOT NULL ;