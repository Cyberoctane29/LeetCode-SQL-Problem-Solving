-- Problem 1075: Project Employees I
-- Difficulty: Easy

-- SQL Schema
-- Table: Project
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | project_id  | int     |
-- | employee_id | int     |
-- +-------------+---------+
-- (project_id, employee_id) is the primary key of this table.
-- employee_id is a foreign key to Employee table.
-- Each row of this table indicates that the employee with employee_id is working on the project with project_id.

-- Table: Employee
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | employee_id      | int     |
-- | name             | varchar |
-- | experience_years | int     |
-- +------------------+---------+
-- employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
-- Each row of this table contains information about one employee.

-- Problem Statement
-- Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
-- Return the result table in any order.

-- Solution 1:
-- Using LEFT JOIN to include all rows from Project and matching rows from Employee.
-- GROUP BY project_id to calculate the average experience years for each project.

SELECT p.project_id, ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project AS p
LEFT JOIN Employee AS e ON p.employee_id = e.employee_id
GROUP BY p.project_id;

-- Intuition:
-- A LEFT JOIN includes all records from Project and matches with Employee.
-- GROUP BY project_id ensures that the average experience years are calculated separately for each project.

-- Explanation:
-- The query performs a LEFT JOIN between Project and Employee tables on the employee_id.
-- It calculates the average experience years for each project and rounds the result to 2 decimal places.

-- Solution 2:
-- Using INNER JOIN to include only the rows where there is a match in both Project and Employee.
-- GROUP BY project_id to calculate the average experience years for each project.

SELECT p.project_id, 
       ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project AS p
JOIN Employee AS e ON p.employee_id = e.employee_id
GROUP BY p.project_id;

-- Intuition:
-- An INNER JOIN includes only rows where there is a match between Project and Employee.
-- GROUP BY project_id ensures that the average experience years are calculated separately for each project.

-- Explanation:
-- The query performs an INNER JOIN between Project and Employee tables on the employee_id.
-- It calculates the average experience years for each project and rounds the result to 2 decimal places.

-- Solution 3:
-- Using window functions to calculate the average experience years for each project.
-- SELECT DISTINCT to avoid duplicate project_id in the result.

SELECT DISTINCT p.project_id, 
       ROUND(AVG(e.experience_years) OVER (PARTITION BY p.project_id), 2) AS average_years
FROM Project AS p
LEFT JOIN Employee AS e ON p.employee_id = e.employee_id;

-- Intuition:
-- The window function AVG() OVER (PARTITION BY p.project_id) calculates the average experience years for each project.
-- DISTINCT is used to ensure each project_id appears only once in the result.

-- Explanation:
-- The query performs a LEFT JOIN between Project and Employee tables on the employee_id.
-- It uses a window function to calculate the average experience years for each project and rounds the result to 2 decimal places.
