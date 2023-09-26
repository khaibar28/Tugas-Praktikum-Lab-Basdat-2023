# no 1#
DROP DATABASE praktikum3
CREATE DATABASE praktikum3

CREATE TABLE mahasiswa (
	NIM VARCHAR (10) PRIMARY KEY,
	Nama VARCHAR (50) NOT NULL ,
	Kelas CHAR (1) NOT NULL,
	status VARCHAR (50) NOT NULL,
	Nilai INT (11)
)
DROP TABLE mahasiswa

DESCRIBE mahasiswa

INSERT INTO mahasiswa
VALUES('H071241056','Kotlina','A','Hadir',100),
('H071241060','Pitonia','A','Alfa',85),
('H071241063','Javano','A','Hadir',50),
('H071241065','Ciplus Kuadra','B','Hadir',65),
('H071241066 ','Pihap E','B','Hadir',85),
('H071241079','Ruby','B','Alfa',90)

# no 2#
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE status = 'Alfa' 

#no 3#
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90

#no 4#
INSERT INTO mahasiswa 
VALUES('H071221037','Muhammad Reza','A','Pindahan',NULL)
UPDATE mahasiswa 
SET Nilai = 50
WHERE status ='Alfa'
UPDATE mahasiswa 
SET Kelas = 'A'

# no 5#
USE classicmodels
USE TABLE employees

INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode,reportsTo,jobTitle)
VALUES (1951,'Khaekal', 'Muhammad', 'X264', 'murphy@classicmodels.com', '2', 1002, 'Sales Rep')

INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode,reportsTo,jobTitle)
VALUES (1953, 'Ilham', 'Muhammad', 'X264', 'Ilham@classicmodels.com', '3', 1102, 'Security')

INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode,reportsTo,jobTitle)
VALUES (1955, 'Reza', 'Muhammad', 'X264', 'Reza@classicmmodels.com', '4', 1002, 'DataAnalyst')