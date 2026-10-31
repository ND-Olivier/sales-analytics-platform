
select
    od.order_id,
    od.product_id,
    o.customer_id,
    o.order_date,
    od.quantity,
    od.unit_price,
    od.discount,
    od.quantity * od.unit_price * (1 - od.discount)
        as sales_amount
from {{ ref('stag_order_details') }} as od
left join {{ ref('stag_orders') }} as o
    on od.order_id = o.order_id