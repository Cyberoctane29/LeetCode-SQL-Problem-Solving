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
-- id is the unique identifier for this table.
-- name is the name of the user.

-- Table: Rides
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | user_id       | int     |
-- | distance      | int     |
-- +---------------+---------+
-- id is the unique identifier for this table.
-- user_id is the id of the user who traveled the distance "distance".

-- Problem Statement:
-- Write a solution to report the total distance traveled by each user.
-- Return the result table ordered by travelled_distance in descending order.
-- If two or more users traveled the same distance, order them by their name in ascending order.

-- Solution:
-- The query uses a LEFT JOIN to ensure that all users are included, even those who may not have any rides recorded.
-- The COALESCE function is used to handle cases where the SUM of distances is NULL, setting it to 0.

WITH cte AS (
    SELECT
        u.name,
        u.id,
        COALESCE(SUM(r.distance), 0) AS travelled_distance
    FROM 
        Users AS u
    LEFT JOIN 
        Rides AS r 
    ON 
        u.id = r.user_id
    GROUP BY 
        u.id, u.name
)
SELECT 
    name,
    travelled_distance 
FROM 
    cte
ORDER BY 
    travelled_distance DESC, 
    name ASC;

-- Explanation:
-- 1. **WITH CTE (Common Table Expression)**: The CTE calculates the total distance traveled by each user.
--    - The `LEFT JOIN` ensures that all users are included, even those without any rides.
--    - The `COALESCE(SUM(r.distance), 0)` function is used to ensure that users with no recorded rides are shown with a `travelled_distance` of 0.
-- 2. **Final SELECT**: The final query retrieves the `name` and `travelled_distance` from the CTE.
-- 3. **ORDER BY Clause**: The result is ordered by `travelled_distance` in descending order, and by `name` in ascending order if there are ties.

-- This query provides an accurate report of the total distance traveled by each user, ensuring proper handling of cases with no ride records.
