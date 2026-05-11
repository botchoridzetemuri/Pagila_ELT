select 
    f.category_name, 
    sum(datediff('hour', r.rental_date, r.return_date)) as total_rental_hours
from {{ ref('stg_rental') }} r
left join {{ ref('stg_inventory') }} i on r.inventory_id = i.inventory_id
left join {{ ref('dim_film') }} f on i.film_id = f.film_id
where f.category_name is not null
group by 1
order by total_rental_hours desc