-- Problem 178: Rank Scores
-- Difficulty: Medium

-- SQL Schema
-- Table: Scores
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | score       | decimal |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains the score of a game. Score is a floating point value with two decimal places.

-- Problem Statement
-- Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:
-- 1. The scores should be ranked from the highest to the lowest.
-- 2. If there is a tie between two scores, both should have the same ranking.
-- 3. After a tie, the next ranking number should be the next consecutive integer value.
--    In other words, there should be no holes between ranks.
-- 4. Return the result table ordered by score in descending order.

-- SQL Solution
SELECT 
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS `rank`
FROM 
    scores
ORDER BY 
    score DESC;

-- Intuition:
-- The problem requires ranking scores based on their values, from highest to lowest.
-- If two or more scores are tied, they should share the same rank.
-- The DENSE_RANK() function is perfect for this because it assigns consecutive ranks without skipping numbers, even when there are ties.
-- The ORDER BY clause ensures that the scores are sorted in descending order, which meets the problem's requirement.

-- Explanation:
-- 1. The DENSE_RANK() window function is used to assign ranks to the scores.
--    It gives the same rank to scores that have the same value.
-- 2. The ORDER BY score DESC inside the DENSE_RANK() function ensures that the highest score gets the rank of 1.
-- 3. The overall result is ordered by score in descending order to display the scores in the correct order.
-- 4. The result will show each score with its rank, and if there is a tie, the same rank is applied to all tied scores.
--    The next distinct score will get the next consecutive rank.
