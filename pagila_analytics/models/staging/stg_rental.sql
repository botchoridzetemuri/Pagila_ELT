with raw_source as (
    select * from {{ source('pagila', 'rental') }}
),
final as (
    select
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        return_date,
        staff_id,
        last_update,
        _airbyte_extracted_at as synced_at
    from raw_source
)
select * from final