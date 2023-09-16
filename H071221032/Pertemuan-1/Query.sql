#1
CREATE DATABASE library;

USE library;

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(50) UNIQUE,
    title VARCHAR(50) NOT NULL,
    pages INT,
    summary TEXT,
    genre VARCHAR(50) NOT NULL
);

#2
ALTER TABLE books
MODIFY COLUMN isbn CHAR(13);
#3
ALTER TABLE books
DROP COLUMN summary;
#4
DESCRIBE books;

#5
CREATE DATABASE db_praktikum;

USE db_praktikum;

CREATE TABLE students (
    student_id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(255) UNIQUE,
    gender CHAR(1)
);

CREATE TABLE classes (
    class_id INT(11) AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50)
);

CREATE TABLE class_student (
    enrollment_id INT(11) AUTO_INCREMENT PRIMARY KEY,
    grade CHAR(1) DEFAULT 'E',
    student_id INT,
    class_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

SHOW TABLES;
DESCRIBE students;
