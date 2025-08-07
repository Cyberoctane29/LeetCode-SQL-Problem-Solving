-- Problem 177: Nth Highest Salary
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
-- Write a solution to find the nth highest salary from the Employee table.
-- If there is no nth highest salary, return null.

-- Solution
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  SET N = N-1;
  RETURN (
      SELECT DISTINCT salary 
      FROM Employee 
      ORDER BY salary DESC
      LIMIT 1 OFFSET N
  );
END;

-- Intuition:
-- To find the nth highest salary, you can order the salaries in descending order and skip the first (N-1) rows.
-- The OFFSET clause skips the specified number of rows, and the LIMIT clause retrieves the next row, which corresponds to the nth highest salary.
-- By using DISTINCT, we ensure that we consider only unique salary values.
-- If N exceeds the number of distinct salaries available, the query will return NULL.

-- Explanation:
-- 1. The `CREATE FUNCTION` statement defines a stored function named `getNthHighestSalary` that accepts an integer `N` as input.
-- 2. The function decreases N by 1 because OFFSET is zero-based.
-- 3. The SELECT statement retrieves the nth highest distinct salary using ORDER BY, LIMIT, and OFFSET.
-- 4. The function returns the nth highest salary or NULL if there isn’t one.