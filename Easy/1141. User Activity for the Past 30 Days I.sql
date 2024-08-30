-- Problem 1141: User Activity for the Past 30 Days I
-- Difficulty: Easy

-- SQL Schema
-- Table: Activity
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | session_id    | int     |
-- | activity_date | date    |
-- | activity_type | enum    |
-- +---------------+---------+
-- This table may have duplicate rows.
-- The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
-- The table shows the user activities for a social media website.
-- Note that each session belongs to exactly one user.

-- Problem Statement
-- Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively.
-- A user was active on a day if they made at least one activity on that day.
-- Return the result table in any order.

-- Solution:
-- The query selects the activity_date and counts the number of distinct users for each day within the 30-day period ending 2019-07-27.

SELECT 
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE 
    activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;

-- Intuition:
-- The query filters records within the 30-day range and groups the results by activity_date.
-- For each date, it counts the distinct users who were active on that day.

-- Explanation:
-- The `COUNT(DISTINCT user_id)` function counts unique users per day.
-- The `GROUP BY activity_date` clause groups the results by each day, providing the number of unique active users for each day in the specified range.

