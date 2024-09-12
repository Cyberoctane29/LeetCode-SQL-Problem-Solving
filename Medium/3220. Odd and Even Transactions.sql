-- Problem 3220: Odd and Even Transactions
-- Difficulty: Medium

-- SQL Schema
-- Table: transactions
-- +------------------+------+
-- | Column Name      | Type | 
-- +------------------+------+
-- | transaction_id   | int  |
-- | amount           | int  |
-- | transaction_date | date |
-- +------------------+------+
-- transaction_id uniquely identifies each row.
-- Each row contains the transaction id, amount, and transaction date.

-- Problem Statement
-- Write a solution to find the sum of amounts for odd and even transactions for each day.
-- If there are no odd or even transactions for a specific date, display as 0.
-- Return the result table ordered by transaction_date in ascending order.

-- SQL Solution
SELECT 
    transaction_date,
    SUM(CASE WHEN amount % 2 != 0 THEN amount ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN amount % 2 = 0 THEN amount ELSE 0 END) AS even_sum
FROM 
    transactions
GROUP BY 
    transaction_date
ORDER BY 
    transaction_date;

-- Intuition:
-- To calculate the sum of odd and even transaction amounts for each day, follow these steps:
-- 1. **Identify Odd and Even Amounts:** We need to determine if the amount of each transaction is odd or even. This can be achieved by checking if the amount modulo 2 is 0 (even) or not (odd).
-- 2. **Calculate Sums:** Use conditional aggregation to sum up amounts for odd and even transactions separately.
-- 3. **Group By Date:** Aggregate these sums for each transaction date.
-- 4. **Handle Missing Data:** Since we are using conditional aggregation, dates with no odd or even transactions will naturally show as 0 in the result.
-- 5. **Order By Date:** Finally, order the results by transaction_date in ascending order to meet the requirements.

-- Explanation:
-- - `SUM(CASE WHEN amount % 2 != 0 THEN amount ELSE 0 END)` calculates the total of odd amounts for each date.
-- - `SUM(CASE WHEN amount % 2 = 0 THEN amount ELSE 0 END)` calculates the total of even amounts for each date.
-- - `GROUP BY transaction_date` ensures we get separate totals for each day.
-- - `ORDER BY transaction_date` sorts the results in ascending order by date.