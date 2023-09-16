-- NOMOR 1
CREATE DATABASE library
USE library

CREATE TABLE books(
id INT(11) PRIMARY KEY,
isbn VARCHAR(50) UNIQUE,
title VARCHAR(50) NOT NULL,
pages INT(11),
summary TEXT(255),
genre VARCHAR(50) NOT NULL
)

SHOW TABLES
DESCRIBE books

-- NOMOR 2
ALTER TABLE books
MODIFY isbn CHAR(13);

-- NOMOR 3
ALTER TABLE books
DROP summary

-- NOMOR 4
SHOW TABLES
DESCRIBE books
 
-- NOMOR 5 
CREATE DATABASE db_praktikum
USE db_praktikum
SHOW TABLES
DESCRIBE class_student
DROP TABLE students

CREATE TABLE class_student(
grade CHAR(1) DEFAULT "E",
student_id INT(11),
class_id INT(11),
enrollment_id INT(11) PRIMARY KEY AUTO_INCREMENT,

FOREIGN KEY(student_id) REFERENCES students(student_id),
FOREIGN KEY(class_id) REFERENCES classes(class_id)
);

-- Jalankan table students dan classes terlebih dahulu, kemudian jalankan table class_student
CREATE TABLE students (
nama VARCHAR(50) NOT NULL,
email VARCHAR(255) UNIQUE,
gender CHAR(1),
student_id INT(11) PRIMARY KEY
);

CREATE TABLE classes (
class_name VARCHAR(50),
class_id INT(11) PRIMARY KEY AUTO_INCREMENT 
);