with raw_source as (
    select * from {{ source('pagila', 'address') }}
),
final as (
    select
        address_id,
        address,
        district,
        city_id,
        postal_code,
        phone,
        last_update,
        _airbyte_extracted_at as synced_at
    from raw_source
)
select * from final