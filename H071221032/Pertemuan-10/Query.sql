#Muhammad Azka Sufirman Rahman | H071221032

USE sakila;

SELECT * FROM film;

#1(diva)
SELECT title 'Judul Film', `length` 'Durasi Film', rating, release_year 'Tahun rilis' 
FROM film 
WHERE rating = "PG" AND `length` > 90
ORDER BY release_year DESC;

#2(zul)
SELECT F.film_id, CONCAT(A.first_name, " ", A.last_name), F.title, 
		F.description, F.release_year 
FROM film F
JOIN film_actor F1
USING(film_id)
JOIN actor A 
USING(actor_id)
WHERE length(A.first_name) = 3 AND LENGTH(A.last_name) > 6
ORDER BY F.film_id;


#3(karina)
(SELECT CONCAT(C.first_name, " ", C.last_name) "Nama Pelanggan", C1.country "Negara", COUNT(R.rental_id) "Jumlah Transaksi", 
case
	when COUNT(R.rental_id) >= 30 then 'Telah melakukan sangat banyak transaksi'
	when COUNT(R.rental_id) >= 15 AND COUNT(R.rental_id) < 30 then 'Telah melakukan banyak transaksi'
	when COUNT(R.rental_id) < 15 then 'Telah melakukan sedikit transaksi' END AS 'Kategori'
FROM customer C
JOIN rental R
USING(customer_id)
JOIN address A
USING(address_id)
JOIN city
USING(city_id)
JOIN country C1
USING(country_id)
WHERE C1.country LIKE "J%"
GROUP BY C.customer_id
LIMIT 3)

UNION

(SELECT CONCAT(C.first_name, " ", C.last_name) "Nama Pelanggan", C1.country "Negara", COUNT(R.rental_id) "Jumlah Transaksi", 
case
	when COUNT(R.rental_id) >= 30 then 'Telah melakukan sangat banyak transaksi'
	when COUNT(R.rental_id) >= 15 AND COUNT(R.rental_id) < 30 then 'Telah melakukan banyak transaksi'
	when COUNT(R.rental_id) < 15 then 'Telah melakukan sedikit transaksi' END AS 'Kategori'
FROM customer C
JOIN rental R
USING(customer_id)
JOIN address A
USING(address_id)
JOIN city
USING(city_id)
JOIN country C1
USING(country_id)
WHERE C1.country LIKE "K%"
GROUP BY C.customer_id
LIMIT 3)

UNION 

(SELECT CONCAT(C.first_name, " ", C.last_name) "Nama Pelanggan", C1.country "Negara", COUNT(R.rental_id) "Jumlah Transaksi", 
case
	when COUNT(R.rental_id) >= 30 then 'Telah melakukan sangat banyak transaksi'
	when COUNT(R.rental_id) >= 15 AND COUNT(R.rental_id) < 30 then 'Telah melakukan banyak transaksi'
	when COUNT(R.rental_id) < 15 then 'Telah melakukan sedikit transaksi' END AS 'Kategori'
FROM customer C
JOIN rental R
USING(customer_id)
JOIN address A
USING(address_id)
JOIN city
USING(city_id)
JOIN country C1
USING(country_id)
WHERE C1.country LIKE "L%"
GROUP BY C.customer_id
LIMIT 3);