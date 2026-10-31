select
    customer_id,
    company_name,
    contact_name,
    city,
    region,
    country
from {{ ref('stag_customers') }}