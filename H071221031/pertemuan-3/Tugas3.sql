CREATE DATABASE praktikum3;

CREATE TABLE mahasiswa (
NIM VARCHAR(10) PRIMARY KEY,
Nama VARCHAR(50) NOT null,
Kelas CHAR(1) NOT NULL,
Status VARCHAR(50) NOT null,
Nilai INT(11)
);

DESCRIBE mahasiswa

SELECT * FROM mahasiswa

-- No.1
INSERT INTO mahasiswa
VALUES ("H071241056", "Kotlina", "A", "Hadir", 100),
			("H071241060", "Pitonia", "A", "Alfa", 85),
			("H071241063", "Javano", "A", "Hadir", 50),
			("H071241065", "Ciplus Kuadra", "B", "Hadir", 65),
			("H071241066", "Pihap E", "B", "Hadir", 85),
			("H071241079", "Ruby", "B", "Alfa", 90)
-- NO.2
UPDATE mahasiswa
SET Nilai = 0
WHERE Status = 'Alfa'

UPDATE mahasiswa
SET kelas = 'C'
WHERE nilai = 0

-- NO.3
DELETE FROM mahasiswa
WHERE kelas = 'A' AND nilai > 90

-- NO.4
INSERT INTO  mahasiswa
VALUES ("H071221031", "Aan Syawaluddin Adi Putra", "A", "Pindahan", NULL)

UPDATE mahasiswa 
SET nilai = 50
WHERE Status = 'Alfa'

UPDATE mahasiswa
SET kelas = 'A'