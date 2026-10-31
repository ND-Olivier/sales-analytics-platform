select
    "OrderID" as order_id,
    "CustomerID" as customer_id,
    "OrderDate" as order_date,
    "RequiredDate" as required_date,
    "ShippedDate" as shipped_date,
    "ShipCountry" as ship_country,
    "Freight" as freight
from {{ source('raw_data', 'orders') }}