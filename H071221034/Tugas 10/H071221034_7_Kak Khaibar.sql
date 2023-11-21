-- Karina Minerva Romeda
-- H071221034

-- No.1 (Reza)
SELECT actor_id, CONCAT(first_name, ' ', last_name) AS 'Nama Aktor'
FROM actor 
WHERE actor_id % 2 = 0
ORDER BY CONCAT(first_name, ' ', last_name) DESC
LIMIT 20;

-- No.2 (Reza)
SELECT film.title, SUM(payment.amount) AS 'total_payment'
FROM film
JOIN inventory
USING (film_id)
JOIN rental
USING (inventory_id)
JOIN payment
USING (rental_id)
WHERE rating > 4
GROUP BY film.title
ORDER BY SUM(payment.amount) DESC;

-- No.3 (Aan)
(SELECT CONCAT(actor.first_name, ' ', actor, last_name) AS 'actor_name', COUNT(film.film_id), CONCAT_WS(' ', film.title) AS 'judul_film',
CASE
WHEN COUNT(film.film_id) > 30 THEN 'GG'
WHEN COUNT(film.film_id) < 25 THEN 'cupu'
FROM actor
JOIN film_actor
USING (actor_id)
JOIN film
USING (film_id))
UNION
(SELECT CONCAT(actor.first_name, ' ', actor, last_name) AS 'actor_name', COUNT(film.film_id), CONCAT_WS(' ', film.title) AS 'judul_film',
CASE
WHEN COUNT(film.film_id) > 30 THEN 'GG'
WHEN COUNT(film.film_id) < 25 THEN 'cupu'
FROM actor
JOIN film_actor
USING (actor_id)
JOIN film
USING (film_id));