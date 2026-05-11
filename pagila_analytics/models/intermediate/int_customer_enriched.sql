with customers as (
    select * from {{ ref('stg_customer') }}
),

addresses as (
    select * from {{ ref('stg_address') }}
),

cities as (
    select * from {{ ref('stg_city') }}
),

enriched as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        c.is_active,
        c.create_date,
        a.address,
        a.district,
        a.postal_code,
        ci.city_name,
        c.synced_at 
    from customers c
    left join addresses a on c.address_id = a.address_id
    left join cities ci on a.city_id = ci.city_id
)

select * from enriched