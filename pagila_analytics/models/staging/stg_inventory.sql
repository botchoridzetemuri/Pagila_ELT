with raw_source as (
    select * from {{ source('pagila', 'inventory') }}
),
final as (
    select
        inventory_id,
        film_id,
        store_id,
        last_update,
        _airbyte_extracted_at as synced_at
    from raw_source
)
select * from final