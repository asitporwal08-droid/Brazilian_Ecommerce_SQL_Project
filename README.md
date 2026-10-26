# Brazilian E-Commerce Data Analysis (Olist)

## Project Overview

This project analyzes the Brazilian E-Commerce Public Dataset by Olist using SQL and MySQL. The goal is to explore order trends, product revenue, payment methods, seller performance, delivery performance, and customer reviews to answer practical business questions.

## Tools Used

- MySQL
- MySQL Workbench
- SQL

## Dataset

**Source:** Brazilian E-Commerce Public Dataset by Olist, available on Kaggle.

The dataset contains information about orders, customers, products, sellers, payments, reviews, and product categories.

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

## Analysis Approach

- Aggregate monthly orders and revenue.
- Compare product categories and seller revenue.
- Analyze payment methods and payment values.
- Measure on-time and late delivery performance.
- Examine review scores and category-level ratings.
- Identify one-time and repeat customers.
- Rank monthly revenue using CTEs and window functions.

## Key Findings

Numerical findings will be added after the SQL queries have been executed and their results validated.

The analysis is designed to identify sales trends, high-performing categories and sellers, customer feedback patterns, and opportunities to improve delivery and customer retention.

## How to Run

1. Download and extract the Olist dataset from Kaggle.
2. Import the required CSV files into MySQL.
3. Use the database named `olist`.
4. Open `olist_ecommerce_analysis.sql` in MySQL Workbench.
5. Execute each query separately and review the results.
6. Add verified numerical findings to this README.

## Skills Demonstrated

- SQL querying and filtering
- Aggregate functions and `GROUP BY`
- Relational joins
- Conditional logic using `CASE`
- Date-based analysis
- Common Table Expressions (CTEs)
- Window functions and ranking
- Business-focused data analysis
