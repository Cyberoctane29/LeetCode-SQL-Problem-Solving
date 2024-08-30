-- Problem 77: Employee Bonus
-- Difficulty: Easy

-- SQL Schema
-- Table: Employee
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | empId       | int     |
-- | name        | varchar |
-- | supervisor  | int     |
-- | salary      | int     |
-- +-------------+---------+
-- empId is the column with unique values for this table.
-- Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.

-- Problem Statement
-- Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.

-- SQL Solution
SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;

-- Intuition:
-- To find employees with a bonus less than 1000, we need to join the Employee table with the Bonus table.
-- We also need to include employees who do not have a bonus record, which is why we use a LEFT JOIN.

-- Explanation:
-- The query performs a LEFT JOIN between the Employee table and the Bonus table on the empId column.
-- It then filters the results to include employees whose bonus is less than 1000 or those who do not have a bonus record (i.e., b.bonus IS NULL).
-- This ensures that all employees with bonuses less than 1000 are included, as well as those without a bonus record.
