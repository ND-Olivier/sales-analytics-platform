select
    date_trunc('month', order_date)::date as sales_month,
    sum(sales_amount) as total_sales,
    count(distinct order_id) as total_orders,
    sum(quantity) as total_quantity_sold,
    sum(sales_amount) / nullif(count(distinct order_id), 0)
        as average_order_value

from {{ ref('fact_sales') }}
group by 1