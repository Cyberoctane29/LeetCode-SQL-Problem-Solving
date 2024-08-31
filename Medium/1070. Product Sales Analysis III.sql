-- Problem 1070: Product Sales Analysis III
-- Difficulty: Medium

-- SQL Schema
-- Table: Sales
-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- (sale_id, year) is the primary key (combination of columns with unique values) of this table.
-- product_id is a foreign key (reference column) to the Product table.
-- Each row of this table shows a sale on the product product_id in a certain year.
-- Note that the price is per unit.

-- Table: Product
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the product name of each product.

-- Problem Statement
-- Write a solution to select the product id, year, quantity, and price for the first year of every product sold.
-- Return the resulting table in any order.

-- SQL Solution
SELECT 
    product_id,
    year AS first_year,
    quantity,
    price
FROM 
    Sales
WHERE 
    (product_id, year) IN (
        SELECT 
            product_id,
            MIN(year) AS first_year
        FROM 
            Sales
        GROUP BY 
            product_id
    );

-- Intuition:
-- To find the sales details for the first year a product was sold, we need to identify the earliest year for each product and then retrieve all sales information for that year.

-- Explanation:
-- 1. The subquery identifies the earliest year (MIN(year)) for each product_id by grouping the sales records by product_id.
-- 2. The main query selects the sales details for each product where the year matches the earliest year identified in the subquery.
--    - This ensures that only the sales information for the first year of each product is returned.
-- 3. The result includes the product_id, the earliest year (`first_year`), quantity, and price for the first year of sales for each product.
