-- Problem 1211: Queries Quality and Percentage
-- Difficulty: Easy

-- SQL Schema
-- Table: Queries
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | query_name  | varchar |
-- | result      | varchar |
-- | position    | int     |
-- | rating      | int     |
-- +-------------+---------+
-- This table may have duplicate rows.
-- This table contains information collected from some queries on a database.
-- The position column has a value from 1 to 500.
-- The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.

-- Problem Statement
-- Write a solution to find each query_name, the quality and poor_query_percentage.
-- Both quality and poor_query_percentage should be rounded to 2 decimal places.

-- Solution:
-- The query calculates the average query quality and the percentage of poor queries (rating < 3) for each query_name.

SELECT 
    query_name, 
    ROUND(AVG(rating / position), 2) AS quality, 
    ROUND(SUM(IF(rating < 3, 1, 0)) * 100 / COUNT(*), 2) AS poor_query_percentage
FROM 
    Queries 
WHERE 
    query_name IS NOT NULL
GROUP BY 
    query_name;

-- Explanation:
-- 1. `ROUND(AVG(rating / position), 2)` calculates the average quality for each query_name, which is the average ratio of rating to position, rounded to 2 decimal places.
-- 2. `ROUND(SUM(IF(rating < 3, 1, 0)) * 100 / COUNT(*), 2)` calculates the percentage of poor queries for each query_name:
--    - `SUM(IF(rating < 3, 1, 0))` counts how many queries have a rating less than 3.
--    - `COUNT(*)` gives the total number of queries for that query_name.
--    - The ratio is multiplied by 100 to convert it to a percentage and rounded to 2 decimal places.
-- 3. The `WHERE query_name IS NOT NULL` clause ensures that only valid query names are considered.
-- 4. The `GROUP BY query_name` clause groups the results by each query_name.
