
select
    "ProductID" as product_id,
    "ProductName" as product_name,
    "CategoryID" as category_id,
    "UnitPrice" as unit_price,
    "UnitsInStock" as units_in_stock,
    "UnitsOnOrder" as units_on_order,
    "ReorderLevel" as reorder_level,
    "Discontinued" as is_discontinued
from {{ source('raw_data', 'products') }}