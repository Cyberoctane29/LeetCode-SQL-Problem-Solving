-- Problem 521: Find Product Recommendation Pairs
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
-- product_id is the primary key.
-- Each row assigns a category and price to a product.

-- Problem Statement:
-- Implement the "Customers who bought this also bought..." feature by:
-- 1. Identifying distinct product pairs (product1_id < product2_id) purchased by the same customers.
-- 2. Counting how many distinct customers purchased both products.
-- 3. Considering only pairs purchased by at least 3 different customers.
-- 4. Returning results ordered by:
--      - customer_count DESC
--      - product1_id ASC (tie-breaker)
--      - product2_id ASC (tie-breaker)

-- Solution:

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
    WHERE 
        a.product_id < b.product_id
        AND a.user_id = b.user_id
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
        productinfo AS p1 ON c.product1_id = p1.product_id
    LEFT JOIN 
        productinfo AS p2 ON c.product2_id = p2.product_id
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
-- Pair products bought by the same user while ensuring each pair is unique.
-- Count how many distinct customers purchased both products.
-- Filter for pairs with at least 3 customers and include product category information.
-- Sort to prioritize the most frequently co-purchased pairs.

-- Explanation:
-- The CROSS JOIN with filtering matches products from the same user while avoiding duplicates by enforcing product1_id < product2_id.
-- Aggregating on product pairs provides the count of distinct customers for each.
-- The HAVING clause filters out infrequent pairs.
-- Joining with product information tables enriches the output with category details.
-- The ORDER BY clause ensures results are sorted by popularity, then by product IDs for tie-breaking.
