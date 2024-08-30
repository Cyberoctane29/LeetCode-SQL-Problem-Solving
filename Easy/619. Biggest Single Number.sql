-- Problem 619: Biggest Single Number
-- Difficulty: Easy

-- SQL Schema
-- Table: MyNumbers
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | num         | int  |
-- +-------------+------+
-- This table may contain duplicates (In other words, there is no primary key for this table in SQL).
-- Each row of this table contains an integer.

-- Problem Statement
-- Find the largest single number. A single number is a number that appeared only once in the MyNumbers table.
-- If there is no single number, report null.

-- SQL Solution
-- The following query finds the largest number that appears only once in the MyNumbers table.

SELECT MAX(num) AS num
FROM (
    SELECT num, COUNT(num) AS cnt
    FROM MyNumbers
    GROUP BY num
    HAVING cnt = 1
) AS single_numbers;

-- Intuition:
-- To find the largest single number, first identify numbers that appear exactly once (single numbers) using the `GROUP BY` clause and `HAVING` clause.
-- Then, from these single numbers, find the maximum value.

-- Explanation:
-- The inner query groups numbers by their value and counts their occurrences. The `HAVING` clause filters out numbers that appear more than once.
-- The outer query then finds the maximum value from the filtered list of single numbers.
-- If no single number exists, the `MAX()` function will return `NULL`.
