-- Problem 176: Second Highest Salary
-- Difficulty: Medium

-- SQL Schema
-- Table: Employee
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains information about the salary of an employee.

-- Problem Statement
-- Write a solution to find the second highest distinct salary from the Employee table.
-- If there is no second highest salary, return null.

-- SQL Solution 1: Using CTE
WITH CTE AS (
    SELECT salary, 
           DENSE_RANK() OVER (ORDER BY salary DESC) AS `rank`
    FROM Employee
)
SELECT 
    (SELECT salary 
     FROM CTE 
     WHERE `rank` = 2 LIMIT 1) AS SecondHighestSalary;

-- Intuition:
-- The problem is to find the second highest distinct salary. 
-- By using DENSE_RANK() within a CTE, we can assign ranks to distinct salary values in descending order.
-- DENSE_RANK() ensures that salaries with the same value receive the same rank.
-- Selecting the salary with rank 2 gives us the second highest distinct salary.
-- If there is no second highest salary, the result will be NULL.

-- Explanation:
-- 1. A CTE (Common Table Expression) is used to calculate the rank of each distinct salary in descending order.
-- 2. The `DENSE_RANK()` function assigns ranks to salaries; if two employees have the same salary, they receive the same rank.
-- 3. We then select the salary where the rank equals 2, representing the second highest salary.
-- 4. The `LIMIT 1` ensures that only one value is returned.

-- SQL Solution 2: Using Subquery
SELECT MAX(salary) AS SecondHighestSalary 
FROM Employee 
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- Intuition:
-- The idea is to find the highest salary first, and then find the maximum salary that is less than this highest salary.
-- This approach naturally leads to the second highest distinct salary.
-- If there is no second highest salary (i.e., all employees have the same salary), the subquery will return NULL.

-- Explanation:
-- 1. This solution first finds the maximum salary in the Employee table.
-- 2. It then finds the maximum salary that is less than the highest salary, which is effectively the second highest salary.
-- 3. The result is returned as the `SecondHighestSalary`.
