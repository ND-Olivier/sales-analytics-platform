select
    c.customer_id,
    c.company_name,
    c.city,
    c.country,
    sum(f.sales_amount) as total_sales,
    count(distinct f.order_id) as total_orders,
    sum(f.quantity) as total_quantity_sold,
    sum(f.sales_amount) / nullif(count(distinct f.order_id), 0)
        as average_order_value

from {{ ref('fact_sales') }} as f
left join {{ ref('dim_customers') }} as c
    on f.customer_id = c.customer_id
group by
    c.customer_id,
    c.company_name,
    c.city,
    c.country