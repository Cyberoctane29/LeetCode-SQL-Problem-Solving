-- Problem 180: Consecutive Numbers
-- Difficulty: Medium

-- SQL Schema
-- Table: Logs
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- id is the primary key for this table.
-- id is an autoincrement column.

-- Problem Statement
-- Find all numbers that appear at least three times consecutively.
-- Return the result table in any order.

-- SQL Solution
WITH CTE AS (
    -- Use window functions to get the next two rows for each row
    SELECT
        num,
        LEAD(num, 1) OVER (ORDER BY id) AS next_1,  -- Get the next row's number
        LEAD(num, 2) OVER (ORDER BY id) AS next_2   -- Get the second next row's number
    FROM
        Logs
)
-- Select numbers where the current number is the same as the next two numbers
SELECT DISTINCT
    num AS ConsecutiveNums
FROM
    CTE
WHERE
    num = next_1 AND num = next_2;

-- Intuition:
-- To identify numbers that appear at least three times consecutively, you can use window functions
-- to look ahead in the data and compare each row with the next two rows.

-- Explanation:
-- 1. **CTE Definition**:
--    - `LEAD(num, 1) OVER (ORDER BY id)` retrieves the number in the next row.
--    - `LEAD(num, 2) OVER (ORDER BY id)` retrieves the number in the row after the next.
--    - This setup allows you to compare the current row with the next two rows to identify consecutive sequences.
-- 2. **Filtering Consecutive Numbers**:
--    - In the final query, check if the current number (`num`) is the same as both `next_1` and `next_2`.
--    - If all three are the same, then the number appears consecutively at least three times.
-- 3. **Distinct**:
--    - Use `DISTINCT` to ensure each number is listed only once in the result.

-- This approach ensures that you capture all numbers with at least three consecutive occurrences efficiently.
