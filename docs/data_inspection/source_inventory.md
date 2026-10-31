
# Raw Data Source structure

## Database
- Database: `north_dw`
- Source schema: `raw_data`

## Source Tables

| Table | Purpose |
|---|---|
| `categories` | Product categories |
| `customers` | Customer and company information |
| `employee_territories` | Employee-to-territory assignments |
| `employees` | Employee information |
| `order_details` | Products, quantities, prices, and discounts per order |
| `orders` | Order dates, customers, employees, shipping, and freight |
| `products` | Product information, prices, stock, and categories |
| `region` | Region descriptions |
| `shippers` | Shipping company information |
| `suppliers` | Suppliers of the company |
| `territories` | Sales territories and their regions |

## Initial Observations

- The source contains 11 tables.
- `orders` and `order_details` appear central to sales analysis.
- `products` and `categories` can support product performance analysis.
- `customers` can support customer performance analysis.