select
    "CategoryID" as category_id,
    "CategoryName" as category_name,
    "Description" as description
from {{ source('raw_data', 'categories') }}