-- Problem 3465: Find Products with Valid Serial Numbers
-- Difficulty: Easy

-- Table: Products
-- +--------------+------------+
-- | Column Name  | Type       |
-- +--------------+------------+
-- | product_id   | int        |
-- | product_name | varchar    |
-- | description  | varchar    |
-- +--------------+------------+
-- (product_id) is the unique key for this table.
-- Each row in the table represents a product with its unique ID, name, and description.

-- Problem Statement:
-- Write a solution to find all products whose description contains a valid serial number pattern.
-- A valid serial number follows these rules:
-- - It starts with the letters SN (case-sensitive).
-- - Followed by exactly 4 digits.
-- - It must have a hyphen (-) followed by exactly 4 digits.
-- - The serial number must be within the description (it may not necessarily start at the beginning).
-- Return the result table ordered by product_id in ascending order.

-- Solution

SELECT 
    product_id, 
    product_name, 
    description
FROM 
    products
WHERE 
    REGEXP_LIKE(description, '(^|\\s)SN[0-9]{4}-[0-9]{4}($|\\s)', 'c')
ORDER BY 
    product_id;

-- Intuition:
-- I need to match a specific serial number pattern embedded within the description string.

-- Explanation:
-- I use REGEXP_LIKE to match a valid serial number using the following pattern:
-- - (^|\\s)    → ensures the pattern is either at the start or preceded by a space
-- - SN[0-9]{4} → matches 'SN' followed by exactly 4 digits
-- - -[0-9]{4}  → matches a hyphen followed by another set of exactly 4 digits
-- - ($|\\s)    → ensures the pattern is either at the end or followed by a space
-- - 'c' flag   → makes the regex case-sensitive, ensuring 'SN' is matched exactly
-- I return all such matching products, ordered by product_id in ascending order.
