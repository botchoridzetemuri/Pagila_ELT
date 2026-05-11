select 
    b.first_name, 
    b.last_name, 
    count(r.rental_id) as total_rentals
from {{ ref('fact_rental') }} r
left join {{ ref('int_film_actor_bridge') }} b on r.film_id = b.film_id
group by 1, 2
order by total_rentals desc
limit 10