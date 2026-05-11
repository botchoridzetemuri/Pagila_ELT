with raw_source as (
    select * from {{ source('pagila', 'customer') }}
),
final as (
    select
        customer_id,
        store_id,
        first_name,
        last_name,
        email,
        address_id,
        activebool as is_active,
        create_date,
        last_update,
        _airbyte_extracted_at as synced_at
    from raw_source
)
select * from final