# Brazilian E-Commerce SQL Analysis

## Project Overview

This project analyzes Brazilian e-commerce data using SQL to uncover business insights related to order performance, revenue, payment methods, customer behavior, delivery performance, and product categories.

The objective is to demonstrate practical SQL skills by answering real-world business questions using a relational database.

## Tools Used

- **Database:** MySQL
- **SQL Environment:** MySQL Workbench
- **Version Control:** Git and GitHub

## Dataset

This project uses the Brazilian E-Commerce Public Dataset by Olist.

The dataset contains information about customers, orders, order items, payments, reviews, products, sellers, geolocation, and product category translations.

## Business Questions

The project addresses the following 10 business questions:

1. What is the overall order status distribution?
2. What is the total revenue generated from delivered orders?
3. Which product categories generate the highest revenue?
4. Which payment methods are used most frequently?
5. What is the monthly revenue trend?
6. How many orders were delivered on time versus late?
7. What is the distribution of customer review scores?
8. How many customers placed repeat orders?
9. Which product categories generate the highest average order value?
10. How do customer ratings vary by product category?

## Project Structure

```text
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

- **Order delivery:** 96,478 orders were delivered, representing approximately 97.02% of all orders.
- **Delivery performance:** Among delivered orders with both actual and estimated delivery dates, 88,644 arrived on time and 7,826 were late.
- **Payment methods:** Credit cards had the highest total payment value, approximately 12.54 million.
- **Customer reviews:** Approximately 57.78% of review records had a score of 5.
- **Repeat customers:** 2,997 repeat customers were identified among 96,096 unique customers with orders, approximately 3.12%.
- **Monthly revenue:** November 2017 had the highest monthly revenue among the months analyzed, at approximately 987,765.37.
- **Top product categories by revenue:** Health & Beauty, Watches & Gifts, and Bed, Bath & Table were among the leading categories.
- **Category ratings:** Books General Interest had an average rating of 4.46 across 508 review-category records. Construction Tools Tools averaged 4.43 across 94 records, while Books Technical averaged 4.41 across 259 records.

## Metric Definitions

- **Revenue:** Calculated using `order_items.price` for delivered orders. Freight charges are excluded.
- **On-time delivery:** Calculated for delivered orders with both actual and estimated delivery dates.
- **Repeat customers:** Customers who placed more than one order.
- **Category ratings:** Each distinct review-category combination is counted once. A review can be associated with multiple categories if an order contains products from different categories.
- **Category threshold:** Only categories with at least 50 review-category records are included in the category rating analysis.
- **Rounding:** Percentages and displayed figures are rounded for readability.

## How to Run

1. Clone or download this repository.
2. Open MySQL Workbench and connect to your MySQL server.
3. Create or select the `olist` database.
4. Import the Olist dataset and ensure the required tables are available.
5. Open `olist_ecommerce_analysis.sql` in MySQL Workbench.
6. Execute the queries individually or run the script.
7. Review the result sets to explore the business insights.

**Requirement:** MySQL 8.0 or
