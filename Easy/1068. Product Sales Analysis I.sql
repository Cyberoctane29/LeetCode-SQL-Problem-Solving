-- Problem 068: Product Sales Analysis I
-- Difficulty: Easy

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
-- product_id is a foreign key (reference column) to Product table.
-- Each row of this table shows a sale on the product product_id in a certain year.
-- Note that the price is per unit.

-- Table: Product
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key (column with unique values) of this table.
-- Each row of this table indicates the product name of each product.

-- Problem Statement
-- Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
-- Return the resulting table in any order.

-- Solution 1:
-- Using LEFT JOIN to include all rows from Sales and matching rows from Product.
-- It ensures that all sales records are included, even if there is no matching product.

SELECT p.product_name, s.year, s.price
FROM Sales AS s
LEFT JOIN Product AS p ON s.product_id = p.product_id;

-- Intuition:
-- A LEFT JOIN includes all records from the Sales table and matches records from the Product table.
-- This ensures that even if some sales records don't have a matching product, they still appear in the result.

-- Explanation:
-- The query performs a LEFT JOIN between Sales and Product tables on the product_id.
-- It returns all rows from Sales along with the product_name and price, even if there are no matching rows in Product.

-- Solution 2:
-- Using INNER JOIN to include only the rows where there is a match in both Sales and Product.

SELECT p.product_name, s.year, s.price
FROM Sales AS s
JOIN Product AS p ON s.product_id = p.product_id;

-- Intuition:
-- An INNER JOIN includes only those rows where there is a match between Sales and Product.
-- This means that only sales with a corresponding product will be included in the result.

-- Explanation:
-- The query performs an INNER JOIN between Sales and Product tables on the product_id.
-- It returns rows where there is a matching product, including the product_name, year, and price.

-- Solution 3:
-- Using RIGHT JOIN to include all rows from Product and matching rows from Sales.

SELECT p.product_name, s.year, s.price
FROM Product AS p
RIGHT JOIN Sales AS s ON p.product_id = s.product_id;

-- Intuition:
-- A RIGHT JOIN includes all records from the Product table and matches records from the Sales table.
-- This ensures that all sales records are included, and the query returns all products even if they don't have corresponding sales.

-- Explanation:
-- The query performs a RIGHT JOIN between Product and Sales tables on the product_id.
-- It returns all rows from Product and matches them with Sales, including the product_name, year, and price.

-- Solution 4:
-- Using RIGHT JOIN but ensuring that only records with non-null years from Sales are included.

SELECT p.product_name, s.year, s.price
FROM Sales AS s
RIGHT JOIN Product AS p ON s.product_id = p.product_id
WHERE s.year IS NOT NULL;

-- Intuition:
-- This query is similar to Solution 3 but includes a filter to ensure that only sales with non-null years are considered.
-- This ensures that the result includes all products but only shows those sales where year information is present.

-- Explanation:
-- The query performs a RIGHT JOIN between Sales and Product tables on the product_id.
-- It returns all rows from Product and matches them with Sales, but only includes rows where year is not null.
