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
-- The (id, month) combination is the primary key of this table.
-- The table contains information about the revenue of each department per month.
-- The 'month' column has values representing each month of the year ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].

-- Problem Statement
-- Reformat the table such that there is a department id column and a revenue column for each month.
-- Return the result table in any order.

-- SQL Solution
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
FROM Department 
GROUP BY id;

-- Intuition:
-- The task is to pivot the table so that each month has its own column representing the revenue for that month.
-- We use the SUM function with a CASE statement to aggregate revenue for each month, grouping the results by department id.

-- Explanation:
-- The CASE statements inside the SUM function check if the current month matches a specific month (e.g., 'Jan', 'Feb').
-- If it matches, the revenue is included in the corresponding column for that month; otherwise, it returns NULL.
-- GROUP BY id ensures that the results are grouped by department id, providing a single row for each department.
