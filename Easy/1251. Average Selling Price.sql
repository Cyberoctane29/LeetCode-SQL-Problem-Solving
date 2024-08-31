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
-- Each row indicates the price of the product_id during the period from start_date to end_date.
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
-- Return the result table in any order.

-- SQL Solution 1
WITH CTE AS (
    SELECT 
        p.product_id, 
        p.start_date, 
        p.end_date, 
        p.price, 
        u.purchase_date, 
        u.units
    FROM 
        Prices p
    LEFT JOIN 
        UnitsSold u 
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

-- Intuition:
-- We need to calculate the weighted average selling price for each product based on the units sold within the corresponding price periods.
-- The query first joins the Prices table with the UnitsSold table using a CTE, ensuring that the purchase dates fall within the price periods.
-- Then, we calculate the average price using a weighted sum, dividing the total revenue by the total units sold for each product.
-- IFNULL ensures that if no units were sold, the average price will be returned as 0.

-- SQL Solution 2
SELECT 
    p.product_id, 
    IFNULL(ROUND(SUM(p.price * u.units) / SUM(u.units), 2), 0) AS average_price
FROM 
    Prices p 
LEFT JOIN 
    UnitsSold u
ON 
    p.product_id = u.product_id 
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY 
    p.product_id;

-- Intuition:
-- This approach also calculates the average selling price for each product.
-- Here, the weighted average is calculated directly within the main query without using a CTE.
-- The logic remains the same, where we calculate the sum of the product of price and units sold and divide it by the total units sold.
-- Again, IFNULL ensures that if no units were sold for a product, the average price will default to 0.
