-- Problem 1321: Restaurant Growth
-- Difficulty: Medium

-- SQL Schema
-- Table: Customer
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | customer_id   | int     |
-- | name          | varchar |
-- | visited_on    | date    |
-- | amount        | int     |
-- +---------------+---------+
-- (customer_id, visited_on) is the primary key for this table.
-- This table contains data about customer transactions in a restaurant.
-- visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
-- amount is the total paid by a customer.

-- Problem Statement
-- You are the restaurant owner and you want to analyze a possible expansion.
-- Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). 
-- The average_amount should be rounded to two decimal places.
-- Return the result table ordered by visited_on in ascending order.

-- SQL Solution
SELECT 
    a.visited_on, 
    SUM(b.day_sum) AS amount, 
    ROUND(AVG(b.day_sum), 2) AS average_amount 
FROM 
    (SELECT visited_on, SUM(amount) AS day_sum 
     FROM customer 
     GROUP BY visited_on) AS a,
    (SELECT visited_on, SUM(amount) AS day_sum 
     FROM customer 
     GROUP BY visited_on) AS b
WHERE 
    DATEDIFF(a.visited_on, b.visited_on) BETWEEN 0 AND 6 
GROUP BY 
    a.visited_on 
HAVING 
    COUNT(b.visited_on) = 7;

-- Intuition:
-- The problem requires a moving average calculation over a 7-day window. 
-- To achieve this, we consider the sum of amounts for each day in this window.
-- By listing two subqueries in the FROM clause, we create an implicit cross join (Cartesian product).
-- The WHERE clause then filters the results to only include rows where the difference in days is between 0 and 6.

-- Explanation:
-- The subqueries calculate the daily sum (`day_sum`) of amounts spent on each date.
-- When we join these two subqueries without an explicit JOIN condition, we create a Cartesian product of the two sets of results.
-- The WHERE clause restricts this Cartesian product to pairs of dates within the desired 7-day range.
-- Finally, we group the results by the current date (`visited_on`) and calculate the average over this 7-day window, rounding the result to two decimal places.
-- The HAVING clause ensures that we only consider periods with exactly 7 days.
-- The final result is ordered by `visited_on` in ascending order.
