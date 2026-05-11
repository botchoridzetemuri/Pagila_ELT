select 
    f.category_name, 
    sum(r.revenue_amount) as total_revenue
from {{ ref('fact_revenue') }} r
left join {{ ref('fact_rental') }} fr on r.rental_id = fr.rental_id
left join {{ ref('dim_film') }} f on fr.film_id = f.film_id
where f.category_name is not null
group by 1
order by total_revenue desc