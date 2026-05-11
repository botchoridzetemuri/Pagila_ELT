select 
    b.first_name, 
    b.last_name, 
    count(b.film_id) as children_movie_count
from {{ ref('int_film_actor_bridge') }} b
left join {{ ref('dim_film') }} f on b.film_id = f.film_id
where f.category_name = 'Children'
group by 1, 2
order by children_movie_count desc
limit 10