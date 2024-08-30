-- Problem 610: Triangle Judgement
-- Difficulty: Easy

-- SQL Schema
-- Table: Triangle
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | x           | int  |
-- | y           | int  |
-- | z           | int  |
-- +-------------+------+
-- In SQL, (x, y, z) is the primary key column for this table.
-- Each row of this table contains the lengths of three line segments.

-- Problem Statement
-- Report for every three line segments whether they can form a triangle.

-- SQL Solution
-- This query checks whether three line segments can form a triangle using the triangle inequality theorem.
SELECT x, y, z,
       CASE
           WHEN x + y > z AND y + z > x AND x + z > y THEN 'Yes'
           ELSE 'No'
       END AS triangle
FROM Triangle;

-- Intuition:
-- To determine if three segments can form a triangle, they must satisfy the triangle inequality theorem:
-- For three segments x, y, and z, they can form a triangle if and only if:
-- x + y > z
-- y + z > x
-- x + z > y
-- This theorem ensures that the sum of the lengths of any two sides must be greater than the length of the remaining side.

-- Explanation:
-- The `CASE` statement checks each of the three conditions required to form a triangle.
-- If all three conditions are met, it returns 'Yes', otherwise 'No'.
-- The result is displayed for each set of line segments (x, y, z) from the `Triangle` table.
