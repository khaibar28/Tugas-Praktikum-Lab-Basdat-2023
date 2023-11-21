-- Nama : Muhammad Zulfikri Sadrah 
-- NIM : H0721221082
-- Asisten : Kak Khaibar

-- NOMOR 1 (SOAL Susanti)
-- Tampilkan staff_id kemudian first_name dari staff yang memiliki address_id < 4. 
-- Kemudian tampilkan juga emailnya, namun sebelum anda menampilkan email, 
-- staf tersebut ingin mengganti emailnya menjadi ‘MHyer@sakilastaff.com’. 
-- Expected Output : 1r x 3c 
-- Staff_id | first_name | email
UPDATE staff
SET email = "MHyer@sakilastaff.com"
WHERE address_id < 4

SELECT staff_id, first_name, email
FROM staff
WHERE address_id < 4

-- NOMOR 2 (SOAL Joy)
-- Seorang fans mencintai film-film drama dan juga sangat mengidolakan 
-- aktor Matthew Johansson. Karena saking ngefansnya, orang tersebut ingin 
-- menonton semua film yang dibintangi oleh sang aktor. Bantu orang tersebut 
-- mencari semua film drama yang dibintangi  oleh sang aktor!
-- Expected output : 3r × 2c 
-- title | kategori | nama_aktor
SELECT title, category.name AS "kategori", CONCAT(actor.first_name, " ", actor.last_name) AS "nama_aktor"
FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
WHERE category.name = "Drama"  AND CONCAT(actor.first_name, " ", actor.last_name) = "Matthew Johansson"

-- NOMOR 3 (SOAL Susanti)
-- Anda adalah seorang data analist yang ditugaskan untuk menyusun sebuah laporan mendalam tentang 
-- perilaku pelanggan dan katalog film perusahaan peminjaman DVD. Anda diminta untuk membuat laporan 
-- tentang aktivitas pelanggan yang mencakup informasi tentang penyewaan dan pembayaran. 
-- Tampilkan nama lengkap dan alamat pelanggan, beserta jumlah transaksi penyewaan dan total 
-- pembayaran yang dilakukan oleh setiap pelanggan. 
-- Jika pelanggan tidak pernah melakukan penyewaan, tampilkan pesan "Belum ada transaksi penyewaan." 
-- Jika pelanggan melakukan penyewaan tetapi belum membayar, tampilkan pesan "Belum ada pembayaran." 
-- Sertakan informasi tambahan berupa: 
-- ✓ Jika total pembayaran pelanggan lebih dari 5000, tampilkan kategori "Pelanggan Berpenghasilan Tinggi." 
-- ✓ Jika total pembayaran pelanggan antara 1000 dan 4999, tampilkan kategori "Pelanggan Berpenghasilan Menengah." 
-- ✓ Jika total pembayaran pelanggan kurang dari 1000, tampilkan kategori "Pelanggan Berpenghasilan Rendah." 
-- Expected Output : 600r x 5c 
-- Nama_Pelanggan | address | total_penyewaan | total_pembayaran | Kategori_Pelanggan

SELECT CONCAT(first_name, " ", last_name) AS "Nama_Pelanggan", address.address, COUNT(rental.rental_id) AS "total_penyewaan", SUM(payment.amount) AS "total_pembayaran", case
when SUM(payment.amount) > 5000 then "Pelanggan Berpenghasilan Tinggi"
when SUM(payment.amount) BETWEEN 1000 AND 4999 then "Pelanggan Berpenghasilan Menengah"
when SUM(payment.amount) < 1000 then "Pelanggan Berpenghasilan Rendah"
END AS "Kategori_Pelanggan"
FROM customer
JOIN address USING (address_id)
JOIN rental USING (customer_id)
JOIN payment USING (customer_id)
GROUP BY customer_id 
