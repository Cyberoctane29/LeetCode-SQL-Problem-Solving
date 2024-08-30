-- Problem 196: Delete Duplicate Emails
-- Difficulty: Easy

-- SQL Schema
-- Table: Person
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | email       | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains an email. The emails will not contain uppercase letters.

-- Problem Statement
-- Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

-- SQL Solution
WITH CTE AS (
    SELECT id,
           email,
           ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS row_num
    FROM Person
)
DELETE FROM Person
WHERE id IN (SELECT id FROM CTE WHERE row_num > 1);

-- Intuition:
-- To remove duplicate emails while keeping only the one with the smallest id, we need to identify and delete all but the first occurrence of each email.
-- We can use a Common Table Expression (CTE) with ROW_NUMBER() to assign a unique number to each row within each partition of emails, ordered by id.
-- The first occurrence (smallest id) will have a row number of 1, and all subsequent occurrences will have row numbers greater than 1.

-- Explanation:
-- The CTE assigns a row number to each email based on the order of their ids, partitioned by email.
-- Emails with a row number greater than 1 are duplicates.
-- The DELETE statement removes rows from the Person table where the id is in the list of ids of duplicate emails (those with row numbers greater than 1).
