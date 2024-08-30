-- Problem 1251: Average Selling Price
-- Difficulty: Easy

-- SQL Schema
-- Table: Prices
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | start_date    | date    |
-- | end_date      | date    |
-- | price         | int     |
-- +---------------+---------+
-- (product_id, start_date, end_date) is the primary key for this table.
-- Each row indicates the price of the product_id in the period from start_date to end_date.
-- For each product_id, there will be no overlapping periods.

-- Table: UnitsSold
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | purchase_date | date    |
-- | units         | int     |
-- +---------------+---------+
-- This table may contain duplicate rows.
-- Each row indicates the date, units, and product_id of each product sold.

-- Problem Statement
-- Write a solution to find the average selling price for each product.
-- The average_price should be rounded to 2 decimal places.

-- Solution 1:
-- This query first creates a Common Table Expression (CTE) to join Prices and UnitsSold based on matching product_id and ensuring that the purchase_date falls within the start_date and end_date period.
-- Then it calculates the average selling price using weighted average formula: (sum(units * price) / sum(units)) and rounds the result to 2 decimal places.

WITH CTE AS (
    SELECT 
        p.product_id, 
        p.start_date, 
        p.end_date, 
        p.price, 
        u.purchase_date, 
        u.units
    FROM 
        Prices AS p
    LEFT JOIN 
        UnitsSold AS u 
    ON 
        p.product_id = u.product_id 
        AND u.purchase_date BETWEEN p.start_date AND p.end_date
) 
SELECT 
    product_id, 
    IFNULL(ROUND(SUM(units * price) / SUM(units), 2), 0) AS average_price 
FROM 
    CTE 
GROUP BY 
    product_id;

-- Solution 2:
-- This solution performs a direct LEFT JOIN between the Prices and UnitsSold tables, and then calculates the average selling price in a similar way to Solution 1.

SELECT 
    p.product_id, 
    IFNULL(ROUND(SUM(p.price * u.units) / SUM(u.units), 2), 0) AS average_price
FROM 
    Prices AS p 
LEFT JOIN 
    UnitsSold AS u
ON 
    p.product_id = u.product_id 
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY 
    p.product_id;

-- Explanation:
-- 1. Both solutions involve joining the `Prices` table with the `UnitsSold` table based on product_id and matching the purchase_date with the price period.
-- 2. The average price is calculated using the weighted average formula: `SUM(units * price) / SUM(units)`, and it is rounded to 2 decimal places.
-- 3. The `IFNULL` function is used to handle cases where a product may not have any units sold, resulting in an average price of 0.
-- 4. The `GROUP BY` clause groups the results by `product_id` to calculate the average price for each product.
