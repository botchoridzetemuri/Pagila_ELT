select 
    category_name, 
    count(film_id) as total_films
from {{ ref('dim_film') }}
where category_name is not null
group by 1
order by total_films desc