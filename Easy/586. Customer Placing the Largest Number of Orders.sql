-- Problem 586: Customer Placing the Largest Number of Orders
-- Difficulty: Easy

-- SQL Schema
-- Table: Orders
-- +-----------------+----------+
-- | Column Name     | Type     |
-- +-----------------+----------+
-- | order_number    | int      |
-- | customer_number | int      |
-- +-----------------+----------+
-- order_number is the primary key (column with unique values) for this table.
-- This table contains information about the order ID and the customer ID.

-- Problem Statement
-- Write a solution to find the customer_number for the customer who has placed the largest number of orders.

-- Solution 1
-- Use a subquery to find the customer with the highest order count.

SELECT customer_number
FROM (
    SELECT customer_number, COUNT(customer_number) AS order_count
    FROM Orders
    GROUP BY customer_number
    ORDER BY order_count DESC
    LIMIT 1
) AS der_tab;

-- Intuition:
-- To identify the customer who placed the largest number of orders, count the orders per customer, then order by this count in descending order and limit the result to one.

-- Explanation:
-- The inner query groups the Orders table by `customer_number`, counts the number of orders, orders the results by `order_count` in descending order, and limits the output to the top result.
-- The outer query selects the `customer_number` from this top result, which corresponds to the customer who placed the most orders.

-- Solution 2
-- Use a MAX function to find the customer_number with the highest order count using a nested subquery approach.

SELECT customer_number
FROM (
    SELECT customer_number, COUNT(customer_number) AS order_count
    FROM Orders
    GROUP BY customer_number
) AS der_tab
WHERE order_count = (
    SELECT MAX(order_count)
    FROM (
        SELECT COUNT(customer_number) AS order_count
        FROM Orders
        GROUP BY customer_number
    ) AS inner_tab
);

-- Intuition:
-- To find the customer with the highest number of orders, calculate the total number of orders for each customer, find the maximum count, and then select the customer associated with this count.

-- Explanation:
-- The inner query groups the Orders table by `customer_number` and counts the orders. 
-- The subquery then finds the maximum count of orders. 
-- The outer query selects the `customer_number` whose order count matches this maximum count.
