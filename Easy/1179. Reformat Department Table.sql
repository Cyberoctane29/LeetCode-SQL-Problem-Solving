-- Problem 1179: Reformat Department Table
-- Difficulty: Easy

-- SQL Schema
-- Table: Department
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | revenue     | int     |
-- | month       | varchar |
-- +-------------+---------+
-- In SQL, (id, month) is the primary key of this table.
-- The table has information about the revenue of each department per month.
-- The month has values in ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"].

-- Problem Statement
-- Reformat the table such that there is a department id column and a revenue column for each month.
-- Return the result table in any order.

-- Solution:
-- The query uses conditional aggregation to pivot the monthly revenue data into separate columns.

SELECT 
    id,
    SUM(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS Jan_revenue,
    SUM(CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS Feb_revenue,
    SUM(CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS Mar_revenue,
    SUM(CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS Apr_revenue,
    SUM(CASE WHEN month = 'May' THEN revenue ELSE NULL END) AS May_revenue,
    SUM(CASE WHEN month = 'Jun' THEN revenue ELSE NULL END) AS Jun_revenue,
    SUM(CASE WHEN month = 'Jul' THEN revenue ELSE NULL END) AS Jul_revenue,
    SUM(CASE WHEN month = 'Aug' THEN revenue ELSE NULL END) AS Aug_revenue,
    SUM(CASE WHEN month = 'Sep' THEN revenue ELSE NULL END) AS Sep_revenue,
    SUM(CASE WHEN month = 'Oct' THEN revenue ELSE NULL END) AS Oct_revenue,
    SUM(CASE WHEN month = 'Nov' THEN revenue ELSE NULL END) AS Nov_revenue,
    SUM(CASE WHEN month = 'Dec' THEN revenue ELSE NULL END) AS Dec_revenue
FROM 
    Department 
GROUP BY 
    id;

-- Explanation:
-- The `SUM(CASE WHEN month = 'MonthName' THEN revenue ELSE NULL END)` syntax is used to create a separate column for each month's revenue.
-- The `GROUP BY id` clause ensures that the data is aggregated by department id, providing the correct revenue for each department in each month.
