with rentals as (
    select * from {{ ref('stg_rental') }}
),

inventory as (
    select * from {{ ref('stg_inventory') }}
),

payments as (
    select * from {{ ref('stg_payment') }}
),

facts as (
    select
        r.rental_id,
        r.rental_date,
        r.customer_id,
        r.staff_id,
        i.film_id,
        i.store_id,
        p.amount as payment_amount,
        p.payment_date
    from rentals r
    left join inventory i on r.inventory_id = i.inventory_id
    left join payments p on r.rental_id = p.rental_id
)

select * from facts