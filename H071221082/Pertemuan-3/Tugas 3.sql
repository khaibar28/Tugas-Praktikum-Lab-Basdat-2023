-- NOMOR 1

CREATE DATABASE praktikum3

USE praktikum3

CREATE TABLE mahasiswa(
NIM VARCHAR(10) PRIMARY KEY NOT NULL,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
`Status` VARCHAR(50) NOT NULL,
Nilai INT(11)
)

INSERT INTO mahasiswa
VALUES ("H071241056", "Kotlina", "A", "Hadir", 100),
("H071241060", "Pitonia", "A", "Alfa", 85),
("H071241063", "Javano", "A", "Hadir", 50),
("H071241065", "Ciplus Kuadra", "B", "Hadir", 65),
("H071241066", "Pihap E", "B", "Hadir", 85),
("H071241079", "Ruby", "B", "Alfa", 90);
SELECT * FROM mahasiswa

-- NOMOR 2
UPDATE mahasiswa
SET Kelas = "C", Nilai = 0
WHERE `Status` = "Alfa";
SELECT * FROM mahasiswa

-- NOMOR 3
DELETE FROM mahasiswa
WHERE Kelas = "A" AND Nilai > 90
SELECT * FROM mahasiswa

-- NOMOR 4
INSERT INTO mahasiswa
VALUES ("H071221082", "Zulfikri", "D", "Pindahan", NULL);

UPDATE mahasiswa
SET Nilai = 50
WHERE `status` = "Alfa"

UPDATE mahasiswa
SET Kelas = "A"
SELECT * FROM mahasiswa

-- SOAL TAMBAHAN
-- Tambahkan data baru dengan status NULL
INSERT INTO mahasiswa
VALUE("H071221080", "Adnan", "A", NULL, 90); -- Error

-- SOAL TAMBAHAN
-- Tambahkanlah 3 orang employee baru pada tabel employees dalam database 
-- Classic Models dengan salah satu nama employee merupakan nama anda.
USE classicmodels
INSERT INTO employees
VALUES (1100, "Fikri", "Zul", "x5000", "zulfikri@gmail.com", 3, 1611, "Sales Rep"),
(1105, "Iqbal", "Muh", "x5500", "muhiqbal@gmail.com", 3, 1702, "Sales Rep"),
(1110, "Adnan", "Andi", "x6000", "andiadnan@gmail.com", 3, 1702, "Sales Rep");
