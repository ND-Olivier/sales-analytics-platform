select
    p.product_id,
    p.product_name,
    p.category_name,
    sum(f.sales_amount) as total_sales,
    sum(f.quantity) as total_quantity_sold,
    count(distinct f.order_id) as total_orders,
    sum(f.sales_amount) / nullif(sum(f.quantity), 0)
        as average_selling_price

from {{ ref('fact_sales') }} as f
left join {{ ref('dim_products') }} as p
    on f.product_id = p.product_id
group by
    p.product_id,
    p.product_name,
    p.category_name