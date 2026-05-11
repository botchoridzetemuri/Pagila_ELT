with raw_source as (
    select * from {{ source('pagila', 'category') }}
),
final as (
    select
        category_id,
        name as category_name,
        last_update,
        _airbyte_extracted_at as synced_at
    from raw_source
)
select * from final