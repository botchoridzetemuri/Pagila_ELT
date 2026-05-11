with films as (
    select * from {{ ref('stg_film') }}
),

actors as (
    select * from {{ ref('stg_actor') }}
),

film_actor as (
    select * from {{ source('pagila', 'film_actor') }}
),

bridge as (
    select
        fa.actor_id,
        a.first_name,
        a.last_name,
        fa.film_id,
        f.title as film_title
    from film_actor fa
    left join actors a on fa.actor_id = a.actor_id
    left join films f on fa.film_id = f.film_id
)

select * from bridge