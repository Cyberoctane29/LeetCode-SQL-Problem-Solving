-- Problem 1164: Product Price at a Given Date
-- Difficulty: Medium

-- SQL Schema
-- Table: Products
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key (combination of columns with unique values) of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.

-- Problem Statement
-- Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    product_id,
    10 AS price
FROM 
    Products
GROUP BY 
    product_id
HAVING 
    MIN(change_date) > '2019-08-16'

UNION

SELECT 
    product_id,
    new_price
FROM 
    Products
WHERE 
    (product_id, change_date) IN (
        SELECT 
            product_id,
            MAX(change_date) AS recent_date
        FROM 
            Products
        WHERE 
            change_date <= '2019-08-16'
        GROUP BY 
            product_id
    );

-- Intuition:
-- To find the price of each product on a specific date (2019-08-16), we need to consider two cases:
-- 1. Products that have never had their price changed before or on that date.
-- 2. Products that have had their price changed before or on that date.

-- Explanation:
-- 1. **Case 1: Products with No Price Change by the Given Date**
--    - For products where the earliest change date is after '2019-08-16', the price on that date is the default price, which is 10.
--    - We use `GROUP BY` on `product_id` and `HAVING MIN(change_date) > '2019-08-16'` to identify such products.

-- 2. **Case 2: Products with Price Change Before or On the Given Date**
--    - For products that have had their price changed before or on '2019-08-16', we need the most recent price change before or on that date.
--    - We use a subquery to find the most recent price change (`MAX(change_date)`) for each product up to and including '2019-08-16'.

-- Combining both cases using `UNION` provides the final result with prices of all products on the specified date.
