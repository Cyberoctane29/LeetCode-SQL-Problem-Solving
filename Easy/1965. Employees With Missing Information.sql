-- Problem 1965: Employees With Missing Information
-- Difficulty: Easy

-- SQL Schema
-- Table: Employees
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | name        | varchar |
-- +-------------+---------+
-- employee_id is the column with unique values for this table.
-- Each row of this table indicates the name of the employee whose ID is employee_id.

-- Table: Salaries
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | salary      | int     |
-- +-------------+---------+
-- employee_id is the column with unique values for this table.
-- Each row of this table indicates the salary of the employee whose ID is employee_id.

-- Problem Statement
-- Write a solution to report the IDs of all the employees with missing information.
-- The information of an employee is missing if:
-- 1. The employee's name is missing, or
-- 2. The employee's salary is missing.
-- Return the result table ordered by employee_id in ascending order.

-- Solution:
-- We will use a Common Table Expression (CTE) to gather all unique employee_ids from both tables.
-- Then, we will find employees who are missing either in the Employees table or the Salaries table.
-- Finally, we will return the employee_ids that are missing in either table.

WITH CTE AS (
    SELECT employee_id FROM Employees
    UNION
    SELECT employee_id FROM Salaries
)
SELECT employee_id
FROM CTE
WHERE employee_id NOT IN (
    SELECT employee_id
    FROM Employees
    INNER JOIN Salaries USING(employee_id)
)
ORDER BY employee_id;

-- Intuition:
-- To identify employees with missing information, we need to check which employee_ids are not present in both tables.
-- By combining employee_ids from both tables and finding those not present in the intersection of both tables, we identify those with missing information.

-- Explanation:
-- The CTE `CTE` gathers all unique employee_ids from both the Employees and Salaries tables.
-- The main query checks which employee_ids from this combined list are missing from the intersection of both tables (i.e., employees who have entries in either Employees or Salaries but not both).
-- This identifies employees with incomplete information (missing name or salary).
-- The results are then ordered by employee_id in ascending order.
