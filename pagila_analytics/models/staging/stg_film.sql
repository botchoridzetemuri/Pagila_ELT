with raw_source as (
    select * from {{ source('pagila', 'film') }}
),
final as (
    select
        film_id,
        title,
        description,
        release_year,
        language_id,
        rental_duration,
        rental_rate,
        length,
        replacement_cost,
        rating,
        last_update,
        _airbyte_extracted_at as synced_at
    from raw_source
)
select * from final