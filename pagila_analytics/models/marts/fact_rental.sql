select
    rental_id,
    rental_date,
    customer_id,
    staff_id,
    film_id,
    store_id,
    payment_amount,
    payment_date
from {{ ref('int_rental_facts') }}