CREATE DATABASE library

CREATE TABLE books(
	id INT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL
)

ALTER TABLE books
MODIFY isbn CHAR(13);

ALTER TABLE books DROP summary;

DESCRIBE books;

ALTER TABLE books
MODIFY id INT(10),
MODIFY pages INT(10),
MODIFY summary INT(10);

ALTER TABLE books
MODIFY summary INT(10) DEFAULT 0;