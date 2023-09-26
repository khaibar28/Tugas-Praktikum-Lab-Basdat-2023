##NO1
CREATE DATABASE praktikum3;
USE praktikum3;


CREATE TABLE COLUMNS (
	NIM VARCHAR(10) PRIMARY KEY NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	`status` VARCHAR (50) NOT NULL, 
	Nilai INT (11)
 	);
DESCRIBE columns;

INSERT INTO COLUMNS (NIM, Nama, Kelas, `status`, Nilai)
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir' ,100),
		('H071241060' , 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano',  'A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90);


##N02
UPDATE COLUMNS
SET Nilai = 0, Kelas = 'C'
WHERE `status` = 'Alfa' ;

##NO3
DELETE FROM COLUMNS
WHERE Kelas = 'A' and Nilai >90;

##NO4
INSERT INTO COLUMNS 
VALUES ('H071221053', 'Diva Aisyah Arfillah', 'B', 'Pindahan', NULL);

UPDATE columns
SET Nilai = 50
WHERE `status` = 'Alfa' ;

UPDATE COLUMNS
SET Kelas = 'A';

UPDATE columns 
SET Kelas = 'B';

SELECT * FROM COLUMNS;

##Tugas Tambahan no 1

USE classicmodels;

SELECT * FROM employees

INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officecode, reportsTo, jobTitle)
VALUES (1789, 'Arfillah', 'Diva', 'z4gh', 'divaaisyah13@gmail.com', '6' , 1370, 'Ada'),
		 (1456, 'Afifah', 'Salsa', 'z4ig', 'afifah@gmail.com', '2' , 1501, 'Behel'),
		 (1567, 'Rahman', 'Arni', 'vgrs', 'arnirai@gmai.com', '7' , 1611, 'Ramah');







