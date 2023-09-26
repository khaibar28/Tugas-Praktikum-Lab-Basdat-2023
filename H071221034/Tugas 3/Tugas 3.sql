-- No.1
CREATE DATABASE praktikum3
USE praktikum3

CREATE TABLE mahasiswa(
	NIM VARCHAR(10) PRIMARY KEY NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
   `Status` VARCHAR(50) NOT NULL,
	Nilai INT(11)
)

DESCRIBE mahasiswa;

INSERT INTO mahasiswa
VALUES("H071241056", "Kotlina", "A", "Hadir", 100), 
("H071241060", "Pitonia", "A", "Alfa", 85), 
("H071241063", "Javano", "A", "Hadir", 50),
("H071241065", "Ciplus Kuadra", "B", "Hadir", 65),
("H071241066", "Pihap E", "B", "Hadir", 85),
("H071241079", "Ruby", "B", "Alfa", 90);

SELECT * FROM mahasiswa;

-- No.2
UPDATE mahasiswa
SET Nilai = 0, Kelas = "C"
WHERE `Status` = "Alfa";

-- No.3
DELETE FROM mahasiswa
WHERE Kelas = "A" AND Nilai > 90;

-- No.4
INSERT INTO mahasiswa
VALUES("H071221034", "Karina", "A", "Pindahan", NULL);

UPDATE mahasiswa
SET Nilai = 50
WHERE `Status` = "Alfa";

UPDATE mahasiswa
SET Kelas = "A";

-- Soal Tambahan
USE classicmodels
SELECT * FROM payments;

SELECT * FROM payments ORDER BY amount ASC;

DELETE FROM payments
WHERE amount < 10000;