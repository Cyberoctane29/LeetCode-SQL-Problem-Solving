-- Problem 1045: Customers Who Bought All Products
-- Difficulty: Medium

-- SQL Schema
-- Table: Customer
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | customer_id | int     |
-- | product_key | int     |
-- +-------------+---------+
-- This table may contain duplicate rows. 
-- customer_id is not NULL.
-- product_key is a foreign key (reference column) to the Product table.

-- Table: Product
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_key | int     |
-- +-------------+---------+
-- product_key is the primary key (column with unique values) for this table.

-- Problem Statement
-- Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.
-- Return the result table in any order.

-- SQL Solution
WITH UniquePurchases AS (
    SELECT DISTINCT customer_id, product_key
    FROM Customer
),
CustomerCounts AS (
    SELECT customer_id, COUNT(*) AS cnt
    FROM UniquePurchases
    GROUP BY customer_id
    HAVING cnt = (SELECT COUNT(*) FROM Product)
)
SELECT customer_id
FROM CustomerCounts;

-- Intuition:
-- To find customers who bought all products, we need to compare the count of unique products bought by each customer to the total number of products available.
-- A customer who bought all products should have a count of distinct products equal to the total number of products.

-- Explanation:
-- 1. The `UniquePurchases` CTE retrieves distinct combinations of `customer_id` and `product_key` to ensure we count each unique purchase only once.
-- 2. The `CustomerCounts` CTE counts the number of distinct products each customer has bought.
--    - It groups by `customer_id` and filters to include only those customers who have a count of distinct products equal to the total number of products (obtained from the `Product` table).
-- 3. The final `SELECT` statement retrieves the `customer_id` from the filtered results, indicating customers who bought every product.
