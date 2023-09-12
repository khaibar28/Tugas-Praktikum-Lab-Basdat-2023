#no 1#
CREATE DATABASE library 
USE library
CREATE TABLE books(
	id INT (10) PRIMARY KEY,
	isbn VARCHAR (50) UNIQUE,
	title VARCHAR (50) NOT NULL, 
	pages INT (10),
	summary TEXT (200),
	genre VARCHAR (50) NOT NULL
);

# no2#
ALTER TABLE books
MODIFY isbn CHAR (13)

#no3#
ALTER TABLE books
DROP summary

#no4#
DESCRIBE books 

#no5#
CREATE DATABASE db_praktikum
USE db_praktikum 

CREATE TABLE students (
	nama VARCHAR (50)
	email VARCHAR (255) UNIQUE,
	gender CHAR (1),
	student_id INT (11) PRIMARY KEY 
);

CREATE TABLE classes (
	class_name VARCHAR (50),
	class_id INT (11) PRIMARY KEY AUTO_INCREMENT 
);

CREATE TABLE class_student(
	grade CHAR (1) DEFAULT 'E',
	student_id INT (11),
	class_id INT (11),
	enrollment_id INT (11) PRIMARY KEY AUTO_INCREMENT,
	
	FOREIGN KEY(student_id)REFERENCES students(student_id),
	FOREIGN KEY(class_id)REFERENCES classes(class_id)
);

ALTER TABLE students 
MODIFY nama VARCHAR (50) NOT NULL 

