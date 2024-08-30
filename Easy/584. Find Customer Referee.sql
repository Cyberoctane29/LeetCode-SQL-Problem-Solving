-- Problem 584: Find Customer Referee
-- Difficulty: Easy

-- SQL Schema
-- Table: Customer
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | referee_id  | int     |
-- +-------------+---------+
-- In SQL, id is the primary key column for this table.
-- Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.

-- Problem Statement
-- Find the names of the customers that are not referred by the customer with id = 2.

-- SQL Solution
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;

-- Intuition:
-- To find customers who were not referred by the customer with id = 2, we need to exclude those records where the referee_id is 2.
-- Additionally, we should include customers who do not have a referee_id (i.e., where referee_id is NULL).

-- Explanation:
-- The query selects the `name` of customers from the Customer table where the `referee_id` is not equal to 2.
-- The condition `referee_id IS NULL` ensures that customers without a referee (i.e., those who were not referred by anyone) are also included in the result.
-- This effectively retrieves the names of customers who were not referred by the customer with id = 2.
