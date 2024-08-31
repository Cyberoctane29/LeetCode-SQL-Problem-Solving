-- Problem 1890: The Latest Login in 2020
-- Difficulty: Easy

-- SQL Schema
-- Table: Logins
-- +----------------+----------+
-- | Column Name    | Type     |
-- +----------------+----------+
-- | user_id        | int      |
-- | time_stamp     | datetime |
-- +----------------+----------+
-- (user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
-- Each row contains information about the login time for the user with ID user_id.

-- Problem Statement
-- Write a solution to report the latest login for all users in the year 2020. 
-- Do not include the users who did not login in 2020.

-- Solution:
-- Use a Common Table Expression (CTE) with ROW_NUMBER() to find the latest login for each user in 2020.
-- The ROW_NUMBER() function assigns a unique sequential integer to rows within a partition of a result set, ordered by a specified column.

WITH cte AS (
    SELECT 
        user_id,
        time_stamp,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY time_stamp DESC) AS rn
    FROM 
        Logins
    WHERE 
        YEAR(time_stamp) = 2020
)
SELECT 
    user_id,
    time_stamp AS last_stamp
FROM 
    cte
WHERE 
    rn = 1;

-- Intuition:
-- To find the latest login for each user in 2020, we need to sort the logins for each user by time_stamp in descending order.
-- The ROW_NUMBER() function helps to identify the most recent login (the latest login) by assigning the number 1 to the most recent login for each user.

-- Explanation:
-- The CTE `cte` filters the logins to include only those from 2020 and assigns a row number (`rn`) to each login for a user, ordered by `time_stamp` in descending order.
-- The main query then selects the rows where `rn = 1`, which corresponds to the latest login for each user.
-- This ensures we only include users who have logged in during 2020 and retrieve their latest login time.
