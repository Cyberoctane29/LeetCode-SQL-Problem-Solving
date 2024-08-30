-- Problem 1084: Sales Analysis III
-- Difficulty: Easy

-- SQL Schema
-- Table: Product
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- | unit_price   | int     |
-- +--------------+---------+
-- product_id is the primary key (column with unique values) of this table.
-- Each row of this table indicates the name and the price of each product.

-- Table: Sales
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | seller_id   | int     |
-- | product_id  | int     |
-- | buyer_id    | int     |
-- | sale_date   | date    |
-- | quantity    | int     |
-- | price       | int     |
-- +-------------+---------+
-- This table can have duplicate rows.
-- product_id is a foreign key (reference column) to the Product table.
-- Each row of this table contains some information about one sale.

-- Problem Statement
-- Write a solution to report the products that were only sold in the first quarter of 2019. 
-- That is, between 2019-01-01 and 2019-03-31 inclusive.
-- Return the result table in any order.

-- Solution 1:
-- Using a combination of IN and NOT IN to filter products sold only within the specified date range.
-- Products that have sales records only within the first quarter of 2019 are selected.

SELECT 
    p.product_id, 
    p.product_name 
FROM 
    Product AS p 
WHERE 
    p.product_id IN (
        SELECT s.product_id 
        FROM Sales AS s 
        WHERE s.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
    )
AND 
    p.product_id NOT IN (
        SELECT s.product_id 
        FROM Sales AS s 
        WHERE s.sale_date < '2019-01-01' OR s.sale_date > '2019-03-31'
    );

-- Intuition:
-- The subquery in the IN clause selects products sold during the first quarter of 2019.
-- The subquery in the NOT IN clause excludes products sold outside this date range.
-- The final result is the intersection of these conditions.

-- Explanation:
-- The query ensures that only products sold in the specified date range and not outside it are selected.

-- Solution 2:
-- Using GROUP BY and HAVING to filter products based on the date range of their sales.
-- Products with all sales within the first quarter of 2019 are selected.

SELECT 
    p.product_id, 
    p.product_name 
FROM 
    Product AS p 
JOIN 
    Sales AS s 
ON 
    p.product_id = s.product_id 
GROUP BY 
    p.product_id, p.product_name 
HAVING 
    MIN(s.sale_date) >= '2019-01-01' 
    AND MAX(s.sale_date) <= '2019-03-31';

-- Intuition:
-- The GROUP BY clause groups sales records by product.
-- The HAVING clause filters groups to include only those where the earliest and latest sale dates are within the first quarter of 2019.

-- Explanation:
-- The query groups sales records by product and ensures that the product's sales dates are all within the first quarter of 2019.

