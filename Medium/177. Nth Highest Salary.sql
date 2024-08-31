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

-- SQL Solution 1: Using OFFSET and LIMIT
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

-- SQL Solution 2: Using DENSE_RANK() in a CTE
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      WITH CTE AS (
          SELECT salary, 
                 DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
          FROM Employee
      )
      SELECT salary 
      FROM CTE 
      WHERE rank = N
      LIMIT 1
  );
END;

-- Intuition:
-- This solution uses a CTE and the DENSE_RANK() function to assign ranks to distinct salaries in descending order.
-- DENSE_RANK() assigns the same rank to identical salaries, and by filtering on rank = N, we can directly access the nth highest salary.
-- If there is no salary at rank N, the query will return NULL.

-- Explanation:
-- 1. The `CREATE FUNCTION` statement defines a stored function named `getNthHighestSalary` that accepts an integer `N` as input.
-- 2. The function uses a CTE to rank distinct salaries in descending order using DENSE_RANK().
-- 3. The SELECT statement retrieves the salary with the nth rank.
-- 4. The function returns the nth highest salary or NULL if there isn’t one.
