-- Problem 182: Duplicate Emails
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
-- Write a solution to report all the duplicate emails.
-- Note that it's guaranteed that the email field is not NULL.

-- SQL Solution
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;

-- Intuition:
-- To find duplicate emails, we need to identify which emails appear more than once in the table.
-- We can do this by grouping the records based on the email field and then counting how many times each email appears.
-- Emails that appear more than once are considered duplicates.

-- Explanation:
-- The GROUP BY clause groups the rows in the Person table by the email column.
-- The HAVING clause is used to filter these groups based on the condition that their count must be greater than 1.
-- This ensures that only emails which appear more than once are included in the result set.
