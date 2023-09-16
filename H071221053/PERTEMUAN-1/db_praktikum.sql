CREATE DATABASE db_praktikum;

USE db_praktikum;

CREATE TABLE students(
	`name` VARCHAR(50),
	email VARCHAR(255) UNIQUE,
	gender CHAR(1) ,
	student_id INT PRIMARY KEY
);

CREATE TABLE classes(
	class_name VARCHAR(50),
	class_id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE class_student(
	grade CHAR(1) DEFAULT "E", 
	student_id INT,
	class_id INT,
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT,

	FOREIGN KEY(class_id) REFERENCES classes (class_id),
	FOREIGN KEY(student_id) REFERENCES students (student_id)
);

SHOW TABLES