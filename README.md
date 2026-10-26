# Brazilian E-Commerce Data Analysis (Olist)

## Project Overview
This project uses SQL and MySQL to analyze the Brazilian E-Commerce Public Dataset by Olist. It explores order trends, product revenue, payment methods, delivery performance, customer reviews, seller performance, and repeat purchasing.

## Tools
- MySQL 8.0+
- MySQL Workbench
- SQL: joins, aggregations, `CASE`, CTEs, date functions, and window functions

## Dataset
Brazilian E-Commerce Public Dataset by Olist, available on Kaggle. The imported database is named `olist`.

## Business Questions
1. How do order volumes change month by month?
2. Which product categories generate the highest revenue?
3. Which payment methods contribute the most payment value?
4. How many orders are delivered on time versus late?
5. What customer review scores are most common?
6. Which sellers generate the highest product revenue?
7. How does product revenue change over time?
8. How many customers place repeat orders?
9. Which months rank highest by revenue?
10. How do customer ratings vary by product category?

## Project Structure
```text
Brazilian_Ecommerce_SQL_Project/
├── README.md
└── olist_ecommerce_analysis.sql
```

## Verified Data Checks
The following row counts were checked in MySQL Workbench during project setup:

| Table | Rows |
|---|---:|
| orders | 99,441 |
| customers | 99,441 |
| order_items | 112,650 |
| order_payments | 103,886 |
| order_reviews | 99,223 |
| products (clean table) | 32,951 |
| sellers | 3,095 |
| geolocation | 1,000,163 |
| category_translation | 71 |

## Key Findings
These findings are based on the query results visible in MySQL Workbench screenshots:

- **Order status:** 96,478 orders were delivered (97.02% of 99,441). Other statuses included shipped (1,107), canceled (625), unavailable (609), invoiced (314), processing (301), created (5), and approved (2).
- **Delivery performance:** Among delivered orders with both actual and estimated delivery dates, 88,644 (91.89%) were on time and 7,826 (8.11%) were late.
- **Payment methods:** Credit card contributed the highest payment value (12,542,084.19), followed by boleto (2,869,361.27), voucher (379,436.87), debit card (217,989.79), and not defined (0.00).
- **Review scores:** Score 5 was most common (57,327 reviews; 57.78%), followed by score 4 (19,142; 19.29%), score 3 (8,179; 8.24%), score 1 (11,424; 11.51%), and score 2 (3,151; 3.18%).
- **Repeat purchasing:** 2,997 repeat customers out of 96,096 unique customers with orders, or 3.12%.
- **Highest-revenue month in the ranking query:** November 2017, with product revenue of 987,765.37. August 2018 ranked second (977,544.69), and April 2018 third (973,534.09).
- **Top category revenue:** The screenshot showed health_beauty (1,233,131.72), watches_gifts (1,166,176.98), and bed_bath_table (1,023,434.76) as the top three categories by delivered-order product revenue.
- **Category ratings:** Among categories with at least 50 reviews, books_general_interest averaged 4.45 (508 reviews), construction_tools_tools 4.44 (94), and books_imported 4.40 (53).

**Metric definition:** Revenue queries sum `order_items.price` for delivered orders. Freight charges are excluded. Category rating averages are based on joined order-review/item records, with categories filtered to at least 50 distinct review IDs.

## How to Run
1. Download and extract the Olist dataset from Kaggle.
2. Import the required CSV files into a MySQL database named `olist`.
3. Open `olist_ecommerce_analysis.sql` in MySQL Workbench.
4. Execute each numbered query separately and review the result grid.
5. If your local data or table counts differ, validate the import before interpreting results.

## Skills Demonstrated
- SQL querying and filtering
- Aggregate functions and `GROUP BY`
- Multi-table joins
- Conditional logic with `CASE`
- Date-based analysis
- CTEs and window functions
- Data validation and business interpretation
