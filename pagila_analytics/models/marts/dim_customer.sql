select
    customer_id,
    first_name,
    last_name,
    email,
    is_active,
    address,
    district,
    city_name as city,
    postal_code
from {{ ref('int_customer_enriched') }}
