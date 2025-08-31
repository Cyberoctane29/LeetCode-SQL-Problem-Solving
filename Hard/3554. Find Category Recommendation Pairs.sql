-- Problem 3554: Find Category Recommendation Pairs
-- Difficulty: Hard

-- Table: ProductPurchases
-- +-------------+------+
-- | Column Name | Type | 
-- +-------------+------+
-- | user_id     | int  |
-- | product_id  | int  |
-- | quantity    | int  |
-- +-------------+------+
-- (user_id, product_id) is the unique identifier for this table.
-- Each row represents a purchase of a product by a user in a specific quantity.

-- Table: ProductInfo
-- +-------------+---------+
-- | Column Name | Type    | 
-- +-------------+---------+
-- | product_id  | int     |
-- | category    | varchar |
-- | price       | decimal |
-- +-------------+---------+
-- product_id is the unique identifier for this table.
-- Each row assigns a category and price to a product.

-- Problem Statement:
-- Amazon wants to understand shopping patterns across product categories.
-- Find all category pairs (where category1 < category2).
-- For each category pair, determine the number of unique customers who purchased products from both categories.
-- A category pair is considered reportable if at least 3 different customers have purchased products from both categories.
-- Return the result table of reportable category pairs ordered by:
--   - customer_count descending
--   - category1 ascending (lexicographically) in case of tie
--   - category2 ascending in case of tie.

-- Solution (Using cross join on same user purchases):

WITH CTE AS (
    SELECT 
        p1.user_id AS user_id1,
        p1.product_id AS product_id1,
        p2.user_id AS user_id2,
        p2.product_id AS product_id2
    FROM productpurchases AS p1 
    CROSS JOIN productpurchases AS p2 
    WHERE p1.user_id = p2.user_id 
      AND p1.product_id != p2.product_id
),
CTE1 AS (
    SELECT 
        c.user_id1,
        c.product_id1,
        pi1.category AS category1,
        c.user_id2,
        c.product_id2,
        pi2.category AS category2
    FROM CTE AS c 
    LEFT JOIN productinfo AS pi1 
        ON c.product_id1 = pi1.product_id 
    LEFT JOIN productinfo AS pi2 
        ON c.product_id2 = pi2.product_id 
    ORDER BY c.user_id1
)
SELECT 
    category1, 
    category2, 
    COUNT(DISTINCT user_id1) AS customer_count 
FROM CTE1 
WHERE category1 < category2 
GROUP BY category1, category2 
HAVING customer_count >= 3 
ORDER BY customer_count DESC, category1, category2;

-- Intuition:
-- We need to find pairs of categories that customers frequently buy together.
-- By cross joining purchases of the same user, we can generate category pairs for each customer.
-- Counting distinct users who purchased both categories gives us the required customer_count.
-- Only category pairs with at least 3 customers are reportable.

-- Explanation:
-- - CTE creates all pairs of products purchased by the same user (excluding identical products).
-- - CTE1 joins product information to map product_ids to categories for both items in the pair.
-- - The final SELECT filters for category1 < category2 to avoid duplicate/reversed pairs.
-- - We count distinct users per category pair, keep only pairs with at least 3 users,
--   and order by customer_count, then category1, then category2 as required.
