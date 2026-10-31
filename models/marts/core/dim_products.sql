select
    p.product_id,
    p.product_name,
    p.category_id,
    c.category_name,
    p.unit_price,
    p.units_in_stock,
    p.units_on_order,
    p.reorder_level,
    p.is_discontinued
from {{ ref('stag_products') }} as p
left join {{ ref('stag_categories') }} as c
    on p.category_id = c.category_id