-- Problem 1327: List the Products Ordered in a Period
-- Difficulty: Easy

-- SQL Schema
-- Table: Products
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | product_id       | int     |
-- | product_name     | varchar |
-- | product_category | varchar |
-- +------------------+---------+
-- product_id is the primary key for this table.
-- This table contains data about the company's products.

-- Table: Orders
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | order_date    | date    |
-- | unit          | int     |
-- +---------------+---------+
-- product_id is a foreign key to the Products table.
-- unit is the number of products ordered on the order_date.

-- Problem Statement
-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their total amount.
-- Return the result table in any order.

-- Solution:
-- The query first joins the Orders and Products tables to associate product names with order details.
-- Then, it filters the records to only include orders made in February 2020.
-- Finally, it sums the units ordered for each product, filtering out products with fewer than 100 units ordered.

WITH CTE AS (
    SELECT 
        p.product_id, 
        p.product_name, 
        o.order_date, 
        o.unit 
    FROM 
        Orders AS o 
    LEFT JOIN 
        Products AS p 
    ON 
        o.product_id = p.product_id
)
SELECT 
    product_name, 
    SUM(unit) AS unit 
FROM 
    CTE 
WHERE 
    order_date LIKE '2020-02%' 
GROUP BY 
    product_name 
HAVING 
    SUM(unit) >= 100;

-- Explanation:
-- 1. **CTE (Common Table Expression)**: The CTE (Common Table Expression) is used to first join the `Orders` and `Products` tables, selecting the relevant columns (product_id, product_name, order_date, and unit).
-- 2. **Filtering Date**: The `WHERE` clause filters the records to include only those where `order_date` falls within February 2020 (using the pattern '2020-02%').
-- 3. **Grouping and Aggregating**: The query groups the results by `product_name`, summing up the `unit` for each product.
-- 4. **Having Clause**: The `HAVING` clause filters out any products that have a total unit count of less than 100.
-- 5. **Output**: The final output lists the product names and the total units ordered for those that meet the criteria.

-- This solution ensures that only the products with significant order volumes in February 2020 are returned.
