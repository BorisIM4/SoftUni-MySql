#01-Table Design
CREATE TABLE `clients` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `full_name` VARCHAR(50),
    `phone_number` VARCHAR(20),
    CONSTRAINT pk_client PRIMARY KEY (`id`)
);

CREATE TABLE `addresses` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    CONSTRAINT pk_addresses PRIMARY KEY (`id`)
);

CREATE TABLE `categories` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(10) NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY (`id`)
);

CREATE TABLE `cars` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `make` VARCHAR(20) NOT NULL,
    `model` VARCHAR(20),
    `year` INT NOT NULL DEFAULT 0,
    `mileage` INT DEFAULT 0,
    `condition` CHAR(1) NOT NULL,
    `category_id` INT NOT NULL,
    CONSTRAINT pk_cars PRIMARY KEY (`id`),
    CONSTRAINT fk_cars FOREIGN KEY (`category_id`)
        REFERENCES categories (`id`)
);

CREATE TABLE `courses` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `from_address_id` INT NOT NULL,
    `start` DATETIME,
    `car_id` INT NOT NULL,
    `client_id` INT NOT NULL,
    `bill` DECIMAL(10 , 2 ) DEFAULT 10,
    CONSTRAINT pk_courses PRIMARY KEY (`id`),
    CONSTRAINT fk_courses_addresses FOREIGN KEY (`from_address_id`)
        REFERENCES addresses (`id`),
    CONSTRAINT fk_courses_car FOREIGN KEY (`car_id`)
        REFERENCES cars (`id`),
    CONSTRAINT fk_courses_clients FOREIGN KEY (`client_id`)
        REFERENCES clients (`id`)
);

CREATE TABLE `drivers` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `age` INT NOT NULL,
    `rating` FLOAT DEFAULT 5.5,
    CONSTRAINT pk_drivers PRIMARY KEY (`id`)
);

CREATE TABLE `cars_drivers` (
    `car_id` INT NOT NULL,
    `driver_id` INT NOT NULL,
    CONSTRAINT pk_cars_drivers_cars PRIMARY KEY (`car_id`, `driver_id`),
    CONSTRAINT fk_cars_drivers_cars FOREIGN KEY (`car_id`)
        REFERENCES cars (`id`),
    CONSTRAINT fk_cars_drivers_drivers FOREIGN KEY (`driver_id`)
        REFERENCES drivers (`id`)
);