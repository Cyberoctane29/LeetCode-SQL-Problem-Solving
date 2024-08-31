-- Problem 1633: Percentage of Users Attended a Contest
-- Difficulty: Easy

-- SQL Schema
-- Table: Users
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | user_name   | varchar |
-- +-------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- Each row of this table contains the name and the id of a user.

-- Table: Register
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | contest_id  | int     |
-- | user_id     | int     |
-- +-------------+---------+
-- (contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table contains the id of a user and the contest they registered into.

-- Problem Statement
-- Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
-- Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

-- SQL Solution
SELECT 
    r.contest_id AS contest_id,
    ROUND((COUNT(r.user_id) * 100.0 / (SELECT COUNT(*) FROM Users)), 2) AS percentage
FROM
    Register r
GROUP BY 
    r.contest_id
ORDER BY 
    percentage DESC, 
    r.contest_id ASC;

-- Intuition:
-- To find the percentage of users registered in each contest, we calculate the ratio of the number of users registered in the contest
-- to the total number of users, then multiply by 100 to get the percentage.

-- Explanation:
-- The subquery `(SELECT COUNT(*) FROM Users)` provides the total number of users.
-- We use this to calculate the percentage of users registered in each contest.
-- The `ROUND` function is used to round the result to two decimal places.
-- The results are ordered by percentage in descending order, and in case of a tie, by contest_id in ascending order.
