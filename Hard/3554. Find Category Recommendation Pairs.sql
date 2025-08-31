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
-- (user_id, product_id) is the unique key.
-- Each row is a purchase of a product by a user.

-- Table: ProductInfo
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_id  | int     |
-- | category    | varchar |
-- | price       | decimal |
-- +-------------+---------+
-- product_id is the unique key.
-- Each row assigns a category and price to a product.

-- Problem Statement:
-- Find all category pairs (category1 < category2).
-- For each pair, count unique users who purchased products from both categories.
-- A pair is reportable if at least 3 distinct users purchased from both.
-- Return (category1, category2, customer_count), sorted by:
--   1. customer_count DESC
--   2. category1 ASC
--   3. category2 ASC


-- Solution:

WITH user_products AS (
    SELECT pp.user_id, pi.category
    FROM ProductPurchases pp
    JOIN ProductInfo pi
      ON pp.product_id = pi.product_id
    GROUP BY pp.user_id, pi.category
),
category_pairs AS (
    SELECT up1.user_id,
           up1.category AS category1,
           up2.category AS category2
    FROM user_products up1
    JOIN user_products up2
      ON up1.user_id = up2.user_id
     AND up1.category < up2.category
)
SELECT category1,
       category2,
       COUNT(DISTINCT user_id) AS customer_count
FROM category_pairs
GROUP BY category1, category2
HAVING COUNT(DISTINCT user_id) >= 3
ORDER BY customer_count DESC, category1, category2;


-- Intuition:
-- Each user’s purchases can be reduced to a set of categories.
-- If a user has both category A and category B, they contribute to pair (A,B).
-- Repeating this across users gives us all category co-purchases.
-- Filtering ensures only pairs with ≥ 3 customers are reportable.

-- Explanation:
-- 1. user_products maps each user to the distinct categories they’ve bought.
-- 2. category_pairs generates category pairs (category1 < category2) for each user.
-- 3. Final SELECT counts distinct users per pair.
-- 4. HAVING ensures only pairs with at least 3 users remain.
-- 5. ORDER sorts results per requirement.
