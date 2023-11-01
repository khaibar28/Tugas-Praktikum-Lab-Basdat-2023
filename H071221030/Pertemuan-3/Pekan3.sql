-- Nomor 1
CREATE DATABASE praktikum3;

USE praktikum3;

CREATE TABLE mahasiswa(
	NIM VARCHAR(10) PRIMARY KEY NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	`status` VARCHAR(50) NOT NULL,
	Nilai INT(11));
	
INSERT INTO mahasiswa
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		 ('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		 ('H071241063', 'Javano', 'A', 'Hadir', 50),
		 ('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		 ('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		 ('H071241079', 'Ruby', 'B', 'Alfa', 90);

-- Nomor 2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE `status` = 'Alfa';

-- Nomor 3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;

-- Nomor 4
INSERT INTO mahasiswa
VALUE ('H071221030', 'Joy', 'A', 'Pindahan', NULL);

UPDATE mahasiswa
SET Nilai = 50
WHERE `status` = 'Alfa';

UPDATE mahasiswa
SET Kelas = 'A';

-- Nomor 5
USE classicmodels;

INSERT INTO offices
VALUES (8, 'rose', '+69 12 3346 4219', 'shiganshina 5-15', null, null, 'paradise', '13415', 'DI');

UPDATE employees
SET officeCode = 8
WHERE officeCode = 4 AND jobTitle = 'Sales Rep';