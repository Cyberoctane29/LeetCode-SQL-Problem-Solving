-- Problem 1907: Count Salary Categories
-- Difficulty: Medium

-- SQL Schema
-- Table: Accounts
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | account_id  | int  |
-- | income      | int  |
-- +-------------+------+
-- account_id is the primary key for this table.
-- Each row contains information about the monthly income for one bank account.

-- Problem Statement
-- Write a solution to calculate the number of bank accounts for each salary category.
-- The salary categories are:
-- "Low Salary": All the salaries strictly less than $20000.
-- "Average Salary": All the salaries in the inclusive range [$20000, $50000].
-- "High Salary": All the salaries strictly greater than $50000.
-- The result table must contain all three categories.
-- If there are no accounts in a category, return 0.

-- SQL Solution
WITH cte AS (
    SELECT income,
        CASE 
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            WHEN income > 50000 THEN 'High Salary'
        END AS category
    FROM accounts
),
categories AS (
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
)
SELECT 
    categories.category, 
    COALESCE(COUNT(cte.category), 0) AS accounts_count
FROM 
    categories
LEFT JOIN 
    cte ON categories.category = cte.category
GROUP BY 
    categories.category;

-- Intuition:
-- The goal is to categorize bank accounts into three salary ranges and count the number of accounts in each category.
-- We also need to ensure that even if there are no accounts in a category, it should return a count of 0.

-- Explanation:
-- 1. We first create a Common Table Expression (CTE) `cte` to assign each income to one of the three categories ('Low Salary', 'Average Salary', or 'High Salary') using a `CASE` statement.
-- 2. Another CTE, `categories`, is used to define the three salary categories explicitly. This ensures that all categories are included, even if there are no accounts in one or more categories.
-- 3. We then perform a `LEFT JOIN` between the `categories` table and the `cte` result. This allows us to keep all categories, even those with no accounts, and use `COALESCE` to return a 0 count when no matching accounts are found.
-- 4. Finally, we group the results by the category and count the number of accounts in each category.
