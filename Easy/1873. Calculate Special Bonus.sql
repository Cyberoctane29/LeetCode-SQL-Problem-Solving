-- Problem 1873: Calculate Special Bonus
-- Difficulty: Easy

-- SQL Schema
-- Table: Employees
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | name        | varchar |
-- | salary      | int     |
-- +-------------+---------+
-- employee_id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the employee ID, employee name, and salary.

-- Problem Statement
-- Write a solution to calculate the bonus of each employee. 
-- The bonus of an employee is 100% of their salary if the ID of the employee is an odd number 
-- and the employee's name does not start with the character 'M'. 
-- The bonus of an employee is 0 otherwise.

-- Solution:
-- Use a CASE statement to determine the bonus based on the conditions:
-- 1. Employee ID is odd.
-- 2. Employee's name does not start with 'M'.

SELECT 
   employee_id, 
   CASE 
       WHEN MOD(employee_id, 2) <> 0 AND name NOT LIKE 'M%' THEN salary
       ELSE 0
   END AS bonus
FROM 
   Employees
ORDER BY 
   employee_id;

-- Intuition:
-- We need to compute the bonus based on two conditions: the employee ID being odd and the name not starting with 'M'.
-- The CASE statement helps us evaluate these conditions and determine the appropriate bonus amount.
-- Employees who meet both conditions receive their full salary as the bonus, while others receive 0.

-- Explanation:
-- The `MOD(employee_id, 2) <> 0` checks if the employee ID is odd.
-- The `name NOT LIKE 'M%'` checks if the employee's name does not start with 'M'.
-- If both conditions are met, the employee receives their salary as the bonus; otherwise, the bonus is 0.
-- The result is ordered by `employee_id` as required.
