-- Problem 3521: Find Product Recommendation Pairs
-- Difficulty: Medium

-- Table: ProductPurchases
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | user_id     | int  |
-- | product_id  | int  |
-- | quantity    | int  |
-- +-------------+------+
-- (user_id, product_id) is the unique key for this table.
-- Each row represents a purchase of a product by a user in a specific quantity.

-- Table: ProductInfo
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_id  | int     |
-- | category    | varchar |
-- | price       | decimal |
-- +-------------+---------+
-- product_id is the primary key for this table.
-- Each row assigns a category and price to a product.

-- Problem Statement:
-- Amazon wants to implement the "Customers who bought this also bought..." feature.
-- Task:
-- 1. Identify distinct product pairs purchased together by the same customers (where product1_id < product2_id).
-- 2. For each pair, find how many customers purchased both products.
-- 3. Only include product pairs purchased together by at least 3 different customers.
-- 4. Return the result ordered by:
--    - customer_count (descending)
--    - product1_id (ascending, tie-breaker)
--    - product2_id (ascending, tie-breaker).

-- Solution (Using CROSS JOIN and Aggregation):

WITH CTE AS (
    SELECT 
        a.user_id AS user1_id,
        a.product_id AS product1_id,
        b.user_id AS user2_id,
        b.product_id AS product2_id
    FROM 
        productpurchases AS a
    CROSS JOIN 
        productpurchases AS b
    HAVING 
        product1_id < product2_id 
        AND user1_id = user2_id
),
CTE1 AS (
    SELECT 
        product1_id,
        product2_id,
        COUNT(*) AS customer_count
    FROM 
        CTE
    GROUP BY 
        product1_id, product2_id
    HAVING 
        customer_count >= 3
),
CTE2 AS (
    SELECT 
        c.product1_id,
        c.product2_id,
        p1.category AS product1_category,
        p2.category AS product2_category,
        customer_count
    FROM 
        CTE1 AS c
    LEFT JOIN 
        productinfo AS p1 
        ON c.product1_id = p1.product_id
    LEFT JOIN 
        productinfo AS p2 
        ON c.product2_id = p2.product_id
)
SELECT 
    *
FROM 
    CTE2
ORDER BY 
    customer_count DESC, 
    product1_id, 
    product2_id;

-- Intuition:
-- Use a self-join (CROSS JOIN) to generate all possible product combinations per customer.
-- Keep only pairs where the first product ID is less than the second to avoid duplicates.
-- Group by product pair to count the number of customers who bought both.
-- Filter to include only pairs purchased by at least 3 customers.
-- Enrich results with product category data from ProductInfo.

-- Explanation:
-- - CTE: Generates all product combinations for the same customer.
-- - CTE1: Aggregates customer counts per product pair, filters for >= 3 customers.
-- - CTE2: Joins with ProductInfo to get category details for both products.
-- - Final SELECT: Orders by customer_count DESC, then product1_id ASC, then product2_id ASC.
