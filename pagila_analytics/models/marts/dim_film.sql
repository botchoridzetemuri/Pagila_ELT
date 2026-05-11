with films as (
    select * from {{ ref('stg_film') }}
),
categories as (
    select * from {{ ref('stg_category') }}
),
film_category as (
    select * from {{ source('pagila', 'film_category') }}
),

final as (
    select
        f.film_id,
        f.title,
        f.description,
        f.release_year,
        f.rental_duration,
        f.rental_rate,
        f.length,
        f.rating,
        c.category_name
    from films f
    left join film_category fc on f.film_id = fc.film_id
    left join categories c on fc.category_id = c.category_id
)

select * from final
