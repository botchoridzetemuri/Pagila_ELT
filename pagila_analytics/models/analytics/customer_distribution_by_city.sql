select 
    city, 
    count(customer_id) as total_customers
from {{ ref('dim_customer') }}
group by 1
order by total_customers desc