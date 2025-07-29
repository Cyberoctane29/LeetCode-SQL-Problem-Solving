-- Problem 3436: Find Valid Emails
-- Difficulty: Easy

-- Table: Users
-- +-----------------+---------+
-- | Column Name     | Type    |
-- +-----------------+---------+
-- | user_id         | int     |
-- | email           | varchar |
-- +-----------------+---------+
-- (user_id) is the unique key for this table.
-- Each row contains a user's unique ID and email address.

-- Problem Statement:
-- Write a solution to find all the valid email addresses. A valid email address meets the following criteria:
-- - It contains exactly one @ symbol.
-- - It ends with .com.
-- - The part before the @ symbol contains only alphanumeric characters and underscores.
-- - The part after the @ symbol and before .com contains a domain name that contains only letters.
-- Return the result table ordered by user_id in ascending order.

-- Solution

SELECT 
    user_id, 
    email 
FROM 
    users 
WHERE 
    email REGEXP '^[A-Za-z0-9_]+@[A-Za-z]+\\.com$' 
ORDER BY 
    user_id ASC;

-- Intuition:
-- I need to filter emails that match a very specific pattern using SQL regex.

-- Explanation:
-- I use a regular expression to validate the structure of email addresses:
-- ^            → start of string
-- [A-Za-z0-9_]+→ one or more alphanumeric characters or underscores before @
-- @            → exactly one @ symbol
-- [A-Za-z]+    → domain name with only letters
-- \\.com$      → ends with '.com'
-- I use REGEXP to match this pattern in SQL and return valid emails, ordering them by user_id.
