-- Problem 1667: Fix Names in a Table
-- Difficulty: Easy

-- SQL Schema
-- Table: Users
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | user_id        | int     |
-- | name           | varchar |
-- +----------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.

-- Problem Statement
-- Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
-- Return the result table ordered by user_id.

-- SQL Solution
SELECT 
    user_id,
    CONCAT(
        UPPER(SUBSTRING(name, 1, 1)),
        LOWER(SUBSTRING(name, 2, LENGTH(name)))
    ) AS name
FROM 
    Users
ORDER BY 
    user_id;

-- Intuition:
-- To fix the names, we need to capitalize the first character and make the rest of the characters lowercase.
-- The `UPPER` function is used to capitalize the first character.
-- The `LOWER` function is used to convert the remaining characters to lowercase.
-- `SUBSTRING` is used to extract the first character and the rest of the string separately.

-- Explanation:
-- We use the `UPPER` function to convert the first character of the name to uppercase.
-- We use the `LOWER` function to convert the rest of the name to lowercase.
-- `CONCAT` is used to combine the uppercase first character with the lowercase remaining characters.
-- The results are ordered by `user_id` as required.
