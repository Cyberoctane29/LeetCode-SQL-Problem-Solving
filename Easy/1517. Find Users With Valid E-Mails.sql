-- Problem 1517: Find Users With Valid E-Mails
-- Difficulty: Easy

-- SQL Schema
-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | name          | varchar |
-- | mail          | varchar |
-- +---------------+---------+
-- user_id is the primary key for this table.
-- This table contains information about users signed up on a website. Some e-mails are invalid.

-- Problem Statement
-- Write a solution to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- - The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'.
-- - The prefix name must start with a letter.
-- - The domain is '@leetcode.com'.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    user_id, 
    name, 
    mail
FROM 
    Users
WHERE 
    mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$';

-- Intuition:
-- To identify valid emails, we use a regular expression to match the required pattern.
-- The regular expression ensures that the email starts with a letter, is followed by allowed characters, and ends with '@leetcode.com'.

-- Explanation:
-- The REGEXP operator is used to match the email against the regular expression pattern.
-- The pattern '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$' breaks down as follows:
-- - '^[A-Za-z]' ensures the email starts with a letter.
-- - '[A-Za-z0-9_.-]*' allows letters, digits, underscores, periods, and dashes in the prefix.
-- - '@leetcode\\.com$' matches the domain part, ensuring it ends with '@leetcode.com'.
