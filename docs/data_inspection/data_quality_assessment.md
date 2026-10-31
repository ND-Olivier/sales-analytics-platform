# Data Quality Assessment

## 1. Row Counts

The raw dataset contains 11 tables and 3,311 rows in total.

The largest tables are:

- `order_details`: 2,155 rows
- `orders`: 831 rows
- `customers`: 93 rows
- `products`: 77 rows

One test order (OrderID 11078) was added to the `orders` table. It has no matching records in `order_details`, so it is not included in `fact_sales`.

## 2. Null Checks

The following critical columns were checked for NULL values:

- `orders.OrderID`
- `orders.CustomerID`
- `orders.OrderDate`
- `order_details.OrderID`
- `order_details.ProductID`
- `order_details.Quantity`
- `order_details.UnitPrice`

Result: All seven columns had zero NULL values.

## 3. Duplicate Checks


| Key                                 | Total Rows | Distinct Keys | Duplicates |
| ----------------------------------- | ---------- | ------------- | ---------- |
| `orders.OrderID`                    | 831        | 831           | 0          |
| `order_details.OrderID + ProductID` | 2,155      | 2,155         | 0          |
| `customers.CustomerID`              | 93         | 93            | 0          |
| `products.ProductID`                | 77         | 77            | 0          |


Result: No duplicates were found in the four checked keys.

## 4. Findings

All order details have matching orders, and all other checked relationships have no unmatched rows.

One order (OrderID 11078) has no matching records in order_details. This is a test record and is not included in sales analysis.

## 5. Limitations

These checks cover selected columns and keys only. Other columns were not checked.