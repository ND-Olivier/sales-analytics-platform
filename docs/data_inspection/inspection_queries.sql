-- 1. schema view
SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'raw_data'
ORDER BY
    table_name,
    ordinal_position;

--2. to see the number of rows in each table
SELECT 'categories' AS table_name, COUNT(*) AS row_count FROM raw_data.categories
UNION ALL
SELECT 'customers', COUNT(*) FROM raw_data.customers
UNION ALL
SELECT 'employee_territories', COUNT(*) FROM raw_data.employee_territories
UNION ALL
SELECT 'employees', COUNT(*) FROM raw_data.employees
UNION ALL
SELECT 'order_details', COUNT(*) FROM raw_data.order_details
UNION ALL
SELECT 'orders', COUNT(*) FROM raw_data.orders
UNION ALL
SELECT 'products', COUNT(*) FROM raw_data.products
UNION ALL
SELECT 'region', COUNT(*) FROM raw_data.region
UNION ALL
SELECT 'shippers', COUNT(*) FROM raw_data.shippers
UNION ALL
SELECT 'suppliers', COUNT(*) FROM raw_data.suppliers
UNION ALL
SELECT 'territories', COUNT(*) FROM raw_data.territories
ORDER BY table_name;

-- 3. check for data quality

-- (a) check for null
SELECT
    'orders' AS table_name,
    'OrderID' AS column_name,
    COUNT(*) FILTER (WHERE "OrderID" IS NULL) AS null_count
FROM raw_data.orders
UNION ALL
SELECT
    'orders',
    'CustomerID',
    COUNT(*) FILTER (WHERE "CustomerID" IS NULL)
FROM raw_data.orders
UNION ALL
SELECT
    'orders',
    'OrderDate',
    COUNT(*) FILTER (WHERE "OrderDate" IS NULL)
FROM raw_data.orders
UNION ALL
SELECT
    'order_details',
    'OrderID',
    COUNT(*) FILTER (WHERE "OrderID" IS NULL)
FROM raw_data.order_details
UNION ALL
SELECT
    'order_details',
    'ProductID',
    COUNT(*) FILTER (WHERE "ProductID" IS NULL)
FROM raw_data.order_details
UNION ALL
SELECT
    'order_details',
    'Quantity',
    COUNT(*) FILTER (WHERE "Quantity" IS NULL)
FROM raw_data.order_details
UNION ALL
SELECT
    'order_details',
    'UnitPrice',
    COUNT(*) FILTER (WHERE "UnitPrice" IS NULL)
FROM raw_data.order_details;

--(b) check duplicates
SELECT
    'orders.OrderID' AS checked_key,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT "OrderID") AS distinct_keys,
    COUNT(*) - COUNT(DISTINCT "OrderID") AS duplicate_count
FROM raw_data.orders
UNION ALL
SELECT
    'order_details.OrderID + ProductID',
    COUNT(*),
    COUNT(DISTINCT ("OrderID", "ProductID")),
    COUNT(*) - COUNT(DISTINCT ("OrderID", "ProductID"))
FROM raw_data.order_details
UNION ALL
SELECT
    'customers.CustomerID',
    COUNT(*),
    COUNT(DISTINCT "CustomerID"),
    COUNT(*) - COUNT(DISTINCT "CustomerID")
FROM raw_data.customers
UNION ALL
SELECT
    'products.ProductID',
    COUNT(*),
    COUNT(DISTINCT "ProductID"),
    COUNT(*) - COUNT(DISTINCT "ProductID")
FROM raw_data.products;

--4. relationship between raw tables

-- (a) order details without a matching order
select 'order_details -> orders' as relationship,
    count(*) as unmached_rows
from raw_data.order_details od left join raw_data.orders o
    on od."OrderID" = o."OrderID"
where o."OrderID" is null
UNION ALL
-- (b) order details without a matching product
select 'order_details -> products',
count(*)
from raw_data.order_details od
LEFT JOIN raw_data.products p
    ON od."ProductID" = p."ProductID"
WHERE p."ProductID" IS NULL
UNION ALL

-- (c) orders without a matching customer
SELECT
    'orders -> customers',
    COUNT(*)
FROM raw_data.orders o
LEFT JOIN raw_data.customers c
    ON o."CustomerID" = c."CustomerID"
WHERE c."CustomerID" IS NULL
UNION ALL

--(d) orders without a matching employee
SELECT
    'orders -> employees',
    COUNT(*)
FROM raw_data.orders o
LEFT JOIN raw_data.employees e
    ON o."EmployeeID" = e."EmployeeID"
WHERE e."EmployeeID" IS NULL
UNION ALL

--(e) products without a matching category
SELECT
  'products -> categories',
   COUNT(*)
FROM raw_data.products p
LEFT JOIN raw_data.categories c
   ON p."CategoryID" = c."CategoryID"
WHERE c."CategoryID" IS NULL;

-- (f) orders without matching order details
SELECT
    'orders -> order_details' as relationship,
    COUNT(*) as unmached_rows
FROM raw_data.orders o
LEFT JOIN raw_data.order_details od
    ON o."OrderID" = od."OrderID"
WHERE od."OrderID" IS NULL;



-- 5. Check whitespace in important text columns
select 'customers.customer_id' as column_name, count(*) as rows_with_spaces
from raw_data.customers
where "CustomerID" <> btrim("CustomerID")

union all

select 'customers.country', count(*)
from raw_data.customers
where "Country" <> btrim("Country")

union all

select 'customers.city', count(*)
from raw_data.customers
where "City" <> btrim("City")

union all

select 'products.product_name', count(*)
from raw_data.products
where "ProductName" <> btrim("ProductName")

union all

select 'categories.category_name', count(*)
from raw_data.categories
where "CategoryName" <> btrim("CategoryName");


SELECT
    MIN("Discount") AS minimum_discount,
    MAX("Discount") AS maximum_discount,
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE "Discount" = 0) AS no_discount_rows,
    COUNT(*) FILTER (WHERE "Discount" > 0) AS discounted_rows
FROM raw_data.order_details;