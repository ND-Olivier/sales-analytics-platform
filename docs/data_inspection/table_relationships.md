#  Raw Table Relationships

## Relationships Checked


| Parent Table | Referencing Table | Join Key     | Unmatched Rows |
| ------------ | ----------------- | ------------ | -------------- |
| `orders`     | `order_details`   | `OrderID`    | 0              |
| `products`   | `order_details`   | `ProductID`  | 0              |
| `customers`  | `orders`          | `CustomerID` | 0              |
| `employees`  | `orders`          | `EmployeeID` | 0              |
| `categories` | `products`        | `CategoryID` | 0              |


## Findings

All order details have matching orders, and all other five checked relationships have no unmatched rows.

One order (OrderID 11078) has no matching records in order_details. This is a test record and is not included in fact_sales.

## Limitations

Other relationships and key constraints were not checked. We will also check table relationships and cardinality in Power BI.