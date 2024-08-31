-- Problem 1757: Recyclable and Low Fat Products
-- Difficulty: Easy

-- SQL Schema
-- Table: Products
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_id  | int     |
-- | low_fats    | enum    |
-- | recyclable  | enum    |
-- +-------------+---------+
-- product_id is the primary key (column with unique values) for this table.
-- low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
-- recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.

-- Problem Statement
-- Write a solution to find the ids of products that are both low fat and recyclable.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    product_id 
FROM 
    Products 
WHERE 
    low_fats = 'Y' 
    AND recyclable = 'Y';

-- Intuition:
-- To find products that are both low fat and recyclable, we need to filter the products based on two conditions:
-- 1. `low_fats` should be 'Y'.
-- 2. `recyclable` should be 'Y'.
-- By combining these conditions with an AND operator, we retrieve the product IDs that satisfy both criteria.

-- Explanation:
-- The query filters rows in the `Products` table where both `low_fats` and `recyclable` are set to 'Y'.
-- It then selects the `product_id` for these filtered rows.
