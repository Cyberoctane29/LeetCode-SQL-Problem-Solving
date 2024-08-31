-- Problem 1729: Find Followers Count
-- Difficulty: Easy

-- SQL Schema
-- Table: Followers
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | user_id     | int  |
-- | follower_id | int  |
-- +-------------+------+
-- (user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
-- This table contains the IDs of a user and a follower in a social media app where the follower follows the user.

-- Problem Statement
-- Write a solution that will, for each user, return the number of followers.
-- Return the result table ordered by user_id in ascending order.

-- SQL Solution
SELECT 
    user_id,
    COUNT(follower_id) AS followers_count
FROM 
    Followers
GROUP BY 
    user_id
ORDER BY 
    user_id;

-- Intuition:
-- To find the number of followers for each user, we use the `COUNT(follower_id)` function to count the number of follower IDs associated with each `user_id`.
-- Grouping by `user_id` allows us to aggregate the follower counts for each individual user.

-- Explanation:
-- The query groups the data by `user_id` and counts the number of distinct `follower_id` values for each user.
-- The result is then ordered by `user_id` in ascending order to provide a list of users and their respective follower counts.
