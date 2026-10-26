-- Brazilian E-Commerce Data Analysis (Olist)
-- Database: olist
-- Tool: MySQL 8.0+ / MySQL Workbench
-- Run each numbered query separately to review its result.
-- Revenue uses order_items.price (product value only; freight is excluded).

USE olist;

-- 1. How do order volumes change month by month?
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;

-- 2. Which product categories generate the highest revenue?
SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS product_category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY COALESCE(
    ct.product_category_name_english,
    p.product_category_name,
    'unknown'
)
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Which payment methods contribute the most payment value?
SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- 4. How many orders are delivered on time versus late?
-- Only delivered orders with both delivery and estimated dates are included.
SELECT
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / (
            SELECT COUNT(*)
            FROM orders
            WHERE order_status = 'delivered'
              AND order_delivered_customer_date IS NOT NULL
              AND order_estimated_delivery_date IS NOT NULL
        ),
        2
    ) AS percentage
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- 5. What customer review scores are most common?
SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM order_reviews),
        2
    ) AS percentage
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- 6. Which sellers generate the highest product revenue?
SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- 7. How does product revenue change over time?
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;

-- 8. How many customers place repeat orders?
-- customer_unique_id identifies the same customer across different orders.
SELECT
    COUNT(*) AS total_unique_customers,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
) AS customer_orders;

-- 9. Which months rank highest by revenue?
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
)
SELECT
    order_month,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM monthly_revenue
ORDER BY revenue_rank, order_month;


-- 10. How do customer ratings vary by product category?
-- Each review is counted once per product category.

WITH review_category AS (
    SELECT DISTINCT
        r.review_id,
        r.review_score,
        COALESCE(
            ct.product_category_name_english,
            p.product_category_name,
            'unknown'
        ) AS product_category
    FROM order_reviews r
    JOIN order_items oi
        ON r.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
)
SELECT
    product_category,
    COUNT(*) AS total_reviews,
    ROUND(AVG(review_score), 2) AS average_rating
FROM review_category
GROUP BY product_category
HAVING COUNT(*) >= 50
ORDER BY average_rating DESC, total_reviews DESC;

