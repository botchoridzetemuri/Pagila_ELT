select
    payment_id,
    customer_id,
    staff_id,
    rental_id,
    amount as revenue_amount,
    payment_date,
    payment_date::date as payment_date_id
from {{ ref('stg_payment') }}