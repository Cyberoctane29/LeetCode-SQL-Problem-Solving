-- Problem 1978: Employees Whose Manager Left the Company
-- Difficulty: Easy

-- SQL Schema
-- Table: Employees
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | employee_id | int      |
-- | name        | varchar  |
-- | manager_id  | int      |
-- | salary      | int      |
-- +-------------+----------+
-- In SQL, employee_id is the primary key for this table.
-- This table contains information about the employees, their salary, and the ID of their manager.
-- Some employees do not have a manager (manager_id is null).

-- Problem Statement
-- Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company.
-- When a manager leaves the company, their information is deleted from the Employees table,
-- but the reports still have their manager_id set to the manager that left.
-- Return the result table ordered by employee_id.

-- Solution:
-- We need to find employees whose manager_id is not present in the Employees table (indicating that their manager left).
-- Additionally, we want to filter these employees to only those whose salary is strictly less than $30000.

-- Solution Steps:
-- 1. Identify the employee_ids of managers who are no longer in the Employees table.
-- 2. Find employees whose manager_id matches one of these missing managers and whose salary is less than $30000.
-- 3. Return the IDs of these employees, ordered by employee_id.

SELECT employee_id
FROM Employees
WHERE manager_id NOT IN (SELECT employee_id FROM Employees)
  AND salary < 30000
ORDER BY employee_id;

-- Intuition:
-- To identify employees whose manager has left, we first find all employee_ids for managers.
-- We then filter out those whose manager_id is not in the list of current employee_ids.
-- Finally, we check if these employees have a salary less than $30000 and return those employee_ids.

-- Explanation:
-- The subquery `SELECT employee_id FROM Employees` gets the list of all current employees.
-- The main query filters employees based on two conditions:
-- 1. Their manager_id must not be in the list of current employee_ids (indicating that their manager has left).
-- 2. Their salary must be less than $30000.
-- The results are then ordered by employee_id in ascending order.
