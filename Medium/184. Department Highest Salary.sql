-- Problem 184: Department Highest Salary
-- Difficulty: Medium

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
-- id is the primary key (column with unique values) for this table.
-- departmentId is a foreign key (reference columns) of the ID from the Department table.
-- Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

-- Table: Department
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
-- Each row of this table indicates the ID of a department and its name.

-- Problem Statement
-- Write a solution to find employees who have the highest salary in each of the departments.
-- Return the result table in any order.

-- SQL Solution
SELECT 
    Department.name AS Department, 
    Employee.name AS Employee, 
    Employee.salary AS Salary
FROM 
    Employee 
INNER JOIN 
    Department 
ON 
    Employee.departmentId = Department.id 
WHERE 
    (departmentId, salary) IN (
        SELECT departmentId, MAX(salary) 
        FROM Employee 
        GROUP BY departmentId
    );

-- Intuition:
-- The goal is to find the employee(s) with the highest salary in each department.
-- To achieve this, we first determine the maximum salary in each department using a subquery.
-- We then match the employee records with these maximum salaries to identify the top earners in each department.
-- By using an INNER JOIN, we can combine the information from both the Employee and Department tables.

-- Explanation:
-- 1. The INNER JOIN operation combines records from the Employee and Department tables based on the departmentId.
-- 2. The WHERE clause filters the records to include only those employees whose salary matches the maximum salary in their respective department.
-- 3. The subquery `(SELECT departmentId, MAX(salary) FROM Employee GROUP BY departmentId)` returns the maximum salary for each department.
-- 4. The final result displays the department name, employee name, and salary of the highest-paid employee(s) in each department.
-- 5. If multiple employees have the same highest salary within a department, they will all be included in the result.

-- Example Walkthrough:
-- Consider a scenario where the Employee table contains the following data:
-- | id | name   | salary | departmentId |
-- |----|--------|--------|--------------|
-- | 1  | John   | 1000   | 1            |
-- | 2  | Jane   | 1200   | 1            |
-- | 3  | Alice  | 900    | 2            |
-- | 4  | Bob    | 1100   | 2            |
-- | 5  | Charlie| 1100   | 2            |
-- 
-- The subquery will return:
-- | departmentId | MAX(salary) |
-- |--------------|-------------|
-- | 1            | 1200        |
-- | 2            | 1100        |
--
-- The final result will be:
-- | Department | Employee | Salary |
-- |------------|----------|--------|
-- | Dept1      | Jane     | 1200   |
-- | Dept2      | Bob      | 1100   |
-- | Dept2      | Charlie  | 1100   |

-- This result shows the highest-paid employee(s) in each department, meeting the problem's requirements.
