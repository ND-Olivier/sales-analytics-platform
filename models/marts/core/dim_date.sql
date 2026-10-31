with date_range as (
    select
        min(order_date)::date as min_date,
        max(order_date)::date as max_date
    from {{ ref('fact_sales') }}
),

dates as (
    select
        generate_series(
            min_date,
            max_date,
            interval '1 day'
        )::date as date_day
    from date_range
)

select
    date_day,
    extract(year from date_day)::int as year,
    extract(quarter from date_day)::int as quarter,
    extract(month from date_day)::int as month,
    to_char(date_day, 'Month') as month_name,
    extract(day from date_day)::int as day_of_month,
    extract(dow from date_day)::int as day_of_week,
    to_char(date_day, 'Day') as day_name
from dates