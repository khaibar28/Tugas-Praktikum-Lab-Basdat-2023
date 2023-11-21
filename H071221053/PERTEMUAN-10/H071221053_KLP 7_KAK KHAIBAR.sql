#Diva Aisyah Arfillah 
#H071221053


##NO1 , JOY 
##Seorang pembajak film mencari sebuah film yang akan dibajak. Untuk mendapat keuntungan yang banyak, 
##sang pembajak mencari film yang memiliki durasi rental sedikit (< 5 hari) 
##namun memiliki rental rate tinggi (> 4) Bantu sang pembajak menemukan judul film yang cocok.


SELECT title AS 'Judul Film' , rental_duration, rental_rate
FROM film 
WHERE rental_duration < 5 AND rental_rate > 4;



##NO2, SUSANTI
##Tampilkan semua nama actor yang memiliki dua huruf terakhir seperti Bahasa inggrisnya ‘jawab’, 
##jumlahkan film yang pernah di perankan oleh actor tersebut beserta judul filmnya, lalu urutkan
## jumlahnya dari yang terbanyak. 

SELECT CONCAT(actor.first_name , ' ', actor.last_name) AS 'Nama Lengkap Aktor' , COUNT(film.film_id) AS 'Jumlah Film' , GROUP_CONCAT(film.title) AS 'Judul Film'
FROM actor 
JOIN film_actor
USING(actor_id)
JOIN film 
USING(film_id)
WHERE CONCAT(actor.first_name, ' ' , actor.last_name) LIKE '%ER' 
GROUP BY actor.actor_id
ORDER BY COUNT(film.film_id) DESC;


##NO3, JOY 
##Seorang pengamat film ingin memberikan penghargaan-penghargaan kepada film-film yang diantaranya :
#1) Film terlama dan film tercepat
#2) Film action dengan rating terbaik
#3) Aktor yang memerankan film terbanyak
#4) Film dengan aktor terbanyak dan tersedikit
#5) Film keluarga dengan rating terbaik

SELECT * FROM (
		(	SELECT title AS 'Nominasi', case when `length` = (SELECT MAX(`length`) FROM film) then 'film terlama'
								  						when `length` = (SELECT MIN(`length`) FROM film) then 'film tercepat'
								  						END AS 'Penghargaan'
			FROM film	)
		UNION
		(	SELECT title, 'Film action terbaik' 
			FROM film AS f
			JOIN film_category AS fc 
			USING (film_id)
			JOIN category AS c 
			USING (category_id)
			WHERE c.`name` = 'Action' AND rental_rate = (SELECT MAX(rental_rate) FROM film) )
		UNION
		(	SELECT CONCAT(first_name, ' ', last_name), 'Aktor dengan film terbanyak' 
			FROM actor AS a
			JOIN film_actor AS fa USING (actor_id)
			GROUP BY fa.actor_id
			HAVING COUNT(film_id) = (SELECT MAX(film_count) FROM ( SELECT actor_id, COUNT(film_id) AS film_count
	            																 FROM film_actor
	            															    GROUP BY actor_id ) AS a )  )
	   UNION
		(	SELECT title, CASE WHEN COUNT(actor_id) = (SELECT MAX(actor_count) FROM (SELECT film_id, COUNT(actor_id) AS actor_count
			                                                              FROM film_actor
			                                                              GROUP BY film_id) AS a)
			        					THEN 'film dengan aktor paling banyak'
			        				 WHEN COUNT(actor_id) = (SELECT MIN(actor_count) FROM (SELECT film_id, COUNT(actor_id) AS actor_count
			                                                              FROM film_actor
			                                                              GROUP BY film_id) AS a)
			        					THEN 'film dengan aktor paling sedikit'
			        			END AS 'penghargaan'
			FROM film AS f
			JOIN film_actor AS fa USING (film_id)
			GROUP BY fa.film_id )
		UNION
		(	SELECT title, 'film keluarga terbaik' FROM film AS f
			JOIN film_category AS fc 
			USING (film_id)
			JOIN category AS c 
			USING (category_id)
			WHERE c.`name` = 'Family' AND rental_rate = (SELECT MAX(rental_rate) FROM film) )
	) AS hasil

 	WHERE Penghargaan IS NOT NULL ;




		
		







