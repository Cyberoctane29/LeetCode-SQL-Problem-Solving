-- Problem 183: Customers Who Never Order
-- Difficulty: Easy

-- SQL Schema
-- Table: Customers
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the ID and name of a customer.

-- Table: Orders
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | customerId  | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- customerId is a foreign key (reference columns) of the ID from the Customers table.
-- Each row of this table indicates the ID of an order and the ID of the customer who ordered it.

-- Problem Statement
-- Write a solution to find all customers who never order anything.

-- SQL Solution
SELECT T1.name AS Customers
FROM Customers T1
WHERE T1.id NOT IN (SELECT customerId FROM Orders);

-- Intuition:
-- To find customers who have never placed an order, we need to identify those customers who are not listed in the Orders table.
-- We can do this by checking for each customer ID that does not appear in the list of customer IDs from the Orders table.

-- Explanation:
-- The subquery `(SELECT customerId FROM Orders)` retrieves all customer IDs who have placed orders.
-- The main query selects the names of customers whose IDs are not in the list obtained from the subquery.
-- This ensures that only customers who have not placed any orders are included in the result set.
