with raw_source as (
    select * from {{ source('pagila', 'actor') }}
),

final as (
    select
        actor_id,
        first_name,
        last_name,
        last_update,
        _airbyte_extracted_at as synced_at
    from raw_source
)

select * from final