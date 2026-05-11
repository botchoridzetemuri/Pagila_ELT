with raw_source as (
    select * from {{ source('pagila', 'payment') }}
),
final as (
    select
        payment_id,
        customer_id,
        staff_id,
        rental_id,
        amount,
        payment_date,
        _airbyte_extracted_at as synced_at
    from raw_source
)
select * from final
