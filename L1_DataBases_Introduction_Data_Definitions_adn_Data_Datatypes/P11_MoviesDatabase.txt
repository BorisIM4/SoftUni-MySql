Create DATABASE `movies`;
USE `movies`;

CREATE TABLE directors
(
  id INT AUTO_INCREMENT NOT NULL,
  director_name VARCHAR(30) NOT NULL,
  notes TEXT,
  CONSTRAINT pk_directors PRIMARY KEY (id)
);

INSERT INTO directors VALUES (1, 'Steven Spilberg', '"Shindler\'s List", "Jurasic Park", "Saving Private Ryan"'),
                             (2, 'David Fintcher', '"Seven", "Fight Club", "Gone Girl"'),
                             (3, 'Ridley Scot', '"Alien", "Gladiator", "Hanibal"'),
                             (4, 'Christopher Nolan', '"Batman Begining", "Inseption", "Intersteller"'),
							 (5, 'Steven Soderberg', '"Erin Brokovich", "Ocean\'s Eleven"');


CREATE TABLE genres
(
  id INT AUTO_INCREMENT NOT NULL,
  genre_name VARCHAR(10) NOT NULL,
  notes TEXT,
  CONSTRAINT pk_genres PRIMARY KEY (id)
);

INSERT INTO genres VALUES (1, 'Comedy', ''),
						  (2, 'Action', ''),
                          (3, 'Crime', ''),
                          (4, 'Adventure', ''),
                          (5, 'Drama', '');
                          
                          
                          
CREATE TABLE categories
(
  id INT AUTO_INCREMENT NOT NULL,
  category_name VARCHAR(15) NOT NULL,
  notes TEXT,
  CONSTRAINT pk_categories PRIMARY KEY (id)
);

INSERT INTO categories VALUES (1, 'Best Feature', ''),
							  (2, 'Best Screenplay', ''),
                              (3, 'Best Actor', ''),
                              (4, 'Best Actress', ''),
                              (5, 'Best Director', '');
                              
                              
CREATE TABLE movies
(
  id INT AUTO_INCREMENT NOT NULL,
  title VARCHAR(50) NOT NULL,
  director_id INT NOT NULL,
  copyright_year DATE,
  length VARCHAR(30),
  genre_id INT NOT NULL,
  category_id INT NOT NULL,
  rating VARCHAR(50),
  notes TEXT,
  CONSTRAINT pk_movies PRIMARY KEY (id)
);

INSERT INTO movies VALUES (1, 'Saving Private Ryan', 1, '1999-08-23', '130 min', 5, 1, '', ''),
                          (2, 'Gone Girl', 2, '2016-09-12', '134 min', 3, 2, '', ''),
                          (3, 'Gladiator', 3, '2000-10-01', '120 min', 2, 3, '', ''),
                          (4, 'Intersteller', 4, '2015-12-12', '128 min', 4, 5, '', ''),
                          (5, 'Erin Brokovich', 5, '1998-08-19', '140 min', 1, 4, '', '');