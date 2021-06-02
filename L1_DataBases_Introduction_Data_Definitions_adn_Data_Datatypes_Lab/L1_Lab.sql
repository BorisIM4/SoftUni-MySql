CREATE DATABASE
`GAMEBAR`;

USE `gamebar`;

CREATE TABLE `gamebar`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  PRIMARY KEY (`id`));
  
  CREATE TABLE `gamebar`.`categories` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL
  );
  
  CREATE TABLE `gamebar`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `gamebar`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
INSERT INTO `gamebar`.`employees` (`first_name`, `last_name`) 
VALUES ('Ivan', 'Ivanov'),
('BOris', 'Milanov');

UPDATE `gamebar`.`employees` 
SET `first_name` = 'Boris' 
WHERE (`id` = '2');

DELETE FROM `gamebar`.`employees` 
WHERE (`id` = '1');

DROP DATABASE `gamebar`;