#soal 1 (Karina)#
SELECT DISTINCT  rating FROM film

SELECT title
FROM film
WHERE title LIKE 'A%S' AND release_year = 2006 AND rating = 'R' 
#soal 2 (Karina)#
SELECT 
	film.title AS 'Judul Film', 
	LENGTH(film.title) AS 'Panjang Karakter'
	film_category.category_id AS 'Genre',
	COUNT(film_actor.actor_id) AS 'Jumlah Aktor'
FROM film_category
JOIN film
USING(film_id)
JOIN film_actor
USING(film_id)
GROUP BY film.title
WHERE film.title LIKE 'A%' 
HAVING COUNT(film_actor.actor_id) >= 5

SELECT 
film.title AS 'Judul Film',
LENGTH(film.title) AS 'Panjang Karakter',
film_category.category_id AS 'Genre',
COUNT(film_actor.actor_id) AS 'Jumlah Aktor'
FROM film_category
JOIN film
USING(film_id)
JOIN film_actor
USING(film_id)
WHERE film.title LIKE 'A%' 
GROUP BY film.title
HAVING LENGTH(film.title) %2 = 1 AND COUNT(film_actor.actor_id) >= 5
ORDER BY LENGTH(film.title) DESC 
#soal 3 ()#

(SELECT film.title, film.`length` ,film_category.category_id,
case 
when `length` > 120 then 'Durasi Panjang'
ELSE 'Durasi Normal'
END AS 'label_durasi'
FROM film
JOIN film_category 
USING(film_id)
WHERE film_category.category_id = 11 AND film.`length` > (SELECT AVG(length)FROM film)
ORDER BY film.`length` DESC 
LIMIT 8)
UNION
(SELECT film.title, film.`length` ,film_category.category_id,
case 
when `length` > 90 then 'Durasi Normal'
ELSE 'Durasi Pendek'
END AS 'label_durasi'
FROM film
JOIN film_category 
USING(film_id)
WHERE film_category.category_id = 2 OR film_category.category_id = 8 AND film.`length` > (SELECT AVG(length)FROM film)
ORDER BY film.`length` DESC 
LIMIT 6)


case 