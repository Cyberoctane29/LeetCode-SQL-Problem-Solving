-- Problem 185: Department Top Three Salaries
-- Difficulty: Hard

-- SQL Schema
-- Table: Employee
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | id           | int     |
-- | name         | varchar |
-- | salary       | int     |
-- | departmentId | int     |
-- +--------------+---------+
-- id is the primary key for this table.
-- departmentId is a foreign key of the ID from the Department table.
-- Each row indicates the ID, name, and salary of an employee, along with the ID of their department.

-- Table: Department
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key for this table.
-- Each row indicates the ID of a department and its name.

-- Problem Statement
-- Write a solution to find the employees who are high earners in each department.
-- A high earner is an employee who has a salary in the top three unique salaries for that department.
-- The result table must contain the department name, employee name, and salary, and must include all employees with the top three unique salaries.

-- Solution 1: Using DENSE_RANK() and CTE
WITH CTE AS (
    SELECT 
        d.name AS Department,
        e.name AS Employee,
        e.salary,
        d.id,
        DENSE_RANK() OVER (PARTITION BY d.id ORDER BY e.salary DESC) AS RN
    FROM 
        Employee AS e 
    JOIN 
        Department AS d ON e.departmentId = d.id
),
CTE1 AS (
    SELECT 
        id, department, employee, salary, RN
    FROM 
        CTE
    WHERE 
        RN <= 3
)
SELECT 
    department, employee, salary
FROM 
    CTE1
WHERE 
    (department, salary) IN (
        SELECT department, salary 
        FROM CTE1
    );

-- Intuition for Solution 1:
-- The problem requires identifying employees who have the top three unique salaries in each department.
-- We use the `DENSE_RANK()` function to assign a rank to each employee's salary within their department.
-- Only those with a rank of 1, 2, or 3 are included in the result.
-- A subquery is used to ensure that if two employees have the same salary within the top 3, both are included.

-- Explanation for Solution 1:
-- 1. We use a Common Table Expression (CTE) to assign a rank (using `DENSE_RANK()`) to each employee's salary within their department.
-- 2. The rank is partitioned by department, and ordered by salary in descending order.
-- 3. The query filters for employees with ranks less than or equal to 3 (top three salaries).
-- 4. A subquery is used to ensure that employees with the same salary within the top 3 are included.

-- Optimized Solution 2: Simplified version using DENSE_RANK()
WITH CTE AS (
    SELECT 
        d.name AS Department,
        e.name AS Employee,
        e.salary,
        DENSE_RANK() OVER (PARTITION BY d.id ORDER BY e.salary DESC) AS RN
    FROM 
        Employee AS e
    JOIN 
        Department AS d ON e.departmentId = d.id
),
CTE1 AS (
    SELECT 
        Department, Employee, salary, RN
    FROM 
        CTE
    WHERE 
        RN <= 3
)
SELECT 
    Department, Employee, salary
FROM 
    CTE1
ORDER BY 
    Department, salary DESC;

-- Intuition for Solution 2:
-- This solution simplifies the first one by eliminating the need for a subquery.
-- It still uses the `DENSE_RANK()` function to assign a rank to each employee's salary within their department.
-- We then filter for those with a rank of 3 or less and return the results.

-- Explanation for Solution 2:
-- 1. The query uses `DENSE_RANK()` to assign ranks to salaries for each department.
-- 2. Only employees with the top three ranks in each department are included (using a rank filter `RN <= 3`).
-- 3. The final result is ordered by department name and salary in descending order.
