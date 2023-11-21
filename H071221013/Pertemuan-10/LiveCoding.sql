USE sakila

#Nama	: SUSANTI
#NIM	: H071221013

#No.1 (Zulfikri)
SELECT film_id, category_id
FROM film_category
WHERE category_id IN (1, 5, 10, 11, 14) AND film_id BETWEEN 200 AND 400;

#No.2 (Azka)
SELECT * FROM film

SELECT 
		CONCAT(a.first_name, ' ', a.last_name) AS Nama_Aktor,
		GROUP_CONCAT(f.title) AS Daftar_Film
FROM actor a
JOIN film_actor fa
USING(actor_id)
JOIN film f
USING(film_id)
JOIN film_category fc
USING(film_id)
WHERE category_id IN (2, 3, 8) AND f.rating IN ("PG", "G")
GROUP BY a.actor_id
HAVING COUNT(film_id) > 2;

#N0.3 (Zulfikri)

SELECT 
		CONCAT(a.first_name, ' ', a.last_name) AS 'Nama Aktor', 
		f.title AS "judul film", 
		c.name AS "kategori",
		case 
			when f.length > 150 then "panjang"
			when f.length < 70 then "pendek"
		ELSE "sedang"
		END AS "durasi film"
FROM actor a
JOIN film_actor
USING(actor_id)
JOIN film f
USING(film_id)
JOIN film_category
USING(film_id)
JOIN category c
USING(category_id)
WHERE c.category_id IN 
	(SELECT category_id
	FROM category 
	WHERE `name` = "action"
	
	UNION
	
	SELECT category_id
	FROM category 
	WHERE `name` = "horror")

GROUP BY f.title
ORDER BY f.title;



 