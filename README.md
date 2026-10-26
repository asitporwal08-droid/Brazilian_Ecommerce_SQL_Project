# Brazilian E-Commerce SQL Analysis

## Project Overview

This project analyzes Brazilian e-commerce data using SQL to uncover business insights related to order trends, product revenue, payment methods, delivery performance, customer reviews, seller performance, and customer retention.

The objective is to demonstrate practical SQL skills by answering real-world business questions using a relational database.

## Tools Used

- **Database:** MySQL
- **SQL Environment:** MySQL Workbench
- **Version Control:** Git and GitHub

## Dataset

This project uses the Brazilian E-Commerce Public Dataset by Olist.

The dataset contains information about customers, orders, order items, payments, reviews, products, sellers, geolocation, and product category translations.

## Business Questions

This project answers the following 10 business questions using SQL:

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

```text id="sk4a9f"
Brazilian_Ecommerce_SQL_Project/
├── README.md
└── olist_ecommerce_analysis.sql
```

## Data Validation

The following table counts were verified in MySQL Workbench:

| Table | Row Count |
|---|---:|
| orders | 99,441 |
| customers | 99,441 |
| order_items | 112,650 |
| order_payments | 103,886 |
| order_reviews | 99,223 |
| products (clean) | 32,951 |
| sellers | 3,095 |
| geolocation | 1,000,163 |
| category_translation | 71 |

## Key Findings

- **Order trends:** Monthly order volumes can be analyzed using order purchase timestamps.
- **Product categories:** Health & Beauty, Watches & Gifts, and Bed, Bath & Table were among the leading categories by product revenue in the previously analyzed results.
- **Payment methods:** Credit cards had the highest total payment value, approximately 12.54 million in the previously analyzed results.
- **Delivery performance:** Among delivered orders with both actual and estimated delivery dates, 88,644 arrived on time and 7,826 were late.
- **Customer reviews:** Approximately 57.78% of review records had a score of 5.
- **Seller performance:** Seller revenue is calculated from product prices for delivered orders.
- **Monthly revenue:** November 2017 had the highest monthly revenue among the previously analyzed months, at approximately 987,765.37.
- **Repeat customers:** 2,997 repeat customers were identified among 96,096 unique customers with orders, approximately 3.12%.
- **Category ratings:** Books General Interest had an average rating of 4.46 across 508 review-category records. Construction Tools Tools averaged 4.43 across 94 records, while Books Technical averaged 4.41 across 259 records.

## Metric Definitions

- **Order volume:** Counts distinct orders by purchase month.
- **Revenue:** Uses `order_items.price` for delivered orders. Freight charges are excluded.
- **Payment value:** Sum of `payment_value` grouped by payment type; this includes payment amounts rather than just product prices.
- **On-time delivery:** Includes delivered orders with both actual and estimated delivery dates.
- **Customer reviews:** Review score percentages use the total number of records in `order_reviews` as the denominator.
- **Seller revenue:** Product prices are summed for delivered orders and grouped by seller.
- **Repeat customers:** Customers identified by `customer_unique_id` who placed more than one order.
- **Monthly revenue ranking:** Uses `DENSE_RANK()` to rank months by delivered-order product revenue.
- **Category ratings:** Each distinct review-category combination is counted once. A review may appear in multiple categories if an order contains products from different categories.
- **Category threshold:** Only categories with at least 50 review-category records are included in the category rating analysis.

## How to Run

1. Clone or download this repository.
2. Open MySQL Workbench and connect to your MySQL server.
3. Create or select the `olist` database.
4. Import the Olist dataset and ensure the required tables are available.
5. Open `olist_ecommerce_analysis.sql` in MySQL Workbench.
6. Execute the numbered queries individually to review their results.
7. Review the result sets to explore the business insights.

**Requirement:** MySQL 8.0 or later is recommended because the script uses Common Table Expressions (CTEs) and window functions.

## Skills Demonstrated

- SQL querying and filtering
- Aggregate functions and `GROUP BY`
- Multi-table joins
- Conditional logic using `CASE`
- Date-based analysis
- Common Table Expressions (CTEs)
- Window functions, including `DENSE_RANK()`
- Data validation and business interpretation
- Translating business questions into SQL queries

## Conclusion

This project demonstrates how SQL can be used to analyze e-commerce data, measure business performance, examine customer behavior, and generate insights to support data-driven decision-making.
