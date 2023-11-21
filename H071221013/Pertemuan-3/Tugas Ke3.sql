CREATE DATABASE praktikum3;
USE praktikum3;

-- No.1
CREATE TABLE mahasiswa(
Nim VARCHAR(10) PRIMARY KEY,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
`Status` VARCHAR(50) NOT NULL,
Nilai INT(11)
);

DESCRIBE mahasiswa;

SELECT * FROM mahasiswa

INSERT INTO mahasiswa(NIM, Nama, Kelas, `Status`, Nilai)
VALUES
		('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano', 'A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90);
		
-- No.2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE `Status` = 'Alfa';

-- No.3
DELETE FROM mahasiswa
WHERE Kelas = "A" AND Nilai > 90;
-- WHERE Nim = 'H071241056';

-- No.4
INSERT INTO mahasiswa (Nim, Nama, Kelas, `Status`)
VALUES ('H071221013', 'Susanti', 'A', 'Pindahan');

UPDATE mahasiswa
SET Nilai = 50
WHERE `Status` = 'Alfa';

UPDATE mahasiswa
SET Kelas = 'A';

-- Tambahan

UPDATE mahasiswa 
SET Nilai = 80
WHERE NIM = "H071221013";

-- Live Coding
USE classicmodels

SELECT * FROM employees
DESCRIBE employees;

INSERT INTO employees
VALUES
(1951, 'Karina', 'Lia', 'x892', 'ibnurohman@gmail.com', '3', 1076, 'Security'),
(1952, 'Susanti', 'Ti', 'x893', 'susantii9261@gmail.com', '4', 1165, 'Security'),
(1953, 'Nia', 'Ramadhani', 'x894', 'niaramadhani@gmail.com', '3', 1143, 'Sales Rep');