#5

CREATE DATABASE db_praktikum 

CREATE TABLE students(
nama VARCHAR(50),
email VARCHAR(255) UNIQUE NOT NULL, 
gender CHAR(1),
student_id INT(1) PRIMARY KEY,
)

CREATE TABLE classes(
class_name VARCHAR(50),
class_id INT(11) AUTO_INCREMENT PRIMARY KEY
) 
 
CREATE TABLE class_student (
grade CHAR(1) DEFAULT 'E',
student_id INT(11) UNIQUE,
class_id INT(11) UNIQUE,
enrollment_id INT(11) AUTO_INCREMENT PRIMARY KEY,

FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (class_id) REFERENCES classes(class_id)
)
 
DROP table students;

DESCRIBE students;
DESCRIBE classes;
DESCRIBE class_student;