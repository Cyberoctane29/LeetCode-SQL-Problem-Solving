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
-- This table may have duplicate rows.
-- product_id is a foreign key to the Products table.
-- unit is the number of products ordered on order_date.

-- Problem Statement
-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
-- Return the result table in any order.

-- SQL Solution
WITH CTE AS (
    SELECT 
        p.product_id,
        p.product_name,
        o.order_date,
        o.unit 
    FROM 
        Orders o 
    LEFT JOIN 
        Products p 
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
    unit >= 100;

-- Intuition:
-- To find products that have a significant number of orders in a specific month, we first join the Orders table with the Products table to get the product names.
-- We then filter the results for orders made in February 2020 and aggregate the units ordered per product.
-- Finally, we only select those products where the total units ordered are 100 or more.

-- Explanation:
-- The CTE (Common Table Expression) combines the Orders and Products tables to provide a dataset with product names and order details.
-- The WHERE clause filters the orders to include only those made in February 2020.
-- The results are grouped by product_name, and the SUM of units is calculated for each product.
-- The HAVING clause ensures that only products with a total of 100 or more units ordered in the specified period are included in the final output.
