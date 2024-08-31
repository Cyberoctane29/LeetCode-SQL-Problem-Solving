-- Problem 1581: Customer Who Visited but Did Not Make Any Transactions
-- Difficulty: Easy

-- SQL Schema
-- Table: Visits
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | visit_id    | int     |
-- | customer_id | int     |
-- +-------------+---------+
-- visit_id is the column with unique values for this table.
-- This table contains information about the customers who visited the mall.

-- Table: Transactions
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | transaction_id | int     |
-- | visit_id       | int     |
-- | amount         | int     |
-- +----------------+---------+
-- transaction_id is the column with unique values for this table.
-- This table contains information about the transactions made during the visit_id.

-- Problem Statement
-- Write a solution to find the IDs of the users who visited without making any transactions 
-- and the number of times they made these types of visits.
-- Return the result table sorted in any order.

-- SQL Solution
WITH CTE AS (
    SELECT 
        v.visit_id, 
        v.customer_id 
    FROM 
        Visits v
    WHERE 
        v.visit_id NOT IN (
            SELECT DISTINCT t.visit_id 
            FROM Transactions t
        )
)
SELECT 
    customer_id,
    COUNT(customer_id) AS count_no_trans 
FROM 
    CTE 
GROUP BY 
    customer_id;

-- Intuition:
-- To identify customers who visited but did not make any transactions, we need to find visits that are not present in the Transactions table.
-- We then count how many times each customer made such visits.

-- Explanation:
-- The CTE first filters out visits where the visit_id is not found in the Transactions table.
-- The main query then groups these filtered visits by customer_id and counts the number of visits for each customer.
