-- Problem 627: Swap Salary
-- Difficulty: Easy

-- SQL Schema
-- Table: Salary
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | id          | int      |
-- | name        | varchar  |
-- | sex         | ENUM     |
-- | salary      | int      |
-- +-------------+----------+
-- id is the primary key (column with unique values) for this table.
-- The sex column is ENUM (category) value of type ('m', 'f').
-- The table contains information about an employee.

-- Problem Statement
-- Write a solution to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables.
-- Note that you must write a single update statement, do not write any select statement for this problem.

-- Solution 1:
-- This query uses a CASE statement to swap the values in the 'sex' column.
-- It changes all 'm' values to 'f', all 'f' values to 'm', and leaves other values unchanged (though 'sex' should only have 'm' or 'f').

UPDATE Salary 
SET sex = CASE 
    WHEN sex = 'm' THEN 'f' 
    WHEN sex = 'f' THEN 'm' 
    ELSE sex 
END;

-- Intuition:
-- The CASE statement checks the current value of the 'sex' column.
-- If the value is 'm', it updates it to 'f'.
-- If the value is 'f', it updates it to 'm'.
-- Other values are left unchanged, but in this schema, only 'm' and 'f' should be present.

-- Explanation:
-- This query performs a bulk update of the 'sex' column in the Salary table.
-- It swaps 'm' with 'f' and vice versa without needing any temporary tables.

-- Solution 2:
-- This query is a simplified version of the previous one.
-- It achieves the same result but without explicitly handling other possible values (which are not expected in this schema).

UPDATE Salary 
SET sex = CASE 
    WHEN sex = 'm' THEN 'f' 
    WHEN sex = 'f' THEN 'm' 
END;

-- Intuition:
-- The CASE statement still performs the same swap operation as in Solution 1.
-- The difference is that it assumes no other values are present in the 'sex' column.
-- Therefore, the ELSE clause is not needed.

-- Explanation:
-- This query updates the 'sex' column by swapping 'm' with 'f' and vice versa.
-- It is a straightforward approach to perform the required update in a single statement.
