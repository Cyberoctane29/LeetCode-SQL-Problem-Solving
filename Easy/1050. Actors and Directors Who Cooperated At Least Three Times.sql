-- Problem 1050: Actors and Directors Who Cooperated At Least Three Times
-- Difficulty: Easy

-- SQL Schema
-- Table: ActorDirector
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | actor_id    | int     |
-- | director_id | int     |
-- | timestamp   | int     |
-- +-------------+---------+
-- timestamp is the primary key (column with unique values) for this table.

-- Problem Statement
-- Write a solution to find all the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.
-- Return the result table in any order.

-- Solution:
-- This query groups the rows by actor_id and director_id, then counts the number of occurrences of each pair.
-- It filters the groups where the count is greater than or equal to 3.

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;

-- Intuition:
-- By grouping the records by actor and director, we can count how many times each pair has cooperated.
-- The HAVING clause filters the groups to include only those where the count of cooperation is 3 or more.

-- Explanation:
-- The query first groups the rows of the ActorDirector table based on actor_id and director_id.
-- Then, it uses the COUNT function to determine how many times each (actor_id, director_id) pair appears.
-- The HAVING clause ensures that only pairs with at least three occurrences are included in the final result.
