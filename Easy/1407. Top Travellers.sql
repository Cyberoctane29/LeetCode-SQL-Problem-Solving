-- Problem 1407: Top Travellers
-- Difficulty: Easy

-- SQL Schema
-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- name is the name of the user.

-- Table: Rides
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | user_id       | int     |
-- | distance      | int     |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- user_id is the id of the user who traveled the distance "distance".

-- Problem Statement
-- Write a solution to report the distance traveled by each user.
-- Return the result table ordered by travelled_distance in descending order. 
-- If two or more users traveled the same distance, order them by their name in ascending order.

-- SQL Solution
WITH cte AS (
    SELECT
        u.name, 
        r.user_id AS id,
        COALESCE(SUM(r.distance), 0) AS travelled_distance
    FROM 
        users AS u
    LEFT JOIN 
        rides AS r 
    ON 
        u.id = r.user_id
    GROUP BY 
        u.id
)
SELECT 
    name,
    travelled_distance 
FROM 
    cte
ORDER BY 
    travelled_distance DESC, 
    name ASC;

-- Intuition:
-- To calculate the total distance traveled by each user, we need to join the `Users` table with the `Rides` table.
-- We use a LEFT JOIN to ensure that all users are included, even if they have not taken any rides.

-- Explanation:
-- The CTE (Common Table Expression) computes the sum of distances for each user.
-- COALESCE is used to handle cases where a user has no rides, defaulting the distance to 0.
-- Finally, the result is ordered first by `travelled_distance` in descending order and then by `name` in ascending order.
