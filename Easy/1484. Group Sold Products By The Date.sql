-- Problem 1484: Group Sold Products By The Date
-- Difficulty: Easy

-- SQL Schema
-- Table: Activities
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | sell_date   | date    |
-- | product     | varchar |
-- +-------------+---------+
-- There is no primary key (column with unique values) for this table. It may contain duplicates.
-- Each row of this table contains the product name and the date it was sold in a market.

-- Problem Statement:
-- Write a solution to find for each date the number of different products sold and their names.
-- The sold products names for each date should be sorted lexicographically.
-- Return the result table ordered by sell_date.

-- Solution:
-- This query groups the data by the sell_date, counts the distinct products sold on each date, 
-- and concatenates the product names into a single string, ordered lexicographically.

SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS products
FROM 
    Activities
GROUP BY 
    sell_date
ORDER BY 
    sell_date;

-- Explanation:
-- 1. **COUNT(DISTINCT product)**: Counts the number of unique products sold on each date.
-- 2. **GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',')**: 
--    - Concatenates the distinct product names for each date into a single string.
--    - The `ORDER BY product` ensures the product names are sorted lexicographically.
--    - The `SEPARATOR ','` specifies that the product names should be separated by commas.
-- 3. **GROUP BY sell_date**: Groups the results by the sell_date to aggregate the data by each date.
-- 4. **ORDER BY sell_date**: Orders the final result by the sell_date in ascending order.

-- This query efficiently summarizes the sales activities by date, listing the number of distinct products sold and their names in a clear and organized manner.
