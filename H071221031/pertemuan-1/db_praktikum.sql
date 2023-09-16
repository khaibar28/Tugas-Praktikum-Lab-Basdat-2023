##no5

CREATE DATABASE db_praktikum

CREATE TABLE students(
nama VARCHAR(50),
email VARCHAR(255) UNIQUE,
gender CHAR(1),
student_id INT(11) PRIMARY KEY auto_increment
);

CREATE TABLE classes(
class_name VARCHAR(50),
class_id INT(11) PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE class_student(
grade CHAR(1) DEFAULT 'E',
student_id INT(11),
class_id INT(11),
enrollment INT(11) PRIMARY KEY AUTO_INCREMENT,

FOREIGN KEY (student_id) REFERENCES students(student_ilibraryd),
FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

ALTER TABLE students
MODIFY nama VARCHAR(50) NOT NULL

