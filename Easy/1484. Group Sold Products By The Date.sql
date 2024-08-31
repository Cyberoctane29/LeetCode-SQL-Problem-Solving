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
-- There is no primary key for this table. It may contain duplicates.
-- Each row of this table contains the product name and the date it was sold in a market.

-- Problem Statement
-- Write a solution to find for each date the number of different products sold and their names.
-- The sold products names for each date should be sorted lexicographically.
-- Return the result table ordered by sell_date.

-- SQL Solution
SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS products
FROM 
    activities
GROUP BY 
    sell_date
ORDER BY 
    sell_date;

-- Intuition:
-- To get the number of different products sold and their names for each date, we use GROUP BY on the `sell_date`.
-- The COUNT function counts the distinct products for each date.
-- GROUP_CONCAT concatenates the product names for each date, ordered lexicographically.

-- Explanation:
-- GROUP_CONCAT is used to aggregate product names into a single string, sorted in ascending order.
-- COUNT(DISTINCT product) calculates the number of unique products sold on each date.
-- The final result is ordered by `sell_date` to present the data chronologically.
