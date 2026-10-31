select
    "CustomerID" as customer_id,
    "CompanyName" as company_name,
    "ContactName" as contact_name,
    "City" as city,
    "Region" as region,
    "Country" as country
from {{ source('raw_data', 'customers') }}