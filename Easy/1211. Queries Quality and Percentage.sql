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
-- The table contains information collected from some queries on a database.
-- The position column has values ranging from 1 to 500.
-- The rating column has values ranging from 1 to 5, with queries having a rating less than 3 considered as poor queries.

-- Problem Statement
-- We define query quality as:
-- The average of the ratio between query rating and its position.
-- 
-- We also define poor query percentage as:
-- The percentage of all queries with a rating less than 3.
--
-- Write a solution to find each query_name, the quality, and poor_query_percentage.
-- Both quality and poor_query_percentage should be rounded to 2 decimal places.
-- Return the result table in any order.

-- SQL Solution
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

-- Intuition:
-- The task is to calculate the quality and poor_query_percentage for each query_name.
-- Quality is defined as the average of the ratio between the query rating and its position.
-- Poor_query_percentage is the percentage of queries with a rating less than 3.

-- Explanation:
-- The AVG function calculates the average ratio of rating to position for each query_name.
-- The SUM(IF(...)) function counts the number of poor queries (rating < 3), and this count is then divided by the total number of queries to calculate the poor query percentage.
-- Both results are rounded to 2 decimal places for clarity.
-- The GROUP BY clause ensures that the calculations are done for each query_name individually.
