-- Nama: Aan Syawaluddin Adi Putra
-- NIM : H071221031

-- NO.1 Azka
SELECT title, `description`, special_features 
FROM film
WHERE `description` LIKE "%robot%" and special_features LIKE "%Behind the Scenes%"
ORDER BY length LIMIT 6;

-- NO.2 Diva
SELECT c.customer_id, c.first_name AS 'Nama Depan', c.last_name AS 'Nama Belakang', COUNT(r.rental_id)
FROM customer c
JOIN rental r
USING(customer_id)
GROUP BY c.customer_id
HAVING  COUNT(r.rental_id) > 30
ORDER BY COUNT(r.rental_id) ASC  

-- NO.3 Azka
(SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Nama',
		COUNT(r.rental_id) AS 'banyak_pinjaman',
CASE
WHEN SUM(p.amount) > (SELECT AVG(total_pembayaran)
							FROM (SELECT SUM(amount) AS 'total_pembayaran'
							FROM payment 
							GROUP BY customer_id) AS c) then "Diatas rata-rata"
ELSE "Bukan diatas rata-rata"
END AS Keterangan,
"2005" AS tahun_pembayaran
FROM customer C
JOIN rental R
USING(customer_id)
JOIN payment P
USING(customer_id)
WHERE YEAR(p.payment_date) = 2005 
GROUP BY C.customer_id
ORDER BY COUNT(R.rental_id) DESC LIMIT 3)

UNION

(SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Nama',
		COUNT(r.rental_id) AS 'banyak_pinjaman',
CASE
WHEN SUM(p.amount) > (SELECT AVG(total_pembayaran)
							FROM (SELECT SUM(amount) AS 'total_pembayaran'
							FROM payment 
							GROUP BY customer_id) AS c) then "Diatas rata-rata"
ELSE "Bukan diatas rata-rata"
END AS Keterangan,
"2006" AS tahun_pembayaran
FROM customer C
JOIN rental R
USING(customer_id)
JOIN payment P
USING(customer_id)
WHERE YEAR(p.payment_date) = 2006
GROUP BY C.customer_id
ORDER BY COUNT(R.rental_id) DESC LIMIT 3)
