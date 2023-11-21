-- Nama : Joy Abrian
-- NIM : H071221030

-- Nomor 1
select * from film
where length > 120 and release_year = 2006;

--  Nomor 2
select f.title, c.name, count(fa.actor_id) as 'actor_count'
from film as f
join film_category as fc using (film_id)
join category as c using (category_id)
join film_actor as fa using (film_id)
where c.name = 'Action' or c.name = 'Sci-Fi'
group by f.film_id
order by f.title;

-- Nomor 3
(	select f.title as 'Judul_film', c.name as 'genre_film', 'Disukai' as 'rating_film'
	from film as f
	join film_category as fc using (film_id)
	join category as c using (category_id)
	where f.rating > (select avg(rating) from film)
	limit 50 )
union
(	select f.title, c.name, 'Standar'
	from film as f
	join film_category as fc using (film_id)
	join category as c using (category_id)
	where f.rating < (select avg(rating) from film)
	limit 50 )