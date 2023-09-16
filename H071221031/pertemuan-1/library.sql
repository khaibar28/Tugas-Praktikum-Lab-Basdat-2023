##no1
CREATE DATABASE library

CREATE TABLE books(
id INT PRIMARY KEY AUTO_INCREMENT,
isbn VARCHAR(50) UNIQUE,
title VARCHAR (50) NOT NULL,
pages INT,
summary TEXT,
genre VARCHAR (50) NOT NULL
);

##no2
ALTER TABLE books
MODIFY isbn CHAR(13);

##no3
ALTER TABLE books DROP summary;

##n04
DESCRIBE books