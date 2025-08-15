-- Problem 3564: Seasonal Sales Analysis
-- Difficulty: Medium

-- Table: sales
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | sale_id       | int     |
-- | product_id    | int     |
-- | sale_date     | date    |
-- | quantity      | int     |
-- | price         | decimal |
-- +---------------+---------+
-- sale_id is the unique identifier for this table.
-- Each row contains information about a product sale including the product_id, date of sale, quantity sold, and price per unit.

-- Table: products
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | product_name  | varchar |
-- | category      | varchar |
-- +---------------+---------+
-- product_id is the unique identifier for this table.
-- Each row contains information about a product including its name and category.

-- Problem Statement:
-- Find the most popular product category for each season:
-- Winter: December, January, February
-- Spring: March, April, May
-- Summer: June, July, August
-- Fall: September, October, November
-- Popularity is determined by total quantity sold in that season.
-- If tied, choose the category with the highest total revenue (quantity × price).
-- Return results ordered by season in ascending order.

-- Solution 1 (Using IN for month matching):

WITH CTE AS (
    SELECT 
        s.product_id,
        p.category,
        CASE 
            WHEN MONTH(s.sale_date) IN (12,1,2) THEN 'Winter'
            WHEN MONTH(s.sale_date) IN (3,4,5) THEN 'Spring'
            WHEN MONTH(s.sale_date) IN (6,7,8) THEN 'Summer'
            WHEN MONTH(s.sale_date) IN (9,10,11) THEN 'Fall'
        END AS season,
        s.quantity,
        s.price
    FROM 
        sales AS s
    LEFT JOIN 
        products AS p
        ON s.product_id = p.product_id
),
CTE1 AS (
    SELECT 
        season,
        category,
        SUM(quantity) AS total_quantity,
        ROUND(SUM(quantity * price), 2) AS total_revenue
    FROM 
        CTE
    GROUP BY 
        season, category
),
CTE2 AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY season 
            ORDER BY total_quantity DESC, total_revenue DESC
        ) AS rn
    FROM 
        CTE1
)
SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM 
    CTE2
WHERE 
    rn = 1;

-- Intuition:
-- Assign each sale to a season using a CASE statement with IN for month matching.
-- Aggregate total quantity and total revenue by season and category.
-- Use ROW_NUMBER to rank categories per season by quantity, breaking ties with revenue.
-- Select the top-ranked category for each season.

-- Explanation:
-- The CASE clause categorizes each sale into Winter, Spring, Summer, or Fall based on its month.
-- Aggregation in CTE1 computes total sales quantity and revenue per category per season.
-- ROW_NUMBER in CTE2 ensures that only the category with the highest quantity (and revenue in case of ties) for each season is chosen.
-- Filtering with rn = 1 gives the final list of most popular categories per season.

-- Solution 2 (Using OR for month matching):

WITH CTE AS (
    SELECT 
        s.product_id,
        p.category,
        CASE 
            WHEN (MONTH(s.sale_date) = 12 OR MONTH(s.sale_date) = 1 OR MONTH(s.sale_date) = 2) THEN 'Winter'
            WHEN (MONTH(s.sale_date) = 3 OR MONTH(s.sale_date) = 4 OR MONTH(s.sale_date) = 5) THEN 'Spring'
            WHEN (MONTH(s.sale_date) = 6 OR MONTH(s.sale_date) = 7 OR MONTH(s.sale_date) = 8) THEN 'Summer'
            WHEN (MONTH(s.sale_date) = 9 OR MONTH(s.sale_date) = 10 OR MONTH(s.sale_date) = 11) THEN 'Fall'
        END AS season,
        s.quantity,
        s.price
    FROM 
        sales AS s
    LEFT JOIN 
        products AS p
        ON s.product_id = p.product_id
),
CTE1 AS (
    SELECT 
        season,
        category,
        SUM(quantity) AS total_quantity,
        ROUND(SUM(quantity * price), 2) AS total_revenue
    FROM 
        CTE
    GROUP BY 
        season, category
),
CTE2 AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY season 
            ORDER BY total_quantity DESC, total_revenue DESC
        ) AS rn
    FROM 
        CTE1
)
SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM 
    CTE2
WHERE 
    rn = 1;

-- Intuition:
-- Similar to Solution 1, but uses multiple OR conditions for month matching instead of IN.
-- The rest of the logic remains identical for calculating top categories per season.

-- Explanation:
-- The CASE statement uses OR comparisons to assign the correct season to each sale.
-- Aggregation and ranking logic matches Solution 1, ensuring the category with the highest quantity (and revenue in case of ties) is selected for each season.
-- The result is ordered by season in ascending order.
