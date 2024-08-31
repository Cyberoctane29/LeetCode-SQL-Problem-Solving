-- Problem 1174: Immediate Food Delivery II
-- Difficulty: Medium

-- SQL Schema
-- Table: Delivery
-- +-----------------------------+---------+
-- | Column Name                 | Type    |
-- +-----------------------------+---------+
-- | delivery_id                 | int     |
-- | customer_id                 | int     |
-- | order_date                  | date    |
-- | customer_pref_delivery_date | date    |
-- +-----------------------------+---------+
-- delivery_id is the column of unique values of this table.
-- The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).

-- Problem Statement
-- If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
-- The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.
-- Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

-- SQL Solution
WITH CTE AS (
    SELECT 
        customer_id,
        order_date,
        customer_pref_delivery_date AS cpdd,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
    FROM 
        Delivery
)
SELECT 
    ROUND(
        (SELECT COUNT(customer_id) FROM CTE WHERE rn = 1 AND order_date = cpdd) * 100.0 / 
        (SELECT COUNT(DISTINCT customer_id) FROM Delivery), 
        2
    ) AS immediate_percentage;

-- Intuition:
-- To find the percentage of immediate orders among the first orders of all customers, follow these steps:
-- 1. Identify the first order for each customer.
-- 2. Determine if the first order was immediate or scheduled.
-- 3. Calculate the percentage of immediate orders among these first orders.

-- Explanation:
-- 1. **CTE Definition:**
--    - Use a Common Table Expression (CTE) to find the first order for each customer.
--    - The `ROW_NUMBER()` function, partitioned by `customer_id` and ordered by `order_date`, helps in identifying the first order (i.e., `rn = 1`).

-- 2. **Percentage Calculation:**
--    - Calculate the number of immediate orders where `order_date = customer_pref_delivery_date` and `rn = 1` (i.e., first orders).
--    - Calculate the total number of distinct customers.
--    - Compute the percentage of immediate orders by dividing the count of immediate first orders by the total number of customers and multiply by 100.0 to get the percentage.
--    - Round the result to 2 decimal places.

-- By combining these steps, you get the required percentage of immediate orders among the first orders of all customers.
