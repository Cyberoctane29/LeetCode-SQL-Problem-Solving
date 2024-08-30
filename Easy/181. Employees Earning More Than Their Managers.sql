-- Problem 181: Employees Earning More Than Their Managers
-- Difficulty: Easy

-- SQL Schema
-- Table: Employee
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | salary      | int     |
-- | managerId   | int     |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.

-- Problem Statement
-- Write a solution to find the employees who earn more than their managers.

-- SQL Solution
SELECT E1.name AS Employee
FROM Employee E1
INNER JOIN Employee E2 ON E1.managerId = E2.id
WHERE E1.salary > E2.salary;

-- Intuition:
-- To find employees who earn more than their managers, we need to compare the salary of each employee with the salary of their manager.
-- We can achieve this by joining the Employee table with itself.
-- In this self-join, one instance of the table (E1) represents the employees, and the other instance (E2) represents their managers.
-- We join these instances based on the managerId of E1 and the id of E2.

-- Explanation:
-- The INNER JOIN operation combines rows from the Employee table with other rows from the same table.
-- We join the table on E1.managerId = E2.id to match each employee with their manager.
-- The WHERE clause filters the results to include only those employees whose salary (E1.salary) is greater than their manager's salary (E2.salary).
