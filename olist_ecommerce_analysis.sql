-- =====================================================
-- PROJECT: Brazilian E-Commerce (Olist) Data Analysis
-- DATABASE: olist
-- TOOL: MySQL Workbench
-- =====================================================

USE olist;


-- Q1. Monthly Order Trend
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;


-- Q2. Top 10 Product Categories by Revenue
SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'Unknown'
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
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 10;


-- Q3. Payment Method Analysis
SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- Q4. Delivery Performance
SELECT
    CASE
        WHEN order_delivered_customer_date
             <= order_estimated_delivery_date
        THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status;


-- Q5. Customer Review Ratings
SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(AVG(review_score), 2) AS average_score
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;


-- Q6. Top 10 Sellers by Product Revenue
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


-- Q7. Monthly Revenue Trend
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;


-- Q8. Repeat Customer Analysis
SELECT
    customer_type,
    COUNT(*) AS total_customers
FROM (
    SELECT
        c.customer_unique_id,
        CASE
            WHEN COUNT(DISTINCT o.order_id) > 1
            THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS customer_type
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_summary
GROUP BY customer_type;


-- Q9. Rank Months by Revenue
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        SUM(oi.price) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY order_month
)
SELECT
    order_month,
    ROUND(total_revenue, 2) AS total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM monthly_revenue
ORDER BY revenue_rank;


-- Q10. Product Category vs Customer Reviews
SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,
    COUNT(DISTINCT r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_rating
FROM order_reviews r
JOIN order_items oi
    ON r.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY product_category
HAVING COUNT(DISTINCT r.review_id) >= 50
ORDER BY average_rating DESC;
