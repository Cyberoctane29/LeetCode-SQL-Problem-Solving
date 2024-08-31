-- Problem 1193: Monthly Transactions I
-- Difficulty: Medium

-- SQL Schema
-- Table: Transactions
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | country       | varchar |
-- | state         | enum    |
-- | amount        | int     |
-- | trans_date    | date    |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"]

-- Problem Statement
-- Write an SQL query to find for each month and country, the number of transactions and their total amount,
-- the number of approved transactions and their total amount.

-- SQL Solution
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,  -- Format the date to YYYY-MM for grouping by month
    country,                                    -- Group by country
    COUNT(id) AS trans_count,                  -- Count the total number of transactions
    COUNT(IF(state = 'approved', 1, NULL)) AS approved_count,  -- Count the number of approved transactions
    SUM(amount) AS trans_total_amount,         -- Sum the total amount of all transactions
    SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount  -- Sum the total amount of approved transactions
FROM 
    Transactions
GROUP BY 
    DATE_FORMAT(trans_date, '%Y-%m'),  -- Group by formatted month
    country;                          -- and country

-- Intuition:
-- To analyze monthly transactions by country, you need to aggregate data for each month and country,
-- and differentiate between total transactions and approved transactions.

-- Explanation:
-- 1. **Format the Date**: Use `DATE_FORMAT(trans_date, '%Y-%m')` to group the transactions by month.
-- 2. **Count Transactions**:
--    - `COUNT(id)` gives the total number of transactions for each month and country.
--    - `COUNT(IF(state = 'approved', 1, NULL))` counts only approved transactions.
-- 3. **Sum Transaction Amounts**:
--    - `SUM(amount)` calculates the total transaction amount for each month and country.
--    - `SUM(IF(state = 'approved', amount, 0))` sums up the amounts for only approved transactions.
-- 4. **Group By**: Group results by month and country to get aggregated values.

-- This approach ensures you capture both the total and approved transaction metrics for each month and country.
