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
-- user_id is the primary key (column with unique values) for this table.
-- This table contains information of the users signed up on a website. Some e-mails are invalid.

-- Problem Statement:
-- Write a solution to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- - The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'.
-- - The prefix name must start with a letter.
-- - The domain is '@leetcode.com'.
-- Return the result table in any order.

-- Solution:
-- This query filters the users with valid emails by using the REGEXP function.
-- The regular expression checks for the following conditions:
-- 1. The prefix starts with a letter (upper or lower case).
-- 2. The prefix can contain letters, digits, underscores, periods, and dashes.
-- 3. The domain must be '@leetcode.com'.

SELECT 
    user_id, 
    name, 
    mail
FROM 
    Users
WHERE 
    mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com';

-- Explanation:
-- 1. **^[A-Za-z]**: Ensures the prefix starts with a letter (either uppercase A-Z or lowercase a-z).
-- 2. **[A-Za-z0-9_.-]*@leetcode\\.com**: 
--    - Allows for letters, digits, underscores, periods, and dashes to follow in the prefix.
--    - `@leetcode.com` specifies the exact domain.
--    - The backslash `\\.` is used to escape the period in the domain name since `.` is a special character in regex.
-- 3. The `REGEXP` function checks if the email meets the pattern criteria for validity.

-- This query filters and returns only the users with valid email addresses, according to the specified format.
