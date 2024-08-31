-- Problem 1731: The Number of Employees Which Report to Each Employee
-- Difficulty: Easy

-- SQL Schema
-- Table: Employees
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | employee_id | int      |
-- | name        | varchar  |
-- | reports_to  | int      |
-- | age         | int      |
-- +-------------+----------+
-- employee_id is the column with unique values for this table.
-- This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null).

-- Problem Statement
-- For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
-- Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.
-- Return the result table ordered by employee_id.

-- SQL Solution
SELECT 
    e1.employee_id,
    e1.name,
    COUNT(e2.employee_id) AS reports_count,
    ROUND(AVG(e2.age)) AS average_age
FROM 
    Employees e1
INNER JOIN 
    Employees e2 
ON 
    e1.employee_id = e2.reports_to
GROUP BY 
    e1.employee_id
ORDER BY 
    e1.employee_id;

-- Intuition:
-- To identify managers, we join the Employees table with itself where the `employee_id` matches the `reports_to` field.
-- This allows us to count how many employees report to each manager and calculate the average age of those reports.
-- Managers are those who have at least one direct report.

-- Explanation:
-- The query performs an inner join on the Employees table to link each manager with their direct reports.
-- It then groups the results by `employee_id` of the manager, counts the number of direct reports, and computes the average age of the reports.
-- The results are ordered by `employee_id` to list managers in ascending order.
