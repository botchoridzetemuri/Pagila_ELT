with raw_source as (
    select * from {{ source('pagila', 'city') }}
),
final as (
    select
        city_id,
        city as city_name,
        country_id,
        last_update,
        _airbyte_extracted_at as synced_at
    from raw_source
)
select * from final